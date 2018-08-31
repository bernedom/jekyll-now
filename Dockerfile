FROM alpine:latest

# open jekyll port to the outside
EXPOSE 4000

# install jekyll necessary dependencies for building github pags
RUN apk update
RUN apk add libatomic readline readline-dev libxml2 libxml2-dev \
        ncurses-terminfo-base ncurses-terminfo \
        libxslt libxslt-dev zlib-dev zlib \
        ruby ruby-dev yaml yaml-dev \
        libffi-dev build-base git nodejs \
        ruby-io-console ruby-irb ruby-json ruby-rake ruby-bundler ruby-rdoc 
#RUN apt update && apt upgrade -y
#RUN apt install -y build-essential jekyll gem ruby ruby-dev ruby-bundler libc-dev libxml2-dev zlib1g-dev libxslt-dev liblzma-dev

# configure and install github pages 
RUN gem install jekyll bundler bigdecimal webrick
RUN gem update bundler
RUN gem install github-pages

# clean up all dependencies no longer used for running the container
#RUN apt remove -y libc-dev libxml2-dev ruby-dev build-essential zlib1g-dev libxslt-dev liblzma-dev gem ruby-bundler
#RUN apt autoremove -y

WORKDIR /home/jekyll
CMD jekyll serve --watch -d /_site --force_polling -H 0.0.0.0 -P 4000

