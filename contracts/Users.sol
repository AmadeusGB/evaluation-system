pragma solidity ^0.4.24;

contract Users {
  struct fortest {
    string Address;
    string name;
    string vin;
    string state;
    string date;
  }

  struct Valuationdata {
    string Frame_number;            //车架号
    string Number_plate;            //号码车牌
    string Vehicle_type;            //车辆类型
    string Brand_number;            //品牌型号
    string Engine_number;           //发动机号码
    string Manufacture_date;        //出厂日期
    string Evaluation;              //评估价值
    string Evaluation_address;      //评估地址
    string Timestammp;              //时间戳(提交时间)
  }

  struct Status {
    string Evaluation_status;                       //每个评估单对应的评估状态(0:未评估,1:已评估,2:已申诉,3:申诉完成)
    uint Evaluation_value;                          //评估支付金额
    address Assessor;                               //评估人
    address Create;                                 //创建人
  }

  uint256 valuationindex;

  mapping(uint => Valuationdata) store_msg;
  mapping(address => uint[]) record;               //记录每个用户下评估单编号
  mapping(uint => Status)    status;               //评估单状态  

  function Users () public {
    valuationindex = 0;                    //评估单编号(唯一)
  }

  function _addvaluation(
    string memory Frame_number,
    string memory Number_plate,
    string memory Vehicle_type,
    string memory Brand_number,
    string memory Engine_number,
    string memory Manufacture_date,
    string memory Evaluation,
    string memory Evaluation_address,
    string memory Timestammp
    ) public {
    Valuationdata memory valuationdata = Valuationdata(Frame_number,Number_plate,Vehicle_type,Brand_number,Engine_number,Manufacture_date,Evaluation,Evaluation_address,Timestammp);
    store_msg[valuationindex] = valuationdata;
    record[msg.sender].push(valuationindex);
    status[valuationindex].Evaluation_status = "待评估";
    valuationindex += 1;
  }

  function _backvaluation() view public returns (uint[] tmp) {
    tmp = record[msg.sender];
  }

  function test1(uint num,uint index) public view returns (string) {
    if(index == 0) {
      return (store_msg[num].Evaluation_address);
    }
    else if(index == 1) {
      return (store_msg[num].Brand_number);
    }
    else if(index == 2) {
      return (store_msg[num].Frame_number);
    }
    else if(index == 3) {
      return (status[num].Evaluation_status);
    }
    else if(index == 4) {
      return (store_msg[num].Timestammp);
    }
  } 

}
