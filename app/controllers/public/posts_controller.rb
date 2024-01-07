class Public::PostsController < ApplicationController
  # ログインユーザーのみアクセス可能（indexアクションは例外）
  before_action :authenticate_user!, except: [:index]

  # レビュー一覧ページ
  def index
    # カテゴリとスキンコンサーンを取得
    @categories = Category.all
    @skin_concerns = SkinConcern.all

    # ページネーション設定
    @posts = Post.all.page(params[:page]).per(9)

    # カテゴリや肌悩みで絞り込み
    if params[:parent_type].present? && params[:parent_id].present?
      case params[:parent_type]
      when "category"
        @posts = @posts.where(category_id: params[:parent_id])
      when "skin_concern"
        @posts = @posts.where(skin_concern_id: params[:parent_id])
      end
    end

    # ソートオプションによる並び替え
    case params[:order]
    when "latest"
      @posts = @posts.latest
    when "old"
      @posts = @posts.old
    when "star_count"
      @posts = @posts.star_count
    end
  end

  # レビュー投稿ページ
  def new
    @post = Post.new
    @categories = Category.all
  end

  # レビュー詳細ページ
  def show
    # 投稿が存在しない場合の処理
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      flash[:alert] = "指定された投稿が見つかりません。"
      redirect_to root_path
    else
      @comment = Comment.new
      @comments = @post.comments
    end
  end

  # レビュー編集ページ
  def edit
    @post = Post.find(params[:id])

    # 不正なアクセスの場合の処理
    if @post.user != current_user
      redirect_to posts_path, alert: "不正なアクセスです。"
    end

    @categories = Category.all
    @skinitem_categories = SkinitemCategory.all
  end

  # レビュー更新アクション
  def update
    @post = Post.find(params[:id])

    if params[:post][:img_delete]
      @post.tags.destroy_all
      @post.image.purge
    end

    # 投稿画像があれば処理する
    unless post_params[:image].blank?
      tags = Vision.get_image_data(post_params[:image])
      tags_ja = Translation.translate_word(tags)
    end

    # レビューが正常に更新された場合の処理
    if @post.update(post_params)
      # 投稿画像があれば処理する
      unless post_params[:image].blank?
        @post.tags.destroy_all
        tags_ja.each do |tag|
          @post.tags.create(name: tag)
        end
      end
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  # レビュー作成アクション
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    # 投稿画像があれば処理する
    unless post_params[:image].blank?
      tags = Vision.get_image_data(post_params[:image])
      tags_ja = Translation.translate_word(tags)
    end

    # レビューが正常に保存された場合の処理
    if @post.save
      # 投稿画像があれば処理する
      unless post_params[:image].blank?
        @post.tags.destroy_all
        tags_ja.each do |tag|
          @post.tags.create(name: tag)
        end
      end
      flash[:notice] = "投稿が成功しました。"
      redirect_to post_path(@post.id)
    else
      flash[:alert] = "投稿に失敗しました。入力内容を確認してください。"
      render :new
    end
  end

  # レビュー削除アクション
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
