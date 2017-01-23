# Preprocessing/Normalization of wather data
# Author: Andrea Sessa

import csv
import sys
import matplotlib.pyplot as plt
import datetime
from matplotlib.dates import DayLocator, HourLocator, DateFormatter, drange
from numpy import arange

TMIN = -15
TMAX = 40
HMIN = 0
HMAX = 100

MONTHS = ['January','February','March','April','May','June','July','Agust','September','October','November','December']

def getDailyAvg(dates, data, date):
    i = 0
    ret = []
    for d in dates:
        y = d.split('-')[0]
        m = d.split('-')[1]
        d = d.split('-')[2]

        if y+'-'+m+'-'+d == date:
            ret.append(data[i])
        i += 1
    return sum(ret)/len(ret)

def compDates(dt1,dt2):
    y1 = int(dt1.split('-')[0])
    m1 = int(dt1.split('-')[1])
    d1 = int(dt1.split('-')[2])

    y2 = int(dt2.split('-')[0])
    m2 = int(dt2.split('-')[1])
    d2 = int(dt2.split('-')[2])

    if y1 > y2:
        return True
    elif y1 == y2:
        if m1 > m2:
            return True
        elif m1 == m2:
            if d1 > d2:
                return True
    return False


def getDaylyData(dates, data, date):
    ret = []
    i = 0
    j = 0
    ret = []
    for d in dates:
        y = d.split('-')[0]
        m = d.split('-')[1]
        d = d.split('-')[2]

        if y+'-'+m+'-'+d == date:
            if i % 6 == 0:
                ret.append(data[j])
            i += 1

        if compDates(y+'-'+m+'-'+d, date):
            break
        j += 1
    return ret


def monthlyAvg(dates, data, mon):
    ret = []
    dist_d = set(dates)

    if(mon < 10): mon = '0'+str(mon)

    for d in dist_d:
        m = d.split('-')[1]
        if m == str(mon):
            ret.append(getDailyAvg(dates,data,d))
    return sum(ret)/len(ret)


def truncate(s):
    if s[0] == '"':
        return s[1:]
    return s

def getMonths(dates):
    ret = []
    dd = set(dates)
    for d in dd:
        ret.append(d.split('-')[1])
    return set(ret)

def main():
    filename = sys.argv[1]

    # Read the csv file containing the data
    with open(filename, newline='') as csvfile:
        csvReader = csv.reader(csvfile, delimiter=',', quotechar='|')

        dates = []
        times = []
        temps = []
        hums = []
        lumns = []

        for row in csvReader:
            if len(row) >= 3:
                # row[0] -> Date/Time
                # row[1] -> ID
                # row[2] -> Temp
                # row[3] -> Hum
                # row[4] -> Lum
                if row[2] != '' and row[3] != '':
                    if float(row[2]) >= TMIN and float(row[2]) < TMAX and float(truncate(row[3])) > HMIN and float(truncate(row[3])) < HMAX:
                        dt = row[0].split()
                        dates.append(dt[0])
                        times.append(dt[1])
                        temps.append(float(row[2]))
                        hums.append(float(truncate(row[3])))
                        if len(row) > 4:
                            lumns.append(float(truncate(row[4])))
                        else:
                            lumns.append(-1)

        months = getMonths(dates)

        monthlyPlot(dates,temps,9)

        for m in months:
            print("Average Temperature in " + MONTHS[int(m)-1]+": " + str(monthlyAvg(dates, temps, int(m))))
            print("Average Humidity in " + MONTHS[int(m)-1]+": " + str(monthlyAvg(dates, hums, int(m))))
            print("Average Luminosity in " + MONTHS[int(m)-1]+": " + str(monthlyAvg(dates, lumns, int(m))))

def sortData(dates,data):
    timestamps, elements = zip(*sorted(zip(dates, data)))
    return timestamps, elements


def monthlyPlot(dates,data,mon):
    fig, ax = plt.subplots()

    ddates = set(dates)

    if(mon < 10): mon = '0'+str(mon)
    mon = str(mon)
    y = []
    mon_d = []
    for d in ddates:
        s = d.split('-')
        m = s[1]
        if m == str(mon):
            dd = datetime.datetime(int(s[0]), int(s[1]), int(s[2]))
            ddata = getDailyAvg(dates,data,d)
            y += [ddata]
            mon_d += [dd]

    [mon_d,y] = sortData(mon_d,y)

    ax.plot_date(mon_d, y,'r-')

    ax.xaxis.set_major_locator(DayLocator())
    ax.xaxis.set_minor_locator(HourLocator(arange(0, 25, 6)))
    ax.xaxis.set_major_formatter(DateFormatter('%Y-%m-%d'))

    ax.fmt_xdata = DateFormatter('%Y-%m-%d')
    fig.autofmt_xdate()
    plt.grid()
    plt.title(MONTHS[int(mon)-1])
    plt.show()

if __name__=="__main__":
    main()
