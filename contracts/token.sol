pragma solidity ^0.4.14;

contract token {
    uint256 buyPrice;
    uint256 CirculationToken;         
    
    string standard = 'Token 1.0';
    string name;
    string symbol;
    
    address owner;
    
    mapping(address => uint256) balanceOf;
    mapping(address => uint256) tra_number; //交易次数

    event Transfer(address indexed from,address indexed to,uint256 value);
    event Reward(address indexed to,uint256 value);
    event Punishment(address indexed to,uint256 value);
    
    
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    constructor() public {
        balanceOf[msg.sender] = 100000000;
        name = 'tokenName';
        symbol = 'tokenSymbol';
        owner = msg.sender;
        buyPrice = 1;
        CirculationToken = 40;             //初始化流通通证数量
    }
  

    /**
     * guobin
     * 购买初始通证，作为押金
    */
    function _buy(uint amount) internal {
        require(balanceOf[owner] > amount);
        require(balanceOf[msg.sender] + amount< 201);
        
        tra_number[msg.sender]++;
        balanceOf[msg.sender] += amount;
        balanceOf[owner] -= amount;
        CirculationToken += amount;
        emit Transfer(owner,msg.sender,amount);
    }
    
    /**
     * guobin
     * 卖出通证
    */
    function _sell(uint256 amount,uint256 eth_amount) internal {
        require(balanceOf[msg.sender] >= amount);
        
        tra_number[msg.sender]++;
        balanceOf[owner] += amount;
        balanceOf[msg.sender] -= amount;
        CirculationToken -= amount;
        address(msg.sender).transfer(eth_amount);
        emit Transfer(msg.sender,owner,amount);
    }
    
    
    /**
     * guobin
     * 显示购买token价格
     * 将eth_balance和流通token返回给js,并由JS计算出当前价格
    */
    function _displaybalance() view internal returns (uint256) {
        return address(this).balance;
    }

    function _displayethbalance() view internal returns (uint256) {
        return (msg.sender).balance;
    }

    function _displayaccount() view internal returns (uint256) {
        return balanceOf[msg.sender];
    }
    
    function _displaytoken() view internal returns (uint256) {
        return CirculationToken;
    }

    function _distranumber() view internal returns (uint256) {
        return tra_number[msg.sender];
    }

    /**
     * guobin
     * 奖励通证
    */
    function reward(address rewarder,uint amount) public {
        balanceOf[rewarder] += amount;
        balanceOf[owner] -= amount;
        CirculationToken += amount;
    }
    
    /**
     * guobin
     * 惩罚通证
    */
    function punish(address punisher,uint amount) public {
        balanceOf[punisher] -= amount;
        balanceOf[owner] += amount;
        CirculationToken -= amount;
    }
    
    /**
     * guobin
     * 返回当前用户账户余额
    */
    function check_balance(address _to) internal view returns (uint256) {
        return balanceOf[_to];
    }
}