require 'rubygems'
require 'bundler/setup'
require 'encoder_ring'

use Rack::Static, :urls => %w[/images], :root => "public"
run EncoderRing.new
