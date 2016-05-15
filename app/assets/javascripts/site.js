// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function () { 
	$('#jstree').jstree({


		//  take from
		// http://jsfiddle.net/53cvtbv9/1/
		// https://www.jstree.com/api/#/
		"search": {
        "case_insensitive": true,
        "show_only_matches" : true
    },
    "plugins": ["search"]
	}) 

	var to = false

	$("#input-search").keyup(function() {
		if(to) {clearTimeout(to)}
			to = setTimeout(search_tree, 200)
	})
});

function search_tree() {
	var val = $("#input-search").val()
	$("#jstree").jstree(true).search(val)
}

$(document).ready(function() {
	$("#jstree a").first().addClass('jstree-hovered')

	$(document).bind('keydown',"return",function () {
		 console.log("wow it works")
		 console.log($("#jstree.jstree-hovered"))
		 $("#jstree.jstree-hovered").trigger('click')
	})

});

