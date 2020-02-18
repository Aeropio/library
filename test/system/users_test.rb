require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "creating a User" do
    visit users_url
    click_on "New User"

    fill_in "City", with: @user.city
    fill_in "Driver license", with: @user.driver_license
    fill_in "Email", with: @user.email
    fill_in "First name", with: @user.first_name
    fill_in "Home address", with: @user.home_address
    fill_in "Last name", with: @user.last_name
    fill_in "Library card", with: @user.library_card_id
    fill_in "Middle name", with: @user.middle_name
    fill_in "Phone number", with: @user.phone_number
    fill_in "Unit number", with: @user.unit_number
    fill_in "Zip", with: @user.zip
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "updating a User" do
    visit users_url
    click_on "Edit", match: :first

    fill_in "City", with: @user.city
    fill_in "Driver license", with: @user.driver_license
    fill_in "Email", with: @user.email
    fill_in "First name", with: @user.first_name
    fill_in "Home address", with: @user.home_address
    fill_in "Last name", with: @user.last_name
    fill_in "Library card", with: @user.library_card_id
    fill_in "Middle name", with: @user.middle_name
    fill_in "Phone number", with: @user.phone_number
    fill_in "Unit number", with: @user.unit_number
    fill_in "Zip", with: @user.zip
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User was successfully destroyed"
  end
end
