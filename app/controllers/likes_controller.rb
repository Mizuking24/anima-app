class LikesController < ApplicationController
  def create
    anime = Anime.find(params[:anime_id])
    like = current_user.likes.new(anime_id: anime.id)
    like.save
    redirect_to anime_path(anime)
  end

  def destroy
    anime = Anime.find(params[:anime_id])
    like = current_user.likes.find_by(anime_id: anime.id)
    like.destroy
    redirect_to anime_path(anime)
  end
end
