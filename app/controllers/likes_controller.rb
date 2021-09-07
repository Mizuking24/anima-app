class LikesController < ApplicationController
  def create
    @anime = Anime.find(params[:anime_id])
    like = current_user.likes.new(anime_id: params[:anime_id])
    like.save
  end

  def destroy
    @anime = Anime.find(params[:anime_id])
    like = Like.find_by(anime_id: params[:anime_id], user_id: current_user.id)
    like.destroy
  end
end
