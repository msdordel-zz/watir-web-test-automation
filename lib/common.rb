$LOAD_PATH << '../lib'
$LOAD_PATH << '../foo'

require 'rubygems'
require 'bundler/setup'

require 'logger'
require 'ignore'

gem 'minitest'
require 'minitest/autorun'
require 'wellbe-minitest'

require 'watir'
require "watir/wait"
require 'watir-dom-wait'
require 'webdriver-user-agent'
require 'benchmark'
include Benchmark
require 'helper'

def initialze_browser_session

    if ENV['ART_MOBILE'] == 'true'
        # TODO: allow for easy UserAgent configuration 
        Watir::always_locate = true
        driver = Webdriver::UserAgent.driver(:browser => :firefox, :agent => :iphone, :orientation => :portrait)
        #driver = Webdriver::UserAgent.driver(:browser => :chrome, :agent => :iphone, :orientation => :portrait)
        browser = Watir::Browser.new driver

    elsif ENV['ART_TABLET'] == 'true'
        Watir::always_locate = true
        driver = Webdriver::UserAgent.driver(:browser => :firefox, :agent => :iPad, :orientation => :landscape)
        #driver = Webdriver::UserAgent.driver(:browser => :chrome, :agent => :iPad, :orientation => :landscape)
        browser = Watir::Browser.new driver

    elsif ENV['HEADLESS'] == 'true'
        # Fireup the Browser & Maximize
        Watir::always_locate = true
        browser = Watir::Browser.new :firefox, headless: true;  
        #browser = Watir::Browser.new ENV['ART_URL'] || "chrome"
        #browser.driver.manage.window.maximize

    else
        # Fireup the Browser & Maximize
        Watir::always_locate = true
        browser = Watir::Browser.new :firefox; 
        #browser = Watir::Browser.new ENV['ART_URL'] || "chrome"
        browser.driver.manage.window.maximize
    end
        
    p "Browser is #{browser.driver.browser}"      # just output our Browser
    browser.goto $BASE_URL        # goto our site
    return browser

end
