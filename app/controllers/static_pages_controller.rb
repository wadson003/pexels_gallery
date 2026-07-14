class StaticPagesController < ApplicationController
  def index
    if params[:collection_id].present?
      @photos = PexelsService.new.fetch_collection(params[:collection_id])
    else
      @photos =[]
    end
  end
end
