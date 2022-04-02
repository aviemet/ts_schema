require "rake"

namespace :ts_schema do
	desc "Generates a schema file in the default javascripts location, or the location specified in the ts_config initializer options"
	task :generate do
		TsSchema.generate
	end
end

namespace :db do
  task migrate: :environment do
    TsSchema.generate if TsSchema.configuration.auto_generate
  end

  task rollback: :environment do
    TsSchema.generate if TsSchema.configuration.auto_generate
  end

  task reset: :environment do
    TsSchema.generate if TsSchema.configuration.auto_generate
  end

  task setup: :environment do
    TsSchema.generate if TsSchema.configuration.auto_generate
  end
end
