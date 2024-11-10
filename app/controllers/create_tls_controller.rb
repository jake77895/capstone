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

  
    # Store the tier list name in the session if present
    session[:tl_name] = params["the_name"]

    # Initialize an array in the session to store fields
    session[:fields] = []
  
    (1..10).each do |i|
      field_name = params["field#{i}_name"]
      field_datatype = params["field#{i}_datatype"]
  
      # Only store the field if both name and datatype are present
      if field_name.present? && field_datatype.present?
        session[:fields] << { name: field_name, datatype: field_datatype.downcase }
      end
    end
  
    # Redirect to the add items page
    redirect_to("/add_items")
  end

  def add_items
    
    render("/createTl_template/add_items")
    
  end

  

end
