class PostsController < ApplicationController
  def index
    @animes = Anime.all
  end

  def new
    @anime = Anime.new
  end

  def create
    @anime = Anime.new(anime_params)
    @anime.user_id = current_user.id
    @anime.save
    redirect_to animes_path
  end

  def show
    @anime = Anime.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @anime = Anime.find(params[:id])
  end

  def update
    @anime = Anime.find(params[:id])
    @anime.update(anime_params)
    redirect_to anime_path(@anime)
  end

  def destroy
    @anime = Anime.find(params[:id])
    @anime.destroy
    redirect_to animes_path
  end

  private
  def anime_params
    params.require(:anime).permit(:title, :image, :body)
  end
end
