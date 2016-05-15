function toggleVisibility (me) {
	var wrapper = me.closest(".component-wrapper")
	var panel = wrapper.children(".panel")
	var body = panel.children(".panel-body")
	// body.toggle(400)
	panel.toggleClass('panel-open panel-closed');
	wrapper.find(".minimize").first().toggleClass('fa-minus fa-plus')
}

$(document).ready(function() {
	$(".component-row").on('click',".minimize",function(e) {
		toggleVisibility($(e.currentTarget))
	})
	$(".component-row").on('click',".component-head",function(e) {
		toggleVisibility($(e.currentTarget))
	})
})