require 'sinatra'
require 'sinatra/reloader'
require_relative 'CipherTools.rb'

set :sessions, true

title = 'CAESAR CIPHER'

instructions = "<strong>1.</strong> Type a message in the field below.<br>
<strong>2.</strong> Then select an encryption key from the dropdown menu.<br>
<strong>3.</strong> Finally, click 'encrypt message' to receive your newly encrypted message below!<br>"

default_message = 'no message'

module Caesar
	extend CipherTools
end

include Caesar

get '/' do 
	erb :index, :locals => {:title => title, 
							:instructions => instructions,
							:default_message => default_message}
end

get '/cipher' do
	@message = params["message"]
	@key = params["encrypt_key"].to_i
	@new_message = cipher(@message, @key)
	erb :index, :locals => {:title => title,
							:instructions => instructions,
							:new_message => @new_message}
end