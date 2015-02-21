new BackgroundLayer backgroundColor:'#000'
book = new Layer width: 750, height: 1334, backgroundColor: 'transparent'

book_cover = new Layer width: 750, height: 1334, backgroundColor: 'transparent', superLayer: book
current_book = {id: 1, cover: 'images/hpcover.jpg'}

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


