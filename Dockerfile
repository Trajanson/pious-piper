FROM haskell:7.10

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN cabal update

COPY ./PiousPiper.cabal /usr/src/app
RUN cabal install --only-dependencies -j4

COPY . /usr/src/app
RUN cabal install

RUN stack setup
RUN stack build
