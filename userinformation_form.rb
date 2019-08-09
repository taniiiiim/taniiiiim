#!/usr/local/bin/ruby

print "Content-Type: text/html\n"
print "\n"

require "cgi"
require "cgi/session"
cgi = CGI.new
begin
  session = CGI::Session.new(cgi, {"new_session"=>false})
rescue ArgumentError
  session = nil
end

p session

print "
<!Doctype=html>
<html lang=\"jp\">
<head>
<meta charset=\"utf-8\">
<meta name=\"description\" content=\"Create User:No Books, No Life\">
<link rel=\"stylesheet\" href=\"/style.css\">
<title>User Information:No Books, No Life
</title>
</head>

<body>

<article>
<h1><u>User Information</u>
</h1>

<form action=\"http://192.168.33.10/cgi-bin/cgi-html/userinformation.rb\" method=\"post\">
  <p><label for=\"Username\">Username</label><br>
  <input type=\"text\" required name=\"Username\" id=\"Username\">
  </p>
  <p><label for=\"Password\">Password</label><br>
  <input type=\"password\" required name=\"Password\" id=\"Password\">
  </p>
  <p><input type=\"submit\" name=\"Display\" value=\"Display\">
  </p>
</form>

<h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/home.rb\">Home</a> > <a href=\"http://192.168.33.10/cgi-bin/cgi-html/userinformation_form.rb\">User Information</a>
</h2>

</article>

</body>

</html>"
