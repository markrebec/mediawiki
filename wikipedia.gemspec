# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'wikicloth/version'

spec = Gem::Specification.new do |s|
  s.name = "wikipedia"
  s.version = Wikipedia::VERSION
  s.author = "Cyril Ucron David"
  s.email = "cyx.ucron@gmail.com"
  s.homepage = "http://code.google.com/p/wikipedia-client/"
  s.platform = Gem::Platform::RUBY
  s.summary = "Allows you to get wikipedia content through their API."
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
