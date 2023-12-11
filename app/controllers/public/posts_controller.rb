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
      redirect_to root_path # または適切なエラー処理を実装
    end
  end

  def edit
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      # 保存に失敗した場合の処理
      render :new
    end
  end

  
private


  def post_params
    params.require(:post).permit(:productname, :image, :comment,  :skinitem_id, :skin_concern_id, :star)
  end
end
