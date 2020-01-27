module ApplicationHelper
  def admin?
    current_user&.admin?
  end

  def tt(text, options = {})
    options[:scope] ||= 'activerecord.attributes'
    I18n.translate(text, options)
  end
end
