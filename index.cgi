#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'cgi'

$LOAD_PATH.unshift('lib')
require 'myapp'

q   = CGI.new
app = MyApp.new

app.request = q
app.path    = q.path_info

res = app.dispatch

print q.header({
	'charset' => 'UTF-8',
	'type' => res.content_type,
});
print res.content
