class Controller
	attr_accessor :req, :res, :view

	def handle_request
		self.do_task

		if self.res.content.nil? then
			# default content is view render
			self.res.content = self.view.render
		end

		self.res.content_type ||= 'text/html' # default content-type

		return self.res
	end
end
