class CreateTlsController < ApplicationController
  
  def submit_tl

    # Need to add in the code to save the tier list in the database

    redirect_to ("/rank_items"), notice: "Object created successfully"

  end
  
  def clear_session
    session.clear
    redirect_to("/")
  end
  
  def create

    render("/createTl_template/create_form")

  end


  def submit_fields
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
    
    render("/createTl_template/add_items")
    
  end

  

end
