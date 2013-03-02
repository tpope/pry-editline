# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'pry-editline'
  s.version     = '1.1.2'
  s.authors     = ['Tim Pope']
  s.email       = ["code@tpop"+'e.net']
  s.homepage    = 'https://github.com/tpope/pry-editline'
  s.summary     = 'C-x C-e to invoke an editor on the current pry (or irb) line'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'rake'
end
