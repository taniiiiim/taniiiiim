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

if session.nil?

print "
<!Doctype=html>
<html lang=\"jp\">
<head>
<meta charset=\"utf-8\">
<meta name=\"description\" content=\"Login / Logout:No Books, No Life\">
<link rel=\"stylesheet\" href=\"/style.css\">
<title>Login / Logout:No Books, No Life
</title>
</head>

<body>

<article>
<h1><u>Login / Logout</u>
</h1>

<form action=\"http://192.168.33.10/cgi-bin/cgi-html/login_logout.rb\" mebthod=\"post\">
  <p><label for=\"Username\">Username</label><br>
  <input type=\"text\" required name=\"Username\" id=\"Username\">
  </p>
  <p><label for=\"Password\">Password</label><br>
  <input type=\"password\" required name=\"Password\" id=\"Password\">
  </p>
  <p><input type=\"submit\" name=\"Login\" value=\"Login\">
  </p>
</form>

<form action=\"http://192.168.33.10/cgi-bin/cgi-html/login_logout.rb\" method=\"post\">
  <p><input type=\"submit\" name=\"Logout\" value=\"Logout\">
  </p>
</form>

<h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/createuser_form.rb\">Create User</a>
</h2>


</h2>

</article>

</body>

</html>"

else

print "
<!Doctype=html>
<html lang=\"jp\">
<head>
<meta charset=\"utf-8\">
<meta name=\"description\" content=\"Share Experience:No Books, No Life\">
<link rel=\"stylesheet\" href=\"/style.css\">
<title>Share Experience:No Books, No Life
</title>
</head>

<body>

<article>
<h1><u>Share Experience</u>
</h1>

<form action=\"http://192.168.33.10/cgi-bin/cgi-html/shareexperience.rb\" method=\"post\">
  <p><label for=\"Bookname\">Bookname</label><br>
  <input type=\"text\" required name=\"Bookname\" id=\"Bookname\">
  </p>
  <p><label for=\"Autherfamilyname\">Autherfamilyname</label><br>
  <input type=\"text\" required name=\"Autherfamilyname\" id=\"Autherfamilyname\">
  </p>
  <p><label for=\"Autherfirstname\">Autherfirstname</label><br>
  <input type=\"text\" required name=\"Autherfirstname\" id=\"Autherfirstname\">
  </p>
  <p><label for=\"Published\">Published</label><br>
  <input type=\"text\" required name=\"Published\" id=\"Published\">
  </p>
  <p><label for=\"Price\">Price</label><br>
  <input type=\"text\" required name=\"Price\" id=\"Price\">
  </p>
  <p><label for=\"Keywords\">Keywords</label><br>
  <input type=\"text\" required name=\"Keywords\" id=\"Keywords\">
  </p>
  <p><label for=\"ISBN\">ISBN</label><br>
  <input type=\"text\" required name=\"ISBN\" id=\"ISBN\">
  </p>
  <p><input type=\"submit\" name=\"Register\" value=\"Register\">
  </p>
</form>

<h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/home.rb\">Home</a> > <a href=\"http://192.168.33.10/cgi-bin/cgi-html/shareexperience_form.rb\">Share Experience</a>
</h2>
<h2>User: #{session["Username"]}</h2>
</article>

</body>

</html>"

end
