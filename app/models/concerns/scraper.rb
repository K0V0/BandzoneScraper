module Scraper

    def assignParameters(opts)
        opts.each do |k, v|
            iv = instance_variable_set("@#{k.to_s}", v)
        end
    end

    def self.included(base)
        base.instance_eval do 

            def scrape(url)
                html = URI.open(url)
                return Nokogiri::HTML(html)
            end

        end
    end

    module ClassMethods

    end

end