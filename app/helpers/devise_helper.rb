# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
# devise helper
module DeviseHelper

  def devise_simple_error_messages!
    return if resource.errors.empty?

    sentence = "Ooops!"
    if resource.errors.count == 1
      message =  resource.errors.full_messages[0]
      html = <<-HTML
        <div class="bg-red-lightest border-l-4 border-red text-orange-dark p-4" role="alert">
          <p class="font-bold">#{sentence}</p>
          <p> #{message}.</p>
        </div>
      HTML
    else
      messages = resource.errors.full_messages.map { |msg| content_tag(:li, "#{msg}.") }
                         .join
      html = <<-HTML
        <div class="bg-red-100 border-l-4 border-red-500  mb-4 p-4 text-red-700" role="alert">
          <p class="font-bold">#{sentence}</p>
          <ul class="list-disc">
            #{messages}
          </ul>
        </div>
      HTML
    end

    html.html_safe
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength
