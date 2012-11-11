#!/usr/bin/env ruby

$LOAD_PATH.unshift('lib')
require 'myapp/model/youtube'

result = Model::Youtube.search('Perl')

result.entries.each {|entry|
	puts entry.title
	puts entry.link
	puts entry.thumbnail_url
}

