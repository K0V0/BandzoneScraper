class SearchersController < ApplicationController

    def bands_fast
        @bands = Virtual::Band.find(query)
        render json: @bands
    end

    def bands_all
        @bands = Virtual::Band.findAll(query, params[:p])
        render json: @bands
    end

end
