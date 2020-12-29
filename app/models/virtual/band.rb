class Virtual::Band
    include Scraper 

    attr_reader :title, :image_url, :href, :slug, :genre, :city

    def initialize(options = {})
        assignParameters(options)
    end

    def self.find(search_term)
        result = []
        data = scrape("https://bandzone.cz/hledani.html?q=" + search_term)
        childs = data.css("section#siteSearchBand").css("div.profileLinksSmall > div")
        childs.each do |child|
            result << new({
                title: child.css("h4.title.cutter").text,
                image_url: child.css("img")[0]['src'],
                href: "https://bandzone.cz" + child.css("a")[0]['href'],
                slug: child.css("a")[0]['href'].sub("/", ""),
                genre: child.css("span.genre.cutter").text,
                city: child.css("span.city.cutter").text
            })
        end
        return result
    end

end