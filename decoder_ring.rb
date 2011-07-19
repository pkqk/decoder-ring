require 'sinatra/base'
require 'erb'
require 'iconv'

class DecoderRing < Sinatra::Base
  get '/' do
    erb :index, :locals => {:title => "Change File Encodings"}
  end

  get '/fix' do
    erb :fix, :locals => {:title => "Fix encoding to UTF-8"}
  end

  post '/fix' do
    file_from(params[:file], 'LATIN1', 'UTF-8')
  end

  get '/bork' do
    erb :bork, :locals => {:title => "Change encoding to Latin1"}
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
