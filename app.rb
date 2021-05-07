class App

  def call(env)
    perform_request
    [status, headers, body]
  end

  private

  def perform_request
    sleep rand(1..2)
  end

  def status
    200
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    ["Welcom aboard!\n"]
  end

end
