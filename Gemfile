source 'https://rubygems.org'

gemspec

gem "rake"

group :test do
  if ENV["CI"]
    gem "coveralls", require: false
  end
end