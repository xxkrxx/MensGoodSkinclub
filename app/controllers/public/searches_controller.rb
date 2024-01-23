class Public::SearchesController < ApplicationController
  before_action :authenticate_user!   # ユーザーが認証されていることを確認

  # 検索を実行し、結果をインスタンス変数に格納
  def search
    
    @range = params[:range]   # 検索対象の範囲を取得
    @word = params[:word]   # 検索キーワードを取得

    if @range == "ユーザー"   # 範囲がユーザーの場合
      @users = User.looks(params[:search], params[:word])   # ユーザーモデルのlooksメソッドを呼び出し、検索結果を取得
    else
      @posts = Post.looks(params[:search], params[:word], params[:skin_type]) 
      # ポストモデルのlooksメソッドを呼び出し、検索結果を取得
    end
  end
end
