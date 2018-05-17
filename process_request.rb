require_relative './facebook'
require_relative './app'
require_relative './cep_endereco'


class ProcessRequest
  
   def request(request_json)

     fb = Facebook.new
      
      #Tentar fazer uma função
      messengerID = fb.parseGetId(request_json) #ID do usuário(único de cada usuário)
      messengerAction = fb.getActionUser(request_json) # Ação do usuário
   
  #Ações do usuário
       case messengerAction

         when 'action-cep'

         	messengerCEP = fb.getCep(request_json) 
      	  messageTextCEP = pesquisar_cep(messengerCEP)
      	  fb.post(fb.messageText(messengerID,messageTextCEP))
         	
        end
        	
     end 
  
end