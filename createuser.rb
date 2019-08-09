#!/usr/local/bin/ruby

print "Content-Type: text/html\n"
print "\n"

require "cgi"
cgi = CGI.new

require 'mysql2'

client = Mysql2::Client.new(:host => 'localhost', :username => 'taniiiiim', :password => 'Yuki1131@WMUD', :database => 'taniiiiim')

if cgi["Password"] != cgi["Retype Password"] 
  print "<html>\n
         <html lang=\"jp\">\n
         <head>\n
         <meta charset=\"utf-8\">\n
         <title>Password not matched...</title>\n
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
         <h1><u>Password not matched...</u></h1>\n
         <h2><a href=\"/createuser\">Retry</h2>\n
         <h2><a href=\"/\">Home</h2>\n
         </article>\n
         </body>\n
         </html>"
else
  query = ("select * from Userinfo where Username = (?) or Email = (?);")
  statement = client.prepare(query)
  result = statement.execute(cgi["Username"], cgi["Email"])
  record = result.first

  if record.nil?
    query = ("insert into Userinfo (Familyname, Firstname, Username, Email, Password, Age, Gender, Country, Address) values (?, ?, ?, ?, ?, ?, ?, ?, ?);")
    statement = client.prepare(query)
    statement.execute(cgi["Familyname"], cgi["Firstname"], cgi["Username"], cgi["Email"], cgi["Password"], cgi["Age"], cgi["Gender"], cgi["Country"], cgi["Address"])

    print "<html>\n
           <html lang=\"jp\">\n
           <head>\n
           <meta charset=\"utf-8\">\n
           <title>Regeter success</title>\n
           <style>body {\n
             text-align: center;\n
             background-color: red;\n
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
           <h1><u>Register Successed!!!</u></h1>\n
           <h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/login_logout_form.rb\">Login</h2>\n
           </article>\n
           </body>\n
           </html>"
  else
    print "<html>\n
           <html lang=\"jp\">\n
           <head>\n
           <meta charset=\"utf-8\">\n
           <title>User Exists</title>\n
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
           <h1><u>User Exists...</u></h1>\n
           <h2><a href=\"http://192.168.33.10/cgi-bin/cgi-html/createuser_form.rb\">Retry</a></h2>
           </article>\n
           </body>\n
           </html>"
  end
end
