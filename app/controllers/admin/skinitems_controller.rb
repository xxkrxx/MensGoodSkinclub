class Admin::SkinitemsController < ApplicationController
  before_action :authenticate_admin!
  def index
     @skinite = Skinitem.all
  end

  def new
    @skinitem = Skinitem.new
  end
  

  def create
    @skinitem = Skinitem.new(skin_item_params)
    @skinitem.user_id = current_admin.id 
    if @skinitem.save
      flash[:notice] = "商品が登録できました"
      redirect_to admin_skinitems_path(@skinitem)
    else
      @Skinitems = Skinitem.all
      render 'new'
    end
  end
  
  def update
    @skinitem = Skinitem.find(params[:id])
    if @skinitem.update(skinitem_params)
      redirect_to admin_skinitem_path(@skinitem)
    else
      render :edit
    end
  end  


  def show
    @skinitem = Skinitem.find(params[:id])
  end

  def edit
    @Skinitem = Skinitem.find(params[:id])
  end
  
  
  private

  def skin_item_params
    params.require(:skinitem).permit(:name, :image, :introduction, :category_id, :skin_concern_id)
  end
end