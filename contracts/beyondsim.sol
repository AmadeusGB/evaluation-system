pragma solidity ^0.4.24;

import "./assign.sol";

contract  beyondsim is assign{
    uint missionnumer = 2019092000001;
    uint[] recordnumber;

    struct Missiondata {
        uint Evaluation_index;                  //评估单编号
        uint Mission_type;                          //任务类型
        uint Create_date;                           //创建日期
        address Assessor;                           //评估师地址
        uint Assessor_token;                    //评估时通证数
        uint Actual_time;                           //实际耗时
        uint loads;                                         //当前负载
    }

    mapping(uint => Missiondata) mission_record_A;
    mapping(uint => Missiondata) mission_record_B;
    mapping(address => uint[3]) Initialization_time_table;
    mapping(address => uint[3]) Initialization_token_table;
    mapping(address => uint256) balanceOfA;
    mapping(address => uint256) balanceOfB;
    mapping(address => uint) loads_Robin;

    function  beyondsim() public {
        Initialization_time_table[0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0][0] = 30;  //任务一耗时
        Initialization_time_table[0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0][1] = 40;  //任务二耗时
        Initialization_time_table[0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0][2] = 60;  //任务三耗时

        Initialization_time_table[0x22d491Bde2303f2f43325b2108D26f1eAbA1e32b][0] = 40;
        Initialization_time_table[0x22d491Bde2303f2f43325b2108D26f1eAbA1e32b][1] = 55;
        Initialization_time_table[0x22d491Bde2303f2f43325b2108D26f1eAbA1e32b][2] = 75;

        Initialization_time_table[0xE11BA2b4D45Eaed5996Cd0823791E0C93114882d][0] = 50;
        Initialization_time_table[0xE11BA2b4D45Eaed5996Cd0823791E0C93114882d][1] = 65;
        Initialization_time_table[0xE11BA2b4D45Eaed5996Cd0823791E0C93114882d][2] = 90;

        Initialization_token_table[0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0][0] = 6;  //任务一奖励通证
        Initialization_token_table[0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0][1] = 8;  //任务二奖励通证
        Initialization_token_table[0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0][2] = 10;  //任务三奖励通证

        Initialization_token_table[0x22d491Bde2303f2f43325b2108D26f1eAbA1e32b][0] = 6;
        Initialization_token_table[0x22d491Bde2303f2f43325b2108D26f1eAbA1e32b][1] = 8;
        Initialization_token_table[0x22d491Bde2303f2f43325b2108D26f1eAbA1e32b][2] = 10;

        Initialization_token_table[0xE11BA2b4D45Eaed5996Cd0823791E0C93114882d][0] = 6;
        Initialization_token_table[0xE11BA2b4D45Eaed5996Cd0823791E0C93114882d][1] = 8;
        Initialization_token_table[0xE11BA2b4D45Eaed5996Cd0823791E0C93114882d][2] = 10;


        balanceOfA[0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0] = 200;   //为Robin初始化token
        balanceOfA[0x22d491Bde2303f2f43325b2108D26f1eAbA1e32b] = 200;
        balanceOfA[0xE11BA2b4D45Eaed5996Cd0823791E0C93114882d] = 200;

        balanceOfB[0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0] = 200;   //为MFTA初始化token
        balanceOfB[0x22d491Bde2303f2f43325b2108D26f1eAbA1e32b] = 200;
        balanceOfB[0xE11BA2b4D45Eaed5996Cd0823791E0C93114882d] = 200;
    }

    function _Robin () internal {
            //创建任务
            Createmission();
            //分配任务
            //assort();
            //检查任务完成情况
            _check();
    }


    function Createmission() private  {
        uint mission = uint(keccak256(now,msg.sender)) % 3;          //l任务类型:0,1,2

        address chooseworker_A = workers[missionnumer  % 3];          //assort()
        address chooseworker_B = statistic(0);
        
        require(loads_Robin[chooseworker_A] <= 5 && loads[chooseworker_B] <=5);

        loads_Robin[chooseworker_A] += 1;           //assort()
        Missiondata memory missiondataA = Missiondata(missionnumer,mission,now,chooseworker_A,balanceOfA[chooseworker_A],0,loads_Robin[chooseworker_A]);
        mission_record_A[missionnumer] = missiondataA;

        loads[chooseworker_B] += 1;
        Missiondata memory missiondataB = Missiondata(missionnumer,mission,now,chooseworker_B,balanceOfB[chooseworker_B],0,loads[chooseworker_B]);
        mission_record_B[missionnumer] = missiondataB;

        
        recordnumber.push(missionnumer);
        missionnumer ++;
    }


    /**
     * guobin
     * 返回所有评估师地址
    */
    function _backofwork111() view internal returns (address[]) {
        return workers;
    }


    // function assort() private {
    //     //2019092000001 % 3 =0
    //     address chooseworker = workers[missionnumer  % 3];
    //     //require(loads[chooseworker] <= 5);

    //     loads[chooseworker] += 1;        
    //     mission_record[missionnumer].Assessor = chooseworker;
    // }

    function _check() internal {
        for(uint i=0;i < recordnumber.length;i++) {
            uint choose_ordernumber = recordnumber[i];      //提取评估单编号

            if(mission_record_A[choose_ordernumber].Actual_time == 0) {
                uint check_Create_date_A = mission_record_A[choose_ordernumber].Create_date;                //提取该评估单下的创建时间
                address check_Assessor_A = mission_record_A[choose_ordernumber].Assessor;                      //提取该评估单下的评估师地址
                uint check_Mission_type_A = mission_record_A[choose_ordernumber].Mission_type;           //提取该评估单下的任务类型
                uint set_time_A = Initialization_time_table[check_Assessor_A][check_Mission_type_A];            //提取初始化该评估师该任务的理论耗时
                uint set_token_A = Initialization_token_table[check_Assessor_A][check_Mission_type_A];       //提取初始化该评估师该任务的理论耗时

                uint tmp_time_A = now - check_Create_date_A;
                
                if(tmp_time_A >= set_time_A) {
                    loads_Robin[check_Assessor_A] -= 1;
                    mission_record_A[choose_ordernumber].Actual_time = tmp_time_A;
                    balanceOfA[check_Assessor_A] += set_token_A;
                    mission_record_A[choose_ordernumber].Assessor_token = balanceOfA[check_Assessor_A];
                }
            }


            if(mission_record_B[choose_ordernumber].Actual_time == 0) {
                uint check_Create_date = mission_record_B[choose_ordernumber].Create_date;                //提取该评估单下的创建时间
                address check_Assessor = mission_record_B[choose_ordernumber].Assessor;                      //提取该评估单下的评估师地址
                uint check_Mission_type = mission_record_B[choose_ordernumber].Mission_type;           //提取该评估单下的任务类型
                uint set_time = Initialization_time_table[check_Assessor][check_Mission_type];            //提取初始化该评估师该任务的理论耗时
                uint set_token = Initialization_token_table[check_Assessor][check_Mission_type];       //提取初始化该评估师该任务的理论耗时

                uint tmp_time = now - check_Create_date;
                
                if(tmp_time >= set_time) {
                    loads[check_Assessor] -= 1;
                    mission_record_B[choose_ordernumber].Actual_time = tmp_time;
                    balanceOfB[check_Assessor] += set_token;
                    mission_record_B[choose_ordernumber].Assessor_token = balanceOfB[check_Assessor];
                }
            }
        }
    }


    function _displaymodelinfo(uint index,uint num,uint flag) view internal returns (uint) {
        if(flag ==0 && num == 1) {
            return mission_record_A[index].Evaluation_index;             //评估单编号
        } 
        else if(flag ==0 && num == 2) {
            return mission_record_A[index].Mission_type;             //任务类型
        }
        else if(flag ==0 && num == 3) {
            return mission_record_A[index].Create_date;             //创建日期
        }
        else if(flag ==0 && num == 5) {
            return mission_record_A[index].Assessor_token;             //评估时通证数
        }
        else if(flag ==0 && num == 6) {
            return mission_record_A[index].Actual_time;             //实际耗时
        }
        else if(flag ==0 && num == 7) {
            return mission_record_A[index].loads;                         //当前负载情况
        }


        else if(flag ==1 && num == 1) {
            return mission_record_B[index].Evaluation_index;             //评估单编号
        } 
        else if(flag ==1 && num == 2) {
            return mission_record_B[index].Mission_type;             //任务类型
        }
        else if(flag ==1 && num == 3) {
            return mission_record_B[index].Create_date;             //创建日期
        }
        else if(flag ==1 && num == 5) {
            return mission_record_B[index].Assessor_token;             //评估时通证数
        }
        else if(flag ==1 && num == 6) {
            return mission_record_B[index].Actual_time;             //实际耗时
        }
        else if(flag ==1 && num == 7) {
            return mission_record_B[index].loads;                         //当前负载情况
        }
    }

    function _displayaddressinfo(uint index,uint num,uint flag) view internal returns (address) {
        if(flag ==0 && num == 4) {
            return mission_record_A[index].Assessor;             //评估师地址
        }
        else if(flag ==1 && num == 4) {
            return mission_record_B[index].Assessor;             //评估师地址
        }
    }

    function _backrecordnumber() internal returns (uint[]) {
        return recordnumber;
    }
}