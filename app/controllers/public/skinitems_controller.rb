class Public::SkinitemsController < ApplicationController
  before_action :authenticate_user!   # ユーザーが認証されていることを確認

  # スキンアイテムの一覧を取得
  def index
    @skinitems = Skinitem.all   # すべてのスキンアイテムを取得
    @acne = Skinitem.all.joins(:skin_concern).where(skin_concerns: {name: "ニキビ"})   # ニキビに効果的なアイテムを取得
    @pore = Skinitem.all.joins(:skin_concern).where(skin_concerns: {name: "毛穴"})   # 毛穴に効果的なアイテムを取得
    @whitening = Skinitem.all.joins(:skin_concern).where(skin_concerns: {name: "美白"})   # 美白に効果的なアイテムを取得
  end

  # 特定のスキンアイテムの詳細情報を取得
  def show
    @skinitem = Skinitem.find(params[:id])  
  end
end

