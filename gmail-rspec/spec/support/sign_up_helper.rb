module SignUpHelper
  def on_sign_up_page
    @sp = SignUpPage.new
    @sp.load
  end

  def fill_form_with_valid_credentials_and_submit
    @user = FactoryGirl.create :user
    @sp.fill_form_with_data(@user)
    @sp.continue_button.click
    @vp = VerificationPage.new
    @vp.verify_phone_number.set @user.mobile_phone
    @vp.continue_button1.click
    code = GmailHelper.get_verification_code_from_email
    @vp.verification_code_field.set code
    @vp.continue_button2.click
  end

  def fill_form_with_already_used_phone_and_submit
    @user = FactoryGirl.create :user_with_used_phone
    @sp.fill_form_with_data(@user)
    @sp.continue_button.click
    @vp = VerificationPage.new
    @vp.verify_phone_number.set @user.mobile_phone
    @vp.continue_button1.click
  end

  def fill_form_with_invalid_credentials_and_submit
    @user = FactoryGirl.create :bad_user
    @sp.fill_form_with_data(@user)
    @sp.continue_button.click
  end

  def should_see_welcome_page_notification(text)
    @wp = WelcomePage.new
    expect(@wp.welcome.text.include? text).to be_truthy
  end

  def should_see_current_page_notification(text)
    expect(@vp.phone_used_error.text.include? text).to be_truthy
  end

  def sign_up_should_be_successfully
    expect(@wp.new_email.text.include? @user.username).to be_truthy
  end

  def sign_up_should_be_failed
    username_err_msg = ['Please use only letters (a-z), numbers, and periods.',
                        'Please use between 6 and 30 characters.',
                        'Someone already has that username. Try another?']
    expect(username_err_msg.include? @sp.username_error.text).to be_truthy
    expect(@sp.password_error.text.include? 'Short passwords are easy to guess. Try one with at least 8 characters.').to be_truthy
  end

  def can_signin_new_gmail_account
    expect(GmailHelper.verify_connected(@user)).to be_truthy
  end

  def cannot_signin_new_gmail_account
    expect(GmailHelper.verify_connected(@user)).to be_falsey
  end
end

RSpec.configure do |config|
  config.include SignUpHelper
end
