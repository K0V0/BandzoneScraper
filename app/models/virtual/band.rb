class Virtual::Band
    include Scraper 

    attr_reader :title, :image_url, :href, :slug, :genre, :city, :tracks

    def initialize(options = {})
        assignParameters(options)
    end

    # rychle hladanie, top vysledky
    def self.find(search_term)
        data = scrape("https://bandzone.cz/hledani.html?q=" + search_term)
        childs = data.css("section#siteSearchBand").css("div.profileLinksSmall > div")
        return self.scrapeBandsData(childs)
    end

    # hladanie vsetko
    def self.findAll(search_term, page=1)
        result = OpenStruct.new
        page = scrape("https://bandzone.cz/kapely.html?q=#{search_term}&p=#{page}")
        rows = page.css('table#searchResults').css('div.profileLink.band')
        result.data = self.scrapeBandsData(rows)
        result.items_current_page = result.data.length
        paginator = page.css('div.paginator')[0]
        if paginator.nil?
            result.pages_count = 1
            result.current_page = 1
            result.items_total = rows.length
        else
            result.pages_count = paginator['data-paginator-pages'].to_i
            result.items_total = paginator['data-paginator-items'].to_i
            result.current_page = paginator.css('a.page.current').text.to_i
        end
        return result
    end

    def self.getBand(slug)
        result=[]
        data = scrape("https://bandzone.cz/" + slug)
        tracks = data.css("ul#playlist").css("li")
        genre = data.css("div.profile-name").css("h1.cutter").css("span.cityStyle").text
        title = data.css("div.profile-name").css("h1.cutter").text.sub(genre, "")

        result = new(
            title: title.strip,
            image_url: data.css("section#profilePhoto").css("img")[0]['src'],
            href: "",
            genre: genre.strip,
            city: "",
            tracks: Virtual::Track.processTracks(tracks)
        )
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