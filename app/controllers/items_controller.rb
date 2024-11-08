class ItemsController < ApplicationController

  def create

    render("/items_template/create_form")

  end

  def submit

    render("/items_template/add_items")

  end
  

end
