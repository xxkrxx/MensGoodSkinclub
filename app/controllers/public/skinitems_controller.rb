class Public::SkinitemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @skinitems = Skinitem.all
    @acne = Skinitem.all.joins(:skin_concern).where(skin_concerns: {name: "ニキビ"})
    @pore = Skinitem.all.joins(:skin_concern).where(skin_concerns: {name: "毛穴"})
    @whitening = Skinitem.all.joins(:skin_concern).where(skin_concerns: {name: "美白"})
  end

  def show
    @skinitem = Skinitem.find(params[:id])
  end
  
  

end
