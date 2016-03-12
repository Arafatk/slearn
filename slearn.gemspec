lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name        = 'slearn'
  spec.version     = '0.0.1'
  spec.date        = '2016-03-07'
  spec.summary     = 'A Supervised Machine learning gem.'
  spec.description = 'A Supervised Machine learning gem built on top of NMatrix and daru.'
  spec.authors     = ['Arafat Dad Khan']
  spec.email       = 'arafat.da.khan@gmail.com'
  spec.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/})}
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f)}
  spec.require_paths = ['lib']
  spec.homepage    = "TODO: Put your gem's website or public repo URL here."
  spec.add_development_dependency 'bundler', '1.8.4'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'nyaplot', '~> 0.1.5'
  spec.add_development_dependency 'nmatrix', '~> 0.2.1'
  spec.add_development_dependency 'daru', '~> 0.1.2'
  spec.license     = 'MIT'
end