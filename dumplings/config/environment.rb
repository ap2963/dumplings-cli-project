#specifies load path / order to load files. Loads gems before code

require 'bundler'

Bundler.require

require_all './lib' #requires all file in lib