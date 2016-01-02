class WelcomePage < SitePrism::Page
  set_url_matcher /accounts.google.com\/SignUpDone/

  element :welcome, "div[class='welcome'] h1"
  element :new_email, "div[class='welcome'] h2"
end
