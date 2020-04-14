# def main():
#     m1,n1 = map(int,input().split())
#     mat1 = [ [0 for x in range(m1)] for y in range(n1)]
#
#
#
#     for i in range(n1):
#             mat1[i] = list(map(int,input().split()))
#
#
#     m2, n2 = map(int, input().split())
#     mat2 = [[0 for x in range(m2)] for y in range(n2)]
#
#     for i in range(n2):
#         mat2[i] = list(map(int, input().split()))
#
#     for i in range(n1):
#         for j in range(m1):
#             mat1[i][j] = mat1[i][j] + mat2[i][j]
#
#     for i in range(n1):
#         for j in range(m1):
#             print(mat1[i][j],end=" ")
#         print("")
#
#
#
# main()

# import csv
# from pymongo import MongoClient
# from bson import ObjectId
#
#
# # def isuserinDB(mycollection,user_id):
# #     data_in = mycollection.find_one({"_id":ObjectId(user_id)})
# #     print(data_in)
# #     if data_in == None:
# #         return False
# #     elif len(data_in) >= 1:
# #         return True
# #     else:
# #         return False
#
#
#
# def csvOffers():
#     client = MongoClient("mongodb://localhost:27017/")
#     mydatabase = client["minor2"]
#     mycollection = mydatabase["offers"]
#     reader = csv.DictReader(open("C:/Users/WELCOME/Desktop/recent need/offersFile.csv"))
#
#
#
#     for raw in reader:
#         print(raw)
#
#         # if isuserinDB(mycollection,raw["user_id"]):
#         #     mycollection.update_one(
#         #         {"_id":ObjectId(raw["user_id"])},
#         #         {
#         #             "$set": {
#         #                 "name": raw["user_id"],
#         #                 "contact": raw["contact"],
#         #                 "address": raw["address"],
#         #                 "email": raw["email"],
#         #             }
#         #         },
#         #         upsert=True
#         #     )
#         # else:
#         mycollection.insert_one(
#             {
#                 "name": raw["name"],
#                 "barcode": raw["barcode"],
#                 "weight": raw["weight"],
#                 "price": raw["price"],
#                 "pic_url": raw["pic_url"],
#             }
#         )
#


# csvOffers()

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from apyori import apriori
import json



def set_default(obj):
    if isinstance(obj, set):
        return list(obj)
    raise TypeError


def saveTrained(trained):
    with open('data.json', 'w') as outfile:
        # one = str(trained).replace("'","\"")
        # two = one.replace("\"","'")
        # print("Going = ",one)
        json.dump(trained, outfile,default=set_default)



store_data = pd.read_csv('C:/Users/WELCOME/Desktop/ML/edureka ML/minor.csv')

print(store_data.head())

store_data = pd.read_csv('C:/Users/WELCOME/Desktop/ML/edureka ML/minor.csv', header=None)

records = []
for i in range(0,len(store_data)):
    records.append([str(store_data.values[i,j]) for j in range(0,16)])
# Support: 0.043478260869565216

association_rules = apriori(records,min_support=0.00000001, min_length=2)
association_results = list(association_rules)
#
print(len(association_results))
print("= ",association_results)
print("= ",association_results[8])
#
trained = {}

for item in association_results:
    # first index of the inner list
    # Contains base item and add item
    pair = item[0]
    items = [x for x in pair]
    try:
        print("Rule: " + items[0] + " -> " + items[1])

        if items[0]!="nan" and items[1]!="nan":
            if items[0] in trained.keys():
                # trained[items[0]].append(items[1])
                trained[items[0]].add(items[1])
                trained[items[1]].add(items[0])

            else:
                trained[items[0]]=set()
                trained[items[1]]=set()
                # trained[items[0]].append(items[1])
                trained[items[0]].add(items[1])
                trained[items[1]].add(items[0])




        # second index of the inner list
        print("Support: " + str(item[1]))

        # third index of the list located at 0th
        # of the third index of the inner list

        print("Confidence: " + str(item[2][0][2]))
        print("Lift: " + str(item[2][0][3]))
        print("=====================================")
    except:
        # print("one val")
        pass



    print(trained)
saveTrained(trained)




