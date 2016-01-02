Feature: Gmail sign up
  In order to use gmail
  As a registered user
  I need to sign up

  Background:
    Given I am on the accounts.google.com sign up page

  Scenario: Sign up with valid credentials
    When I fill the sign up form with valid credentials and submit
    Then I should see welcome page notification "Welcome"
    And the sign up should be successfully
    And I can sign in to my new gmail account

  Scenario: Sign up with already used phone number
    When I fill the sign up form with already used phone and submit
    Then I should see current page notification "This phone number has already been used too many times"
    And I can`t sign in to my new gmail account


  Scenario: Sign up with incorrect credentials
    When I fill the sign up form with incorrect credentials and submit
    Then the sign up should be failed
    And I can`t sign in to my new gmail account
