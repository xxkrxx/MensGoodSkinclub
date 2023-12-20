class Public::FavoritesController < ApplicationController
  # ポストにお気に入りを追加します
  def create
    @post = Post.find(params[:post_id]) 
    favorite = @post.favorites.new(user_id: current_user.id)   # 新しいお気に入りを作成
    favorite.save 
  end

  # ポストからお気に入りを削除します
  def destroy
    @post = Post.find(params[:post_id]) 
    favorite = current_user.favorites.find_by(post_id: @post.id)   # 現在のユーザーのお気に入りを特定
    favorite.destroy
  end
end
