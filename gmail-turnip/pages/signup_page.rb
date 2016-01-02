class SignUpPage < SitePrism::Page
  set_url 'https://accounts.google.com/signUp?service=mail'
  set_url_matcher /accounts.google.com\/signUp/

  element :first_name, '#FirstName'
  element :last_name, '#LastName'
  element :username, '#GmailAddress'
  elements :username_suggestions, '#username-suggestions a'
  element :username_error, '#errormsg_0_GmailAddress' # Please use between 6 and 30 characters.
  element :password_error, '#errormsg_0_Passwd' # Short passwords are easy to guess. Try one with at least 8 characters.

  element :password, '#Passwd'
  element :password1, '#PasswdAgain'
  element :birth_month_dropdown, "div[title='Birthday']"
  elements :months_list, "div[class='goog-menuitem']"
  element :birth_day_number, '#BirthDay'
  element :birth_year_number, '#BirthYear'
  element :gender_dropdown, '#Gender'
  elements :gender_options, "#Gender div[class='goog-menuitem']"
  element :gender_female, '#:e'
  element :gender_male, '#:f'
  element :gender_other, '#:g'
  element :recovery_phone_number, 'RecoveryPhoneNumber'
  element :recovery_email, 'RecoveryEmailAddress'
  element :skip_captcha_checkbox, '#SkipCaptcha'
  element :captcha_field, '#recaptcha_response_field'
  element :location_dropdown, 'div#CountryCode'
  elements :location_options, "#CountryCode div[class='goog-menuitem']"
  element :agree_checkbox, '#TermsOfService'
  element :continue_button, '#submitbutton'

  def fill_form_with_data(user)
    agree_checkbox.click
    skip_captcha_checkbox.click
    first_name.set user.first_name
    last_name.set user.last_name
    username.set user.username
    password.set user.password
    password1.set user.password
    username_suggestions.sample.click if username_suggestions.size > 0
    birth_month_dropdown.click
    months_list.sample.select_option
    birth_d = [*1..28].sample
    birth_y = [*(Time.new.year - 100)..(Time.new.year - 18)].sample
    birth_day_number.set birth_d
    birth_year_number.set birth_y
    gender_dropdown.click
    gender_options.sample.click
    location_dropdown.click
    location_options.sample.select_option
  end
end
