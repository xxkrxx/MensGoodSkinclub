class Admin::PostsController < ApplicationController
  # 投稿一覧を表示するアクション
  def index
    # カテゴリ一覧を取得
    @categories = Category.all
    # 肌の悩み一覧を取得
    @skin_concerns = SkinConcern.all
    # 全ての投稿を取得し、ページネーションを適用
    @posts = Post.all.page(params[:page]).per(9)

    # 親タイプおよび親IDが指定されていれば、条件に基づいて投稿を絞り込む
    if params[:parent_type].present? && params[:parent_id].present?
      case params[:parent_type]
      when "category"
        @posts = @posts.where(category_id: params[:parent_id])
      when "skin_concern"
        @posts = @posts.where(skin_concern_id: params[:parent_id])
      end
    end

    # order パラメータに基づいて投稿をソート
    case params[:order]
    when "latest"
      @posts = @posts.latest
    when "old"
      @posts = @posts.old
    when "star_count"
      @posts = @posts.star_count
    end
  end

  # 投稿詳細を表示するアクション
  def show
    # 指定されたIDに基づいて投稿を取得
    @post = Post.find_by(id: params[:id])

    # 投稿が見つからない場合はルートページにリダイレクト
    if @post.nil?
      flash[:alert] = "指定された投稿が見つかりません。"
      redirect_to root_path
    end
  end

  # 投稿を削除するアクション
  def destroy
    # 指定されたIDに基づいて投稿を取得し、削除
    user = User.find(params[:user_id])
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_user_path(user), notice: "レビューを削除しました。"
  end
end