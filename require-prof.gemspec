Gem::Specification.new do |s|
  s.name        = 'require-prof'
  s.version     = '0.0.1'
  s.authors     = ["Greg Brockman"]
  s.email       = ["gdb@gregbrockman.com"]
  s.homepage    = 'https://github.com/gdb/require-prof'
  s.summary     = %q{Profile your project's requires}
  s.description = %q{Use require-prof to see how long you spend importing various code}

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
end
