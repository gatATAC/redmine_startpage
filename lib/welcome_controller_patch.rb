 module WelcomeControllerPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)

      base.class_eval do

	    before_filter :forward_to_startpage, :only => :index
	  
      end
    end

    module InstanceMethods
	  def forward_to_startpage
		
		if (Setting.plugin_redmine_startpage['startpage_active'] && 
			  !Setting.plugin_redmine_startpage['startpage_controller'].blank?)
		  if (Setting.plugin_redmine_startpage['startpage_action'].blank?)
			action_to_redirect = nil
		  else
			action_to_redirect = Setting.plugin_redmine_startpage['startpage_action']
		  end
		
		  if (Setting.plugin_redmine_startpage['startpage_id'].blank?)
			id_to_redirect = nil
		  else
			id_to_redirect = Setting.plugin_redmine_startpage['startpage_id']
		  end
		
		  if (Setting.plugin_redmine_startpage['startpage_argname'].blank? ||
				Setting.plugin_redmine_startpage['startpage_argvalue'].blank?)
			argname_to_redirect = nil
			argvalue_to_redirect = nil
		  else
			argname_to_redirect = Setting.plugin_redmine_startpage['startpage_argname']
			argvalue_to_redirect = Setting.plugin_redmine_startpage['startpage_argvalue']
		  end
		
		  if (argname_to_redirect.nil?) 
			redirect_to(
			  :controller => Setting.plugin_redmine_startpage['startpage_controller'],
			  :action => action_to_redirect,
			  :id => id_to_redirect)
		  else
			redirect_to(
			  :controller => Setting.plugin_redmine_startpage['startpage_controller'],
			  :action => action_to_redirect,
			  :id => id_to_redirect,
			  argname_to_redirect => argvalue_to_redirect
			)
		  end
		end
	  end
	end
end

# Add module to Welcome Controller
WelcomeController.send(:include, WelcomeControllerPatch)