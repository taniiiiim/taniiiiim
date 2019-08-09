#!/usr/local/bin/ruby

print "Content-Type: text/html\n"
print "\n"

require "cgi"
require "cgi/session"
require 'cgi/session/pstore'

cgi = CGI.new

begin
  session = CGI::Session.new(cgi,{"new_session"=>false})
rescue ArgumentError
  session = nil
end

if session != nil
 
 session['count'] = session['count'].to_i +4 
  session.close
else
  session = CGI::Session.new(cgi,{"new_session"=>true})
  session['count'] ="1"
  session.close
end

header = cgi.header({"charset"=>"UTF-8"})
puts header
puts "Count is #{session['count']}"

