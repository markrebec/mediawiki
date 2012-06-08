# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'mediawiki/version'

spec = Gem::Specification.new do |s|
  s.name = "mediawiki"
  s.version = MediaWiki::VERSION
  s.author = "Mark Rebec"
  s.email = "mark@markrebec.com"
  s.homepage = "http://github.com/markrebec/mediawiki"
  s.platform = Gem::Platform::RUBY
  s.summary = "Provides interaction with MediaWiki APIs."
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = "lib"
  s.description = File.read("README")
  s.has_rdoc = false
  s.extra_rdoc_files = ["README","MIT-LICENSE"]
  s.add_development_dependency 'test-unit'
  s.add_development_dependency 'activesupport'
  s.add_development_dependency 'i18n'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency(RUBY_VERSION =~ /^1\.9/ ? "simplecov" : "rcov")
end
