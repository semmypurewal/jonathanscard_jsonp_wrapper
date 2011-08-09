require 'rubygems'
require 'sinatra'
require 'net/http'
require 'uri'

default_msg = 'hi there, see <a href="http://jonathanstark.com/card/">http://jonathanstark.com/card/</a> for more info on this awesome social experiment<br/><br/>'+
  'here\'s an example url format:<br/>'+
  '<a href="http://jonathanscard.cloudfoundry.com/api/balances?callback=jsonpcallback">http://jonathanscard.cloudfoundry.com/api/balances?callback=jsonpcallback</a><br/><br/>'+
  'here\'s a full example using JSONP to access the API<br/>'+
  '<a href="http://jonathanscard.cloudfoundry.com/example/index.html">http://jonathanscard.cloudfoundry.com/example/index.html</a>'


base_url = 'http://jonathanstark.com/card/api'
methods = ['balances','latest','changes','summary']

get '/api/:method' do
  if(methods.include?(params[:method]))
    url = base_url+'/'+params[:method]
    resp = Net::HTTP.get_response(URI.parse(url));
    params['callback']?params['callback']+'('+resp.body+')':resp.body
  else
    '{"error":"sorry, that method is not currently supported"}'
  end
end

get '/' do
  default_msg
end

get '/api' do
  default_msg
end



