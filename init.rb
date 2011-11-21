require 'redmine'
RAILS_DEFAULT_LOGGER.info 'Redmine LaTeX MathJax'

Redmine::Plugin.register :redmine_latex_mathjax do
  name 'Redmine Latex MathJax'
  author 'Michael Boratko'
  description 'Employ MathJax in all settings: wiki, issues, or every page.'
  url ''
  author_url ''
  version '0.1.0'
end

require 'redmine_latex_mathjax/hooks/view_layouts_base_html_head_hook'
