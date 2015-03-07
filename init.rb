require 'redmine'
require 'dispatcher' unless Rails::VERSION::MAJOR >= 3
::Rails.logger.info 'Redmine LaTeX MathJax'

Redmine::Plugin.register :redmine_latex_mathjax do
  name 'Redmine LaTeX MathJax'
  author 'Michael Boratko'
  description 'Employ MathJax in all settings: wiki, issues, or every page.'
  url ''
  author_url ''
  version '0.2.0'
end

# require 'redmine_latex_mathjax/hooks/view_layouts_base_html_head_hook'

if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    require_dependency 'redmine_latex_mathjax/hooks'
  end
else
  Dispatcher.to_prepare :redmine_latex_mathjax do
    require_dependency 'redmine_latex_mathjax/hooks'
  end
end

