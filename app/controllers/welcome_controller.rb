class WelcomeController < ApplicationController
  unloadable
 
  before_filter :forward_to_wiki, :only => :index

  def forward_to_wiki
      redirect_to(:controller => "projects", :action => "wikisw", :id => "wiki")
  end

end
