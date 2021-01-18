class BandsController < ApplicationController

    def show
        @band = Virtual::Band.getBand(params[:slug])
        render json: @band
    end

end
