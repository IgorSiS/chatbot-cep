
require_relative './process_request'

def pesquisar_cep(cep)

        validacep = /^\d{5}\d{3}$/ # Expressão regular para validar cep.

       if(validacep.match(cep)) # Falta validar caso o cep não exista

           address = ViaCep::Address.new(cep.to_s)
           retorna_cep = address.street + " - " + address.neighborhood+ " - " + address.city + " - " + address.state 

        else

            nao_encontrado = "CEP não encontrado ou inválido. Certifique que esteja correto e informa apenas números(ex: 99999999). Ou pesquise seu endereço para encontrar seu CEP"         
        end 
	      #Falta validar caso o CEP esteja com o formato certo e não encontrado.
	      #search.zipcode # => "01001-000"
		  #search = ViaCep::SearchByAddress.new(state: 'SP', city: 'São Paulo', street: 'Praça da Sé')
 end

