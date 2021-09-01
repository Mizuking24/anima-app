class PostCommentsController < ApplicationController
  def create
    anime = Anime.find_by(id: params[:anime_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.anime_id = anime.id
    comment.save
    redirect_to anime_path(anime.id)
  end

  def destroy
    PostComment.find_by(id: params[:id], anime_id: params[:anime_id]).destroy
    redirect_to anime_path(params[:anime_id])
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
