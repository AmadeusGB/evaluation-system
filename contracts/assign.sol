pragma solidity ^0.4.24;

import "./queue.sol";
import "./login.sol";

contract assign is login,queue{
    struct arbitration {
        mapping(address => bool) flag;                //flag为仲裁师对某订单的评估状态，当评估后，该状态flag=1，不允许再次评估
        uint tick;
        uint sum;
    }

    mapping(address => uint)   values;                //评估师报价
    mapping(uint => address)   appeals;               //评估单编号对应的评估师地址
    mapping(address => Queue)  loads;                 //评估师负载
    mapping(address => uint[]) record;                //记录每个用户下评估单编号
    mapping(address => uint[]) appeallist;            //记录每个仲裁者名下的仲裁单

    mapping(uint => arbitration) status;              //记录仲裁者对某个评估单的评估结果
    
    
    /**
     * guobin
     * 录入评估师报价
    */
    function _Enter_quote(uint value) internal {          
        values[msg.sender] = value;
    }
    
    /**
     * guobin
     * 计算评估师竞争力
    */
    function calc(address worker,uint state) internal returns (uint competitve) {       
        loads[worker].data.length = 200; //对队列初始化,实际长度由extent=6控制
        
        uint Load = length(loads[worker]);
        if(Load >= 5) {
            return 0;
        }
        if(state == 0) {  //创建评估单分配时计算公式
            //真实公式:competitve = check_balance(worker) * (2 - values[worker]/10) * (1 - length(loads[worker])/5);
            competitve = check_balance(worker) * (values[worker]) * (5 - Load);
        }
        else {            //评估单被退回时计算公式
            competitve = check_balance(worker) * (5 - Load);
        }
    }
    
    /**
     * guobin
     * 统计并筛选出最优评估师
    */
    function statistic(uint state) internal returns (address choose) {             
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
        push(loads[choose], number);
        appeals[number] = choose;
        uint[] tmp = record[choose];
        for(uint i = 0;i < tmp.length;i++) {
            if(tmp[i] == number) return 0;
        }
        record[choose].push(number);                        //将当前评估单编号(由js传递)存入对应评估师地址
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
    function _evaluate(uint index,string value) internal {
        order.store_msg[index].Evaluation = value;
        order.store_sta[index].Evaluation_status = "1";         //将评估单状态改为已评估
        finishwork(index,0);
    }

    /**
     * guobin
     * 将申诉订单编号分配给仲裁者
    */
    function _appealdistribution(uint number,address appeal1,address appeal2,address appeal3,address appeal4,address appeal5) internal { 
        push(loads[appeal1], number);
        push(loads[appeal2], number);
        push(loads[appeal3], number);
        push(loads[appeal4], number);
        push(loads[appeal5], number);
        
        appeallist[appeal1].push(number);                    //将当前评估单编号(由js传递)存入对应仲裁者地址
        appeallist[appeal2].push(number);                    //将当前评估单编号(由js传递)存入对应仲裁者地址
        appeallist[appeal3].push(number);                    //将当前评估单编号(由js传递)存入对应仲裁者地址
        appeallist[appeal4].push(number);                    //将当前评估单编号(由js传递)存入对应仲裁者地址
        appeallist[appeal5].push(number);                    //将当前评估单编号(由js传递)存入对应仲裁者地址
        order.store_sta[number].Evaluation_status = "2";     //将评估单状态改为已申诉
    }

    /**
     * guobin
     * 返回当前仲裁者的所有评估单编号
    */
    function _backappnumber() view internal returns (uint[]) {
        return appeallist[msg.sender];
    }

    /**
     * guobin
     * 仲裁者对订单进行评估
    */
    function _appealevaluate(uint index,uint value) internal returns (uint) {
        uint tmpvalue = 0;
        uint tmpsum = 0;
        
        if(status[index].flag[msg.sender]) {                        //当同一仲裁师再次进入同一评估单，不再允许进行评估
            return 2;
        }

        status[index].tick += 1;
        status[index].sum += value;
        pop(loads[msg.sender]);
        status[index].flag[msg.sender] = true;

        if(status[index].tick == 5) {
            order.store_sta[index].Evaluation_status = "3";         //将评估单状态改为已仲裁
            tmpvalue = stringToUint(order.store_msg[index].Evaluation) * 5;
            tmpsum = status[index].sum;
            if(tmpsum > tmpvalue * 95) {
                if(tmpsum < tmpvalue * 105) {
                    return 1;
                }
                else {
                    return 0;
                }
            }
            else {
                return 0;
            }
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
    function finishwork(uint index,uint parameter) internal returns (uint) {
        if(parameter == 1) {                                           //当评估单被两次退回后，自动变为已关闭状态
            order.store_sta[index].Evaluation_status = "4";         //将评估单状态改为已关闭
        }
        return pop(loads[msg.sender]);
        
    }
    
    /**
     * guobin
     * 找出执行申诉订单的工人
    */
    function workfor(uint number) view internal returns (address) {
        return appeals[number];
    }

}
