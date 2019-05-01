pragma solidity ^0.4.24;

import "./queue.sol";
import "./login.sol";

contract assign is login,queue{
    struct arbitration {
        mapping(address => uint)    flag;                //flag为仲裁师对某订单的评估状态，当评估后，该状态flag=1，不允许再次评估
        uint tick;
        uint sum;
    }

    mapping(address => uint)        values;              //评估师报价
    mapping(address => uint)        loads;               //评估师负载
    mapping(address => uint[])      record;              //记录评估师下评估单编号

    mapping(address => uint[])      appeallist;          //记录每个仲裁者名下的仲裁单
    mapping(uint => arbitration)    status;              //记录仲裁者对某个评估单的评估结果
    mapping(uint => address[])      incomelist;          //记录每个申诉单对应的仲裁师评估序列

    Queue Leaderboard;                                   //排行榜字段（最大接受100个订单，超过后先进先出）
  
    constructor() public {
        Leaderboard.data.length = 200;
    }

    /**
     * guobin
     * 录入评估师报价
    */
    function _Enter_quote(uint value) internal {          
        values[msg.sender] = value;
    }

    function _check_quote(address work) internal view returns (uint) {
        return (values[work]-100);
    }
    
    /**
     * guobin
     * 计算评估师竞争力
    */
    function calc(address worker,uint state) internal view returns (uint competitve) {            
        uint Load = loads[worker];

        if(Load >= 5) {
            return 0;
        }
        if(state == 0) {                        //创建评估单分配时计算公式
            //真实公式:competitve = check_balance(worker) * (2 - values[worker]/10) * (1 - length(loads[worker])/5);
            competitve = check_balance(worker) * (values[worker]) * (5 - Load);
        }
        else {                                  //评估单被退回时计算公式
            competitve = check_balance(worker) * (5 - Load);
        }
    }
    
    /**
     * guobin
     * 统计并筛选出最优评估师
    */
    function statistic(uint state) internal view returns (address choose) {             
        uint256 max = 0;
        uint256 current = 0;
        
        for(uint i = 0;i < workers.length;i++) {
            current = calc(workers[i],state);
            if(current > max) {
                max = current;
                choose = workers[i];
            }
        }
    }
    
    /**
     * guobin
     * 将当前订单编号分配给最优评估师
    */
    function distribution(uint number,address choose) internal returns (uint) { 
        loads[choose] += 1;
        _setassessor(number,choose);                            //存储评估单对应的评估师
        uint[] memory tmp = record[choose];
        for(uint i = 0;i < tmp.length;i++) {
            if(tmp[i] == number) return 0;
        }
        record[choose].push(number);                            //将当前评估单编号(由js传递)存入对应评估师地址
    }

    /**
     * guobin
     * 返回当前评估师的所有评估单编号
    */
    function _backvalnumber() view internal returns (uint[]) {
        return record[msg.sender];
    }

    /**
     * guobin
     * 评估师对订单进行评估
    */
    function _evaluate(uint index,uint value) internal {
        uint tokentmp = _check_quote(msg.sender);
        order.store_msg[index].Evaluation = value;
        order.store_sta[index].Evaluation_status = "1";         //将评估单状态改为已评估
        finishwork(index,0);
        reward(msg.sender,tokentmp);                            //根据评估师设定的分成比例给予通证奖励
        msg.sender.transfer(100-tokentmp);                      //根据评估师设定的分成比例给予ether奖励
        push(Leaderboard,index);                                //将评估后的工单推入排行榜公示，只有评估后的订单才可进入排行榜
    }

    /**
     * guobin
     * 将申诉订单编号分配给仲裁者
    */
    function _appealdistribution(uint number,address appeal1,address appeal2,address appeal3,address appeal4,address appeal5) internal { 
        loads[appeal1] += 1;
        loads[appeal2] += 1;
        loads[appeal3] += 1;
        loads[appeal4] += 1;
        loads[appeal5] += 1;        
        
        appeallist[appeal1].push(number);                    //将当前评估单编号(由js传递)存入对应仲裁者地址
        appeallist[appeal2].push(number);                    //将当前评估单编号(由js传递)存入对应仲裁者地址
        appeallist[appeal3].push(number);                    //将当前评估单编号(由js传递)存入对应仲裁者地址
        appeallist[appeal4].push(number);                    //将当前评估单编号(由js传递)存入对应仲裁者地址
        appeallist[appeal5].push(number);                    //将当前评估单编号(由js传递)存入对应仲裁者地址
        order.store_sta[number].Evaluation_status = "2";     //将评估单状态改为已申诉
    }

    /**
     * guobin
     * 返回排行榜中所有评估单编号
    */
    function _backLeaderboard() internal view returns (uint[]) {
        return Leaderboard.data;
    }

    /**
     * guobin
     * 返回排行榜中所有评估单编号
    */
    function _backLength() internal view returns (uint) {
        return length(Leaderboard);
    }

    /**
     * guobin
     * 返回当前仲裁者的所有评估单编号
    */
    function _backappnumber() internal view returns (uint[]) {
        return appeallist[msg.sender];
    }

    /**
     * guobin
     * 当前仲裁者对本订单是否具备仲裁条件
    */
    function _appealesituation(uint index) internal view returns (uint) {
        if(status[index].flag[msg.sender] == 1) {
            return 0;                           //返回0，则不具备仲裁条件
        }
        else {
            return 1;                           //返回1，具备仲裁条件
        }
    }

    /**
     * guobin
     * 仲裁者对订单进行评估
    */
    function _appealevaluate(uint index,uint value) internal returns (uint) {
        uint tmpvalue = 0;
        uint tmpsum = 0;
        
        if(status[index].flag[msg.sender] == 1) {                                        //当同一仲裁师再次进入同一评估单，不再允许进行评估
            revert();
        }

        loads[msg.sender] -= 1;                                                     //当前仲裁师评估订单，工作负载减1
        incomelist[index].push(msg.sender);                                         //当前仲裁师评估订单，记录其订单评估顺序（方便做收益分配）
        status[index].tick += 1;                                                    //当前申诉单tick记录加1，共5人（即最大值为5）
        status[index].sum += value;                                                 //将当前仲裁师对申诉单的估价累加进sum
        status[index].flag[msg.sender] = 1;                                         //当前仲裁师进入本函数，其flag状态从false变true，下次不可再进入
        

        if(status[index].tick == 5) {
            tmpvalue = order.store_msg[index].Evaluation * 500;                     //评估师估价（评估价*5*100）
            tmpsum = status[index].sum;                                             //5个仲裁者的估价总数
            order.store_sta[index].Evaluation_status = "3";                         //将评估单状态改为已仲裁
            
            if(tmpvalue > tmpsum * 95) {
                if(tmpvalue < tmpsum * 105) {
                    _resultprocessing(index,100,0);                                 //仲裁结果：合理，平台给予仲裁者通证奖励
                    return 0;                                                       //返回1，代表评估师对于订单的价格估价是合理的
                }
                else {
                    order.store_msg[index].Evaluation = tmpsum/5;                   //将仲裁师的平均估价重新赋给Evaluation
                    _resultprocessing(index,2*_check_quote(_getassessor(index)),1); //仲裁结果：不合理，平台双倍（2倍）扣除该评估师获得该订单的通证奖励给予仲裁师（有可能多于100，有可能少于100，取决于评估师获得的通证数量）
                    return 1;                                                       //评估师价格高于仲裁师平均估价105%，代表评估师对订单估价不合理
                }
            }
            else {
                order.store_msg[index].Evaluation = tmpsum/5;                       //将仲裁师的平均估价重新赋给Evaluation
                _resultprocessing(index,2*_check_quote(_getassessor(index)),1);
                return 1;                                                           //评估师价格低于仲裁师平均估价95%，代表评估师对订单估价不合理
            }
        }
    }

    /**
     * guobin
     * 仲裁结果：合理/不合理，处理流程
    */
    function _resultprocessing(uint index,uint amount,uint state) internal {
        uint total = 0;
        uint[5] memory appeal_val;
        uint[5] memory pay;
        address[5] memory appeal;

        for(uint i = 0;i < 5;i++) {
            appeal[i] = incomelist[index][i];
            appeal_val[i] = (5-i) * check_balance(appeal[i]);
            total += appeal_val[i];
        }

        for(i = 0;i < 5;i++) {
            pay[i] = amount*(appeal_val[i] / total);
            reward(appeal[i],pay[i]);
        }

        if(state == 1) {
            punish(_getassessor(index),amount);
        }
    }

    /**
     * guobin
     * 仲裁订单进度查询
    */
    function _appealeschedule(uint index) internal view returns (uint) {
        return status[index].tick;
    }

    /**
     * guobin
     * 完成当前订单
    */
    function finishwork(uint index,uint parameter) internal{
        if(parameter == 1) {                                            //当评估单被两次退回后，自动变为已关闭状态
            order.store_sta[index].Evaluation_status = "4";             //将评估单状态改为已关闭
        }
        loads[msg.sender] -= 1;        
    }
}
