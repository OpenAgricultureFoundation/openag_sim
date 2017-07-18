import sys
import csv
import os
import json  # for outputting location info nicely
from pprint import pprint
import argparse
from matplotlib import pyplot as plt


def get_location(input_directory):
    epw = filter(lambda fname: fname.endswith(
        ".epw"), os.listdir(input_directory))[0]
    #print("EEEEEEEEEE", epw)
    with open(input_directory + "/" + epw, "rb") as csvfile:
        weatherFile = csv.reader(csvfile)
        tup = next(weatherFile)
        return epw[:-4], tup[6], tup[7]
    # return
    for elt in os.listdir(input_directory):
        fileName = elt[:-4]
        # print fileName
        if not (elt.endswith(".epw")):
            continue
        with open(input_directory + "/" + elt, "rb") as csvfile:
            weatherFile = csv.reader(csvfile)
            # print next(weatherFile)


parser = argparse.ArgumentParser()
parser.add_argument('--dir', default='EPW')
parser.add_argument('--referencefile',
                    default='referenceFile.txt')  # later mod
parser.add_argument('--output', default='latLongValData.json')  # later mod

if __name__ == '__main__':
    args = parser.parse_args()
    # Elena's modification: get paths to all directories that contain the .epw
    # file
    lowest_dirs = list()

    for root, dirs, files in os.walk(args.dir):
        if not dirs:
            lowest_dirs.append(root)

    lat_lon_by_fname = {fname: (lat, lon) for fname, lat, lon in (
        get_location(d) for d in lowest_dirs)}
    ref = open(args.referencefile)
    no_by_fname = {}
    for no, bogusname in enumerate(ref, 1):
        bogusname = bogusname.strip()[:-4]
        for fname in lat_lon_by_fname.keys():
            if bogusname.endswith(fname):
                no_by_fname[fname] = no

    # pprint(no_by_fname)
    output = []
    max_out = 0
    for fname, (lat, lon) in lat_lon_by_fname.items():
        try:
            f = open('./RES/%sLeafAreaIndex.sci' % no_by_fname[fname])
            val = float(f.read().split("\n")[-2])
            output.append([lat, lon, val, fname])
            max_out = max(max_out, val)
        except IOError:
            pass

    # output = [(lat, lon, val / max_out) for lat, lon, val in output] # pre messing-with normalizing data, it was this
    #output = [(lat, lon, val) for lat, lon, val in output]

    #vals = [v for lat, lon, v in output]
    #plt.hist(vals, bins=100)
    # plt.show()

    # uncomment this when done trying to figure out how to normalize
    json.dump(output, open(args.output, 'w+'))

    #(lat, lon): float(open(dfname).read().splitlines()[-2]) for dfname, (lat, lon) in }

    # pprint(lat_lon_by_fname)
    """
    for d in lowest_dirs:
        #reader(d) # this if want to "read" the epw files. else

        # 3/30/17 get locations

        fname, lat, lon = get_location(d)
        print(fname, lat, lon)

        """

    # below is what is used to do
    # reader(sys.argv)
