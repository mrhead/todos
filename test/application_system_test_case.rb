require "test_helper"

Capybara.register_driver :my_playwright do |app|
  Capybara::Playwright::Driver.new(app, browser_type: :chromium, headless: true)
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :my_playwright
end
