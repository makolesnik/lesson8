# -*- coding: UTF-8 -*-

class GmailHelper
  class << self
    def get_verification_code_from_email
      login = 'qwerasdfljkh@gmail.com'
      password = '@Qwer123456'
      sleep 60
      gmail = Gmail.connect(login, password)
      email = gmail.inbox.find(:unread, from: login).first
      email.body.raw_source[/(?<=Your Google verification code is )(\d+)/]
    end

    def verify_connected(user)
      Gmail.connect(user.username, user.password).logged_in?
    end
  end
end
