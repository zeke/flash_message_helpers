module FlashMessageHelpers
  FLASH_MESSAGE_TYPES = [ :error, :notice, :message ]
  
  module ControllerHelpers

    def flash_changes(obj, name=nil)
      name = obj.try(:name) if name.blank?
      name = obj.try(:title) if name.blank?
      name = "<b>#{name}</b>" unless name.blank?
      # Be sure to set config.time_zone in environment.rb, or the following will not work!
      verb = (obj.created_at.to_i < 5.seconds.ago.to_i) ? "updated" : "created"
      flash[:notice] = "#{obj.class.to_s} #{name} was successfully #{verb}."
    end
    
  end

  module ViewHelpers

    def render_flash_message(css_class, message = "")
      content_tag(:p, message, :class => "#{css_class}") unless message.nil? || message.blank?
    end
  
    def render_flash_messages(div_id = "flash_messages", div_class = "")
      div_content = ''
      FLASH_MESSAGE_TYPES.each do |key|
        div_content << render_flash_message( key.to_s, flash[key] ) unless flash[key].blank?
      end
      content_tag( 'div', div_content, :id => div_id, :class => div_class ) unless div_content.blank?
    end
    
    def flash_message_set?
      FLASH_MESSAGE_TYPES.any? {|key| !flash[key].blank? }
    end
    
  end
end