#!/usr/local/bin/ruby

print "Content-Type: text/html\n"
print "\n"

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
require 'mysql2'

if cgi["Familyname"] == "" || cgi["Firstname"] == "" || cgi["Email"] == "" || cgi["Age"] == "" || cgi["Gender"] == "" || cgi["Country"] == "" || cgi["Address"] == ""

  print "<html>\n
         <html lang=\"jp\">\n
         <head>\n
         <meta charset=\"utf-8\">\n
         <title>Update Failed</title>\n
         <style>body {\n
           text-align: center;\n
         background-color: red
         }\n
         h1 {
           font-size: 3em;\n;
           color: white;\n
         }\n
         h2 {
           font-size: 2em;\n
           color: white;\n
         </style>\n
         </head>\n\n
         <body>\n
         <article>\n
         <h1><u>Update Failed...</u></h1>\n
         <h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/updateuser_form.rb\">Retry</a></h2>\n
         <h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/home.rb\">Home</a></h2>\n
         <h2>User: #{session["Username"]}</h2>
         </article>\n
         </body>\n
         </html>"

else
client = Mysql2::Client.new(:host => 'localhost', :username => 'taniiiiim', :password => 'Yuki1131@WMUD', :database => 'taniiiiim')

query = ("update Userinfo set Familyname = (?), Firstname = (?), Email = (?), Age = (?), Gender = (?), Country = (?), Address = (?) where Username = (?);")
statement = client.prepare(query)
result = statement.execute(cgi["Familyname"], cgi["Firstname"], cgi["Email"], cgi["Age"], cgi["Gender"], cgi["Country"], cgi["Address"], cgi["Username"])

  print "<html>
         <html lang=\"jp\">\n
         <head>\n
         <meta charset=\"utf-8\">\n
         <title>Update Success!!!</title>\n
         <style>body {\n
           text-align: center;\n
           background-color: red
           }\n
         h1 {
           font-size: 3em;\n;
           color: white;\n
         }\n
         h2 {
           font-size: 2em;\n
           color: white;\n
         </style>\n
         </head>\n\n
         <body>\n
         <article>\n
         <h1><u>Update Success!!!</u></h1>\n
         <h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/userinformation.rb\">User Information</h2></a>\n
         <h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/updateuser_form.rb\">Update Again</a></h2>\n
         <h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/home.rb\">Home</a></h2>\n
         <h2>User: #{session["Username"]}</h2>
         </article>\n
         </body>\n
         </html>\n"
end
end
