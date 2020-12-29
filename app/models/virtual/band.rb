class Virtual::Band
    include Scraper 

    attr_reader :title, :image_url, :href, :slug, :genre, :city

    def initialize(options = {})
        assignParameters(options)
    end

    def self.find(search_term)
        data = scrape("https://bandzone.cz/hledani.html?q=" + search_term)
        childs = data.css("section#siteSearchBand").css("div.profileLinksSmall > div")
        return self.scrapeBandsData(childs)
    end

    def self.findAll(search_term, page=1)
        result = OpenStruct.new
        page = scrape("https://bandzone.cz/kapely.html?q=#{search_term}&p=#{page}")
        rows = page.css('table#searchResults').css('div.profileLink.band')
        result.data = self.scrapeBandsData(rows)
        paginator = page.css('div.paginator')[0]
        if paginator.nil?
            result.pages_count = 1
            result.current_page = 1
            result.items_total = rows.length
        else
            result.pages_count = paginator['data-paginator-pages']
            result.items_total = paginator['data-paginator-items']
            result.current_page = paginator.css('a.page.current').text
        end
        return result
    end

    private

    def self.scrapeBandsData(elementsCollection)
        result = []
        elementsCollection.each do |element|
            result << new({
                title: element.css("h4.title.cutter").text,
                image_url: element.css("img")[0]['src'],
                href: "https://bandzone.cz" + element.css("a")[0]['href'],
                slug: element.css("a")[0]['href'].sub("/", ""),
                genre: element.css("span.genre.cutter").text,
                city: element.css("span.city.cutter").text
            })
        end
        return result
    end

end