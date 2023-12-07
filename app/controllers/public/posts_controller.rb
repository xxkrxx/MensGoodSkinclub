class Public::PostsController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end
  
  
private

  def post_params
    params.require(:post).permit(:productname, :image, :comment, :categories_id, :skinconcernss_id, :star)

  end
end
