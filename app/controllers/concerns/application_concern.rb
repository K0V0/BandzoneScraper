module ApplicationConcern
    extend ActiveSupport::Concern

    def query
        notNilString(params[:q])
    end
end