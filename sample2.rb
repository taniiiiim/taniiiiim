#!/usr/local/rbenv/shims/ruby

print "Content-Type: text/html\n\n"


require "cgi"
require "cgi/session"
cgi = CGI.new
begin
 # セッション取得
  # 値が true のときは強制的に新しいセッションを始めます。
   # 値が false のときは、リクエストにセッション ID が含まれていない場合に
    # 例外 ArgumentError が発生します。 値がないときは、リクエストにセッション ID が
     # 含まれている場合はそれを使用し、含まれていない場合は新しいセッションを始めます。
      #  (default: 偽)
       session = CGI::Session.new(cgi,{"new_session"=>false})
       rescue ArgumentError
        session = nil
        end
        if cgi['logout'] == "1"   # ログアウトボタンが押されたら
         session.delete          # セッション削除
          redirect_url="http://#{ENV['SERVER_NAME']}#{ENV['REQUEST_URI']}"
           header = cgi.header({"charset"=>"UTF-8","status"=>"REDIRECT","Location"=>redirect_url})
            puts header             # このページにリダイレクト
            elsif session != nil      # セッションが存在していれば
             # HTMLでユーザ名とログアウトボタンを表示
              header = cgi.header("charset"=>"UTF-8")
               puts header
                puts <<-EOS
                <html>
                <head></head>
                <body>
                Hello #{session['name']}
                <form action="session_test.rb" method="post">
                 <input type="submit" value="logout">
                  <input type="hidden" name="logout" value="1">
                  </form>
                  </body>
                  </html>
                   EOS
                   elsif cgi['name'] != "" and cgi['password'] == "foo"    # ユーザ名が入力され、パスワードがfooなら
                    begin
                       session = CGI::Session.new(cgi,{"new_session"=>false})
                          session.delete
                           rescue ArgumentError
                            end
                             session = CGI::Session.new(cgi,{"new_session"=>true})   # セッションを張る
                              session['name'] = cgi['name']                           # セッション(Cookie)にユーザ名を保存
                               session.close
                                redirect_url="http://#{ENV['SERVER_NAME']}#{ENV['REQUEST_URI']}"
                                 header = cgi.header({"charset"=>"UTF-8","status"=>"REDIRECT","Location"=>redirect_url})
                                  puts header   # このページにリダイレクト
                                  else
                                   # HTMLでログインページを表示
                                    header = cgi.header("charset"=>"UTF-8")
                                     puts header
                                      puts <<-EOS
                                      <html>
                                      <head></head>
                                      <body>
                                      <form action="session_test2.rb" method="post">
                                       name : <input type="text" name="name"><br>
                                        password : <input type="password" name="password"><br>
                                         <input type="submit" value="login">
                                         </form>
                                          EOS
                                        end
