# BandzoneScraper

**BandzoneScraper** is headless (API) Ruby on Rails app used to query informations from [Bandzone.cz](https://bandzone.cz) music portal and convert/process them into JSON format to be used for upcoming project(s). 


## Functions, examples

Current version supporting querying only bands and their songs, but there is probability that some other posibilities may appear in the future.  
Application currently runs on my virtual server without domain on address [http://172.104.155.216:3030/](http://172.104.155.216:3030/)


### Search bands by name, query bands list (paginated, full search)  

GET request to:

```
http(s)://<domain>/search/bands?q=<band_name>&p=<page_if_available>
```

Source of data: [https://bandzone.cz/kapely.html?q=[band_name]&p=[page_num]](https://bandzone.cz/kapely.html)

#### Example

request:

```
http://172.104.155.216:3030/search/bands?q=wilderness
```

output:

```
{
	"table": {
		"data": [
			{
				"title": "Wilderness",
				"image_url": "https://bzmedia.cz/band/wi/wilderness/gallery/profile.default/239095_t_s.jpg",
				"href": "https://bandzone.cz/wilderness",
				"slug": "wilderness",
				"genre": "power-metal",
				"city": "Vsetín"
			},	
			{
				"title": "The Wilderness",
				"image_url": "https://bzmedia.cz/band/a6/58/5319/e1/ad/8d4e/NymabjkJbmiHMEBCkjay658emY_CCFGu.jpg",
				"href": "https://bandzone.cz/thewildernesstt",
				"slug": "thewildernesstt",
				"genre": "punk",
				"city": "Trnava"
			}
		],
		"pages_count": 1,
		"current_page": 1,
		"items_total": 2,
		"items_current_page": 2
	}
}

```

### get songs list from webplayer for given band

GET request to:

```
http(s)://<domain>/songs/list?q=<band_slug>
```

Source of data : [https://bandzone.cz/[band_slug_name]](https://bandzone.cz/thewildernesstt)

#### Example

You want to listen to "The Wilderness", this one:

```
...
{
	"title": "The Wilderness",
	"image_url": "https://bzmedia.cz/band/a6/58/5319/e1/ad/8d4e/NymabjkJbmiHMEBCkjay658emY_CCFGu.jpg",
	"href": "https://bandzone.cz/thewildernesstt",
	"slug": "thewildernesstt",
	"genre": "punk",
	"city": "Trnava"
}
...
```

request:

```
http://172.104.155.216:3030/songs/list?q=thewildernesstt
```

output:

```
[
	{
		"full_title": "Načo pojdem domov- Singel 2017 (2017)",
		"title": "Načo pojdem domov",
		"album": "Singel 2017 (2017)",
		"plays_count": "3670",
		"href": "https://bandzone.cz/track/download/697871",
		"href_hash": "28400c3aadef688166a927180e68718e",
		"duration": "12:42"
	},
	...
]
```





