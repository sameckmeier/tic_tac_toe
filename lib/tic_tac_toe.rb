require 'terminal-table'

Dir[File.join(__dir__, 'tic_tac_toe', 'view', 'abstract', '*.rb')].sort.each { |file| require file }

Dir[File.join(__dir__, '..', 'spec', 'factories', '*.rb')].sort.each { |file| require file }

Dir[File.join(__dir__, '**', '*.rb')].sort.each { |file| require file }
