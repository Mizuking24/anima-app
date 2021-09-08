class PostCommentsController < ApplicationController
  def create
    @anime = Anime.find_by(id: params[:anime_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.anime_id = @anime.id
    @post_comment.save
    render :index
  end

  def destroy
    @anime = Anime.find_by(id: params[:anime_id])
    @post_comment = PostComment.find_by(id: params[:id], anime_id: params[:anime_id]).destroy
    render :index
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
