# encoding: UTF-8

Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'btr_rms_migrator'
  s.version       = '1.0.0.pre'
  s.summary       = 'The Migrator for Bureau of the Treasury Records Management from v1 to v2.'
  s.description   = 'The Migrator for Bureau of the Treasury Records Management from v1 to v2.'

  s.required_ruby_version = '>= 2.3.0'

  s.author        = 'Angel Aviel Madlangbayan Domaoan'
  s.email         = 'support@cdasia.com'
  s.homepage      = 'http://cdasia.com'
  s.license       = 'CD Technologies Asia, Inc.'

  s.files         = `git ls-files`.split("\n")
  s.require_path  = 'lib'

  s.add_dependency 'nokogiri'
end
