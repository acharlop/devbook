function toggleVisibility (me) {
	var wrapper = me.closest(".component-wrapper")
	var panel = wrapper.children(".panel")
	var body = panel.children(".panel-body")
	body.toggle(400)
	panel.toggleClass('js-panel-open js-panel-closed');
	wrapper.find(".minimize").first().toggleClass('fa-minus fa-plus')

	store_visibility(panel)
}

function store_visibility (panel) {
	var id = panel.attr("id")
	var status = "-" + panel.attr("class").match(/js-panel-(open|closed)/)[1][0]
	var opts = localStorage.getItem(id)
	if (opts) 
		status = opts.split("-")[0] + status
	localStorage.setItem(id, status)
}

function make_sortable(row) {
	$(row + " .component-col").sortable({
		handle: ".move",
		items: "> .component",
		placeholder: "placeholder",
		connectWith: ".component-col",
		stop: function(event, ui) {
			var oldParent = event.target
			var newParent = ui.item[0].offsetParent

			rebuild_data(newParent)
			if (oldParent != newParent)  rebuild_data(oldParent)
		}	
	})
}

function rebuild_data(parent) {
	var type = parent.parentElement.id.split("-")[0][0]
	// no class save arangement for now
	if (type == "c") return
	//
	var letter = parent.className.match(/col-([ab])/)[1]
	var childs = parent.children
	for (var i = 0; i < childs.length; i++) {
		var pos = `${type}${letter}${i + 1}`
		var id = $(childs[i]).find(".panel").attr("id")
		childs[i].dataset.position = pos
		localStorage.setItem(id,pos)
	}
}

function rebuild_screen() {
	["description", "syntax", "examples", "source"].forEach( function(e, index) {
		e += "-panel"
		var pos = localStorage.getItem(e)
		if (pos) {
			var deets = deets_fix(pos.split("-")[0].split(""))
			var component = $("#"+e).closest(".component").detach()
			var parent = $(`#${deets[0]} .${deets[1]}`)
			if (deets[2] == 1)
				parent.prepend(component)
			else
				parent.append(component)
		}
		// load visibility
		var current_state = component.find(".panel").attr("class").match(/js-panel-(open|closed)/)[1][0]
		if (pos.split("-")[1]) {
			if (pos.split("-")[1] != current_state) {
				toggleVisibility(component.find(".minimize"))
			}
		}
			// going to need a solution for more then 3 components
			// console.log(parent.children()[deets[2] - 1])
			// component.after(parent.children()[deets[2] - 1])
			
			// if deets[2] == 2
			// var ans = component.attr("class").insertAfter(parent.children()[1].attr("class"))
			// console.log(ans)
	}); 

}

function deets_fix(deets) {
	if (deets[0] == "m") 			{deets[0] += "ethod-row"}
	else if (deets[0] == "c") {deets[0] += "lass-row"} 
	else 											{deets.pop()}
	deets[1] = "col-" + deets[1]
	return deets
}


$(document).ready(function() {
	$(".component-row").on('click',".minimize",function(e) {
		toggleVisibility($(e.currentTarget))
	})
	$(".component-row").on('click',".component-head",function(e) {
		toggleVisibility($(e.currentTarget))
	})

	// toggleVisibility($("div#source-panel"))
	rebuild_screen()
	make_sortable("div#method-row")
})
