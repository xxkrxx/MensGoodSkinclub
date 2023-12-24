class Public::PostsController < ApplicationController

  def index
    @categories = Category.all
    @skin_concerns = SkinConcern.all
    @posts = Post.all.page(params[:page]).per(9)

    if params[:parent_type].present? && params[:parent_id].present?
      case params[:parent_type]
      when "category"
        @posts = @posts.where(category_id: params[:parent_id])
      when "skin_concern"
        @posts = @posts.where(skin_concern_id: params[:parent_id])
      end
    end

    case params[:order]
    when "latest"
      @posts = @posts.latest
    when "old"
      @posts = @posts.old
    when "star_count"
      @posts = @posts.star_count
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
      @comments = @post.comments
    end
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
      render :edit
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿が成功しました。"
      redirect_to post_path(@post)
    else
      flash[:alert] = "投稿に失敗しました。入力内容を確認してください。"
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