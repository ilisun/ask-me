# issue solutions https://github.com/thoughtbot/shoulda/issues/203
# no require of rails or active record, suppose this loads them
require "bundler/setup"
Bundler.require(:default, :test)

require "shoulda/matchers"
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec
    #with.test_framework :minitest
    #with.test_framework :minitest_4
    #with.test_framework :test_unit

    # Choose one or more libraries:
    # with.library :active_record
    # with.library :active_model
    # with.library :action_controller
    # Or, choose the following (which implies all of the above):
    with.library :rails
  end
end