# frozen_string_literal: true

require_relative "lib/signature_pad_rails/version"

Gem::Specification.new do |spec|
  spec.name = "signature_pad_rails"
  spec.version = SignaturePadRails::VERSION
  spec.authors = ["heyjeremy"]
  spec.email = ["hello@heyjeremy.com"]

  spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.summary     = "Signature pad integration for Rails applications"
  spec.description = "Easy integration of signature_pad.js with Rails, including models and views"
  spec.license     = "MIT"
  
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  
  spec.add_dependency "rails", ">= 7.0.0"
  spec.add_dependency "jsbundling-rails"
end
