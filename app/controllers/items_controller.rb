class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item, notice: "Item was successfully created."
    else
      render :new
    end
  end

  private

  def item_params
    # Permit name, description, and custom_fields (as a hash)
    params.require(:item).permit(:name, :description, custom_fields: {})
  end
end
