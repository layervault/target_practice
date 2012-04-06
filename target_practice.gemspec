require './lib/target_practice/version'

Gem::Specification.new do |s|
  s.name = %q{target_practice}
  s.version = TargetPractice::VERSION

  s.authors = ["Kelly Sutton"]
  s.date = Time.now.utc.strftime("%Y-%m-%d")
  s.description = %q{A Ruby library for running TargetPractice (.tp) test suites.}
  s.email = %q{kelly@layervault.com}
  s.files = Dir.glob("lib/**/*") + [
     "README.md",
     "Gemfile",
     "target_practice.gemspec",
  ]
  s.homepage = %q{http://github.com/kellysutton/psd.rb}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.summary = %q{A Ruby library for running TargetPractice (.tp) test suites.}
  s.test_files = Dir.glob("test/**/*")
end

