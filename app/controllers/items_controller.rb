class ItemsController < ApplicationController
  def new
    @item = Item.new
    @fields = Field.all  # Retrieve all customizable fields
  end

  def create
    @item = Item.new(item_params)

    # Process custom fields
    custom_fields = {}
    Field.all.each do |field|
      custom_fields[field.name] = params[:item][:custom_fields][field.name]
    end
    @item.custom_fields = custom_fields

    if @item.save
      redirect_to @item, notice: "Item was successfully created."
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description)
  end
end
