require 'sinatra'
require 'thin'
require 'json'
require 'pp'
require 'date'
require 'base64'
require 'via_cep'
require 'pp'

require_relative './facebook'
require_relative './process_request'

set :port, 9000

# -------------------------------------------------------------

post '/webhook' do 

    #PRECISO PEGAR QUAL É A AÇÃO QUE O USUÁRIO QUER atraés da action no json ..., E CHAMAR SUAS RESPECTIVAS FUNÇÕES EM OUTRO .RB
    
    pq = ProcessRequest.new
	#fb = Facebook.new();
	request_payload =  "#{ request.body.read }" # Recebe o conteúdo do usuário JSON do usuário
	request_json = JSON.parse(request_payload,symbolize_names: true) # Transforma em JSON
	
	puts '=========== REQUEST ================'
	pp request_json
	puts '=========== REQUEST END============='
    

    #Processr uma requisião do usuário
	pq.request(request_json)

	#FAZER UMA FUNÇÃO GENÊRICA ENVIANDO OS PARÂMETROS DO JSON QUE EU QUERO USAR E CHAMAR A FUNÇÃO GENERICA DO FACEBOOK.RB
	#DEFINO AQUI O QUE EU QUERO QUE ELE ENVIE PARA A FUNÇÃO GENÊRICA. Ela valida e me responde.

end