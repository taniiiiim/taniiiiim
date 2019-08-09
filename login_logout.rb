#!/usr/local/bin/ruby

require "cgi"
require "cgi/session"

cgi = CGI.new


begin
  session = CGI::Session.new(cgi,{"new_session"=>false})
rescue ArgumentError
  session = nil
end


if cgi["Logout"] == "Logout"  
  session = CGI::Session.new(cgi,{"new_session"=>true})
  session.delete
  header = cgi.header("charset"=>"UTF-8")
  puts header

  print "<html>\n
         <html lang=\"jp\">\n
         <head>\n
         <meta charset=\"utf-8\">\n
         <title>Logged-out</title>\n
         <style>body {\n
           text-align: center;\n
           background-color: red;
         }\n
         h1 {
           font-size: 3em;\n
           color: white;\n
         }\n
         h2 {
           font-size: 2em;\n
           color: white;\n
         </style>\n
         </head>\n\n
         <body>\n
         <article>\n
         <h1><u>Logged-out!!!</u></h1>\n
         <h2>See you again!</h2>
         <h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/login_logout_form.rb\">Login / Logout</h2></a>\n
         </article>\n
         </body>\n
         </html>\n"

elsif !(session.nil?)
  session['count'] = session['count'].to_i + 1
  session.close
  header = cgi.header("charset"=>"UTF-8")
  puts header
  print "<html>\n
         <html lang=\"jp\">\n
         <head>\n
         <meta charset=\"utf-8\">\n
         <title>Already Logged-in</title>\n
         <style>body {\n
           text-align: center;\n
           background-color: red;
         }\n
         h1 {
           font-size: 3em;\n;
           color: white;\n
         }\n
         h2 {
           font-size: 2em;\n
           color: white;\n
         }\n
         </style>\n
         </head>\n\n
         <body>\n
         <article>\n
         <h1><u>Already Logged!!!</u></h1>\n
         <h2>How are you doing, #{session["Username"]}?</h2>
         <h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/home.rb\">Home</h2></a>\n
         </article>\n
         </body>\n
         </html>\n"

elsif cgi["Login"] != "Login"

print "Content-Type: text/html\n\n"

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
  result = statement.execute(cgi["Username"])
  record = result.first

  if !(record.nil?) && cgi["Password"] == record["Password"] 

  session = CGI::Session.new(cgi,{"new_session"=>true})
  session['count'] = "1"
  session["Username"] = record["Username"]
  session["UserID"] = record["UserID"]
  session.close
 
  header = cgi.header("charset"=>"UTF-8")
  puts header

    print "<html>\n
           <html lang=\"jp\">\n
           <head>\n
           <meta charset=\"utf-8\">\n
           <title>Login success</title>\n
           <style>body {\n
             text-align: center;\n
             background-color: red;
           }\n
           h1 {
             font-size: 3em;\n;
             color: white;\n
           }\n
           h2 {
           font-size: 2em;\n
           color: white;\n
           }\n
           </style>\n
           </head>\n\n
           <body>\n
           <article>\n
           <h1><u>Login Success!!!</u></h1>\n
           <h2>How have you been, #{session["Username"]}?</h2>
           <h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/home.rb\">Home</h2></a>\n
           </article>\n
           </body>\n
           </html>\n" 
else
    header = cgi.header("charset"=>"UTF-8")
    puts header

    print "<html>\n
           <html lang=\"jp\">\n
           <head>\n
           <meta charset=\"utf-8\">\n
           <title>Login / Logout failed</title>\n
           <style>body {\n
             text-align: center;\n
             background-color: red;
           }\n
           h1 {
             font-size: 3em;\n;
             color: white;\n
           }\n
           h2 {
             font-size: 2em;\n
             color: white;\n
           }\n
           </style>\n
           </head>\n\n
           <body>\n
           <article>\n
           <h1><u>Login / Logout Failed...</u></h1>\n
           <h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/login_logout_form.rb\">Retry</h2>\n
           </article>\n
           </body>\n
           </html>"
end
end
