$LOAD_PATH << '../lib'
$LOAD_PATH << '../screenshot'

require 'common'

class Helper

	def initialize(browser)
		@browser = browser
	end

	attr_accessor :browser

	def error_page?
		@browser.html.include? 'We feel terrible, something was wrong with that link'
	end

		def do_screenshot(filename)
		begin
			p "saving screenshot: #{DateTime.now.strftime("%d%b%Y%H%M%S")}.png"
			# @browser.driver.save_screenshot "./screenshot/#{filename}.png"
			@browser.screenshot.save "./screenshot/#{filename}.png"
		rescue Exception => e
			p "failed to save screen shot: #{e.message}"
		end
	end
end
