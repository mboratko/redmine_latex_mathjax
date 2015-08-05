require 'redmine'
::Rails.logger.info 'Redmine LaTeX MathJax Macro'
require File.dirname(__FILE__) + '/lib/redmine_latex_mathjax/hooks/view_layouts_base_html_head_hook'

Redmine::Plugin.register :redmine_latex_mathjax do
  name 'Redmine LaTeX MathJax Macro'
  author 'René van Dorst'
  description 'Employ MathJax in all settings: wiki, issues, or every page.'
  url 'https://github.com/vDorst/redmine_latex_mathjax'
  author_url 'https://github.com/vDorst'
  version '0.2.0'

  Redmine::WikiFormatting::Macros.register do
    desc = "MathJax Macro: Usage: {{mj( MathJax Syntax )}}"
    macro :mj, :parse_args => false do |obj, args|
      out = MatchJaxEmbedMacro.mj_macro(obj, args)
    end
  end
end

class MathJaxEmbedMacro
  # Modify the delimiter.
  @@delimiter = '~~~'
  # Modify URL to MathJax.
  @@url = 'https://cdn.mathjax.org/mathjax/latest/MathJax.js'
  def self.mj_macro(obj, arg)
    raise "Usage: {{mj( MathJax Syntax )}}" unless arg.length >= 1
    out = "#@@delimiter #{arg} #@@delimiter".html_safe
  end
  def self.delimiter()
	  return @@delimiter
  end
  def self.URLToMathJax()
	  return @@url
  end
end

