# Dockerfile

FROM starknet/cairo:1.0.0-alpha.6 AS build
# FROM starknet/cairo:latest AS build

FROM python:3.9-alpine

# Aquí se pueden agregar varios programas que se ocuparian para trabajar más cómodos.
RUN apk add --update gmp-dev build-base nodejs npm git zsh curl libc6-compat gcompat

# Optional deps
RUN apk add --update tmux vim bash wget tree

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN sh -c "$(mkdir -p /root/bin)"

RUN sh -c "$(cd /tmp/ && wget -q https://github.com/software-mansion/scarb/releases/download/v0.1.0/scarb-v0.1.0-x86_64-unknown-linux-gnu.tar.gz)"

# RUN sh -c "$(cd /tmp/ && tar -xf scarb-v0.1.0-x86_64-unknown-linux-gnu.tar.gz --one-top-level=/root/bin/scarb --strip-components 1)"
RUN sh -c "$(cd /tmp/ && tar -xf scarb-v0.1.0-x86_64-unknown-linux-gnu.tar.gz && mv scarb-v0.1.0-x86_64-unknown-linux-gnu /root/bin/scarb)"

ENV PATH "/root/bin/scarb/bin/:$PATH"

RUN python -m pip install --upgrade pip

RUN pip3 install ecdsa fastecdsa sympy
RUN pip3 install cairo-lang

ENV STARKNET_NETWORK=alpha-goerli
ENV STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount

COPY --from=build /usr/bin/* /usr/bin/
COPY --from=build /corelib /corelib

WORKDIR /work/
ENTRYPOINT [ "zsh" ]
