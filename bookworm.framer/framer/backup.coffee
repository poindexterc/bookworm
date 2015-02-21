new BackgroundLayer backgroundColor:'#000'
Utils.insertCSS('@import url(http://fonts.googleapis.com/css?family=Lusitana);')
book = new Layer width: 750, height: 1334, backgroundColor: 'transparent'


# -- BOOK VIEW 
book_cover = new Layer width: 750, height: 1334, backgroundColor: 'transparent', superLayer: book
current_book = {id: 1, directory: 'http://localhost:9000/genre/adventure/lorem.txt', cover: 'images/threemus.jpg'}
book_cover.image = current_book.cover
book_cover.style = 
	backgroundPosition: 'center center'
book_cover.blur = 20
book_cover.brightness = 60

# Text input - Koen Bok
# This creates a layer and tells it to listen to mouse events 
textInputLayer = new Layer 
	x:55
	y:80
	width:640
	height:80
	backgroundColor: "transparent"
	borderRadius:10
	superLayer: book

textInputLayer.ignoreEvents = false
textInputLayer.style = {"border" : "2px solid #fff"}

# This creates a text input and adds some styling in plain JS
inputElement = document.createElement("input")
inputElement.style["width"]  = "#{textInputLayer.width}px"
inputElement.style["height"] = "#{textInputLayer.height}px"
inputElement.style["font"] = "34px/1.35em Helvetica"
inputElement.style["-webkit-user-select"] = "text"
inputElement.style["padding-left"] = "20px"
inputElement.style["background-color"] = "rgba(255,255,255,.3)"
inputElement.style["color"] = "#fff"
inputElement.style["outline"] = "none"

# Set the value, focus and listen for changes
inputElement.placeholder = "Search for a book..."
inputElement.value = ""
inputElement.focus()
textInputLayer._element.appendChild(inputElement)

book_cover_inner = new Layer width: 527, height: 725, backgroundColor: 'transparent', superLayer: book

book_cover_inner.image = current_book.cover
book_cover_inner.shadowY = 0
book_cover_inner.shadowBlur = 16
book_cover_inner.shadowColor = "rgba(0,0,0,.4)"
book_cover_inner.x = 110
book_cover_inner.y = 300



upvote = new Layer width: 77, height: 73, backgroundColor: 'transparent', superLayer: book
upvote.image = 'images/upvote.png'
upvote.x = 275
upvote.y = 1095

downvote = new Layer width: 77, height: 73, backgroundColor: 'transparent', superLayer: book
downvote.image = 'images/downvote.png'
downvote.x = 393
downvote.y = 1095

book.on Events.Click, ->
	console.log('click')
	get_text()

## -- READ VIEW
read = new Layer width: 750, height: 1334, backgroundColor: 'transparent'
read_text = new Layer width: 750, height: 1334, backgroundColor: 'white', superLayer: read


read_text.style = {color: "#000", fontFamily: 'Lusitana', fontSize: '35px', lineHeight: '100%', padding: '30px'}
read_text.opacity = 0
read.visible = false
get_text = ->
	book_cover_inner.animate({
    	properties: {scale:1.45},
    	curve: "ease-in-out"
	})
	$.ajax current_book.directory,
	  jsonp: "jsonp",
	  crossOrigin: true,
	  success: (data, status) => show_text(data)

show_text = (data) ->
	read.visible = true
	read_text.scroll = true	
	read_text.html = data
	Utils.delay 0.01, ->
		read_text.animate({
			properties: {'opacity': 1},
			curve: "ease-in-out"
			time: 1
		})
	
	book.animate({
		properties: {'opacity': 0},
		curve: "ease-in-out",
		time: 1
	})
	read.draggable.enabled = true
	read.draggable.speedX = 0
	
	
read.on Events.DragMove, ->
	console.log(read.draggable.calculateVelocity().y)
	hide_read() if read.draggable.calculateVelocity().y > 6 
	
hide_read = ->
	read.draggable.enabled = false
	Utils.delay 0.01, ->
		read_text.animate({
			properties: {'opacity': 0},
			curve: "ease-in-out"
			time: 1
		})
		read.animate({
			properties: {y: 1000},
			time: .5
		})
	book.animate({
		properties: {'opacity': 1},
		curve: "ease-in-out",
		time: 1
	})
	book_cover_inner.animate({
    	properties: {scale:1},
    	curve: "ease-in-out"
	})