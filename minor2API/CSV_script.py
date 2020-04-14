import csv
from pymongo import MongoClient
from bson import ObjectId


def isuserinDB(mycollection,user_id):
    data_in = mycollection.find_one({"_id":ObjectId(user_id)})
    print(data_in)
    if data_in == None:
        return False
    elif len(data_in) >= 1:
        return True
    else:
        return False



def main():
    client = MongoClient("mongodb://localhost:27017/")
    mydatabase = client["SampleDB"]
    mycollection = mydatabase["users"]
    reader = csv.DictReader(open("C:/Users/WELCOME/Desktop/recent need/file1.csv"))



    for raw in reader:
        print(raw)

        if isuserinDB(mycollection,raw["user_id"]):
            mycollection.update_one(
                {"_id":ObjectId(raw["user_id"])},
                {
                    "$set": {
                        "name": raw["user_id"],
                        "contact": raw["contact"],
                        "address": raw["address"],
                        "email": raw["email"],
                    }
                },
                upsert=True
            )
        else:
            mycollection.insert_one(
                {
                    "name": raw["user_id"],
                    "contact": raw["contact"],
                    "address": raw["address"],
                    "email": raw["email"],
                }
            )





def isiteminDB(mycollection,barcode):
    data_in = mycollection.find_one({'barcode':barcode})
    print(data_in)
    if data_in == None:
        return False
    elif len(data_in) >= 1:
        return True
    else:
        return False

def post_new_items():
    client = MongoClient("mongodb://localhost:27017/")
    mydatabase = client["minor2"]
    mycollection = mydatabase["items"]
    reader = csv.DictReader(open("C:/Users/WELCOME/AndroidStudioProjects/minor2/minor2API/res/post_items.csv"))

    for raw in reader:
        print(raw)

        if isiteminDB(mycollection, raw["barcode"]):
            mycollection.update_one(
                {"barcode": raw['barcode']},
                {
                    "$set": {
                        "name": raw["name"],
                        "barcode": raw["barcode"],
                        "weight": raw["weight"],
                        "price": raw["price"],
                        "pic_url": raw["pic_url"],
                    }
                },
                upsert=True
            )
        else:
            mycollection.insert_one(
                {
                    "name": raw["name"],
                    "barcode": raw["barcode"],
                    "weight": raw["weight"],
                    "price": raw["price"],
                    "pic_url": raw["pic_url"],
                }
            )

    print("Items inserted successfully !!")

def delete_item():
    client = MongoClient("mongodb://localhost:27017/")
    mydatabase = client["minor2"]
    mycollection = mydatabase["items"]

    barcode = input("Enter barcode to delete Item = ")

    try:
        mycollection.delete_one({"barcode": barcode})
        print("Success in deleting")
    except:
        print("error in deleting")


def post_offers():
    client = MongoClient("mongodb://localhost:27017/")
    mydatabase = client["minor2"]
    mycollection = mydatabase["offers"]
    reader = csv.DictReader(open("C:/Users/WELCOME/AndroidStudioProjects/minor2/minor2API/res/post_offers.csv"))

    for raw in reader:
        print(raw)

        if isiteminDB(mycollection, raw["barcode"]):
            mycollection.update_one(
                {"barcode": raw['barcode']},
                {
                    "$set": {
                        "name": raw["name"],
                        "barcode": raw["barcode"],
                        "weight": raw["weight"],
                        "price": raw["price"],
                        "pic_url": raw["pic_url"],
                    }
                },
                upsert=True
            )
        else:
            mycollection.insert_one(
                {
                    "name": raw["name"],
                    "barcode": raw["barcode"],
                    "weight": raw["weight"],
                    "price": raw["price"],
                    "pic_url": raw["pic_url"],
                }
            )

    print("offers inserted successfully !!")

post_new_items()
# post_offers()