# build smart_nvim docker env

#how to build: 
# do this locally
# 1. git clone --depth 1 https://github.com/wbthomason/packer.nvim\
#      ~/.local/share/nvim/site/pack/packer/start/packer.nvim
# 2. run :LspInstallInfo to install lsp server
# 3. run :TSInstall <language_to_install> to install language parser
# 4. sync your plugins to specfic snapshot (search sync_plugins in code)
#    实在没法sync，可以到插件的各个目录手动git checkout到指定commit
# 5. cp -r /home/smart/.local/share/nvim .
# finally run: docker build  --network host -f dockerfile/Dockerfile .

FROM ubuntu:22.04

ENV http_proxy  http://127.0.0.1:7890
ENV https_proxy http://127.0.0.1:7890

RUN sed -i s/archive.ubuntu.com/mirrors.163.com/g /etc/apt/sources.list && \
    sed -i s/security.ubuntu.com/mirrors.163.com/g /etc/apt/sources.list


RUN apt-get update 

RUN apt-get install -y --no-install-recommends\
      wget \
      git \
      ca-certificates \
      build-essential \
      gcc

#for telescope
RUN apt-get install -y --no-install-recommends\
      ripgrep \
      fd-find \
       && update-ca-certificates

#for some lsp servers
RUN apt-get install -y  --no-install-recommends\
      npm

#for clangd
RUN apt-get install -y  --no-install-recommends\
      bear

#inctall nvim
RUN wget --no-check-certificate https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.tar.gz
RUN tar -zxvf nvim-linux64.tar.gz
RUN cd nvim-linux64 && cp -r ./* /usr/local/
RUN echo "alias v='nvim'" >> ~/.bashrc

#install nvim config
RUN mkdir ~/.config && cd ~/.config/  \
      && git clone https://github.com/Jiaao-Bai/smart_neovim_config.git \
       && mv smart_neovim_config nvim \
        && cd nvim \
         && git checkout v0.0.2


COPY nvim  /root/.local/share/nvim/


