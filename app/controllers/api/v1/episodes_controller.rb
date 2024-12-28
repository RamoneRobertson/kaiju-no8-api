class Api::V1::EpisodesController < ApplicationController
  def index
    if params[:episode_num]
      @episodes = Episode.where(episode_num: [ params[:episode_num].to_i ])
    else
      @episodes = Episode.all
    end

    if params[:season]
      @episodes = Episode.where(season: [ params[:season] ])
    end
    render json: @episodes.order(release_date: :asc)
  end

  def create
    @episode = Episode.new(episode_params)

    if @episode.save
      render json: @episode, status:
    else
      render json: { error: @episode.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def episode_params
    params.require(:episode).permit(:title, :release_date, :description, :rating, :picture, :episode_num, :season)
  end
end
