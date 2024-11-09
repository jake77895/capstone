class ItemsController < ApplicationController

  def update_field_count
    # Parse the JSON request body (Rails should handle this automatically)
    data = JSON.parse(request.body.read) rescue {}
    
    # Update session with new field count if it exists
    if data['field_count']
      session[:field_count] = data['field_count']
      render json: { success: true, field_count: session[:field_count] }, status: :ok
    else
      render json: { success: false, error: "No field count provided" }, status: :unprocessable_entity
    end
  end
  
  def clear_session
    session.clear
    redirect_to("/")
  end
  
  def create

    render("/items_template/create_form")

  end


  def submit
    @tl_name = params.fetch("the_name")
    session[:tl_name] = @tl_name
  
    (1..10).each do |i|
      # Set the field name if present
      field_name_key = "field#{i}_name"
      if params[field_name_key].present?
        session[:"#{field_name_key}"] = params[field_name_key]
      end
  
      # Set the field datatype if present
      field_datatype_key = "field#{i}_datatype"
      if params[field_datatype_key].present?
        session[:"#{field_datatype_key}"] = params[field_datatype_key].downcase
      end
    end

    redirect_to("/add_items")

  end

  def add_items
    
    render("/items_template/add_items")
    
  end

  

end
