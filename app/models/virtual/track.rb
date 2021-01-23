class Virtual::Track
    include Scraper 
    require 'digest'

    attr_reader :full_title, :title, :album, :href, :playsCount, :href_hash, :duration

    def initialize(options = {})
        assignParameters(options)
    end

    def self.find(slug)
        data = scrape("https://bandzone.cz/" + slug)
        tracks = data.css("ul#playlist").css("li")
        return processTracks(tracks)
    end

    def self.processTracks(tracks)
        result = []
        url_regex = /^(http\:\/\/|https\:\/\/)?(www)?(bandzone\.cz\/track\/)(play)(\/)(\d+)(.+)$/
        duration_regex = /^PT(\d*)M?(\d*\.*\d*)S*/
        album_regex = /\s*\-*\s*/
        plays_count_regex = /\D/i

        tracks.each do |track|
            album = track.css("span.album-title")[0]
            full_title = track.css("strong.title")[0].text.strip
            title = ""
            href = track['data-source'].sub(url_regex, "\\1\\2\\3download\\5\\6")
            duration_match = track.css("meta[itemprop=duration]")[0]['content'].match(duration_regex)
            if duration_match[2].blank?
                duration_seconds = duration_match[1]
                duration_minutes = "00"
            else
                duration_minutes = duration_match[1].to_s
                duration_seconds = duration_match[2].to_f.floor.to_s
            end
            duration_seconds = duration_seconds.length <= 1 ? "0#{duration_seconds}" : duration_seconds
            duration = "#{duration_minutes}:#{duration_seconds}"

            if album.nil?
                album = "Nezaradené"
                title = full_title
            else
                title = full_title.sub(album, "")
                album = album.text.strip.sub(album_regex, "")
            end

            result << new({
                full_title: full_title,
                title: title,
                album: album,
                plays_count: track.css("span.total-plays")[0].text.squish.gsub(plays_count_regex, ""),
                href: href,
                href_hash: Digest::MD5.hexdigest(href),
                duration: duration
            })

        end

        return result
    end 

end