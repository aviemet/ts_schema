# frozen_string_literal: true

require "bundler/setup"
require "bundler/gem_tasks"
require "ts_schema"
# require "rails/plugin/test"

# RSpec::Core::RakeTask.new(:test)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[rubocop]
