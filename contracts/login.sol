pragma solidity ^0.4.24;

import "./token.sol";
import "./create.sol";

contract login is token,create{
    mapping(address => uint)  ID;                           //地址对应用户属性(0:普通用户,1:评估师)
    address[] workers;                                      //评估师列表
    
    /**
     * guobin
     * 地址注册函数
    */
    function _register(uint index,uint testvalue) internal returns (uint) {
        require(balanceOf[msg.sender] >= 100);              //评估时注册需缴纳100押金
        
        testvalue = testvalue * 100;                        //放大100倍避免除法造成造成的误差
        
        uint value = stringToUint(order.store_msg[index].Evaluation);
        if(testvalue < value * 105) {
            if(testvalue > value * 95) {
                ID[msg.sender] = 1;
                workers.push(msg.sender);
                return 1;
            }
        }
        return 0;
    }

    function _registertest() internal {
        ID[msg.sender] = 1;
        workers.push(msg.sender);
    }

    /**
     * guobin
     * 返回所有评估师地址
    */
    function _backofwork() view internal returns (address[]) {
        return workers;
    }

    function _checkuser() view internal returns (uint) {
        return ID[msg.sender];
    }
    
    /**
     * guobin
     * 解除注册函数
    */
    function _unregister() internal returns (uint) {
        ID[msg.sender] = 0;
        return 1;
    }
    
    /**
     * guobin
     * String转Uint
    */
    function stringToUint(string s) internal pure returns (uint) {
        bytes memory b = bytes(s);
        uint result = 0;
        
        for (uint i = 0; i < b.length; i++) {
            if (b[i] >= 48 && b[i] <= 57) {
                result = result * 10 + (uint(b[i]) - 48);
            }
        }
        return result;
    }

    /**
     * guobin
     * Uint转String
    */
    function uintToString(uint v) internal pure returns (string str) {
        uint maxlength = 100;
        bytes memory reversed = new bytes(maxlength);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = byte(48 + remainder);
        }
        bytes memory s = new bytes(i + 1);
        for (uint j = 0; j <= i; j++) {
            s[j] = reversed[i - j];
        }
        str = string(s);
    }
}