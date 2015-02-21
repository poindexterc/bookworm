new BackgroundLayer backgroundColor:'#000'
book = new Layer width: 750, height: 1334, backgroundColor: 'transparent'

book_cover = new Layer width: 750, height: 1334, backgroundColor: 'transparent', superLayer: book
current_book = {id: 1, cover: 'images/hpcover.jpg'}

book_cover.image = current_book.cover
book_cover.style = 
	backgroundPosition: 'center center'
book_cover.blur = 20
book_cover.brightness = 90

	
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


