module RedmineLatexMathjax
  module Hooks
    class ViewLayoutsBaseHtmlHeadHook < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(context={})
          return "<script type=\"text/x-mathjax-config\">
          MathJax.Hub.Config({
    extensions: ['tex2jax.js'],
    jax: ['input/TeX', 'output/HTML-CSS'],
    tex2jax: {
  	  inlineMath: [ ['" + MatchJaxEmbedMacro.delimiter.html_safe + "','" + MatchJaxEmbedMacro.delimiter.html_safe + "'] ],
      displayMath: [ ],
      processEscapes: false,
      ignoreClass: 'text-diff'
    },
    'HTML-CSS': { availableFonts: ['TeX'] }
  });
          MathJax.Hub.Typeset();
          </script>" +
            javascript_include_tag(MatchJaxEmbedMacro.URLToMathJax + '?config=TeX-AMS-MML_HTMLorMML&delayStartupUntil=onload') +
            "<script type=\"text/javascript\">
  // Own submitPreview script with Mathjax trigger. Copy & Paste of public/javascripts/application.js
  function MJsubmitPreview(url, form, target) {
	$.ajax({
  	  url: url,
  	  type: 'post',
  	  data: $('#'+form).serialize(),
  	  success: function(data){
    	$('#'+target).html(data);
    	MathJax.Hub.Queue([\"Typeset\",MathJax.Hub,target]);
  	  }
	});
  }
  // Replace function submitPreview with own version with a Mathjax trigger
  document.addEventListener(\"DOMContentLoaded\", function() {
	a = document.getElementsByTagName(\"a\");
    for( var x=0; x < a.length; x++ ) {
      if ( a[x].onclick ) {
        str = a[x].getAttribute(\"onclick\");
        a[x].setAttribute(\"onclick\", str.replace(\"submitPreview\",\"MJsubmitPreview\"));
        break;
      };  
	};	
  });
</script>"
      end
    end
  end
end
