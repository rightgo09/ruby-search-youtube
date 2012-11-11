class Model
	class Model::Youtube
		class Model::Youtube::Result
			attr_accessor :entries

			def initialize(entries)
				self.entries = entries
			end
		end
	end
end
