require 'redmine'

Redmine::Plugin.register :redmine_wiki_startpage do
  name 'Redmine Wiki Startpage plugin'
  author 'Txinto Vaz'
  description 'This is a plugin for Redmine.  It allows the user to select almost any redmine sub page as start page for a Redmine website'
  version '0.0.2'
  url 'http://gatatac.net/projects/redminewikistartpage'
  author_url 'http://gatatac.net/users/3'
  
  settings :default => {
    'startpage_active' => :false,
    'startpage_controller'  => '',
    'startpage_action' => '',
    'startpage_id' => '',
    'startpage_argname' => '',
    'startpage_argvalue' => ''
  }, :partial => 'settings/startpage_settings'  
end
