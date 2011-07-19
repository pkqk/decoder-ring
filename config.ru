require 'rubygems'
require 'bundler/setup'
require 'decoder_ring'

use Rack::Static, :urls => %w[/images], :root => "public"
run DecoderRing.new
