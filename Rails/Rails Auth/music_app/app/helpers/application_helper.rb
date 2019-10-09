module ApplicationHelper
  def ugly_lyrics(lyrics)
    formatted_lyrics = ""
    lyrics.lines.each do |line|
      formatted_lyrics += "&#9835; #{h(line)}"
    end

    "<pre class='lyrics'>#{formatted_lyrics}</pre>".html_safe
  end

  def error_messages(object)
    if object.errors.full_messages.any?
      errors = "<div class='errors'>"
      object.errors.full_messages.each { |error| errors << "<p>#{error}</p>" }

      errors.html_safe
    end
  end
end
