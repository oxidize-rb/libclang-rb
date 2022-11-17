require "libclang"
require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'ffi'
  gem 'minitest', require: 'minitest/autorun'
end

module Clong
  extend FFI::Library

  ffi_lib Libclang.path
  attach_function :clang_getClangVersion, [], :string

  def self.version
    clang_getClangVersion
  end
end

describe FFI do
  it "works" do
    assert_equal(Clong.version, "clang version 14.0.6")
	end
end
