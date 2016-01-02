#############################################################
#                      PREREQUISITES                        #
#############################################################
Given(/^I am on the accounts\.google\.com sign up page$/) do
  @sp = SignUpPage.new
  @sp.load
end
####################################
#              ACTIONS             #
####################################

When(/^I fill the sign up form with valid credentials and submit$/) do
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

When(/^I fill the sign up form with already used phone and submit$/) do
  @user = FactoryGirl.create :user_with_used_phone
  @sp.fill_form_with_data(@user)
  @sp.continue_button.click
  @vp = VerificationPage.new
  @vp.verify_phone_number.set @user.mobile_phone
  @vp.continue_button1.click
end

When(/^I fill the sign up form with incorrect credentials and submit$/) do
  @user = FactoryGirl.create :bad_user
  @sp.fill_form_with_data(@user)
  @sp.continue_button.click
end

####################################
#              CHECKS              #
####################################

Then(/^I should see welcome page notification "([^"]*)"$/) do |text|
  @wp = WelcomePage.new
  expect(@wp.welcome.text.include? text).to be_truthy
end

Then(/^I should see current page notification "([^"]*)"$/) do |text|
  expect(@vp.phone_used_error.text.include? text).to be_truthy
end

Then(/^the sign up should be successfully$/) do
  expect(@wp.new_email.text.include? @user.username).to be_truthy
end

Then(/^the sign up should be failed$/) do
  username_err_msg = ['Please use only letters (a-z), numbers, and periods.',
                      'Please use between 6 and 30 characters.',
                      'Someone already has that username. Try another?']
  expect(username_err_msg.include? @sp.username_error.text).to be_truthy
  expect(@sp.password_error.text.include? 'Short passwords are easy to guess. Try one with at least 8 characters.').to be_truthy
end

Then(/^I can sign in to my new gmail account$/) do
  expect(GmailHelper.verify_connected(@user)).to be_truthy
end

Then(/^I can`t sign in to my new gmail account$/) do
  expect(GmailHelper.verify_connected(@user)).to be_falsey
end
