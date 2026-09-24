require 'redmine'

Redmine::Plugin.register :redmine_startpage do
  name 'Redmine Startpage plugin'
  author 'Txinto Vaz'
  description 'Select an internal Redmine page as the instance start page.'
  version '0.2.0'
  url 'https://github.com/gatATAC/redmine_startpage'
  author_url 'https://github.com/txinto'

  requires_redmine version_or_higher: '7.0.1'

  settings default: {
    'startpage_active' => false,
    'startpage_controller' => '',
    'startpage_action' => '',
    'startpage_id' => '',
    'startpage_argname' => '',
    'startpage_argvalue' => ''
  }, partial: 'settings/startpage_settings'
end

require_dependency 'welcome_controller'
require_dependency File.expand_path('lib/welcome_controller_patch', __dir__)

patch_redmine_startpage = proc do
  WelcomeController.prepend WelcomeControllerPatch unless WelcomeController < WelcomeControllerPatch
end

patch_redmine_startpage.call
Rails.application.config.to_prepare(&patch_redmine_startpage)
