class Admin::PostsController < ApplicationController
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

  def show
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      flash[:alert] = "指定された投稿が見つかりません。"
      redirect_to root_path
    end
  end  
end


