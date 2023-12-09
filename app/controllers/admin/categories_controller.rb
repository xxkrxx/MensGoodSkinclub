class Admin::CategoriesController < ApplicationController
  
  def index
  @Category = Category.new #Categories新規登録用の箱 
  @categories = Categories.all #Categories全件取得
  end
  

  def create
    @category = Category.new(skin_concern_params) #Category新規登録データ取得
    if @category.save #保存
      redirect_to request.referer, notice: "カテゴリーを登録しました。" #Category一覧に戻る
    else
      @category = Category.all
      flash.now[:alert] = "カテゴリーが入力されていません。"
      render 'index'
    end
  end
end