# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'supercast/version'

Gem::Specification.new do |gem|
  gem.name          = 'supercast'
  gem.version       = Supercast::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ['Jordan Ell']
  gem.email         = ['info@supercast.com']
  gem.description   = 'Supercast ruby client'
  gem.summary       = 'A HTTP client for accessing Supercast services.'
  gem.homepage      = 'https://github.com/company-z/supercast-api-ruby'
  gem.license       = 'Apache-2.0'

  gem.files         = Dir['{lib}/**/*.rb', 'bin/*']
  gem.test_files    = Dir['{spec}/**/*.rb']
  gem.require_paths = ['lib']

  gem.add_dependency('faraday', '~> 0.13')
  gem.add_dependency('net-http-persistent', '~> 3.0')

  gem.add_development_dependency 'rspec', '~> 3.8'
  gem.add_development_dependency 'shoulda-matchers', '3.1.2'
  gem.add_development_dependency 'simplecov', '0.16.1'
end
