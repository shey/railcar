# Copyright (c) 2009-2019, Nick Quaranto

# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:

# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
ActiveSupport.on_load(:action_controller) do
  def append_info_to_payload(payload)
    payload.merge!(
      timestamp: Time.now.utc,
      env: Rails.env,
      network: {
        client: {
          ip: request.remote_ip
        }
      }
    )
    super
    payload[:rails] = {
      controller: payload.fetch(:controller),
      action: payload.fetch(:action),
      params: request.filtered_parameters.except('controller', 'action', 'format', 'utf8'),
      format: payload.fetch(:format),
      view_time_ms: payload.fetch(:view_runtime, 0.0),
      db_time_ms: payload.fetch(:db_runtime, 0.0)
    }
    payload[:http] = {
      request_id: request.uuid,
      method: request.method,
      status_code: response.status,
      response_time_ms: request.url,
      useragent: request.user_agent,
      url: request.url
    }

    method_and_path = [request.method, request.path].select(&:present?)
    method_and_path_string = method_and_path.empty? ? ' ' : " #{method_and_path.join(' ')} "

    payload[:message] ||= "[#{response.status}]#{method_and_path_string}(#{payload.fetch(:controller)}##{payload.fetch(:action)})"
  end
end

class SemanticErrorSubscriber
  include SemanticLogger::Loggable
  def report(error, handled:, severity:, context:, source: nil)
    logger.send severity.to_s.sub(/ing$/, ''), { exception: error, handled:, context:, source: }
  end
end

Rails.error.subscribe(SemanticErrorSubscriber.new)
