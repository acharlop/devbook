function toggleVisibility (me) {
	var wrapper = me.closest(".component-wrapper")
	var panel = wrapper.children(".panel")
	var body = panel.children(".panel-body")
	body.toggle(400)
	wrapper.find(".minimize").first().toggleClass('fa-minus fa-plus')
}

$(document).ready(function() {
	$(".minimize").on('click', function(e) {
		toggleVisibility($(e.currentTarget))
	})
	$(".component-head").on('click', function(e) {
		toggleVisibility($(e.currentTarget))
	})
})



// function viewClassArticles (id) {
// 	var row = $("div#class-row")
// 	row.empty()
// 	$.get('/api/klasses/'+id, function(articles) {


// 		articles.forEach( function(article) {

// 		});

// // <div class="component-wrapper">
// // 										<div class="component-head">
// // 							<h4>Examples</h4>
// // 						</div>
// // 						<div class="component-actions" id="examples-component-actions">
// // 							<h4>
// // 								<i class="fa fa-arrows move"></i>
// // 								&nbsp;
// // 								<i class="fa fa-minus minimize"></i>
// // 							</h4>
// // 						</div>
		
// // 		<div class="panel panel-primary" id="examples-panel">
// // 			<div class="panel-body" id="examples-body">
				
// // 			</div>
// // 		</div>
// // 	</div>

// 	});
// }