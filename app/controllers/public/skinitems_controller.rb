class Public::SkinitemsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @skinitems = Skinitem.all
    @posts = Post.all
  end

  def show
    @skinitem = Skinitem.find(params[:id])
  end
end
