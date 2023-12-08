class Public::PostsController < ApplicationController
  def index
  end

  def new
    @post = Post.new
  end

  def show
  end

  def edit
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
  
    if @post.save
      redirect_to posts_path(@post)
    else
      # 保存に失敗した場合の処理
      render :new
    end
  end

  
private


  def post_params
    params.permit(:productname, :image, :comment, :categories_id, :skinconcernss_id, :star)
  end
end
