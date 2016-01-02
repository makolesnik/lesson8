class VerificationPage < SitePrism::Page
  set_url 'https://accounts.google.com/UserSignUpIdvChallenge'
  set_url_matcher /UserSignUpIdvChallenge/

  element :verify_phone_number, '#signupidvinput'
  element :verify_via_sms, '#signupidvmethod-sms'
  element :verify_via_voice, '#signupidvmethod-voice'
  element :continue_button1, '#next-button'
  element :verification_code_field, '#verify-phone-input'
  element :continue_button2, "input[name='VerifyPhone']"
  element :phone_used_error, "span[class='errormsg']"
end
