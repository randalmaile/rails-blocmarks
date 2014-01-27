module ApplicationHelper
  def control_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'control-group error'
    else
      content_tag :div, capture(&block), class: 'control-group'
    end
  end

  def embedlyThumb_or_default(embedly)
    if embedly[:thumbnail_url] == nil 
      image_tag("thumb.png", size: "260")
    else
      image_tag(embedly[:thumbnail_url], width: "260")
    end
  end
end
