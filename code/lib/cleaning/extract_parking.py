import csv

with open('parking_lots.csv', 'r') as f:
    csvreader = csv.reader(f)
    for row in csvreader:
        with open('new_parking.csv', 'a+') as o:
            csvwriter = csv.writer(o)
            csvwriter.writerow([row[0], row[1], row[-2]])
