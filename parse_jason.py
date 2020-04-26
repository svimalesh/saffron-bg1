import csv
import json

json_file = open('testfile.json')
data = json.load(json_file)
json_file.close()

csvfile = csv.writer(open("out.csv", "wb+"))

for data in data:
    if not data['places']:
        csvfile.writerow([data["id"],
                          data["fname"],
                          data["lname"]])
    else:
        for place in data['places']:
            csvfile.writerow([data["id"],
                              data["fname"],
                              data["lname"],
                              place])