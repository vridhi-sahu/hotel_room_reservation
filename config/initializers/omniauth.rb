  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '494244611219033', '9c805ba8a0efea13cb0b3699401cb0d8'
    provider :google_oauth2, '639047874457-qjjgih1a441i18gdtikstpe7ai4bbc42.apps.googleusercontent.com', 'p5HsoUIgbeUeQtPSO4gLblv7', skip_jwt: true
    OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
end
