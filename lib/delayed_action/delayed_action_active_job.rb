class DelayedActionActiveJob < ActiveJob::Base

  queue_as :default

  def perform(result)

    begin
      # TODO: remove this hack
      Rack::Timeout.timeout = 0
    rescue

    end

    env = JSON.parse(result.request_env)
    session = ActionDispatch::Integration::Session.new(Rails.application)
    path = "#{env["PATH_INFO"]}?force=true"
    session.get path, nil, env
    result.update(result: session.response.body, content_type: session.response.content_type)

  end

end
