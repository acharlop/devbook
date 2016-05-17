var keys = [ "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","Shift+a","Shift+b","Shift+c","Shift+d","Shift+e","Shift+f","Shift+g","Shift+h","Shift+i","Shift+j","Shift+k","Shift+l", "Shift+m","Shift+n","Shift+o","Shift+p","Shift+q","Shift+r","Shift+s","Shift+t","Shift+u","Shift+v","Shift+w","Shift+x", "Shift+y","Shift+z"]
$.each(keys, function(i,e){
	$(document).bind('keydown', keys[i], function(){
		var input = $("#input-search")
		input.text(input.text() + e[e.length-1])
		input.focus()
	})	
})

$(document).bind("keydown","backspace",function(){
	var input = $("#input-search")
	input.text(input.text().slice(0,-1))
	input.focus()
})

