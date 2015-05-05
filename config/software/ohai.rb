#
# Copyright:: Copyright (c) 2015 - Fastly Inc.

name "ohai"
default_version "7.2.4"

source git: "git://github.com/fastly/ohai.git"

relative_path "ohai"

if windows?
  dependency "ruby-windows"
  dependency "ruby-windows-devkit"
else
  dependency "ruby"
  dependency "rubygems"
end

dependency "bundler"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  patch source: 'fix_default_route.patch'

  bundle "install --without development", env: env

  gem "build ohai.gemspec", env: env
  gem "install ohai*.gem" \
      " --no-ri --no-rdoc", env: env
end
