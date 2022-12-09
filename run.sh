#!/bin/zsh

flutter build web --release
docker rm -f bookshelf
docker build -t bookshelf .
docker run --name bookshelf  -itd -p 8080:80 bookshelf
open http://localhost:8080/
