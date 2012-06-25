module RedmineLatexMathjax
  module Hooks
    class ViewLayoutsBaseHtmlHeadHook < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(context={})
          return "<script type=\"text/x-mathjax-config\">
          MathJax.Hub.Config({
    extensions: ['tex2jax.js'],
    jax: ['input/TeX', 'output/HTML-CSS'],
    tex2jax: {
      inlineMath: [ ['$','$'] ],
      displayMath: [ ['$$','$$'] ],
      processEscapes: true
    },
    'HTML-CSS': { availableFonts: ['TeX'] }
  });
          MathJax.Hub.Typeset();
          </script>" +
            javascript_include_tag('http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML') + 
            javascript_include_tag('https://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js')+
            '<script>
  jQuery.fn.contentChange = function(callback){
    var elms = jQuery(this);
    elms.each(
      function(i){
        var elm = jQuery(this);
        elm.data("lastContents", elm.html());
        window.watchContentChange = window.watchContentChange ? window.watchContentChange : [];
        window.watchContentChange.push({"element": elm, "callback": callback});
      }
    )
    return elms;
  }
  setInterval(function(){
    if(window.watchContentChange){
      for( i in window.watchContentChange){
        try {
        if(window.watchContentChange[i].element.data("lastContents") != window.watchContentChange[i].element.html()){
          window.watchContentChange[i].callback.apply(window.watchContentChange[i].element);
          window.watchContentChange[i].element.data("lastContents", window.watchContentChange[i].element.html())
        }
        }
        catch(err){}
      }
    }
  },500);
</script>' + 
            "<script>
            $.noConflict();
            jQuery(document).ready(function($) {
                $('#preview').contentChange(function() { MathJax.Hub.Typeset(); } );
            });
            </script>" 
      end
    end
  end
end
