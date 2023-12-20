class Public::ItemfavoritesController < ApplicationController
  # ポストにお気に入りを追加します
  def create
    @skinitem = Skinitem.find(params[:skinitem_id])
    favorite = @skinitem.itemfavorites.new(user_id: current_user.id)   # 新しいお気に入りを作成
    favorite.save
  end

  # ポストからお気に入りを削除します
  def destroy
    @skinitem = Skinitem.find(params[:skinitem_id])
    favorite = current_user.itemfavorites.find_by(skinitem_id: @skinitem.id)   # 現在のユーザーのお気に入りを特定
    favorite.destroy
  end
end
