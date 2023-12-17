class Public::PostsController < ApplicationController
  
  def index
    @posts = Post.all
    @categories = Category.all
    @skin_concerns = SkinConcern.all

    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @posts = @category.posts
    end

    if params[:skin_concern_id].present?
      @skin_concern = SkinConcern.find(params[:skin_concern_id])
      @posts = @skin_concern.posts
    end
    
    if params[:latest]
     @posts = Post.latest
    elsif params[:old]
     @posts = Post.old
    elsif params[:star_count]
     @posts = Post.star_count
    else
     @posts = Post.all
    end
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      flash[:alert] = "指定された投稿が見つかりません。"
      redirect_to root_path
    else
      @comment = Comment.new
    end
      @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user != current_user
        redirect_to posts_path, alert: "不正なアクセスです。"
    end
    @categories = Category.all
    @skinitem_categories = SkinitemCategory.all
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
      puts @post.errors.full_messages
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
    params.require(:post).permit(:productname, :image, :comment, :category_id, :skinitem_category_id, :skin_concern_id, :star)
  end
end