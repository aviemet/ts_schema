require_relative "lib/ts_schema/version"

Gem::Specification.new do |spec|
  spec.name        = "ts_schema"
  spec.version     = TsSchema::VERSION
  spec.authors     = ["Avram Walden"]
  spec.email       = ["aviemet@gmail.com"]
  spec.homepage    = "https://github.com/aviemet"
  spec.summary     = "Generates typescript definitions from ActiveRecord"
  spec.description = ""
	spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/aviemet/ts_schema"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency 'rails', '~> 7.0', '>= 7.0.2.3'
end
