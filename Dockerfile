FROM ubuntu:14.04

RUN apt-get update && apt-get install -y --force-yes wget git

RUN wget "https://storage.googleapis.com/golang/go1.5.linux-amd64.tar.gz" \
  && tar -C /usr/local -xzf go1.5.linux-amd64.tar.gz \
  && rm go1.5.linux-amd64.tar.gz

ENV PATH $PATH:/usr/local/go/bin

ENV GOPATH /go

RUN wget https://raw.githubusercontent.com/pote/gpm/v1.3.2/bin/gpm \
  && chmod +x gpm \
  && mv gpm /usr/local/bin

RUN go get github.com/evertrue/burrow

RUN cd $GOPATH/src/github.com/evertrue/burrow \
  && gpm install \
  && go  install

ADD config $GOPATH/config

RUN mkdir -p $GOPATH/log

EXPOSE 8000

CMD cd $GOPATH && ./bin/burrow --config config/burrow.cfg