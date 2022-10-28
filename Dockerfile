FROM golang:1.17

RUN apt update -y --allow-insecure-repositories && apt upgrade -y && \ 
  apt install -y git && \
  apt -y clean


RUN git clone https://github.com/riking/AutoDelete.git
RUN cd AutoDelete && go build -ldflags="-s -w" -v -o ~/go/bin/autodelete ./cmd/autodelete 

RUN mkdir -p /autodelete/data && \
  cp ~/go/bin/autodelete /autodelete/

ENV HOME=/

EXPOSE 2202

WORKDIR /autodelete/

ENTRYPOINT ./autodelete
