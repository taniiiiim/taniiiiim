#!/usr/local/bin/ruby

print "Content-Type: text/html\n\n"

require "cgi"
require "cgi/session"
cgi = CGI.new

begin
session = CGI::Session.new(cgi, {"new_session"=>false})
rescue ArgumentError
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
<meta name=\"description\" content=\"読書家の読書家による、読書家のためのデータベース\">
<link rel=\"stylesheet\" href=\"/style_home.css\">
<title>No Books, No Life ~Let you spend a creative reading experience~
</title>
</head>

<body>
<article>

<h1>No Books, No Life<br>
<span class=\"subtitle\">~Let you spend a creative reading experience~
</h1>

<h2>~Menu~
<h2>
<h3 class=\"menu\"><a href=\"http://192.168.33.10/cgi-bin/cgi-html/searchbooks_form.rb\">Search Books</a><br>
<a href=\"http://192.168.33.10/cgi-bin/cgi-html/shareexperience_form.rb\">Share Experience</a><br>
<a href=\"http://192.168.33.10/cgi-bin/cgi-html/updatememories_form.rb\">Update Memories<a><br>
<a href=\"http://192.168.33.10/cgi-bin/cgi-html/disposebooks_form.rb\">Dispose Books</a><br>
</h3>

<h2>~User~
</h2>
<h3 class=\"user\"><a href=\"http://192.168.33.10/cgi-bin/cgi-html/userinformation.rb\">User Information</a><br>
<a href=\"http://192.168.33.10/cgi-bin/cgi-html/login_logout_form.rb\">Login / Logout</a>
</h3>

<h2>~Links~
</h2>
<h3 class=\"link\">
<a href=\"https://www.lmi.ne.jp/\">Link and Motivation</a><br>
<a href=\"https://communication.motivation-cloudapp.com/companies/3/member\">COMMUNICATION CLOUD</a><br>
<a href=\"https://www.amazon.co.jp/TEAM-5%E3%81%A4%E3%81%AE%E6%B3%95%E5%89%87-NewsPicks-Book/dp/4344034546\">
THE TEAM ~5つの法則~</a><br>
</h3>

<h2>User: #{session["Username"]}
</h2>

</article>
</body>

</html>"
end
