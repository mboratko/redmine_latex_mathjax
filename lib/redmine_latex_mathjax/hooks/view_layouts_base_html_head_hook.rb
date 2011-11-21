module RedmineLatexMathjax
  module Hooks
    class ViewLayoutsBaseHtmlHeadHook < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(context={})
          return "<script type=\"text/x-mathjax-config\">
          MathJax.Hub.Config({
    extensions: ['tex2jax.js'],
    jax: ['input/TeX', 'output/HTML-CSS'],
    tex2jax: {
      inlineMath: [ ['$','$'], ['\\(','\\)'] ],
      displayMath: [ ['$$','$$'], ['\\[','\\]'] ],
      processEscapes: true
    },
    'HTML-CSS': { availableFonts: ['TeX'] }
  });
          </script>" +
            javascript_include_tag('https://d3eoax9i5htok0.cloudfront.net/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML')
      end
    end
  end
end
