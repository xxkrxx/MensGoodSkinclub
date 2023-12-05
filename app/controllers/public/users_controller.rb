class Public::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def check
  end

  def show
  end

  def edit
  end
end
