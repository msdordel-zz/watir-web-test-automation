$LOAD_PATH << '../lib'
$LOAD_PATH << '../page'
$LOAD_PATH << '../modules'
$LOAD_PATH << '../imp-modules'


require 'common'

MiniTest::Unit.autorun
#Minitest.autorun

class MiniTest
  class Unit < MiniTest::Unit
    attr_accessor :browser, :helper
    def before_suites
      # code to run before the first test
      # p "Before everything"
      @browser = initialze_browser_session
      @helper = Helper.new(@browser)
    end

    def after_suites
      # code to run after the last test
      # p "After everything"
      @browser.close
    end

    def _run_suites(suites, type)
      begin
        before_suites
        super(suites, type)
      ensure
        after_suites
      end
    end

    def _run_suite(suite, type)
      begin
        suite.before_suite if suite.respond_to?(:before_suite)
        super(suite, type)
      ensure
        suite.after_suite if suite.respond_to?(:after_suite)
      end
    end

  end
end
