require 'net/http'
require 'uri'

FB_GRAPH        = 'https://graph.facebook.com'
FB_MESSAGES     = 'https://graph.facebook.com/v2.10/me/messages'
FB_ACCESS_TOKEN = 'EAAFPp0gLttwBAPO0bkZBu9k4jKVeTrDO4vM5cjin3KhJvreN06RdZCKiKRZAW9xsSDYeQmzGe46nkeFomsmbmjRVVil5hCkCl8I1z7A8IJI1MZAmABAMHrnZBoVzgIA3r6ZB8zZAQPAegM6wnApp7DTf3aP5Xfc1NLf2ZBphBgGKZBAZDZD'

class Facebook

  def post(objJson)
    uri = URI.parse(FB_MESSAGES+"?access_token="+FB_ACCESS_TOKEN)

    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = JSON.dump(objJson)
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
      http.finish
    end
    # puts response.code
    # puts response.body
  end


  def getIdData(id)
    uri = URI.parse(FB_GRAPH+"/"+id)
    params = {:fields => "name,email", :access_token => FB_ACCESS_TOKEN}

    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)

    # puts response.body if response.is_a?(Net::HTTPSuccess)
    return response.is_a?(Net::HTTPSuccess) ? JSON.parse(response.body,symbolize_names: true) : ""
  end

  def messageText(messengerID, text)
    objJson = {
      :recipient => {:id   => messengerID},
      :message   => {:text => text}
    }
    return objJson
  end


  #Pega o id do usuário pra fazer algo...
    def parseGetId(request_json)
      messengerID = ""
      request_json[:result][:contexts].each do |row|
        messengerID = row[:parameters][:facebook_sender_id] if row[:parameters].key? :facebook_sender_id
      end
      return messengerID
    end


  #Pega o id do usuário pra fazer algo...
    def getActionUser(request_json)
      messengerActionUser = ""
        messengerActionUser = request_json[:result][:action] if request_json[:result].key? :action
      return messengerActionUser
    end   

   #Fazer uma função PARA NAVEGAR NO JSON.. UM FUNÇÃO MAIS GENÊRICA..
   #INFORMAR AQUI SOMENTE OS PARÁMETROS QUE EU QUERO , ENVIADOS DE OUTRA FUNÇÃO.

    def getCep(request_json)
      messengerCEP = ""
      request_json[:result][:contexts].each do |row|
        messengerCEP = row[:parameters][:cep] if row[:parameters].key? :cep
        #Se ele encontrar na linha parâmetro o cep... Retorna o cep. o Parãmetro pe o que o usuário digita. o cep foi definido la no dialod...
      end
      return messengerCEP
    end

end