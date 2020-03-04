require "terminal-table"

Dir[File.join(__dir__, "tic_tac_toe", "view", "abstract", "*.rb")].each {|file| require file }

Dir[File.join(__dir__, "..", "spec", "factories", "*.rb")].each {|file| require file }

Dir[File.join(__dir__, "**", "*.rb")].each {|file| require file }
