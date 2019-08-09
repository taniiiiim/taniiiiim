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
require 'mysql2'

client = Mysql2::Client.new(:host => 'localhost', :username => 'taniiiiim', :password => 'Yuki1131@WMUD', :database => 'taniiiiim')

query = ("select * from Userinfo where Username = ?;")
statement = client.prepare(query)
result = statement.execute(session["Username"])
record = result.first

print "
<!Doctype=html>
<html lang=\"jp\">
<head>
<meta charset=\"utf-8\">
<meta name=\"description\" content=\"Create User:No Books, No Life\">
<link rel=\"stylesheet\" href=\"/style.css\">
<title>Update User:No Books, No Life
</title>
</head>

<body>

<article>
<h1><u>Update User</u>
</h1>

<form action=\"http://192.168.33.10/cgi-bin/cgi-html/updateuser.rb\" method=\"post\">
  <p><label for=\"Familyname\">Familyname</label><br>
  <input type=\"text\" required name=\"Familyname\" id=\"Familyname\" value=\"#{record["Familyname"]}\">
  </p>
  <p><label for=\"Firstname\">Firstname</label><br>
  <input type=\"text\" required name=\"Firstname\" id=\"Firstname\" value=\"#{record["Firstname"]}\">
  </p>
  <p><label for=\"Email\">Email</label><br>
  <input type=\"text\" required name=\"Email\" id=\"Email\" value=\"#{record["Email"]}\">
  </p>
  <p><label for=\"Age\">Age</label><br>
  <input type=\"text\" required name=\"Age\" id=\"Age\" value=\"#{record["Age"]}\">
  </p>
  <p><label for=\"Gender\">Gender</label><br>
  <input type=\"text\" required name=\"Gender\" id=\"Gender\" value=\"#{record["Gender"]}\">
  </p>
  <p><label for=\"Country\">Country</label><br>
  <input type=\"text\" required name=\"Country\" id=\"Country\" value=\"#{record["Country"]}\">
  </p>
  <p><label for=\"Address\">Address</label><br>
  <input type=\"text\" required name=\"Address\" id=\"Address\" value=\"#{record["Address"]}\">
  </p>
  <p><input type=\"submit\" name=\"Update\" value=\"Update\">
  </p>
</form>

<h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/home.rb\">Home</a> > <a href=\"http://192.168.33.10/cgi-bin/cgi-html/updateuser_form.rb\">Update User</a>
</h2>
<h2>User: #{session["Username"]}
</h2>
</article>

</body>

</html>"

end
