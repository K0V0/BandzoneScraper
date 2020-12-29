module UsefulFunctions
    extend ActiveSupport::Concern

    def notNilString(str)
        return "" if str.nil?
        return str
    end

end