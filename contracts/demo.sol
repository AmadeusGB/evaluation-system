pragma solidity ^0.4.24;

import "./assign.sol";

contract demo is assign{
    mapping(uint => uint) backrecord;
    /**************用户定义空间***************/
    /**************创建评估单功能类***************/
    /**
     * guobin
     * 创建评估单基本信息
    */
    function addvaluation(
        string memory Frame_number,             //车架号
        string memory Number_plate,             //号码车牌
        string memory Vehicle_type,             //车辆类型
        string memory Brand_number,             //品牌型号
        string memory Engine_number,            //发动机号码
        string memory Manufacture_date,         //出厂日期
        string memory Evaluation,               //评估价值
        string memory Timestammp,               //时间戳
        uint evaluation_index                   //评估单编号(由js保证唯一性,前端代码放入ipfs,保证不可篡改性)
        ) public {
        _addvaluation(Frame_number,Number_plate,Vehicle_type,Brand_number,Engine_number,Manufacture_date,Evaluation,Timestammp,evaluation_index); //添加评估单信息
    }

    /**
     * guobin
     * 添加评估单图片并进行分配
    */
    function addphoto(
        string memory photo1,
        string memory photo2,
        string memory photo3,
        string memory photo4,
        string memory photo5,
        string memory photo6,
        string memory photo7,
        string memory photo8,
        uint evaluation_index
    ) public payable {
        _addphoto(photo1,photo2,photo3,photo4,photo5,photo6,photo7,photo8,evaluation_index);
        distribution(evaluation_index,statistic(0));             //对该评估单进行评估师分配
    }


    /**
     * guobin
     * 评估师对订单进行退回
    */
    function backwork(uint evaluation_index) public {
        if(checkbackstate(evaluation_index) == 1) {
            finishwork(evaluation_index,1);
        }
        else {
            finishwork(evaluation_index,0);
            distribution(evaluation_index,statistic(1));             //对该评估单重新分配评估师
            backrecord[evaluation_index] += 1;
            _getcreator(evaluation_index).transfer(100);
        }
    }

    /**
     * guobin
     * 检查该评估单退回次数
    */
    function checkbackstate(uint evaluation_index) internal view returns (uint) {
        return backrecord[evaluation_index];
    }

    /**
     * guobin
     * 评估师对订单进行评估
    */
    function evaluate(uint index,string value) public {
        _evaluate(index,value);
    }

    /**
     * guobin
     * 返回当前用户的所有评估单编号
    */
    function backvaluation() view public returns (uint[]) {
        return _backvaluation();
    }

    /**
     * guobin
     * 存储指定评估单评估状态
    */
    function setstate(uint index,string condition) public {
        _setstate(index,condition);
    }

    /**
     * guobin
     * 获取指定评估单评估信息
    */
    function display(uint index,uint num) view public returns (string) {
        return _display(index,num);
    }

    /**************通证买卖功能类***************/
    /**
     * guobin
     * 购买通证
    */
    function buy(uint amount) public payable {
        _buy(amount);
    }
    
    /**
     * guobin
     * 卖出通证
    */
    function sell(uint256 amount,uint256 eth_amount) public payable {
        _sell(amount,eth_amount);
    }

    /**
     * guobin
     * 显示平台资金池中以太币资金量
    */
    function displaybalance() view public returns (uint256) {
        return _displaybalance();
    } 

    /**
     * guobin
     * 显示当前用户持有以太币数量
    */
    function displayethbalance() view public returns (uint256) {
        return _displayethbalance();
    } 

    /**
     * guobin
     * 显示当前用户通证数量
    */
    function displayaccount() view public returns (uint256) {
        return _displayaccount();
    } 

    /**
     * guobin
     * 计算当前用户，订单退回情况下的竞争力
    */
    function displayaccountforarbitrage(address send) public view returns (uint) {
        return calc(send,1);
    }

    /**
     * guobin
     * 显示已发行的通证总数
    */
    function displaytoken() view public returns (uint256) {
        return _displaytoken();
    } 

    /**
     * guobin
     * 显示当前用户的交易次数
    */
    function distranumber() view public returns (uint256) {
        return _distranumber();
    } 



    /**************评估师定义空间***************/
    /**
     * guobin
     * 注册评估师
    */
    function registertest(uint amount,uint scale) public payable {          
        _registertest();
        _buy(amount);
        _Enter_quote(scale);
    }

    /**
     * guobin
     * 设置评估单报价
    */
    function Enter_quote(uint value) public {                               
        _Enter_quote(value);
    }
    
    /**
     * guobin
     * 检查用户状态（是否为评估师，是：1，否：0）
    */
    function checkuser() view public returns (uint) {                       
        return _checkuser();
    }

    /**
     * guobin
     * 注销评估师
    */
    function unregister() public {                                          
        _unregister();
    }

    /**
     * guobin
     * 返回所有评估师地址
    */
    function backofwork() view public returns (address[]) {
        return _backofwork();
    }

    /**
     * guobin
     * 返回当前评估师的所有评估单编号
    */
    function backvalnumber() view public returns (uint[]) {
        return _backvalnumber();
    }


    /**************仲裁定义空间***************/
    /**
     * guobin
     * 返回当前仲裁者的所有评估单编号
    */
    function backappnumber() view public returns (uint[]) {
        return _backappnumber();
    }

    /**
     * guobin
     * 将申诉订单编号分配给仲裁者
    */
    function appealdistribution(uint number,address appeal1,address appeal2,address appeal3,address appeal4,address appeal5) public {
        _appealdistribution(number,appeal1,appeal2,appeal3,appeal4,appeal5);
    }

    /**
     * guobin
     * 仲裁者对订单进行评估
    */
    function appealevaluate(uint index,uint value) public {
        _appealevaluate(index,value);
    }

    /**
     * guobin
     * 仲裁订单进度查询
    */
    function appealeschedule(uint index) public view returns (uint) {
        return _appealeschedule(index);
    }
}
