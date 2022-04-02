require "rake"

namespace :ts_schema do
	desc "Generates a schema file in the default javascripts location, or the location specified in the ts_config initializer options"
	task :generate do
		TsSchema.output_file
	end
end

namespace :db do
	def auto_generate_and_save_file
		TsSchema.output_file if TsSchema.configuration.auto_generate
	end

  task migrate: :environment do
    auto_generate_and_save_file
  end

  task rollback: :environment do
		auto_generate_and_save_file
  end

  task reset: :environment do
		auto_generate_and_save_file
  end

  task setup: :environment do
		auto_generate_and_save_file
  end
end
