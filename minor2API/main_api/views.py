import json
from pymongo import MongoClient
from bson.json_util import dumps
import time
from barcode.writer import ImageWriter
import barcode
import random
from datetime import datetime

# Create your views here.
def isuserinDB(mycollection,userdata):
    data_in = mycollection.find_one({"email":userdata["email"]})
    print(data_in)
    if data_in == None:
        return False
    elif len(data_in) >= 1:
        return True
    else:
        return False

def is_user_in_DB(request):
    payload = json.loads(request.body)
    client = MongoClient("mongodb://localhost:27017/")
    mydatabase = client["minor2"]
    mycollection = mydatabase["usersDB"]
    email = payload['email']
    data_in = mycollection.find_one({"email": email})
    print(data_in)
    response = json.dumps({'message': 'error'})
    if data_in==None:
        response = json.dumps({'message': 'false'})
    elif len(data_in) >= 1:
        data_send = dumps(data_in)
        response = json.dumps({'message': 'true','user':data_send})
    else:
        response = json.dumps({'message': 'false'})

    return HttpResponse(response, content_type='text/json')

def register_user_in_DB(request):
    if request.method == 'GET':
        print("GET method called here")
        response = json.dumps([{'message': 'Get not allowed'}])
        return HttpResponse(response, content_type='text/json')
    response = json.dumps([{'message': 'initiated data'}])
    if request.method == 'POST':
        payload = json.loads(request.body)
        client = MongoClient("mongodb://localhost:27017/")
        mydatabase = client["minor2"]
        mycollection = mydatabase["usersDB"]
        email = payload['email']
        name = payload['name']
        phone = payload['phone']
        address = payload['address']


        userdata = {
            "email": email,
            "name" : name,
            "phone": phone,
            "address":address
        }
        print("18")
        if isuserinDB(mycollection, userdata):
            response = json.dumps({'message': 'already a user'})
            return HttpResponse(response, content_type='text/json')
        else:
            res = mycollection.insert_one(userdata)

        print(userdata)
        print("message = ", res)
        print("inserted")
        response = json.dumps([{'message': 'user added successfully', 'status': True}])

    return HttpResponse(response, content_type='text/json')

def update_user_info(request):
    if request.method == 'GET':
        print("GET method called here")
        response = json.dumps([{'message': 'Get not allowed'}])
        return HttpResponse(response, content_type='text/json')
    response = json.dumps([{'message': 'initiated data'}])
    if request.method == 'POST':
        payload = json.loads(request.body)
        client = MongoClient("mongodb://localhost:27017/")
        mydatabase = client["minor2"]
        mycollection = mydatabase["usersDB"]
        email = payload['email']
        name = payload['name']
        phone = payload['phone']
        address = payload['address']


        userdata = {
            "email": email,
            "name" : name,
            "phone": phone,
            "address":address
        }

        res = mycollection.replace_one(
            {"email": email},
            userdata
        )

        print(userdata)
        print("message = ", res)
        print("Data is updated")
        response = json.dumps([{'message': 'data updated successfully', 'status': True}])

    return HttpResponse(response, content_type='text/json')

def start_order(request):
    if request.method == 'POST':
        payload = json.loads(request.body)
        client = MongoClient("mongodb://localhost:27017/")
        mydatabase = client["minor2"]
        mycollection = mydatabase["Orders"]

        email = payload['email']
        data = {
            "email":email,
            "checkout":"false"
        }

        FindOrder = mycollection.find_one(data)
        print("1")
        if FindOrder == None:
            print("2")
            ticks = time.time_ns()
            RandomNumber = str(random.randrange(100, 999)) + "" + str(int(ticks))
            print("RandomNumber = ", RandomNumber)
            barcode_url = make_barcode(RandomNumber)
            orderID = barcode_url
            print("orderID = ", orderID, " and ", barcode_url)
            # amount = payload['amount']

            userdata = {
                "timestamp": str(datetime.now()),
                "amount": "",
                "orderID": orderID,
                "email": email,
                "barcode_url": orderID,
                "checkout": "false",
                "items": []
            }
            res = mycollection.insert_one(userdata)

            response = json.dumps(
                {
                    "timestamp": str(datetime.now()),
                    "amount": "",
                    "orderID": orderID,
                    "email": email,
                    "barcode_url": barcode_url,
                    "checkout": "false",
                    "items": []
                }
            )

            print("message = ", res)
            print("inserted")
            # response = json.dumps({'message': 'Order added and barcode created successfully', 'status': True})
        elif len(FindOrder) >= 1:
            print("3 = ",FindOrder)
            response = dumps(FindOrder)


    return HttpResponse(response, content_type='text/json')

def make_barcode(id):
    ean = barcode.get('ean13', id,writer=barcode.writer.ImageWriter(),)
    # ean = barcode.get('code128', id,writer=barcode.writer.ImageWriter(),)
    # ean.default_writer_options["write_text"] = False

    print("EAN = ",ean.ean)
    filename = ean.save("orders_barcode/{}".format(ean))
    print("file saved")
    return ean.ean

def post_item(request):
    if request.method == 'POST':
        payload = json.loads(request.body)
        client = MongoClient("mongodb://localhost:27017/")
        mydatabase = client["minor2"]
        mycollection = mydatabase["items"]

        data = {
            "name": payload['name'],
            "barcode": payload['barcode'],
            "weight": payload['weight'],
            "price": payload['price'],
            "pic_url": payload['pic_url'],
        }
        res = mycollection.insert_one(data)
        print("message = ", res)
        print("inserted")
        response = json.dumps([{'message': 'item added successfully'}])

    else:
        response = json.dumps([{'message': 'Get not allowed'}])

    return HttpResponse(response, content_type='text/json')

def search_item(request):
    if request.method == 'POST':
        payload = json.loads(request.body)
        client = MongoClient("mongodb://localhost:27017/")
        mydatabase = client["minor2"]
        mycollection = mydatabase["items"]

        barcode = payload['barcode']

        userdata = {
            "barcode": barcode,
        }
        print("18")
        cursor = mycollection.find_one(userdata)
        print("19")

        if cursor == None:
            print("20")
            response = json.dumps({'message': 'Item Not in DB', 'status': True})
            HttpResponse(response, content_type='text/json')
        else:
            print("cursor = ", cursor)
            # response = dumps(cursor)
            try:
                suggestions = return_suggestions(barcode)
                response = json.dumps({'message': dumps(cursor), 'suggestions': dumps(suggestions), 'status': True})
            except:
                print("No suggestions generated")
                response = json.dumps({'message': dumps(cursor), 'suggestions': 'no', 'status': True})

            print("message = ", response)
        # response = json.dumps([{'message': 'user added successfully'}])

    return HttpResponse(response, content_type='text/json')

def add_item_to_cart(request):
    if request.method == 'POST':
        payload = json.loads(request.body)
        client = MongoClient("mongodb://localhost:27017/")
        mydatabase = client["minor2"]
        mycollection = mydatabase["Orders"]

        items = payload['items']
        email = payload['email']
        orderID = payload['orderID']

        userdata = {
            "items": items,
        }
        print("18")
        cursor = mycollection.update_many(
            {"email":email,"orderID":orderID},
            {
                "$set":{
                    "items": items
                }
            },
            upsert=True
        )
        print("19")
        response = json.dumps({'message': "item added", 'status': True})

    return HttpResponse(response, content_type='text/json')

def checkout_true(request):
    if request.method == 'POST':
        payload = json.loads(request.body)
        client = MongoClient("mongodb://localhost:27017/")
        mydatabase = client["minor2"]
        mycollection = mydatabase["Orders"]
        mycollection2 = mydatabase["completed_orders"]

        paid = payload['paid']
        email = payload['email']
        orderID = payload['orderID']
        amount = payload['amount']


        print("18")
        if paid=="true":
            print("1")

            cursor = mycollection.update_many(
                {"email":email,"orderID":orderID},
                {
                    "$set":{
                        "checkout": "true",
                        "amount":amount
                    }
                },
                upsert=True,
            )
            print("2")

            cursor2 = mycollection.find_one(
                {
                    "email": email,
                    "orderID": orderID,
                    "checkout": "true"
                }
            )
            print("3")

            mycollection.delete_one(
                {
                    "email": email,
                    "orderID": orderID,
                    "checkout": "true"
                }
            )
            print("4")
            print(cursor2)
            mycollection2.insert(cursor2)
            print("5")

            response = json.dumps({'message': "checkout confirm", 'status': True})
        else:
            response = json.dumps({'message': "checkout false", 'status': False})

        print("19")

    return HttpResponse(response, content_type='text/json')

def getOffer(request):
    if request.method == 'GET':
        client = MongoClient("mongodb://localhost:27017/")
        mydatabase = client["minor2"]
        mycollection = mydatabase["offers"]


        cursor = mycollection.find()
        print("19")

        if cursor == None:
            print("20")
            response = json.dumps({'message': 'No Offers', 'status': False})
            HttpResponse(response, content_type='text/json')
        else:
            print("cursor = ", cursor)
            # response = dumps(cursor)
            response = json.dumps({'message': dumps(cursor), 'status': True})

    print("19 get only")

    return HttpResponse(response, content_type='text/json')
# ML part below it
import pandas as pd
from apyori import apriori
import csv
import os

def prepare_data():
    client = MongoClient("mongodb://localhost:27017/")
    mydatabase = client["minor2"]
    mycollection = mydatabase["completed_orders"]
    print("prepare 1")

    cursor = mycollection.find()
    print("prepare 2")
    os.remove("res/orders_data_for_training.csv")

    for order in cursor:
        print(order)
        barcodes = []
        count = 20
        for item in order["items"]:
            barcodes.append(item['barcode'])
            count -= 1
        print("prepare 3")

        for i in range(0, count + 1):
            barcodes.append("")
        print("prepare 4")

        with open('res/orders_data_for_training.csv', 'a', newline='\n') as file:
            writer = csv.writer(file)
            writer.writerow(barcodes)
        print("prepare 5")

def set_default(obj):
    if isinstance(obj, set):
        return list(obj)
    raise TypeError

def saveTrained(trained):
    print("save 1")

    with open('res/trained_data.json', 'w') as outfile:
        # one = str(trained).replace("'","\"")
        # two = one.replace("\"","'")
        # print("Going = ",one)
        json.dump(trained, outfile,default=set_default)
    print("save 2")

def train_data(request):
    print("tarin 1")
    prepare_data()
    # first it'll prepare the data, from the above code , and save it in 'orders_data_for_training' in 'res' folder.
    print("tarin 2")

    store_data = pd.read_csv('res/orders_data_for_training.csv')
    print("tarin 3")

    print(store_data.head())
    print("tarin 4")

    store_data = pd.read_csv('res/orders_data_for_training.csv', header=None)
    # from that prepared data, saved file we read it again
    print("tarin 5")

    records = []
    # this variable will hold the orders in form of seperate list ,like this :-
    # [
    #     [12356987, 123654789, 26579845 ],    <- order 1st
    #     [12356925, 123654778, 26579487  ],   <- order 2nd
    #        .
    #        .
    #        .
    #        .                                  <- order n
    #
    # ]
    # converts each line into list of ID of items
    for i in range(0, len(store_data)):
        records.append([str(store_data.values[i, j]) for j in range(0, 16)])
    # Support: 0.043478260869565216
    print("tarin 6")
    print("record = ",records)
    # ************************************************************************************************
    # ************************************************************************************************
    # THIS IS THE MAIN FUNCTION
    association_rules = apriori(records, min_support=0.00000001, min_length=2)
    association_results = list(association_rules)
    # ************************************************************************************************
    # ************************************************************************************************
    print("tarin 7")

    print(len(association_results))
    print("= ", association_results)
    # this will give us a query set, which is usefull of course and it'll be the final prediction you make,
    # find a pair you want to predict, (a,b) -> means if someone buys 'a' he'll buy 'b' also and vise-versa
    # but there are a lot of other information also here with in the query set which is not really required.
    # our next task is how to extract this data in form of simple (a,b) relation and save it.
    # why save it - so that we don't have to calculate this relations everytime a person searches for a item.

    # ************************************************************************************************
    # ************************************************************************************************
    # SAVE DATA
    trained = {}
    print("tarin 8")
    # below is a simple logic , which extracts the data
    # first it take a one query set from all the trained data and perform logic on it
    # logic -> if 'a' is related to 'b' then 'b' is also related to 'a'
    # of course it's simple and we know that but we have to tell this to the computer also.
    # if on index a -> b doesn't imply that index b -> a
    # hence we have just performed some simple logic to create this.
    for item in association_results:
        # first index of the inner list
        # Contains base item and add item
        pair = item[0]
        items = [x for x in pair]
        try:
            print("Rule: " + items[0] + " -> " + items[1])

            # do not compute anything for 'nan' = that's just empty cells / sparse data
            if items[0] != "nan" and items[1] != "nan":
                # what is going on in the below part if/elif/elif/elif/else
                # it's working is described in the animation
                if items[0] in trained.keys() and items[1] in trained.keys():
                    trained[items[0]].add(items[1])
                    trained[items[1]].add(items[0])
                elif items[0] in trained.keys() and items[1] not in trained.keys():
                    trained[items[0]].add(items[1])
                    trained[items[1]] = set()
                    trained[items[1]].add(items[0])
                elif items[0] not in trained.keys() and items[1]  in trained.keys():
                    trained[items[0]] = set()
                    trained[items[0]].add(items[1])
                    trained[items[1]].add(items[0])
                else:
                    trained[items[0]] = set()
                    trained[items[1]] = set()
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
    # ************************************************************************************************
    # ************************************************************************************************
    # SAVE THE RELATIONS ON THE HARD DISK
    saveTrained(trained)
    # now our data is trained and ready to predict

    print("tarin 9")

    response = json.dumps({'message':"data trained", 'status': True})

    return HttpResponse(response, content_type='text/json')

def return_suggestions(barcode_in):
    suggested_barcodes = []
    suggested_items = []
    with open('res/trained_data.json') as json_file:
        data = json.load(json_file)
        # data = json.dumps(data)
        print(data[barcode_in+".0"])
        suggested_barcodes = data[barcode_in+".0"]

    client = MongoClient("mongodb://localhost:27017/")
    mydatabase = client["minor2"]
    mycollection = mydatabase["items"]

    for code in suggested_barcodes:
        code = code.split(".")
        code = code[0]
        userdata1 = {
            "barcode": code,
        }
        cursor = mycollection.find_one(userdata1)
        if cursor != None:
            suggested_items.append(cursor)

    print("suggested items =",suggested_items)
    # response = json.dumps({'message': dumps(suggested_items), 'status': True})

    # print("response = ", response)
    return suggested_items


from io import BytesIO
from django.http import HttpResponse
from django.template.loader import get_template
from xhtml2pdf import pisa

def render_to_pdf(template_src, context_dict={}):
    print("A")

    template = get_template(template_src)
    print("B = ",context_dict)
    html = template.render(context_dict)
    print("C")
    result = BytesIO()
    print("D")
    pdf = pisa.pisaDocument(BytesIO(html.encode("ISO-8859-1")), result)
    print("E")
    if not pdf.err:
        return HttpResponse(result.getvalue(), content_type='application/pdf')
    return None

from email.message import EmailMessage
import smtplib
from django.conf import settings

def send_invoice(request):

    payload = json.loads(request.body)
    print("13 send invoice = ", payload)

    items = json.loads(payload["items"])
    # items =payload["items"]
    # items = payload["items"]
    print("13 = ", items)
    msg = EmailMessage()
    print("invoice send 1")
    msg['Subject'] = payload["order_id"] + " Invoice"
    print("invoice send21")

    msg['From'] = settings.EMAIL_HOST_USER
    print("invoice send 3")

    msg['To'] = payload["customer_email"]
    print("invoice send 4")

    msg.set_content("Thank you for shopping with us")
    print("invoice send 5")

    orderData = {
        "items": items,
        "order_id": payload["order_id"],
        "total": payload["total"],
        "customer_address":payload["customer_address"],
        "customer_email":payload["customer_email"],
        "date":str(datetime.now())
    }

    print(orderData)
    pdf = render_to_pdf('invoice_template.html', orderData)
    print("1")

    pdf2 = pdf.getvalue()
    print("2")

    msg.add_attachment(pdf2,maintype='application',subtype='octet-stream',filename='invoice.pdf')
    print("3")

    with smtplib.SMTP_SSL('smtp.gmail.com',465) as smtp:
        # smtp.login(settings.EMAIL_HOST_USER,settings.EMAIL_HOST_PASSWORD)
        smtp.login("taacropolis@gmail.com","Acropolis@123")
        smtp.send_message(msg)
        print("4")

    response = json.dumps([{'message': 'invoice sent'}])
    return HttpResponse(response, content_type='text/json')
    # return HttpResponse(pdf, content_type='application/pdf')

def ngrok_eg(request):
    response = "HAY YAHH BORSE"
    return HttpResponse(response, content_type='text')

def previous_order(request):
    payload = json.loads(request.body)
    client = MongoClient("mongodb://localhost:27017/")
    mydatabase = client["minor2"]
    mycollection = mydatabase["completed_orders"]

    userdata1 ={
        "email":payload['email']
    }
    cursor = mycollection.find(userdata1)
    data = dumps(cursor)
    print(data)

    response = json.dumps([{'message': data}])
    return HttpResponse(response, content_type='text/json')

