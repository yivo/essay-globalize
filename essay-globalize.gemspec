# encoding: utf-8
Gem::Specification.new do |s|
  s.name            = 'essay-globalize'
  s.version         = '1.0.0'
  s.authors         = ['Yaroslav Konoplov']
  s.email           = ['yaroslav@inbox.com']
  s.summary         = 'Essay writer for globalize'
  s.description     = 'Essay writer for globalize'
  s.homepage        = 'http://github.com/yivo/essay-globalize'
  s.license         = 'MIT'

  s.executables     = `git ls-files -z -- bin/*`.split("\x0").map{ |f| File.basename(f) }
  s.files           = `git ls-files -z`.split("\x0")
  s.test_files      = `git ls-files -z -- {test,spec,features}/*`.split("\x0")
  s.require_paths   = ['lib']

  s.add_dependency 'activesupport', '>= 3.2.0'
  s.add_dependency 'activerecord', '>= 3.2.0'
  s.add_dependency 'essay', '~> 1.0.0'
end