class CommentsController < ApplicationController

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
    @comment.destroy
    redirect_to article_path(@article)
    
  end

  private
    def comment_params
      params.require(:comment).permit(:user_id, :body, :rating)
    end

end
