source 'http://rubygems.org'

gemspec

group :test do
  gem "ruby-debug", "~> 0.10.4" if RUBY_VERSION == "1.8.7"
  gem "debugger" if RUBY_VERSION == "1.9.3"
  gem "byebug" if RUBY_VERSION > "2"
  gem "shoulda"
  gem "rake"
  gem "mocha"
  gem "nokogiri"
end
