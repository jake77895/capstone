class CreateTlsController < ApplicationController
  
  def submit_tl
      # Access the values directly to get an array of item parameters
      items = params[:items].values || []

      @items = items.map do |item_params|
        # Permit parameters for each item
        Item.new(item_params.permit(:name, :description, :image, custom_fields: {}))
      end

      # Save all items if they are valid
      if @items.all?(&:save)
        reset_session
        redirect_to rank_items_path, notice: 'Tier List items were successfully created.'
      else
        render :new
      end

  end

  def item_params
    # Use strong parameters and log the permitted params
    params.require(:item).permit(:name, :description, :image, custom_fields: {})
  end

  
  def clear_session
    session.clear
    redirect_to("/")
  end
  
  def create

    render("/createTl_template/create_form")

  end


  def submit_fields
    # Store the tier list name in the session if present
    session[:tl_name] = params["the_name"]
  
    # Initialize an array in the session to store fields
    session[:fields] = []
  
    (1..10).each do |i|
      field_name = params["field#{i}_name"]
      field_datatype = params["field#{i}_datatype"].presence || "text" # Default to "text" if field_datatype is blank
  
      # Only store the field if name is present (datatype will default to "text" if missing)
      if field_name.present?
        session[:fields] << { name: field_name, datatype: field_datatype.downcase }
        puts "Stored field #{i} in session: #{session[:fields].last}" # Debugging output
      end
    end
  
    # Final debugging output for session[:fields]
    puts "Final fields stored in session: #{session[:fields].inspect}"
  
    # Redirect to the add items page
    redirect_to("/add_items")
  end
  

  def add_items
    
    # Retrieve the tier list name and fields from the session
    @tl_name = session[:tl_name]
    @fields = (session[:fields] || []).map do |field|
      { name: field["name"], datatype: field["datatype"] }
    end
    puts "Debugging @fields in controller: #{@fields.inspect}"
    
    # Render the template (this line is technically optional, as Rails will automatically render `add_items.html.erb` in `createTl_template`)
    render("/createTl_template/add_items")
    
  end

  

end
