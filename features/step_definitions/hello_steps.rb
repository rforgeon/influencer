

When(/^I go to the homepage$/) do
  visit root_path
end

Then(/^I should see the welcome message$/) do
  expect(body).to have_content("Welcome!")
end
