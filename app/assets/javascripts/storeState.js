document.cookie = "loggedin=true"

function store_visibility (panel) {
	var id = panel.attr("id")
	var status = "-" + panel.attr("class").match(/js-panel-(open|closed)/)[1][0]
	var opts = localStorage.getItem(id)
	if (opts) 
		status = opts.split("-")[0] + status
	localStorage.setItem(id, status)
}

function rebuild_data(parent) {
	var type = parent.parentElement.id.split("-")[0][0]
	// no class save arangement for now
	if (type == "c") return
	//
	var letter = parent.className.match(/col-([ab])/)[1]
	var childs = parent.children
	for (var i = 0; i < childs.length; i++) {
		var pos = type + letter + (i + 1)
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
			var parent = $("#"+deets[0] + " ." + deets[1])
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

function save_layout () {
	
}


$(document).ready(function(){
	rebuild_screen()
	
	window.addEventListener("beforeunload", function(e){
		document.cookie = "loggedin=; expires=Thu, 01 Jan 1970 00:00:00 UTC";
		save_layout()
	})
})