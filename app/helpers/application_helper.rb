
module ApplicationHelper
  def contentful
    @client ||= Contentful::Client.new(
      space: "qvwo3s6zz3y2",
      access_token: "gf2Pskk-4gfnzt2T54F1LZSwD52uLnckrm1IrMcHXfM",
      environment: "master",
      dynamic_entries: :auto,
      raise_errors: true
    )
  end

  def render_contentful_content(content)
    return "" if content.nil? || content["content"].nil?

    html = ""

    content["content"].each do |node|
      case node["nodeType"]
      when "paragraph"
        # Join all text content of the paragraph node
        paragraph_text = node["content"].map { |child| child["value"] }.join
        html += "<p>#{paragraph_text}</p>"
      when "heading-1"
        # Example for headings (if applicable)
        heading_text = node["content"].map { |child| child["value"] }.join
        html += "<h1>#{heading_text}</h1>"
      # Add cases for other node types as needed
      else
        html += "<span>Unsupported node type: #{node["nodeType"]}</span>"
      end
    end

    html.html_safe
  end
end
