module FlashMessageHelpers
  FLASH_MESSAGE_TYPES = [ :error, :notice, :message ]
  
  module ControllerHelpers

    def flash_changes(obj, options={})

      # If the object has any of these attributes, they'll be used as the name..
      name_attribute = %w(name title permalink id).detect do |a|
        obj.respond_to?(a.to_sym) && !obj.send(a.to_sym).nil?
      end
      name = options[:name] || obj[name_attribute.to_sym]
      name = "<b>#{name}</b>" unless name.blank?

      # Determine verb from params 
      verb = case params[:action]
      when "create" then "created"
      when "update" then "updated"
      when "destroy" then "deleted"
      else
        "somethinged"
      end
      
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