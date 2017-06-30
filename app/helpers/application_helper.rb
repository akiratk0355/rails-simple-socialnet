module ApplicationHelper
  def user_html_string(user)
    if user.nil?
      "You are not logged in"
    else
      super_string = ""
      if user.can_admin?
        super_string = " &mdash; <b style='color: red'>Superuser</b>"
      end
      "<b style='color: white'> #{user.name} (#{user.email}) </b> " + super_string
    end
  end
end
