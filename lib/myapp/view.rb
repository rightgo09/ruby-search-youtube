#require 'tenjin'
require 'erb'
include ERB::Util

class View
	attr_accessor :path_segments

	def initialize(args)
		self.path_segments = args['path_segments']
		@vars = Hash.new
	end

	def vars(args = nil)
		if args.nil? then
			return @vars
		else
			@vars.merge!(args)
		end
	end

	def template_file
		file = ['template', self.path_segments].join('/')
		file << '.html'

		return file
	end

	def render
#		t = Tenjin::Engine.new
#		out = t.render(self.template_file, self.vars)

#		f = open(self.template_file)
#		out = f.read
#		f.close

		erb = ERB.new(File.read(self.template_file))
		vars = self.vars
		out = erb.result(binding())

		return out
	end
end
