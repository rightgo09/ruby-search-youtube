require 'open-uri'
require 'nokogiri'
require 'myapp/model/youtube/result'

YOUTUBE_API = 'http://gdata.youtube.com/feeds/api/videos?orderby=viewCount&vq='

class Model
	class Model::Youtube
		attr_accessor :title, :link, :thumbnail_url

		def initialize(args = Hash.new)
			self.title         = args[:title]
			self.link          = args[:link]
			self.thumbnail_url = args[:thumbnail_url]
		end

		def Youtube.search(query = '')
			uri = URI(YOUTUBE_API + URI.encode(query))
			entries = self._parse_videos(uri.read)
			return Model::Youtube::Result.new(entries)
		end

		def Youtube._parse_videos(content)
			doc = Nokogiri::XML(content)
			entries = Array.new
			doc.search('entry').each { |entry|
				entries.push(Model::Youtube.new({
					:title => entry.search('title').text,
					:link  => entry.xpath('media:group/media:player').first['url'],
					:thumbnail_url => entry.xpath('media:group/media:thumbnail').first['url'],
				}));
			}
			return entries
		end

		def thumbnail
		end

		def to_hash
			return {
				:title        => self.title,
				:link         => self.link,
				:tumbnail_url => self.thumbnail_url,
			}
		end
	end
end
