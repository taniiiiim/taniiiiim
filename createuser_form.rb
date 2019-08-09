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

print "
<!Doctype=html>
<html lang=\"jp\">
<head>
<meta charset=\"utf-8\">
<meta name=\"description\" content=\"Create User:No Books, No Life\">
<link rel=\"stylesheet\" href=\"/style.css\">
<title>Create User:No Books, No Life
</title>
</head>

<body>

<article>
<h1><u>Create User</u>
</h1>

<form action=\"http://192.168.33.10/cgi-bin/cgi-html/createuser.rb\" method=\"post\">
  <p><label for=\"Familyname\">Familyname</label><br>
  <input type=\"text\" required name=\"Familyname\" id=\"Familyname\">
  </p>
  <p><label for=\"Firstname\">Firstname</label><br>
  <input type=\"text\" required name=\"Firstname\" id=\"Firstname\">
  </p>
  <p><label for=\"Username\">Username</label><br>
  <input type=\"text\" required name=\"Username\" id=\"Username\">
  </p>
  <p><label for=\"Email\">Email</label><br>
  <input type=\"text\" required name=\"Email\" id=\"Email\">
  </p>
  <p><label for=\"Password\">Password</label><br>
  <input type=\"password\" required name=\"Password\" id=\"Password\">
  </p>
  <p><label for=\"Retype Password\">Retype Password</label><br>
  <input type=\"password\" required name=\"Retype Password\" id=\"Retype Password\">
  </p>
  <p><label for=\"Age\">Age</label><br>
  <input type=\"text\" required name=\"Age\" id=\"Age\">
  </p>
  <p><label for=\"Gender\">Gender</label><br>
  <input type=\"text\" required name=\"Gender\" id=\"Gender\">
  </p>
  <p><label for=\"Country\">Country</label><br>
  <input type=\"text\" required name=\"Country\" id=\"Country\">
  </p>
  <p><label for=\"Address\">Address</label><br>
  <input type=\"text\" required name=\"Address\" id=\"Address\">
  </p>
  <p><input type=\"submit\" name=\"Register\" value=\"Register\">
  </p>
</form>

<h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/login_logout_form.rb\">Login / Logout</a> > <a href=\"http://192.168.33.10/cgi-bin/cgi-html/createuser_form.rb\">Create User</a>
</h2>

</article>

</body>

</html>"
