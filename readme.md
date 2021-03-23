**Web server for storing and retrieving images.**

Run the live server:

uvicorn app.main:app --port 5000

Usage example:

Upload an image from path. The server responds with the URL to retrieve the image from:

`curl -X POST -F img_file=@testimages/image1.png http://localhost:5000/images`

{
"new": true,
"url": "/images/dfe1481e35c8840bad7d81ad4993d195"
}

Storing the same image more than once is accepted and detected, and returns that fact in the "new"
value, which is false for an image that already was uploaded:

`curl -X POST -F img_file=@testimages/image1.png http://localhost:5000/images`

{
"new": false,
"url": "/images/dfe1481e35c8840bad7d81ad4993d195"
}

Download an image and save it to foo.jpg

`curl -D - -o foo.jpg http://localhost:5000/images/dfe1481e35c8840bad7d81ad4993d195
`
