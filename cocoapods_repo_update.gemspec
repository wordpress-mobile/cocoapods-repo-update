# coding: utf-8
require File.expand_path('../lib/cocoapods_repo_update/gem_version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = CocoapodsRepoUpdate::NAME
  spec.version       = CocoapodsRepoUpdate::VERSION
  spec.authors       = ['James Treanor']
  spec.email         = ['jtreanor3@gmail.com']
  spec.description   = %q{A CocoaPods plugin that updates your specs repos on pod install if needed.}
  spec.summary       = %q{cocoapods-repo-update is a CocoaPods plugin that checks your dependencies when you run `pod install` and updates the local specs repositories if needed.}
  spec.homepage      = 'https://github.com/wordpress-mobile/cocoapods-repo-update'
  spec.license       = 'GPL-2.0'

  spec.files         = Dir['lib/**/*.rb']
  spec.test_files    = Dir['spec/**/*.rb']
  spec.require_paths = ['lib']
  spec.extra_rdoc_files = ['README.md']

  spec.add_dependency 'cocoapods', '~> 1.0', '>= 1.3.0'
end
