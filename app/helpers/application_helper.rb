module ApplicationHelper
  def user_html_string(user)
    if user.nil?
      "You are not logged in"
    else
      super_string = ""
      if user.can_admin?
        super_string = "<span class=\"navbar-text\" style='color: red'>Superuser</span>"
      end
      "<span class=\"navbar-text\"> #{user.name} (#{user.email}) &mdash; </span>" + super_string
    end
  end
end
