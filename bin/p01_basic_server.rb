require 'webrick'

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html

server = WEBrick::HTTPServer.new(Port: 3000)
trap('INT') { server.shutdown }

server.mount_proc('/') do |req, res|
  path = req.path
  res.content_type = "text/text"
  res.body = 'Main Screen Turn On: ' + path
  res.status = 200
end

server.start
