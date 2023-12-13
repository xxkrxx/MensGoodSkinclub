class Public::CommentsController < ApplicationController

    def create
        @post = Post.find(params[:post_id])
        @comments = Comment.new(comment_params)
        @comments.user_id = current_user.id
        @comments.post_id = @post.id
        @comments.save
    end

    def destroy  
        @post = Post.find(params[:post_id])
        @post_comments = @post.comments
        Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    end

    private

    def comment_params
        params.require(:comment).permit(:comment)
    end
end
