class SearchersController < ApplicationController

    def bands
        @bands = Virtual::Band.find(query)
        render json: @bands
    end

end
