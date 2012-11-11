require 'myapp/view'
require 'myapp/response'
require 'myapp/controller'

class MyApp
	attr_accessor :request, :path

	def dispatch
		con = self.controller
		
		con.req  = self.request
		con.res  = Response.new
		con.view = View.new({
			'path_segments' => [ self.path_segments ]
		})

		con.handle_request # handling by uri dispatching

		return con.res
	end

	# get controller instance
	def controller
		handler = ['myapp','controller', self.path_segments].join('/')
		require handler

		handler = self.get_class(self.get_classname(self.path_segments))

		return handler.new
	end

	def path_segments
		self.path ||= '/'

		path_segments = self.path.split('/')
		path_segments.shift
		path_segments.push('index') if path_segments.size == 0

		return path_segments
	end

	def get_classname(path_segments = Array.new)
		return ['controller', path_segments].join('::').gsub(/\w+/) do |m|
			m[0] = m[0,1].upcase; m
		end
	end

	def get_class(classname)
		return classname.split(/::/).inject(Object) do |c,name|
			c.const_get(name)
		end
	end
end
