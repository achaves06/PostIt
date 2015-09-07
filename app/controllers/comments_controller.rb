class CommentsController < ApplicationController

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		@comment.creator = User.first
		if @comment.save
      flash[:success] = "Your comment was successfully created"
      redirect_to :back
    else
      redirect_to :back
    end
	end
end