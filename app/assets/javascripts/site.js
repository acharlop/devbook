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
});
