require 'spec_helper'
feature 'Gmail sign up' do
  background 'I am on the accounts.google.com sign up page' do
    on_sign_up_page
  end

  scenario 'Sign up with valid credentials' do
    fill_form_with_valid_credentials_and_submit
    should_see_welcome_page_notification 'Welcome'
    sign_up_should_be_successfully
    can_signin_new_gmail_account
  end

  scenario 'Sign up with already used phone number' do
    fill_form_with_already_used_phone_and_submit
    should_see_current_page_notification 'This phone number has already been used too many times'
    cannot_signin_new_gmail_account
  end

  scenario 'Sign up with invalid credentials' do
    fill_form_with_invalid_credentials_and_submit
    sign_up_should_be_failed
    cannot_signin_new_gmail_account
  end
end
