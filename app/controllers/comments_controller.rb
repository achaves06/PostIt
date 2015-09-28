class CommentsController < ApplicationController

	before_action :require_user
	
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		@comment.creator = current_user
		if @comment.save
      flash[:success] = "Your comment was successfully created"
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
	end

  def vote
    @vote = Vote.create(vote: params[:vote], user_id: current_user.id, voteable: Comment.find(params[:id]))
    if @vote.valid?
      flash[:success] = "Your vote has been counted"
      redirect_to :back
    else
      flash[:danger] = "Your vote was not counted, you an only vote once"
      redirect_to :back
    end
  end

end