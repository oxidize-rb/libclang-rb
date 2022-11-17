# frozen_string_literal: true

require_relative "lib/libclang/version"

Gem::Specification.new do |spec|
  spec.name = "libclang"
  spec.version = Libclang::VERSION
  spec.authors = ["Ian Ker-Seymer"]
  spec.email = ["hello@ianks.com"]

  spec.summary = "The easiest way to install libclang in Ruby"
  spec.description = "Provides bundled static-linked libclang shared library for different platforms, which, should work well on OSX, Windows, as well as usual Linux distributions."
  spec.homepage = "https://github.com/oxidize-rb/libclang-rb"
  spec.license = "Apache-2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir["lib/**/*.rb", "LICENSE.txt", "README.md"]
  spec.bindir = "exe"
  spec.executables = []
  spec.require_paths = ["lib"]
  spec.extensions = []
  spec.cert_chain = ["certs/ianks.pem"]
  spec.metadata = {"rubygems_mfa_required" => "true"}
end
