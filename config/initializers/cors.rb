Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://github.com:80'
    resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  end
end
