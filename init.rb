require 'redmine'
::Rails.logger.info 'Redmine LaTeX MathJax Macro'
require File.dirname(__FILE__) + '/lib/redmine_latex_mathjax/hooks/view_layouts_base_html_head_hook'

Redmine::Plugin.register :redmine_latex_mathjax_macro do
  name 'Redmine LaTeX MathJax Macro'
  author 'RVD'
  description 'Employ MathJax in all settings: wiki, issues, or every page.'
  url 'https://github.com/process91/redmine_latex_mathjax'
  author_url 'https://github.com/vDorst'
  version '0.3.0'

  settings :default => {
    'latex_mathjax_url' => 'https://cdn.mathjax.org/mathjax/latest/MathJax.js',
    'latex_mathjax_inline_delimiter_start' => '$',
    'latex_mathjax_inline_delimiter_end' => '$',
    'latex_mathjax_block_delimiter_start' => '$$',
    'latex_mathjax_block_delimiter_end' => '$$',
    'latex_mathjax_html_css_config' => "availableFonts: ['TeX']\n"
  }, :partial => 'redmine_latex_mathjax/settings'

  Redmine::WikiFormatting::Macros.register do
    desc "MathJax Macro:\n\n" +
	    "Usage:\n"+ 
	    "{{mj( single line MathJax Syntax )}}\n\n" +
	    "{{mj\nMulti line\nMathJax Syntax\n}}"
    macro :mj, :parse_args => false do |obj, args, text|
      out = MathJaxEmbedMacro.mj_macro(obj, args, text)
    end
  end
end

class MathJaxEmbedMacro

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
	return "#{MathJaxEmbedMacro.delimiterStartBlock} #{text} #{MathJaxEmbedMacro.delimiterEndBlock}".html_safe
    else
	# Check argument length in Argument Mode
	if (arg != nil) && (arg.length < 1)
	    return self.mj_error("Input must be at least 1 character long.")
	end
	return "#{MathJaxEmbedMacro.delimiterStartInline} #{arg} #{MathJaxEmbedMacro.delimiterEndInline}".html_safe
    end
  end

  def self.delimiterStartInline()
	  return Setting.plugin_redmine_latex_mathjax_macro['latex_mathjax_inline_delimiter_start'] || ""
  end

  def self.delimiterEndInline()
	  return Setting.plugin_redmine_latex_mathjax_macro['latex_mathjax_inline_delimiter_end'] || ""
  end

  def self.delimiterStartBlock()
	  return Setting.plugin_redmine_latex_mathjax_macro['latex_mathjax_block_delimiter_start'] || ""
  end

  def self.delimiterEndBlock()
	  return Setting.plugin_redmine_latex_mathjax_macro['latex_mathjax_block_delimiter_start'] || ""
  end

  def self.URLToMathJax()
	  return Setting.plugin_redmine_latex_mathjax_macro['latex_mathjax_url'] || ""
  end
end
