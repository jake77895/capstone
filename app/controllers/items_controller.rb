class ItemsController < ApplicationController

  def create

    render("/items_template/create_form")

  end

  def submit

    @tl_name = params.fetch("the_name")
    session[:tl_name] = @tl_name

    @field1_datatype = params[:field1_datatype] if params[:field1_datatype].present?


    if params.fetch("field1_name").present?
      @field1_name = params.fetch("field1_name")  
    end
    
    if params.fetch("field1_datatype").present?
      @field1_datatype = params.fetch("field1_datatype")  
    end
    
    @field2_name = params.fetch("field2_name")
    @field2_datatype = params.fetch("field2_datatype")
    @field3_name = params.fetch("field3_name")
    @field3_datatype = params.fetch("field3_datatype")
    @field4_name = params.fetch("field4_name")
    @field4_datatype = params.fetch("field4_datatype")
    @field5_name = params.fetch("field5_name")
    @field5_datatype = params.fetch("field5_datatype")

    redirect_to("/add_items")

  end

  def add_items
    
    render("/items_template/add_items")
    
  end

  

end
