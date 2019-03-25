# evaluation-system
该项目是基于以太坊的汽车估值系统，主要用到以下方面知识：
* solidity
* web3.js
* vue.js & element-ui
* bancor
* metamask

# 1.运行前准备
**安装Node.js**  
***
首先根据你的 ubuntu 是 32 位还是 64 位，分别下载不同的预编译版本，我们使用官方长期支持的 8.10.0LTS 版本：

64 位：
`~$ wget https://nodejs.org/dist/v8.10.0/node-v8.10.0-linux-x64.tar.gz`

32 位：
`~$ wget https://nodejs.org/dist/v8.10.0/node-v8.10.0-linux-x86.tar.gz`

然后解压到当前目录，以 64 位为例：

`~$ tar zxvf node-v8.10.0-linux-x64.tar.gz`

然后接下来修改.bashrc 来设置相关的环境变量：

`~$ echo "export NODE_HOME=$HOME/node-v8.10.0-linux-x64" >> .bashrc`

`~$ source .bashrc`

`~$ echo "export NODE_PATH=$NODE_HOME/lib/node_modules" >> .bashrc`

`~$ source .bashrc`

`~$ echo "export PATH=$NODE_HOME/bin:$PATH" >> .bashrc`

`~$ source .bashrc`


最后重新载入.bashrc（或者重新登陆）来使 node 生效：

`~$ source .bashrc`

现在，你可以使用 node （检查）：

`~$ node –v`

v8.10.0

**安装Web3**
***

`~$ npm install –g web3@0.20.2`

安装验证：

`~$ node –p 'require("web3")'`

{[Function: Web3] 

    providers:{…}}

**安装ganache-cli（以太坊底层环境）**
***

`~$ npm install –g ganache-cli`

**安装truffle框架**
***

执行以下命令安装 truffle 开发框架：

`~$ npm install –g truffle`

验证安装：

`~$ truffle version`

Truffle v4.1.3 (core 4.1.3)

**安装IPFS**
***

`~$ wget https://dist.ipfs.io/go-ipfs/v0.4.13/go-ipfs_v0.4.13_linux-amd64.tar.gz`

`~$ tar xzvf go-ipfs_v0.4.13_linux-386.tar.gz`

`~$ echo "export PATH=$HOME/go-ipfs:$PATH" >> .bashrc`

`~$ source .bashrc`

# 2.初始化

**IPFS配置及初始化**
***
第一步（初始化本地仓库）：

`~$ ipfs init`

第二步（由于IPFS节点提供REST API借口，默认在本地5001端口坚挺，配置监听地址和CORS）：

`~$ ipfs config --json Addresses.Gateway '"/ip4/0.0.0.0/tcp/5000"'`

**ganache初始化**
***

`~$ ganache-cli -d`

# 3.项目运行

**更新node_module**
***

`~$ npm install`

**编译部署**
***

`~$ truffle compile && truffle migrate --reset && npm run dev`
