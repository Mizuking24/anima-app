class PostCommentsController < ApplicationController
  def create
    @anime = Anime.find_by(id: params[:anime_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.anime_id = @anime.id
    @comment.save
    render :index
  end

  def destroy
    @comment = PostComment.find_by(id: params[:id], anime_id: params[:anime_id]).destroy
    render :index
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
