# frozen_string_literal: true

require_relative "libclang/version"

module Libclang
  class Error < StandardError; end

  class << self
    def version
      VERSION
    end

    def libdir
      @libdir ||= File.expand_path("../vendor/lib", __dir__)
    end

    def path
      @path ||= Dir["#{libdir}/*clang.*"].first
    end
  end
end
