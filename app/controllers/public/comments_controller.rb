class Public::CommentsController < ApplicationController
  # ポストに新しいコメントを作成します
  def create
    @post = Post.find(params[:post_id])  
    @comment = Comment.new(comment_params)   # 新しいコメントを作成
    @comment.user_id = current_user.id   # コメントのユーザーIDをセット
    @comment.post_id = @post.id   # コメントのポストIDをセット
    @comment.save  
    @comments = @post.comments   # ポストのコメントを取得
  end

  # ポストからコメントを削除します
  def destroy
    @post = Post.find(params[:post_id])   
    @comments = @post.comments   # ポストのコメントを取得
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy   # コメントを削除
  end

  private

  # コメントのデータに対するストロングパラメータ
  def comment_params
    params.require(:comment).permit(:comment)
  end
end

