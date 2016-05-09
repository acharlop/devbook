$(document).ready(function($) {
	$(".minimize").on('click', function(e) {
		var self = $(e.currentTarget)
		var wrapper = self.closest(".component-wrapper")
		var panel = wrapper.children(".panel")
		var body = panel.children(".panel-body")
		console.log(panel)
		console.log(body)
		body.toggle(400)
	})
})