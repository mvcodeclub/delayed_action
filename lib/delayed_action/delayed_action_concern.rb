module DelayedAction
  extend ActiveSupport::Concern

  included do
    # raise an error if we are using the inline active job
    if Rails.env.development?
      if Rails.application.config.active_job.queue_adapter == :inline
         raise  "ERROR: DelayedAction will cause deadlocks with the :inline active_job queue adapter.  Please switch to another adapter, such as delayed_job or resque"
      end
    end

    private

    def delayed_action_queue
      params_to_copy = ["SCRIPT_NAME", "PATH_INFO", "REQUEST_METHOD", "HTTP_COOKIE", "REQUEST_URI", "SERVER_NAME", "SERVER_PORT", "REMOTE_ADDR", "SERVER_PROTOCOL", "HTTP_HOST", "HTTP_USER_AGENT" , "HTTP_VERSION", "HTTP_X_FORWARDED_PROTO"]
      request_env = {}
      params_to_copy.each do |p|
        request_env[p] = request.env[p]
      end

      result = DelayedAction::DelayedActionResult.create request_env: request_env.to_json
      job = DelayedActionActiveJob.perform_later result
      redirect_to "#{request.path}?delayed_uuid=#{result.uuid}"

    end

    def delayed_action_view
      # unwrap the job, get the results and view it here
      result = DelayedAction::DelayedActionResult.find_by_uuid(params[:delayed_uuid])
      if result.result.blank?
        render html: "<html><head><title>Loading</title><meta http-equiv='refresh' content='5'></head><body>Loading, this page will refresh in 5 seconds.  Or, <a href='#{request.fullpath}'>refresh this page</a> for results...</body></html>".html_safe
      else
        render body: "#{result.result}", content_type: result.content_type
      end
    end

    def delayed_action_dispatch
      return if params[:force]

      if params[:delayed_uuid]
        delayed_action_view
      else
        delayed_action_queue
      end
    end

  end

  module ClassMethods
    def delayed_action(options = {})
      actions = options

      before_action :delayed_action_dispatch, only: actions

    end
  end

end

