class Admin::SkinitemsController < ApplicationController
  before_action :authenticate_admin!

  # すべてのスキンアイテムの一覧を表示
  def index
    @skinitems = Skinitem.all.page(params[:page]).per(10)
  end

  # 新しいスキンアイテムのフォームおよび必要なデータを準備
  def new
    @skinitem = Skinitem.new
    @categories = Category.all
    @skinitem_categories = SkinitemCategory.all
  end

  # 提供されたパラメータに基づいて新しいスキンアイテムを作成
  def create
    @skinitem = Skinitem.new(skin_item_params)
    if @skinitem.save
      redirect_to admin_skinitem_path(@skinitem)
    else
      # 保存に失敗した場合は、エラーが含まれた新しいスキンアイテムのフォームを再表示
      @skinitems = Skinitem.all
      render :new
    end
  end

  # 提供されたパラメータに基づいて既存のスキンアイテムを更新
  def update
    @skinitem = Skinitem.find(params[:id])
    if @skinitem.update(skin_item_params)
      redirect_to admin_skinitem_path(@skinitem)
    else
      # 更新に失敗した場合は、エラーが含まれた既存のスキンアイテムの編集フォームを再表示
      render :edit
    end
  end

  # 特定のスキンアイテムの詳細を表示
  def show
    @skinitem = Skinitem.find(params[:id])
  end

  # 既存のスキンアイテムの編集フォームを準備
  def edit
    @skinitem = Skinitem.find(params[:id])
  end

  # スキンアイテムを削除
  def destroy
    @skinitem = Skinitem.find(params[:id])
    @skinitem.destroy
    redirect_to admin_skinitems_path
  end

  private

  # スキンアイテムのデータに対するストロングパラメータ
  def skin_item_params
    params.require(:skinitem).permit(:name, :image, :product_name, :introduction, :category_id, :skin_concern_id, :skinitem_category_id)
  end
end
