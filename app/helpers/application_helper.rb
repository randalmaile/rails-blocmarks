module ApplicationHelper
  def control_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'control-group error'
    else
      content_tag :div, capture(&block), class: 'control-group'
    end
  end

  def bookmark_thumbnail(metadata)
    image_tag(metadata[:thumbnail_url] || "thumb.png", width: "260")
  end
end
