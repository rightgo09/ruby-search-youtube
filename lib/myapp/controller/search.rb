require 'myapp/model/youtube'

class Controller::Search < Controller
	def do_task
		self.view.vars({
			'result' => Model::Youtube.search(self.req['q']),
			'q'      => self.req['q'],
		})
	end
end
