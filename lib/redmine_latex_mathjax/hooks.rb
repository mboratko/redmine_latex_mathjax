#*******************************************************************************
# redmine_latex_mathjax Redmine plugin.
#
# Hooks.
#
# Authors:
# - ...
#
# Terms of use:
# - GNU GENERAL PUBLIC LICENSE Version 2
#*******************************************************************************

module RedmineLatexMathjax
  class Hooks  < Redmine::Hook::ViewListener

    # Add stylesheets and javascripts links to all pages
    # (there's no way to add them on specific existing page)
    render_on :view_layouts_base_html_head,
      :partial => "redmine_latex_mathjax/headers" 

  end # class
end # module
