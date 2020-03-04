lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tic_tac_toe/version'

Gem::Specification.new do |spec|
  spec.name          = 'sams_tic_tac_toe'
  spec.version       = TicTacToe::VERSION
  spec.authors       = ['Sam Eckmeier']
  spec.email         = ['eckmeier41@gmail.com']

  spec.summary       = 'Simple, command line tic tac toe game'
  spec.description   = ''
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = ['play_tic_tac_toe']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'factory_bot', '~> 5.1.1'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.80.1'
  spec.add_runtime_dependency 'terminal-table', '~> 1.8'
end
