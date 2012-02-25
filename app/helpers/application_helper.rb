module ApplicationHelper
  def title
    args = {}
    if @establishments
      # @todo
    elsif @establishment
      # @todo
    end
    t "#{controller.controller_name}.#{controller.action_name}.title", args
  end

  # Open Graph tags
  def og_title
    if @establishments
      # @todo
    elsif @establishment
      # @todo
    elsif current_page?(controller: 'pages', action: 'index')
      'Resto-Net'
    else
      title
    end
  end

  def og_type
    if @establishments
      # @todo
    elsif @establishment
      # @todo
    else
      'website'
    end
  end

  def og_image
    root_url.chomp('/') + image_path('logo.gif')
  end

  def og_description
    t "layouts.application.description"
  end

  def current?(path)
    request.path == path.sub(%r{\b(en|fr)\b}, '')
  end

  # Overrides default method to handle locales.
  # @note +options+ must be a string.
  def link_to_unless_current(name, options = {}, html_options = {}, &block)
    link_to_unless current?(options), name, options, html_options, &block
  end



  def meta_description
    content_for?(:meta_description) ? content_for(:meta_description) : t(:meta_description)
  end

  def render_establishment_partial(establishment)
    case establishment.source
      when 'toronto'
        render :partial => 'toronto'
      when 'montreal'
        render :partial => 'montreal'
      when 'vancouver'
        render :partial => 'vancouver'
    end
  end

  # icons from http://code.google.com/p/google-maps-icons/
  def establishments_json(establishments)
    establishments.select{|e| e.geocoded?}.map do |establishment|
      infraction = establishment.infractions.first
      {
        :id     => establishment.id,
        :lat    => establishment.latitude,
        :lng    => establishment.longitude,
        :name   => establishment.name,
        :url    => url_for(establishment),
        :count  => establishment.infractions_count,
        :amount => number_to_currency(establishment.infractions_amount),
        :latest => {
          :date   => l(infraction.judgment_date),
          :amount => number_to_currency(infraction.amount),
        },
      }
    end.to_json
  end

  def map_translations_json
    {
      :total_infractions => t(:total_infractions),
      :latest_infraction => t(:latest_infraction)
    }.to_json
  end

  def address(establishment)
    establishment.street ? establishment.street : establishment.address
  end

end
