$(function(){
	    function initToolbarBootstrapBindings() {
	      var fonts = ['Serif', 'Sans', 'Arial', 'Arial Black', 'Courier', 
	            'Courier New', 'Comic Sans MS', 'Helvetica', 'Impact', 'Lucida Grande', 'Lucida Sans', 'Tahoma', 'Times',
	            'Times New Roman', 'Verdana'],
	            fontTarget = $('[title=Font]').siblings('.dropdown-menu');
	      $.each(fonts, function (idx, fontName) {
	          fontTarget.append($('<li><a data-edit="fontName ' + fontName +'" style="font-family:\''+ fontName +'\'">'+fontName + '</a></li>'));
	      });
	      $('a[title]').tooltip({container:'body'});
	    	$('.dropdown-menu input').click(function() {return false;})
			    .change(function () {$(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle');})
	        .keydown('esc', function () {this.value='';$(this).change();});

	      $('[data-role=magic-overlay]').each(function () { 
	        var overlay = $(this), target = $(overlay.data('target')); 
	        overlay.css('opacity', 0).css('position', 'absolute').offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
	      });
	      if ("onwebkitspeechchange"  in document.createElement("input")) {
	        var editorOffset1 = $('#editor1').offset();
	        var editorOffset2 = $('#editor2').offset();
	        var editorOffset3 = $('#editor3').offset();
	        $('#voiceBtn1').css('position','absolute').offset({top: editorOffset1.top, left: editorOffset1.left+$('#editor1').innerWidth()-35});
	        $('#voiceBtn2').css('position','absolute').offset({top: editorOffset2.top, left: editorOffset2.left+$('#editor2').innerWidth()-35});
	        $('#voiceBtn3').css('position','absolute').offset({top: editorOffset3.top, left: editorOffset3.left+$('#editor3').innerWidth()-35});
	      } else {
	        $('#voiceBtn1').hide();
	        $('#voiceBtn2').hide();
	        $('#voiceBtn3').hide();
	      }
		};
		function showErrorAlert (reason, detail) {
			var msg='';
			if (reason==='unsupported-file-type') { msg = "Unsupported format " +detail; }
			else {
				console.log("error uploading file", reason, detail);
			}
			$('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>'+ 
			 '<strong>File upload error</strong> '+msg+' </div>').prependTo('#alerts');
		};
	    initToolbarBootstrapBindings();  
		$('#editor1').wysiwyg({toolbarSelector: '[data-role=editor1-toolbar]'},{ fileUploadError: showErrorAlert} );
		$('#editor2').wysiwyg({toolbarSelector: '[data-role=editor2-toolbar]'},{ fileUploadError: showErrorAlert} );
		$('#editor3').wysiwyg({toolbarSelector: '[data-role=editor3-toolbar]'},{ fileUploadError: showErrorAlert} );
	    window.prettyPrint && prettyPrint();
	  });