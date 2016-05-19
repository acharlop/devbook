// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function () { 
	$('#jstree').jstree({
    "plugins": ["search","wholerow"],
    "core": {
    	"themes": {
    		"name": "proton",
    		"responsive": true
    	}
    },
		"search": {
        "case_insensitive": true,
        "show_only_matches" : true
    }
	}) 

	var to = false

	$("#input-search").keydown(function() {
		if(to) {clearTimeout(to)}
			to = setTimeout(search_tree, 250)
	})
});

function search_tree() {
	var val = $("#input-search").val()
	$("#jstree").jstree(true).search(val)
}

$(document).ready(function($) {
	$("#search-overload").on('submit', function(event) {
		event.preventDefault();
		search_tree()
	});
});
