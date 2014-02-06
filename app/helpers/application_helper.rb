module ApplicationHelper
	#determine which alert styling to use
	def flash_class(type)
		case type
		when :alert
			"alert-danger"
		when :notice
			"alert-success"
		else
			""
		end
    end

    def redirect(boolean)
    	case boolean
    	when true
    		"/feed"
    	when false
    		"/login"
    	end
    end
end
