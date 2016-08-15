class CommentsController < ApplicationController
  before_action :require_admin, only: [:destroy]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html {redirect_to article_path(@article), notice: 'comment was created successfully.' }
        format.json { render :show, status: :created, location: @article}
      else
        format.html { redirect_to article_path(@article), notice: 'Oops, something went wrong.'}
        format.json { render json: @comment.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @article = Article.find(params[:article_id])
      if @comment.destroy
        flash[:success] = "Comment was successfully destroyed"
        redirect_to article_path(@article)
      end
  end

  private
    def comment_params
      params.require(:comment).permit(:user_id, :body, :rating)
    end
  
    def require_admin
      if logged_in? and !current_user.admin?
        flash[:danger] = "Only admin users can perform that action"
        redirect_to root_path
      end
    end

end
