FROM ubuntu:latest

RUN apt-get update -y && apt-get upgrade -y && \
 apt-get install -y software-properties-common ca-certificates apt-transport-https curl wget jq && \
 curl https://apt.corretto.aws/corretto.key | apt-key add - && \
 add-apt-repository 'deb https://apt.corretto.aws stable main' && \
 apt-get update && \
 apt-get install -y java-17-amazon-corretto-jdk && \
 rm -rf /var/lib/apt/lists/* && \
 mkdir /papermc


# Environment variables
ENV MC_VERSION="latest" \
    PAPER_BUILD="latest" \
    MC_RAM="" \
    JAVA_OPTS=""

COPY papermc.sh .

# Start script
CMD ["sh", "./papermc.sh"]

# Container setup
EXPOSE 25565/tcp
EXPOSE 25565/udp
VOLUME /papermc
