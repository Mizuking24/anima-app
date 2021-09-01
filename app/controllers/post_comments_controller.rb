class PostCommentController < ApplicationController
  def create
    anime = Anime.find(params[:id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = anime.id
    comment.save
    redirect_to post_path(@anime)
  end

  def destroy
    PostComment.find_by(id: params[:id], anime_id: params[:anime_id]).destroy
    redirect_to post_image_path(params[:anime_id])
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
