class StaticPagesController < ApplicationController
  def index
    flickr = Flickr.new
    if params[:flickr_id]
      begin
        @name = flickr.people.getInfo(:user_id => params[:flickr_id]).username
        @photo_urls = flickr.people.getPhotos(:user_id => params[:flickr_id]).map { |response| get_url(response) }
      rescue Flickr::FailedResponse
        flash.notice = 'Invalid Flickr ID'
      end
    end
  end

  private

  def get_url(response)
    "https://live.staticflickr.com/#{response['server']}/#{response['id']}_#{response['secret']}.jpg"
  end
end
