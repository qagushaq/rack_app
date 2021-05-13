require 'rack'
require_relative 'middleware/dataformat'

class App

  def call(env)
    request = Rack::Request.new(env)
    request_valid?(request) ? operate_request(request) : response_bad_request
  end

  private

  def operate_request(request)
    params_string = request.params['format']
    @data_format = DataFormat.new(params_string)
    @data_format.check_formats
    @data_format.success? ? response_success : response_unknown_formats
  end

  def request_valid?(request)
    request.get? &&
    request.path == '/time' &&
    request.params['format']
  end

  def response(status, body)
    Rack::Response.new(body, status, {'Content-Type' => 'text/plain'}).finish
  end

  def response_bad_request
    response(404, 'Check your request')
  end

  def response_success
    response(200, @data_format.converted_formats)
  end

  def response_unknown_formats
    response(400,"Unknown time format #{@data_format.rejected_params}")
  end

end
