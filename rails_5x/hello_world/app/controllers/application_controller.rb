class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render html: "Hello, World!"
  end

  def goodbye
    render html: "さようなら、世界！"
  end
end
