function toggleVisibility (me) {
	var wrapper = me.closest(".component-wrapper")
	var panel = wrapper.children(".panel")
	var body = panel.children(".panel-body")
	body.toggle(400)
	panel.toggleClass('js-panel-open js-panel-closed');
	wrapper.find(".minimize").first().toggleClass('fa-minus fa-plus')
}


function make_sortable(row) {
	$(row + " .component-col").sortable({
		handle: ".move",
		items: "> .component",
		placeholder: "placeholder",
		connectWith: ".component-col",
		stop: function(event, ui) {
			// add check for only one element
		}	
	})
}


$(document).ready(function() {
	$(".component-row").on('click',".minimize",function(e) {
		toggleVisibility($(e.currentTarget))
	})
	$(".component-row").on('click',".component-head",function(e) {
		toggleVisibility($(e.currentTarget))
	})

	// toggleVisibility($("div#source-panel"))
	
	make_sortable("div#method-row")
})
