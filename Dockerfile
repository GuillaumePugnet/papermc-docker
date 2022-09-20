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

# Container setup
EXPOSE 25565/tcp
EXPOSE 25565/udp
VOLUME /papermc

ARG USERNAME=paper
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME 
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    # && apt-get update \
    # && apt-get install -y sudo \
    # && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    # && chmod 0440 /etc/sudoers.d/$USERNAME

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# Set the default user. Omit if you want to keep the default as root.
USER $USERNAME

# Start script
CMD ["sh", "./papermc.sh"]


