%include head
      		
		<!-- <hr> -->
		<div class="xyz"><br /><h4>{{answer['question']}}</h4></div>
		<div class="xyz">
			<ul class="nav nav-tabs nav-stacked">
%for i in randomlist:
		
			<li><a href="#" style="font-size: 1.1em">{{answer['answer'][i]['value']}}</a></li>
		
%end
			</ul>
		</div>
  		
		<div class="xyzcenter"><button id="ant" type="button" class="btn btn-medium" disabled>Antwort</button><br /><br />
			<div class="progress">
    				<div class="bar bar-success" style="width: 0%;"></div>
    				<div class="bar bar-danger" style="width: 0%;"></div>
    		    	</div>
		</div>	
		    	
		<ul class="pager">
    			<li class="next"><a href="#">Next</a></li>
    		</ul>

	<script> 
	var question_count = 0;
	var ranswer_count = 0; 
	var ranswer_percent = 0.0;
	var filename_ = "{{filename}}";
	var key_ = "{{key}}";
	$(document).ready(function() { 
		$(".xyz ul li a").live("click",function() {
			var aanswer = $(this).html();
			$("#ant").html(aanswer);
		});

		$(".pager li a").click(function() {
			var aanswer = $("#ant").html();
			var req = $.ajax({
				url: "control",
				type: "POST",
				data: { answer_string: aanswer, filename: filename_, key: key_},
				dataType: "html"
				});
			req.done(function(re) {
				question_count = question_count + 1;
				if(re == "Richtig") { ranswer_count = ranswer_count + 1; }
				$("#ant").html("Letzte Antwort: " + re + " (" + ranswer_count + "/" + question_count + ")");
				ranswer_percent = ranswer_count * 100 / question_count;
				$(".bar-success").attr('style', 'width: ' + ranswer_percent + '%;');
				$(".bar-danger").attr('style', 'width: ' + (100.0 - ranswer_percent) + '%;');
			});
			var req = $.ajax({
				url: "getquestion",
				type: "GET",
				});
			req.done(function(re) {
				$(".xyz h4").html(re.question);
				$(".xyz ul li").detach();
				filename_ = re.filename;
				key_ = re.key;
				for (var i in re.answer)
				{
					$('<li><a href="#" style="font-size: 1.1em">'+re.answer[i].value+'</a></li>').appendTo('.xyz ul'); 
					
				}
			});
			
		}); 
	});  
	</script> 

%include foot

<!-- 

zusätzliche Angaben zum Urheberrecht:

Alle Artikel, wenn nicht anders gekennzeichnet, stehen unter der Creative Commons by 4.0 Lizenz (<a href="http://creativecommons.org/licenses/by/4.0/deed.de">CC by</a>)

Die Metadaten (json-Dateien) stehen unter der Lizenz: <a href="http://creativecommons.org/publicdomain/zero/1.0/">CC Zero</a>

verwendete Software: 
<a href="http://twitter.github.com/bootstrap/">bootstrap</a> MIT license
<a href="http://jquery.com/">jQuery</a> MIT license
<a href="http://bottlepy.org/">bottle</a> MIT license

-->
