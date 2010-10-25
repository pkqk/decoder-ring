require 'sinatra/base'
require 'erb'
require 'iconv'

class EncoderRing < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/fix' do
    erb :fix
  end

  post '/fix' do
    file_from(params[:file], 'LATIN1', 'UTF-8')
  end

  get '/bork' do
    erb :bork
  end

  post '/bork' do
    file_from(params[:file], 'UTF-8', 'LATIN1')
  end

  def file_from(file, from, to)
    headers = {
      "Content-Disposition" => "attachment; filename=#{file[:filename]}",
      "Content-Type" => file[:type]
    }
    contents = Iconv.iconv("UTF-8","LATIN1",file[:tempfile].read)
    [200, headers, contents]
  end
end
