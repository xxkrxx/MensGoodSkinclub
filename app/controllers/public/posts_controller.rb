class Public::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @options = ["Option 1", "Option 2", "Option 3"]
  end
  
  def show
    @post = Post.find_by(id: params[:id])
  
    if @post.nil?
      flash[:alert] = "指定された投稿が見つかりません。"
      redirect_to root_path 
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user != current_user
        redirect_to posts_path, alert: "不正なアクセスです。"
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :new
    end
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end
  
   def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(post.user), notice: "レビューを削除しました。"
  end

  
private


  def post_params
    params.require(:post).permit(:productname, :image, :comment,  :skinitem_id, :skin_concern_id, :star)
  end
end
