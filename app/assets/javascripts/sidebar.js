// show 


// toggle class and method views

function show_class_row() {
	var row = $("div#class-row")
	if(row.is(":hidden")) {
		$("div#method-row").toggle(400)
		row.toggle(400)
	}
	return row
}
function show_method_row() {
	var row = $("div#method-row")
	if(row.is(":hidden")) {
		$("div#class-row").toggle(400)
		row.toggle(400)
	}
	return row	
}

// updated method and class ajax callback methods
function update_method_components (method) {
	var row = show_method_row()
	row.find("div#description-body").html(method.description)
	row.find("div#syntax-body").html(method.signature)
	row.find("div#examples-body").html(method.example)
	row.find("div#source-body").html(method.source)
}

function show_class_components (articles) {
	var row = show_class_row()
	row.empty()
	row.append(articles)

	make_sortable("div#class-row")
}

// dim language after 4 seconds

function dim_language () {
	$(".language-name").toggleClass('dim-language-name');
	$(".language-icon").toggleClass('colored');
}

// document ready

$(document).ready(function() {
	setTimeout(dim_language, 6000)

	$("#jstree").on("select_node.jstree", function(e, data){
		data.instance.toggle_node(data.node)
		data.instance.get_node(data.node.id,true).siblings('.jstree-open').each(function(){
			data.instance.close_node(this)
		})
	})

	$("div#jstree").on('click', '.js-class-select', function(event) {
		var button = $(event.currentTarget)
		var id = button.data("class-id")
		$.ajax({
			url: '/articles/' + id,
			dataType: "html",
			success: show_class_components
		})
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
