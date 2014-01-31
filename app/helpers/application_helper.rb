module ApplicationHelper
  def control_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'control-group error'
    else
      content_tag :div, capture(&block), class: 'control-group'
    end
  end

  def bookmark_thumbnail(metadata)
    image_tag(metadata[:thumbnail_url] || "thumb.png", width: "128")
  end
  
  def will_paginate(collection_or_options = nil, options = {})
      if collection_or_options.is_a? Hash
        options, collection_or_options = collection_or_options, nil
      end
      unless options[:renderer]
        options = options.merge :renderer => BootstrapLinkRenderer
      end
      super *[collection_or_options, options].compact
  end
end
