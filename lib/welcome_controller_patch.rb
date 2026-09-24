# frozen_string_literal: true

module WelcomeControllerPatch
  def self.prepended(base)
    base.before_action :redirect_to_configured_startpage, only: :index
  end

  private

  def redirect_to_configured_startpage
    settings = Setting.plugin_redmine_startpage || {}
    return unless ActiveModel::Type::Boolean.new.cast(settings['startpage_active'])

    controller = settings['startpage_controller'].to_s.strip
    return if controller.blank?

    target = { controller: controller }
    action = settings['startpage_action'].to_s.strip
    identifier = settings['startpage_id'].to_s.strip
    argument_name = settings['startpage_argname'].to_s.strip
    argument_value = settings['startpage_argvalue'].to_s.strip

    target[:action] = action if action.present?
    target[:id] = identifier if identifier.present?
    target[argument_name] = argument_value if argument_name.present? && argument_value.present?

    redirect_to target
  rescue ActionController::UrlGenerationError => error
    Rails.logger.error("redmine_startpage cannot generate its configured route: #{error.message}")
  end
end
