# encoding:utf-8
import json
import pymysql
from flask import Flask,request
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# insert interface group
@app.route('/insert/carinfo',methods=['POST'])
def insert_carinfo():
    content = json.loads(request.data)

    address = content['address']
    Frame_number = content['Frame_number']
    Number_plate = content['Number_plate']
    Vehicle_type = content['Vehicle_type']
    Brand_number = content['Brand_number']
    Car_displacement = content['Car_displacement']
    approval_passengers = content['approval_passengers']
    Engine_number = content['Engine_number']
    Manufacture_date = content['Manufacture_date']
    Evaluation = content['Evaluation']
    Timestammp = content['Timestammp']
    Evaluation_status = content['Evaluation_status']

    db = pymysql.connect("localhost","guobin","wdsr9198988","evaluationinfo")
    cursor = db.cursor()

    Carinfoinsert = "INSERT INTO Carinfo(address,Frame_number,Number_plate,Vehicle_type,Brand_number,Car_displacement,approval_passengers,Engine_number,Manufacture_date,Evaluation,Timestammp,Evaluation_status) VALUES ('%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s')" % (address,Frame_number,Number_plate,Vehicle_type,Brand_number,Car_displacement,approval_passengers,Engine_number,Manufacture_date,Evaluation,Timestammp,Evaluation_status)

    cursor.execute(Carinfoinsert)

    db.commit()
    db.close()
    return 'carinfo ok'

@app.route('/insert/photoinfo',methods=['POST'])
def insert_photoinfo():
    content = json.loads(request.data)

    address = content['address']
    photo1 = content['photo1']
    photo2 = content['photo2']
    photo3 = content['photo3']
    photo4 = content['photo4']
    photo5 = content['photo5']
    photo6 = content['photo6']
    photo7 = content['photo7']
    photo8 = content['photo8']

    db = pymysql.connect("localhost","guobin","wdsr9198988","evaluationinfo")
    cursor = db.cursor()

    Photoinfoinsert = "INSERT INTO Photoinfo(address,photo1,photo2,photo3,photo4,photo5,photo6,photo7,photo8) VALUES ('%s','%s','%s','%s','%s','%s','%s','%s','%s')" % (address,photo1,photo2,photo3,photo4,photo5,photo6,photo7,photo8)

    cursor.execute(Photoinfoinsert)

    db.commit()
    db.close()
    return 'photoinfo ok'

@app.route('/insert/blocklist',methods=['POST'])
def insert_blocklist():
    content = json.loads(request.data)

    owner = content['owner']
    address = content['address']
    gasused = content['gasused']
    timestamp = content['timestamp']
    blockhash = content['blockhash']
    blocknumber = content['blocknumber']
    transactionid = content['transactionid']
    token = content['token']
    location = content['location']
    detail = content['detail']

    db = pymysql.connect("localhost","guobin","wdsr9198988","evaluationinfo")
    cursor = db.cursor()

    Blocklistinsert = "INSERT INTO Blocklist(owner,address,gasused,timestamp,blockhash,blocknumber,transactionid,token,location,detail) VALUES ('%s','%s','%s','%s','%s','%s','%s','%s','%s','%s')" % (owner,address,gasused,timestamp,blockhash,blocknumber,transactionid,token,location,detail)

    cursor.execute(Blocklistinsert)

    db.commit()
    db.close()
    return 'blocklist ok'

@app.route('/insert/Ipfshashlist',methods=['POST'])
def insert_ipfshashlist():
    content = json.loads(request.data)

    address = content['address']
    blocknumber = content['blocknumber']
    ipfshash = content['ipfshash']
    blockhash = content['blockhash']
    location = content['location']

    db = pymysql.connect("localhost","guobin","wdsr9198988","evaluationinfo")
    cursor = db.cursor()

    Ipfshashlistinsert = "INSERT INTO Ipfshashlist(address,blocknumber,ipfshash,blockhash,location) VALUES ('%s','%s','%s','%s','%s')" % (address,blocknumber,ipfshash,blockhash,location)

    cursor.execute(Ipfshashlistinsert)

    db.commit()
    db.close()
    return 'ipfshashlist ok'

# update interface group
@app.route('/update/carinfo/Evaluation',methods=['POST'])
def update_carinfo_Evaluation():
    content = json.loads(request.data)

    address = content['address']
    Evaluation = content['Evaluation']

    db = pymysql.connect("localhost","guobin","wdsr9198988","evaluationinfo")
    cursor = db.cursor()

    Carinfoinsert = "UPDATE Carinfo SET Evaluation = '%s' WHERE address = '%s'" % (Evaluation,address)

    cursor.execute(Carinfoinsert)

    db.commit()
    db.close()
    return 'update carinfo ok'

@app.route('/update/carinfo/Evaluation_status',methods=['POST'])
def update_carinfo_Evaluation_status():
    content = json.loads(request.data)

    address = content['address']
    Evaluation_status = content['Evaluation_status']

    db = pymysql.connect("localhost","guobin","wdsr9198988","evaluationinfo")
    cursor = db.cursor()

    Carinfoinsert = "UPDATE Carinfo SET Evaluation_status = '%s' WHERE address = '%s'" % (Evaluation_status,address)

    cursor.execute(Carinfoinsert)

    db.commit()
    db.close()
    return 'update carinfo ok'

@app.route('/update/blocklist',methods=['POST'])
def update_blocklist():
    content = json.loads(request.data)

    address = content['address']
    token = content['token']

    db = pymysql.connect("localhost","guobin","wdsr9198988","evaluationinfo")
    cursor = db.cursor()

    Blocklistinsert = "UPDATE Blocklist SET token = '%s' WHERE address = '%s'" % (token,address)

    cursor.execute(Blocklistinsert)

    db.commit()
    db.close()
    return 'update blocklist ok'


# search interface group
@app.route('/search/carinfo')
def search_carinfo():
    db = pymysql.connect("localhost","guobin","wdsr9198988","evaluationinfo" )

    cursor = db.cursor()

    number = request.args.get("key")
    sql = "SELECT * FROM Carinfo WHERE address = '%s'" % (number)
    cursor.execute(sql)
    db.commit()

    data = cursor.fetchall()
    db.close()


    jsonData = []

    for row in data:
        result = {}
        result['address'] = row[0]
        result['Frame_number'] = row[1]
        result['Number_plate'] = row[2]
        result['Vehicle_type'] = row[3]
        result['Brand_number'] = row[4]
        result['Car_displacement'] = row[5]
        result['approval_passengers'] = row[6]
        result['Engine_number'] = row[7]
        result['Manufacture_date'] = row[8]
        result['Evaluation'] = row[9]
        result['Timestammp'] = row[10]
        result['Evaluation_status'] = row[11]
        jsonData.append(result)

    jsondatar=json.dumps(jsonData,ensure_ascii=False)
    return jsondatar
    #return jsondatar[1:len(jsondatar)-1]

@app.route('/search/photoinfo')
def search_photoinfo():
    db = pymysql.connect("localhost","guobin","wdsr9198988","evaluationinfo" )

    cursor = db.cursor()

    sql = "SELECT * FROM Photoinfo"
    cursor.execute(sql)
    db.commit()

    data = cursor.fetchall()
    db.close()


    jsonData = []

    for row in data:
        result = {}
        result['address'] = row[0]
        result['photo1'] = row[1]
        result['photo2'] = row[2]
        result['photo3'] = row[3]
        result['photo4'] = row[4]
        result['photo5'] = row[5]
        result['photo6'] = row[6]
        result['photo7'] = row[7]
        result['photo8'] = row[8]
        jsonData.append(result)

    jsondatar=json.dumps(jsonData,ensure_ascii=False)
    return jsondatar
    #return jsondatar[1:len(jsondatar)-1]

@app.route('/search/blocklist')
def search_blocklist():
    db = pymysql.connect("localhost","guobin","wdsr9198988","evaluationinfo" )

    cursor = db.cursor()

    flag = request.args.get("key")
    param = request.args.get("param")
    if flag == 'owner':
        sql = "SELECT * FROM Blocklist WHERE owner = '%s'" % (param)
    elif flag == 'address':
        sql = "SELECT * FROM Blocklist WHERE address = '%s'" % (param)
    elif flag == 'timestamp':
        sql = "SELECT * FROM Blocklist order by timestamp desc LIMIT 5"
    else: 
        sql = "SELECT * FROM Blocklist"
        
    cursor.execute(sql)
    db.commit()

    data = cursor.fetchall()
    db.close()


    jsonData = []

    for row in data:
        result = {}
        result['owner'] = row[0]
        result['address'] = row[1]
        result['gasused'] = row[2]
        result['timestamp'] = row[3]
        result['blockhash'] = row[4]
        result['blocknumber'] = row[5]
        result['transactionid'] = row[6]
        result['token'] = row[7]
        result['location'] = row[8]
        result['detail'] = row[9]
        jsonData.append(result)

    jsondatar=json.dumps(jsonData,ensure_ascii=False)
    return jsondatar
    #return jsondatar[1:len(jsondatar)-1]

@app.route('/search/blocklist/owner')
def search_blocklist_owner():
    db = pymysql.connect("localhost","guobin","wdsr9198988","evaluationinfo" )

    cursor = db.cursor()

    number = request.args.get("key")
    sql = "SELECT distinct owner FROM Blocklist"

    cursor.execute(sql)
    db.commit()

    data = cursor.fetchall()
    db.close()

    jsonData = []

    for row in data:
        result = {}
        result['owner'] = row[0]
        jsonData.append(result)

    jsondatar=json.dumps(jsonData,ensure_ascii=False)
    return jsondatar

@app.route('/search/Ipfshashlist')
def search_Ipfshashlist():
    db = pymysql.connect("localhost","guobin","wdsr9198988","evaluationinfo" )

    cursor = db.cursor()

    flag = request.args.get("key")
    param = request.args.get("param")
    if flag == 'address':
        sql = "SELECT * FROM Ipfshashlist WHERE address = '%s'" % (param)
    elif flag == 'timestamp':
        sql = "SELECT * FROM Ipfshashlist order by timestamp desc LIMIT 5"
    else:
        sql = "SELECT * FROM Ipfshashlist"
    
    
    cursor.execute(sql)
    db.commit()

    data = cursor.fetchall()
    db.close()


    jsonData = []

    for row in data:
        result = {}
        result['address'] = row[0]
        result['timestamp'] = row[1]
        result['blocknumber'] = row[2]
        result['ipfshash'] = row[3]
        result['blockhash'] = row[4]
        result['location'] = row[5]
        jsonData.append(result)

    jsondatar=json.dumps(jsonData,ensure_ascii=False)
    return jsondatar
    #return jsondatar[1:len(jsondatar)-1]


if __name__ == '__main__':
    app.run(port=6001,debug=True)

