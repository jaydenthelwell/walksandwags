module ContentfulHelper
  def render_rich_text(content)
    return if content.blank?

    content["content"].map do |node|
      case node["nodeType"]
      when "paragraph"
        "<p>#{render_text_content(node)}</p>"
      when "heading-4"
        "<h4>#{render_text_content(node)}</h4>"
      when "heading-1"
        "<h1>#{render_text_content(node)}</h1>"
      when "heading-2"
        "<h2>#{render_text_content(node)}</h2>"
      when "unordered-list"
        render_unordered_list(node)
      when "list-item"
        render_list_item(node)
      when "embedded-asset-block"
        render_embedded_asset(node)
      else
        ""
      end
    end.join.html_safe
  end

  private

  def render_text_content(node)
    return "" if node["content"].blank?

    node["content"].map do |c|
      c["value"] if c["nodeType"] == "text" # Only extract text content from text nodes
    end.compact.join(" ") # Join the text content with spaces
  end

  def render_unordered_list(node)
    # Render unordered list (bullet points)
    items = node["content"].map { |item| render_list_item(item) }.join
    "<ul>#{items}</ul>"
  end

  def render_list_item(node)
    # Debugging: Log the entire node to check its structure
    Rails.logger.debug "Rendering List Item Node: #{node.inspect}"

    # Initialize a variable to store the list item content
    list_item_content = ""

    # Iterate through the content array
    node["content"].each do |child_node|
      Rails.logger.debug "Child Node: #{child_node.inspect}" # Log each child node

      # Check if the child node is a paragraph
      next unless child_node["nodeType"] == "paragraph"

      Rails.logger.debug "Paragraph found in list item" # Log if a paragraph is found

      # Extract the text content from the paragraph's content
      child_node["content"].each do |text_node|
        Rails.logger.debug "Text Node: #{text_node.inspect}" # Log each text node
        if text_node["nodeType"] == "text"
          # Append the text value to list_item_content
          list_item_content += text_node["value"]
        end
      end
    end

    # Debugging: Log the final content of the list item
    Rails.logger.debug "Final List Item Content: '#{list_item_content.strip}'"

    # Return the content wrapped in <li> tags
    "<li>#{list_item_content.strip}</li>".html_safe
  end

  def render_embedded_asset(node)
    # Log the entire node to inspect its structure
    Rails.logger.debug "Rendering node: #{node.inspect}"

    # Extract the asset from the embedded node
    asset = node["data"]["target"]
    return "<p>Asset not found.</p>" unless asset

    # Log the entire asset's fields to see their structure
    Rails.logger.debug "Asset fields: #{asset.fields.inspect}"

    # Check if the asset has the 'file' field
    file_field = asset.fields["file"]
    if file_field.nil?
      Rails.logger.warn "No 'file' field found for asset: #{asset.id}. Skipping image render."
      return "<p>Missing image file for this asset.</p>" # Fallback message for missing image
    end

    # Log the raw 'file' data to check its structure
    Rails.logger.debug "File field data: #{file_field.inspect}"

    # Check if the 'url' is present in the 'file' field
    image_url = file_field.url
    if image_url.nil? || image_url.empty?
      Rails.logger.warn "No valid URL found for asset: #{asset.id}. Skipping image render."
      return "<p>Missing image URL for this asset.</p>" # Fallback message for missing image URL
    end

    # Explicitly handle the URL from Contentful
    # Ensure that the URL is fully qualified by prepending 'https:' if necessary
    image_url = "https:" + image_url unless image_url.start_with?("http")

    # Make sure the URL starts with the Contentful CDN domain if it's missing
    image_url = "https://cdn.contentful.com" + image_url unless image_url.include?("cdn.contentful.com")

    # Log the final image URL before rendering
    Rails.logger.debug "Final image URL: #{image_url}"

    # Ensure the image URL is correct
    return "<p>Missing image URL for this asset.</p>" if image_url.blank?

    # Use the title or default to a generic title for the image
    title = asset.fields["title"] || "Embedded Image"

    # Return the HTML for the image
    "<img src='#{image_url}' alt='#{title}' />".html_safe
  end
end
