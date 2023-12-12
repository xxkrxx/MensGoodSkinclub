class Public::FavoritesController < ApplicationController
  
  def create
  @post_favorite = Favorite.new(user_id: current_user.id, post_id: params[:post_id])
  @post_favorite.save
  redirect_to request.referer
  end
  
  def destroy
    post = Post.find(params[:post_id]) 
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to request.referer
  end
  
end