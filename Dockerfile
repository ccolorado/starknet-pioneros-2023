# Dockerfile

# FROM starknet/cairo:1.0.0-alpha.6 AS build
FROM starknet/cairo:latest AS build

FROM ubuntu:latest

# Install some dependencies required by deadsnakes PPA
RUN apt-get update && \
  apt-get install -y software-properties-common dirmngr gnupg-agent && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6A755776

# Add deadsnakes PPA and install Python 3.9
RUN add-apt-repository ppa:deadsnakes/ppa && \
  apt-get update && \
  apt-get install -y python3.9

# FROM python:3.9-ubuntu

RUN ls /etc/*release && cat /etc/*release

RUN apt-get install nodejs npm git zsh curl
RUN apt-get install tmux vim bash wget tree

# RUN apk add --update libc6-compat gcompat gmp-dev build-base

# Optional deps

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN sh -c "$(mkdir -p /work/bin)"

RUN sh -c "$(cd /tmp/ && wget -q https://github.com/software-mansion/scarb/releases/download/v0.2.0-alpha.0/scarb-v0.2.0-alpha.0-x86_64-unknown-linux-gnu.tar.gz)"

# RUN sh -c "$(cd /tmp/ && tar -xf scarb-v0.1.0-x86_64-unknown-linux-gnu.tar.gz --one-top-level=/root/bin/scarb --strip-components 1)"
RUN sh -c "$(cd /tmp/ && tar -xf scarb-v0.2.0-alpha.0-x86_64-unknown-linux-gnu.tar.gz && mv scarb-v0.2.0-alpha.0-x86_64-unknown-linux-gnu /work/bin/scarb)"

ENV PATH "/work/bin/scarb/bin/:$PATH"

RUN python -m pip install --upgrade pip

RUN pip3 install ecdsa fastecdsa sympy
RUN pip3 install cairo-lang

ENV STARKNET_NETWORK=alpha-goerli
ENV STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount

COPY --from=build /usr/bin/* /usr/bin/
COPY --from=build /corelib /corelib

WORKDIR /work/
ENTRYPOINT [ "sh" ]
