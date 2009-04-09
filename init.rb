require File.dirname(__FILE__) + '/lib/flash_message_helpers'

ActionController::Base.send( :include, FlashMessageHelpers::ControllerHelpers )
ActionView::Base.send( :include, FlashMessageHelpers::ViewHelpers )