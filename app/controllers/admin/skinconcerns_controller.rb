class Admin::SkinconcernsController < ApplicationController 
  before_action :authenticate_admin!
  
  def index
  @skin_concern = Skinconcern.new #skin_concern新規登録用の箱 
  @skin_concerns = Skinconcerns.all #skin_concern全件取得
  end
  

  def create
    @skin_concern = Skin_concern.new(skin_concern_params) #skin_concern新規登録データ取得
    if @skin_concern.save #保存
      redirect_to request.referer, notice: "肌悩みを登録しました。" #skin_concern一覧に戻る
    else
      @skin_concern = Skin_concern.all
      flash.now[:alert] = "肌悩み名が入力されていません。"
      render 'index'
    end
  end
end