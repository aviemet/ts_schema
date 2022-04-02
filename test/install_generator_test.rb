require "test_helper"

class InstallGeneratorTest < Rails::Generators::TestCase
	tests TsSchema::Generators::InstallGenerator
	destination File.expand_path("../tmp", __FILE__)
	setup :prepare_destination

	test "it creats a file" do
		run_generator

		assert_file "config/initializers/ts_schema.rb"
	end
end
