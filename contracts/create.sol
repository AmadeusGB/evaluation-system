pragma solidity ^0.4.24;

contract create {
    struct Valuationdata {
        string Frame_number;            //车架号
        string Number_plate;            //号码车牌
        string Vehicle_type;            //车辆类型
        string Brand_number;            //品牌型号
        string Engine_number;           //发动机号码
        string Manufacture_date;        //出厂日期
        string Evaluation;              //评估价值
        string Timestammp;              //时间戳
    }

    struct Picture {
        string photo1;                  //图片一(合格证)
        string photo2;                  //图片二(左前45度)
        string photo3;                  //图片三(左前门)
        string photo4;                  //图片四(左后门)
        string photo5;                  //图片五(右前门)
        string photo6;                  //图片六(右后45度)
        string photo7;                  //图片七(中控台)
        string photo8;                  //图片八(车内顶)
    }
    
    struct Status {
        uint    Evaluation_value;       //评估支付金额
        string  Evaluation_status;      //每个评估单对应的评估状态(0:未评估,1:已评估,2:已申诉,3:申诉完成，4:已关闭)
        address Assessor;               //评估人
        address Create;                 //创建人
    }

    struct Msg {
        mapping(uint => Status)         store_sta;           //存储评估单状态  
        mapping(uint => Valuationdata)  store_msg;           //存储评估单详情  
        mapping(uint => Picture)        store_pho;           //存储评估单图片  
    }

    Msg order;                                               //评估单(包含评估单状态、评估单详情和评估单图片结构体)
    mapping(address => uint[])          record;              //记录每个用户下评估单编号
    
    /**
     * guobin
     * 创建评估单信息
    */
    function _addvaluation(
        string memory Frame_number,
        string memory Number_plate,
        string memory Vehicle_type,
        string memory Brand_number,
        string memory Engine_number,
        string memory Manufacture_date,
        string memory Evaluation,
        string memory Timestammp,
        uint valuationindex                                             //评估单编号(唯一)
        ) internal {
        Valuationdata memory valuationdata = Valuationdata(Frame_number,Number_plate,Vehicle_type,Brand_number,Engine_number,Manufacture_date,Evaluation,Timestammp);
        order.store_msg[valuationindex] = valuationdata;                //将评估信息存入对应评估单
        order.store_sta[valuationindex].Evaluation_status = "0";        //将评估状态初始化为0,即未评估
        order.store_sta[valuationindex].Create = msg.sender;            //存储评估单的创建人(默认当前用户创建)
        record[msg.sender].push(valuationindex);                        //将当前评估单编号(由js传递)存入对应用户地址
    }
    
    /**
     * guobin
     * 创建评估单图片信息
    */
    function _addphoto(
        string memory photo1,
        string memory photo2,
        string memory photo3,
        string memory photo4,
        string memory photo5,
        string memory photo6,
        string memory photo7,
        string memory photo8,
        uint valuationindex
    ) internal {
        Picture memory picture = Picture(photo1,photo2,photo3,photo4,photo5,photo6,photo7,photo8);
        order.store_pho[valuationindex] = picture;
    }

    /**
     * guobin
     * 返回当前用户的所有评估单编号
    */
    function _backvaluation() view internal returns (uint[]) {
        return record[msg.sender];
    }

    /**
     * guobin
     * 存储评估单对应的评估师
    */
    function _setassessor(uint index,address _to) internal {
        order.store_sta[index].Assessor = _to;
    }
    
    /**
     * guobin
     * 存储指定评估单付费价格
    */
    function _setvalue(uint index,uint amount) internal {
        order.store_sta[index].Evaluation_value = amount;
    }
    
    /**
     * guobin
     * 存储指定评估单评估状态
    */
    function _setstate(uint index,string condition) internal {
        order.store_sta[index].Evaluation_status = condition;
    }
    
    /**
     * guobin
     * 获取评估单对应的创建人
    */
    function _getcreator(uint index) view internal returns(address) {
        return order.store_sta[index].Create;
    }

    /**
     * guobin
     * 获取评估单对应的评估师
    */
    function _getassessor(uint index) view internal returns(address) {
        return order.store_sta[index].Assessor;
    }
    
    /**
     * guobin
     * 获取指定评估单付费价格
    */
    function _getvalue(uint index) view internal returns(uint) {
        return order.store_sta[index].Evaluation_value;
    }
    
    /**
     * guobin
     * 获取指定评估单评估状态
    */
    function _getstate(uint index) view internal returns(string) {
        return order.store_sta[index].Evaluation_status;
    }
    
    /**
     * guobin
     * 获取指定评估单评估信息
    */
    function _display(uint index,uint num) view internal returns (string) {
        if(num == 1) {
            return order.store_msg[index].Frame_number;             //车架号
        } 
        else if(num == 2) {
            return order.store_msg[index].Number_plate;             //号码车牌
        }
        else if(num == 3) {
            return order.store_msg[index].Vehicle_type;             //车辆类型
        }
        else if(num == 4) {
            return order.store_msg[index].Brand_number;             //品牌型号
        }
        else if(num == 5) {
            return order.store_msg[index].Engine_number;            //发动机号码
        }
        else if(num == 6) {
            return order.store_msg[index].Manufacture_date;         //出厂日期
        }
        else if(num == 7) {
            return order.store_msg[index].Evaluation;               //评估价值
        }
        else if(num == 8) {
            return order.store_msg[index].Timestammp;               //时间戳
        }
        else if(num == 9) {
            return order.store_sta[index].Evaluation_status;        //评估状态
        }
        else if(num == 10) {
            return order.store_pho[index].photo1;                   //图片一(合格证)
        }
        else if(num == 11) {
            return order.store_pho[index].photo2;                   //图片二(左前45度)
        }
        else if(num == 12) {
            return order.store_pho[index].photo3;                   //图片三(左前门)
        }
        else if(num == 13) {
            return order.store_pho[index].photo4;                   //图片四(左后门)
        }
        else if(num == 14) {
            return order.store_pho[index].photo5;                   //图片五(右前门)
        }
        else if(num == 15) {
            return order.store_pho[index].photo6;                   //图片六(右后45度)
        }
        else if(num == 16) {
            return order.store_pho[index].photo7;                   //图片七(中控台)
        }
        else if(num == 17) {
            return order.store_pho[index].photo8;                   //图片八(车内顶)
        }
    }
}