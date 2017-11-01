class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(comment_params)
    @comment.chef = current_chef
    if @comment.save
      ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
      #flash[:success] = "Comment was created successfully" - Flash not needed since comments are in real time.
      #redirect_to recipe_path(@recipe) - We don't want a redirect after posting a real time comment.
    else
      flash[:danger] = "Invalid! Comment was not created!"
      redirect_to :back
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:description)
  end
  
end