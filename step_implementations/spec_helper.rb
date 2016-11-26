require_relative "./pages/base_page.rb"

require 'selenium/webdriver'

Dir[File.join(File.dirname(__FILE__), './pages/*.rb')].each {|file| require file }


# Define your helpers...
module GaugeRubyExample
  module Helpers
    def customer_page
      GaugeRubyExample::Pages::CustomerPage.new
    end

    def product_page
      GaugeRubyExample::Pages::ProductPage.new
    end

    def product_list_page
      GaugeRubyExample::Pages::ProductListPage.new
    end

    def sign_up_page
      GaugeRubyExample::Pages::SignUpPage.new
    end
  end
end

# Include your helpers!
Gauge.configure do |config|
  config.include GaugeRubyExample::Helpers
end

# https://github.com/jnicklas/capybara#drivers
# Firefox 35 + Selenium has a bug - https://code.google.com/p/selenium/issues/detail?id=8390

# LOCAL RUN
# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end

# Capybara.default_driver = :selenium

# BROWSERSTACK
Capybara.register_driver :browserstack do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.new
  caps['os'] = "Windows"
  caps['os_version'] = "7"
  caps['browser'] = "Chrome"
  caps['browser_version'] = "53.0"
  caps['resolution'] = "1280x800"
  caps['browserstack.local'] = "true"
  caps['browserstack.debug'] = "true"

  caps['build'] = "BrowserStack Gauge Framework"
  caps['project'] = "BrowserStack Gauge Framework"

  Capybara::Selenium::Driver.new(app,
    :browser => :remote,
    :url => "http://<BROWSERSTACK_USERNAME>:<BROWSERSTACK_ACCESS_KEY>@hub.browserstack.com/wd/hub",
    :desired_capabilities => caps
  )
end

Capybara.default_driver = :browserstack
