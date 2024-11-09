class ItemsController < ApplicationController

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

    
    # Field 1
    if params.fetch("field1_name").present?
      @field1_name = params.fetch("field1_name")
      session[:field1_name] = @field1_name  
    end

    if params[:field1_datatype].present?
      @field1_datatype = params[:field1_datatype].downcase
      session[:field1_datatype] = @field1_datatype  
    end

    # Field 2
    if params.fetch("field2_name").present?
      @field2_name = params.fetch("field2_name")
      session[:field2_name] = @field2_name  
    end

    if params[:field2_datatype].present?
      @field2_datatype = params[:field2_datatype].downcase
      session[:field2_datatype] = @field2_datatype  
    end

    # Field 3
    if params.fetch("field3_name").present?
      @field3_name = params.fetch("field3_name")
      session[:field3_name] = @field3_name  
    end

    if params[:field3_datatype].present?
      @field3_datatype = params[:field3_datatype].downcase
      session[:field3_datatype] = @field3_datatype  
    end

    # Field 4
    if params.fetch("field4_name").present?
      @field4_name = params.fetch("field4_name")
      session[:field4_name] = @field4_name  
    end

    if params[:field4_datatype].present?
      @field4_datatype = params[:field4_datatype].downcase
      session[:field4_datatype] = @field4_datatype  
    end

    # Field 5
    if params.fetch("field5_name").present?
      @field5_name = params.fetch("field5_name")
      session[:field5_name] = @field5_name  
    end

    if params[:field5_datatype].present?
      @field5_datatype = params[:field5_datatype].downcase
      session[:field5_datatype] = @field5_datatype  
    end

    redirect_to("/add_items")

  end

  def add_items
    
    render("/items_template/add_items")
    
  end

  

end
