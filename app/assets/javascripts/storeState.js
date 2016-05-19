function save_layout () {
	$("#method-row > .component-col").each( function() {
		var col = $(this)
		var idx = 0
		col.children().each( function() {
			var panel = $(this).find("div[id$=-panel]")
			var key = "m" + col.attr("class").match(/col-([ab])/)[1] + (++idx)
			var value = panel.attr("id").split("-")[0] + ","
			value += panel.attr("class").match(/js-panel-(open|closed)/)[1]
			localStorage.setItem(key, value)
		});
	});
}

function load_layout () {
	var cols = {a: [], b: [] }
	Object.keys(cols).forEach(function(col) {
		var idx = 1
		var settings = true
		while( true ){
			settings = localStorage.getItem("m"+col+(idx++))
			if(!settings) break;
			settings = settings.split(",")

			var panel = $("#"+settings[0]+"-panel")
			panel.removeClass("js-panel-open js-panel-closed")
			panel.addClass("js-panel-" + settings[1])

			var actions = $("#"+settings[0]+"-component-actions .minimize")
			actions.removeClass("fa-minus fa-plus")
			actions.addClass(settings[1] == "open" ? "fa-minus" : "fa-plus")

			cols[col].push( panel.closest(".component").detach() )
		}
	})

	rebuild_layout(cols)
}

function rebuild_layout (cols) {
	Object.keys(cols).forEach(function(alpha) {
		var col = $("#method-row > .col-" + alpha)
		while(cols[alpha].length){
			col.append(cols[alpha].shift())
		}
	})
}





$(document).ready(function(){
	load_layout()

	window.addEventListener("beforeunload", function(e){
	localStorage.clear()
		save_layout()
	})
})