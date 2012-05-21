require File.expand_path("../lib/simple_geocoder/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name     = 'simple_geocoder'
  spec.summary  = 'Simple interface to Google Geocoding API V3 for ruby.'
  spec.version     = ::SimpleGeocoder::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.email    = 'tsenying at gmail dot com'
  spec.authors  = ['Ying Tsen Hong']
  spec.homepage = 'http://github.com/tsenying/simple_geocoder'

  # silence a gem build warning.
  spec.rubyforge_project = 'N/A'
  
  spec.extra_rdoc_files = ['MIT-LICENSE', 'README.rdoc']

  # everything except the git files
  spec.files = Dir['**/*'].reject{ |f| f.include?('.git') }
  # spec.files += ['.gitignore']
  spec.test_files = Dir['test/*.rb']

  spec.description = %q{Simple Geocoder}
  # spec.require_paths = ["lib"] # default
  spec.has_rdoc = "true"

  spec.add_dependency('json', '~>1.7.3')
end
