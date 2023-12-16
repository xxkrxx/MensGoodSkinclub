class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
     @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
  
  
  private
  
  
  def post_params
    params.require(:post).permit(:productname, :image, :comment,  :category_id, :skin_concern_id, :skinitem_category_id, :star)
  end
  
  
end


