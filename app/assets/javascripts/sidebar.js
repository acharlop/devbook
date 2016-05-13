
function toggle_class() {
	var row = $("div#class-row")
	if(row.is(":hidden")) {
		$("div#method-row").toggle(400)
		row.toggle(400)
	}
	return row
}
function show_method() {
	var row = $("div#method-row")
	if(row.is(":hidden")) {
		$("div#class-row").toggle(400)
		row.toggle(400)
	}
	return row	
}

function update_method_components (method) {
	$("div#description-body").html(method.description)
	$("div#syntax-body").html(method.signature)
	$("div#examples-body").html(method.example)
	$("div#source-body").html(method.source)
}

function show_class_components (articles) {
	var row = toggle_class()
	row.empty()
	row.append(articles)
}

$(document).ready(function() {

	$("div#jstree").on('click', '.js-class-select', function(event) {
		var button = $(event.currentTarget)
		var id = button.data("class-id")
		$.get('/articles/'+id, show_class_components)
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
