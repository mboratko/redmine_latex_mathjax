require 'redmine'
::Rails.logger.info 'Redmine LaTeX MathJax Macro'
require File.dirname(__FILE__) + '/lib/redmine_latex_mathjax/hooks/view_layouts_base_html_head_hook'

Redmine::Plugin.register :redmine_latex_mathjax_macro do
  name 'Redmine LaTeX MathJax Macro'
  author 'René van Dorst'
  description 'Employ MathJax in all settings: wiki, issues, or every page.'
  url 'https://github.com/vDorst/redmine_latex_mathjax'
  author_url 'https://github.com/vDorst'
  version '0.3.0'

  Redmine::WikiFormatting::Macros.register do
    desc "MathJax Macro:\n\n" +
	    "Usage:\n"+ 
	    "{{mj( single line MathJax Syntax )}}\n\n" +
	    "{{mj\nMmulti line\nMathJax Syntax\n}}"
    macro :mj, :parse_args => false do |obj, args, text|
      out = MathJaxEmbedMacro.mj_macro(obj, args, text)
    end
  end
end

class MathJaxEmbedMacro
  # Modify the delimiter.
  @@delimiter = '~~~'
  # Modify URL to MathJax.
  @@url = 'https://cdn.mathjax.org/mathjax/latest/MathJax.js'
  def self.mj_error(text)
	return "<span id=\"errorExplanation\"><strong>MathJaxMacro:</strong> #{text}</span>".html_safe
  end
  def self.mj_macro(obj, arg, text)
    ## Check any argument is given
    if ((text == nil) && (arg.length == 0))
	return "<div id=\"errorExplanation\"><strong>MathJaxMacro:</strong> Usage:<ul><li><stong>Argument only</strong>: only single line MathJax Syntax</li>{{mj( MathJax Syntax )}}<li>Blocktext only: Multiline MathJax Syntax</li>{{mj<br/>Multi-<br/>line<br/>}}</ul></div>".html_safe
    end
    ## Check if both argument are given
    if ((text != nil) && (arg.length > 0))
	return self.mj_error("Usage: Don\'t mix argument and blocktext!")
    end
    # Use text is arg == nil
    if (text != nil)
	arg = text
    end
    # Check argument length in Argument Mode
    if (arg != nil) && (arg.length < 1)
	return self.mj_error("Input must be atlease 1 characet long.")
    end
    # Check for illegal charaters.
    if arg =~ /[<>]/
	return self.mj_error("Illegal characters found! Don\'t using < or >")
    end
    return "#@@delimiter #{arg} #@@delimiter".html_safe
  end
  def self.delimiter()
	  return @@delimiter
  end
  def self.URLToMathJax()
	  return @@url
  end
end