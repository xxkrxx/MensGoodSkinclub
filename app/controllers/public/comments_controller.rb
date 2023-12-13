class Public::CommentsController < ApplicationController

    def create
        @post = Post.find(params[:post_id])
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        @comment.post_id = @post.id
        @comment.save
        @comments = @post.comments
    end

    def destroy  
        @post = Post.find(params[:post_id])
        @comments = @post.comments
        Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    end

    private

    def comment_params
        params.require(:comment).permit(:comment)
    end
end
