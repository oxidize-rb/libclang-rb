# frozen_string_literal: true

require "io/console"
require "bundler/gem_tasks"

GEMSPEC = Bundler.load_gemspec("libclang.gemspec")

ARCH_MAP = {
  "x86_64-darwin" => "macosx_10_9_x86_64",
  "x86_64-linux" => "manylinux1_x86_64",
  "x86_64-linux-musl" => "musllinux_1_2_x86_64",
  "x64-mingw32" => "win_amd64",
  "x64-mingw-ucrt" => "win_amd64",
  "aarch64-linux" => "manylinux2014_aarch64",
  "arm64-darwin" => "macosx_11_0_arm64"
}

ARCH_MAP.each do |ruby_platform, py_platform|
  desc "Download libclang for from PyPI for #{py_platform}"
  task "vendor:#{ruby_platform}" do
    cmd = "python3 -m pip install --platform #{py_platform} -t tmp/#{ruby_platform} --no-deps libclang==#{GEMSPEC.version}"
    puts "==== #{ruby_platform} ===="
    puts "Running: #{cmd}"
    system cmd, exception: true
    FileUtils.mkdir_p("tmp/stage/#{ruby_platform}/vendor/lib/")
    libclang = Dir["tmp/#{ruby_platform}/clang/native/libclang.*"].first
    FileUtils.cp(libclang, "tmp/stage/#{ruby_platform}/vendor/lib/")
    FileUtils.rm_rf("tmp/#{ruby_platform}")
  end

  desc "Build staging gem directory (#{ruby_platform})"
  task "stage:#{ruby_platform}" => "vendor:#{ruby_platform}" do
    spec = GEMSPEC.dup
    FileUtils.mkdir_p("tmp/stage/#{ruby_platform}")
    spec.files.each do |file|
      FileUtils.mkdir_p(File.dirname("tmp/stage/#{ruby_platform}/#{file}"))
      FileUtils.cp file, "tmp/stage/#{ruby_platform}/#{file}"
    end
    spec.cert_chain.each do |file|
      FileUtils.mkdir_p(File.dirname("tmp/stage/#{ruby_platform}/#{file}"))
      FileUtils.cp file, "tmp/stage/#{ruby_platform}/#{file}"
    end
    spec.platform = Gem::Platform.new(ruby_platform)
    spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") unless ENV['CI']
    Dir.chdir "tmp/stage/#{ruby_platform}" do
      spec.files = Dir["**/*"].select { |f| File.file?(f) }
      File.write("libclang.gemspec", spec.to_ruby)
      system "gem build libclang.gemspec", exception: true
      FileUtils.mkdir_p("../../../pkg")
      FileUtils.mv Dir["*.gem"].first, "../../../pkg/"
    end
  end

  task "stage" => "stage:#{ruby_platform}"
end

task "sign" do
  next if ENV['CI']

  ENV["GEM_PRIVATE_KEY_PASSPHRASE"] = $stdin.getpass("Enter passphrase of gem signature key: ")
end

task :clean do
  FileUtils.rm_rf("tmp")
  FileUtils.rm_rf("pkg")
end

task default: ["clean", "sign", "stage"]
