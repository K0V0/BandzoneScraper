class SongsController < ApplicationController

    def list
        @songs = Virtual::Track.find(query)
        render json: @songs
    end

end
