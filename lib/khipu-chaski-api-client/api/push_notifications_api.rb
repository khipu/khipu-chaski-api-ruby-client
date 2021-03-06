require "uri"

module KhipuChaski
  class PushNotificationsApi
    attr_accessor :api_client

    def initialize(api_client = nil)
      @api_client = api_client || Configuration.api_client
    end

    # Enviar un nuevo mensaje
    # Encolar un nuevo mensaje para dispositivos moviles.
    # @param message Mensaje a enviar
    # @param [Hash] opts the optional parameters
    # @return [SuccessResponse]
    def send_message(message, opts = {})
      if Configuration.debugging
        Configuration.logger.debug "Calling API: PushNotificationsApi#send_message ..."
      end
      
      # verify the required parameter 'message' is set
      fail "Missing the required parameter 'message' when calling send_message" if message.nil?
      
      # resource path
      path = "/message".sub('{format}','json')

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}

      # HTTP header 'Accept' (if needed)
      _header_accept = ['application/json']
      _header_accept_result = @api_client.select_header_accept(_header_accept) and header_params['Accept'] = _header_accept_result

      # HTTP header 'Content-Type'
      _header_content_type = ['application/json']
      header_params['Content-Type'] = @api_client.select_header_content_type(_header_content_type)

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(message)
      

      auth_names = ['khipu']
      result = @api_client.call_api(:POST, path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => 'SuccessResponse')
      if Configuration.debugging
        Configuration.logger.debug "API called: PushNotificationsApi#send_message. Result: #{result.inspect}"
      end
      return result
    end
  end
end




