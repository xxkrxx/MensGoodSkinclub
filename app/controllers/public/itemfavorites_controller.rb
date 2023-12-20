class Public::ItemfavoritesController < ApplicationController
  # ポストにお気に入りを追加します
  def create
    @skinitem = Post.find(params[:post_id]) 
    favorite = @skinitem.favorites.new(user_id: current_user.id)   # 新しいお気に入りを作成
    favorite.save 
  end

  # ポストからお気に入りを削除します
  def destroy
    @skinitem = Skinitem.find(params[:post_id]) 
    favorite = current_user.favorites.find_by(skinitem_id: @skinitem.id)   # 現在のユーザーのお気に入りを特定
    favorite.destroy
  end
end
