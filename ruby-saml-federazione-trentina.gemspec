$LOAD_PATH.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name = 'ruby-saml-federazione-trentina'
  s.version = '0.0.3'

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Fabiano Pavan"]
  s.date = Time.now.strftime("%Y-%m-%d")
  s.description = %q{SAML toolkit for Ruby programs to integrate with federazione PAT trentina }
  s.email = %q{fabiano.pavan@soluzionipa.it}
  s.files = `git ls-files`.split("\n")
  s.homepage = %q{https://github.com/fabianopavan/ruby-saml-federazione-trentina}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.summary = %q{SAML Ruby Tookit}

  s.add_runtime_dependency("canonix", ["0.1.1"])
  s.add_runtime_dependency("uuid", ["~> 2.3"])
  s.add_runtime_dependency("nokogiri")
end
