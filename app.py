from bottle import route, run, request, post, response, static_file
import json
import os
import random


@route('/get_next_book')
def get_next_book():
    # gets the next book of the given genre
    # calls get_book_from_genre
    # return id, cover

    json_data = open("history_id.json", "r")
    data = json.load(json_data)
    max_value = -9999
    genre_str = ""
    for genre, count in data.iteritems():
        if (count >= max_value):
            max_value = count
            genre_str = genre
    return get_book_from_genre(genre_str)


def get_book_from_genre(genre):
    # expect to return an id e.i. a number
    if not genre:
        genre = random.choice(['adventure', 'children', 'fantasy', 'sci-fi'])
    linked = "genre/" + genre
    list_of_books = os.listdir(linked)
    list_of_books = filter(lambda x: not x.startswith('.'), list_of_books)
    rand_title = random.choice(list_of_books)
    json_data = open('book_info.json', 'r')
    data = json.load(json_data)
    for id_es, book in data.iteritems():
        if (book["title"][:-3] == rand_title[:-3]):
            return {"id": id_es, "cover": linked + "/" + rand_title[:-3] + "jpg"}


@post('/thumb_up')
def thumb_up():
    # increases the amount of times a genre has been read

    book_id = request.forms.get('id')
    json_new_data = open('book_info.json', 'r')
    new_data = json.load(json_new_data)
    book_genre = new_data[book_id]["genre"]
    increase_genre(book_genre)
    return '{"success": true}'


@post('/thumb_down')
def thumb_down():
    # decrease the amount of times a genre has been read

    book_id = request.forms.get('id')
    json_new_data = open('book_info.json', 'r')
    new_data = json.load(json_new_data)
    book_genre = new_data[book_id]["genre"]
    decrease_genre(book_genre)
    next_book_id = get_next_book()
    return next_book_id


@post('/get_text')
def get_text():
    # go into the directory of the book and return the text file
    book_id = request.forms.get('id')
    # print json_data
    # print dir(json_data)
    # data = json.loads(json_data)
    # book_id = json_data['id']

    json_new_data = open('book_info.json', 'r')
    new_data = json.load(json_new_data)
    book_genre = new_data[book_id]["genre"]
    book_title = new_data[book_id]["title"]
    book_path = "genre/"+ book_genre + "/" + book_title
    text = open(book_path, 'r')
    response.content_type = "application/html"
    response.status = 200
    return text


def increase_genre(genre):
    json_data = open('history_id.json', 'r')
    data = json.load(json_data)
    data[genre] = data[genre] + 1
    with open('history_id.json', 'w') as history:
        json.dump(data, history)


def decrease_genre(genre):
    json_data = open('history_id.json', 'r')
    data = json.load(json_data)
    data[genre] = data[genre] - 1
    with open('history_id.json', 'w') as history:
        json.dump(data, history)


@route('/')
def index():
    filename = 'index.html'
    return static_file(filename, root='./bookworm.framer/')


@route('/app.coffee')
def coffee():
    filename = 'app.coffee'
    return static_file(filename, root='./bookworm.framer/')


@route('/framer/:filename#.*#')
def send_static(filename):
    return static_file(filename, root='./bookworm.framer/framer/')


@route('/images/:filename#.*#')
def images(filename):
    return static_file(filename, root='./bookworm.framer/images/')


@route('/genre/:genre/:filename#.*#')
def book_images(genre, filename):
    print genre
    print filename
    return static_file(filename, root='./genre/' + genre + "/")


run(host='0.0.0.0', port=int(os.environ.get("PORT", 5000)))
