class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
     @posts = Post.all
  end

  def new
    @post = Post.new
  end
  

  def create
    @post = Post.new(post_params)
    @post.user_id = current_admin.id 
    if @post.save
      flash[:notice] = "商品が登録できました"
      redirect_to admin_posts_path(@post)
    else
      @Posts = Post.all
      render 'new'
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path(@post)
    else
      render :edit
    end
  end  


  def show
    @post = Post.find(params[:id])
  end
  
  
  private
  
  
  def post_params
    params.require(:post).permit(:productname, :image, :comment,  :skinitem_id, :skin_concern_id, :star)
  end
  
  
end


