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

    request_query_string_valid? ? response_success : response_unknown_formats
  end

  def request_query_string_valid?
    @data_format.rejected_params.empty?
  end

  def request_valid?(request)
    request.get? && request.path == '/time' &&
    !request.params.empty? && !request.params['format'].nil?
  end

  def response(options)
    [
      options[:status],
      {'Content-Type' => "text/html"},
      [options[:body]]
    ]
  end

  def response_bad_request
    response({status: 404, body: 'Check your request'})
  end

  def response_success
    response({status: 200, body: @data_format.converted_formats})
  end

  def response_unknown_formats
    response({status: 400, body: "Unknown time format #{@data_format.rejected_params}"})
  end

end
