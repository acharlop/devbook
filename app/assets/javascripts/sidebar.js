
// toggle class and method views

function show_class_row() {
	var row = $("div.class-row")
	if(row.is(":hidden")) {
		$("div.method-row").toggle(400)
		row.toggle(400)
	}
	return row
}
function show_method_row() {
	var row = $("div.method-row")
	if(row.is(":hidden")) {
		$("div.class-row").toggle(400)
		row.toggle(400)
	}
	return row	
}

// updated method and class ajax callback methods
function update_method_components (method) {
	var row = show_method_row()
	row.find("#description-body").html(method.description)
	row.find("div#syntax-body").html(method.signature)
	row.find("div#examples-body").html(method.example)
	row.find("div#source-body").html(method.source)
}

function show_class_components (articles) {
	var row = show_class_row()
	row.empty()
	row.append(articles)
}


// document ready

$(document).ready(function() {
	


	$("div#jstree").on('click', '.js-class-select', function(event) {
		var button = $(event.currentTarget)
		var id = button.data("class-id")
		$.ajax({
			url: '/articles/' + id,
			dataType: "html",
			success: show_class_components
		})
		
		// $.get('/articles/'+id, )
	})

	$("div#jstree").on('click', '.js-method-select', function(event) {
		event.preventDefault();
		var button = $(event.currentTarget)
		var id = button.data("method-id")
		$.get('/api/meths/'+id, function(data) {
			update_method_components(data)
		})
	});

})
