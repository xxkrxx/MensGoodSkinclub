class Admin::SkinitemsController < ApplicationController
  before_action :authenticate_admin!
  def index
     @skinitems = Skinitem.all
  end

  def new
    @skinitem = Skinitem.new
    @categories = Category.all
  end
  
  def create
    @skinitem = Skinitem.new(skin_item_params)
    if @skinitem.save
      redirect_to admin_skinitems_path(@skinitem)
    else
      @skinitems = Skinitem.all
      render 'new'
    end
  end
  

  def update
    @skinitem = Skinitem.find(params[:id])
    if @skinitem.update(skin_item_params)
      redirect_to admin_skinitem_path(@skinitem)
    else
      render :edit
    end
  end



  def show
    @skinitem = Skinitem.find(params[:id])
  end

  def edit
    @skinitem = Skinitem.find(params[:id])
    @categories = Category.all
  end
  
  def destroy
    @skinitem = Skinitem.find(params[:id])
    @skinitem.destroy
    redirect_to admin_skinitems_path
  end
  
  
  private

  def skin_item_params
    params.require(:skinitem).permit(:name, :image, :product_name, :introduction, :category_id, :skin_concern_id)
  end
end