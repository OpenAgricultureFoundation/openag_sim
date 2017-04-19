import sys
import csv
import os
import json # for outputting location info nicely
from pprint import pprint
import argparse
from matplotlib import pyplot as plt

# Recall that growth cycle is dependent on cumulated thermal temperature
# According to cotton.org this requires from 2200-2600 "heat units" for full growth
# Heat units is defined as :Average of (max Temp_i+min Temp_i-threshold=60 degrees)
# However, GreenScilab requires sum of cumulated thermal time, so use the
# above for reference


def averager(listToUpdate, sequence, data, isRain):
    elapsedDays = 0
    for x in range(0, len(sequence)):
        totalStuff = 0
        noneBogus = 0
        for y in range(elapsedDays * 24, (elapsedDays + sequence[x]) * 24):

            if (isRain):
                if(int(data[y]) != 999):
                    noneBogus = noneBogus + 1
                    totalStuff = totalStuff + data[y]
            else:
                totalStuff = totalStuff + data[y]

        if (isRain):
            if (noneBogus == 0):
                if (totalStuff > 0):
                    listToUpdate.append(listToUpdate[-1])
                else:
                    listToUpdate.append(0)
            else:
                listToUpdate.append(totalStuff / (1.0 * noneBogus))

            elapsedDays = elapsedDays + sequence[x]

        else:
            listToUpdate.append(totalStuff / (24.0 * sequence[x]))
            elapsedDays = elapsedDays + sequence[x]

# Formats axis into averages of the same data


def outputParameter(colx, coly, colz, new_path, filename):
    output_file = new_path + "/" + filename + ".dat"
    f = open(output_file, "w")
    f.write("environmental target file: temp2.dat, temperature and light data")
    f.write("\n")
    f.write("\n")
    f.write("GCNumber	WATER		TEMPERATURE	LIGHT")
    f.write("\n")
    for x in range(0, len(colx)):
        f.write("GC" + str(x + 1) + ":" + "		")
        f.write(str(round(colx[x], 2)))
        f.write("		")
        f.write(str(round(coly[x], 2)))
        f.write("		")
        f.write(str(round(colz[x], 2)))
        f.write("\n")

# takes input_directory as string
def reader(input_directory):
    #input_directory = str(args[1])

    for elt in os.listdir(input_directory):
        fileName = elt[:-4]
        print fileName

        if not (elt.endswith(".epw")):
            continue
        with open(input_directory + "/" + elt, "rb") as csvfile:
            weatherFile = csv.reader(csvfile)
            counter = 0
            rain = []
            radiation = []
            temperature = []
            start = 753

            rainAvg = []
            radiationAvg = []
            temperatureAvg = []
            for eltx in weatherFile:
                counter = counter + 1
                # if counter==19:
                # Access the header for the relavent info
                if counter >= start and counter <= 7680 + start:
                    # index 3 is for temperature
                    # index -2 is for rain
                    # index 8 is for vertical radiation

                    temperature.append(float(eltx[6]))
                    radiation.append(float(eltx[14]))
                    rain.append(float(eltx[33]))

            # Calculate averages per sections of growth, will be divided
            sequence = []
            for x in range(40):
                sequence.append(8)

            averager(rainAvg, sequence, rain, True)
            averager(radiationAvg, sequence, radiation, False)
            averager(temperatureAvg, sequence, temperature, False)

            # Scale water to the portions found in input files
            noneBogus = []
            for elt in rain:
                if (int(elt) != 999):
                    noneBogus.append(elt)
            if (len(noneBogus) == 0):
                maxWater = 0.1
            else:
                maxWater = max(noneBogus)

            # From 800 to 1200
            newRainAvg = []
            for elt in rainAvg:
                if maxWater == 0:
                    newRainAvg.append(800)
                else:
                    newRainAvg.append(elt / (1.0 * maxWater) * 400 + 800)

            # standardize output directory and create it if necessary
            output_directory = 'dat' 
            if not os.path.exists(output_directory):
                os.makedirs(directory)

            # to instead write .dat files into the same folders that contain the original data, pass in input_directory
            #    rather than output_directory below.

            outputParameter(newRainAvg, temperatureAvg,
                            radiationAvg, output_directory, fileName)

def get_location(input_directory):
    epw = filter(lambda fname: fname.endswith(".epw"), os.listdir(input_directory))[0]
    #print("EEEEEEEEEE", epw)
    with open(input_directory + "/" + epw, "rb") as csvfile:
        weatherFile = csv.reader(csvfile)
        tup = next(weatherFile)
        return epw[:-4], tup[6], tup[7]
    #return
    for elt in os.listdir(input_directory):
        fileName = elt[:-4]
        #print fileName
        if not (elt.endswith(".epw")):
            continue
        with open(input_directory + "/" + elt, "rb") as csvfile:
            weatherFile = csv.reader(csvfile)
            #print next(weatherFile)


parser = argparse.ArgumentParser()
parser.add_argument('--dir', default='EPW')
#parser.add_argument('--referencefile', default='../Data/output/referenceFile.txt')
#parser.add_argument('--output', default='latLongValData.json')
parser.add_argument('--referencefile', default='../Data/output2/referenceFile.txt') # later mod
parser.add_argument('--output', default='latLongValData.json') # later mod

if __name__ == '__main__':
    args = parser.parse_args()
    # Elena's modification: get paths to all directories that contain the .epw file
    lowest_dirs = list()



    for root,dirs,files in os.walk(args.dir):
        if not dirs:
            lowest_dirs.append(root)
    lat_lon_by_fname = {fname: (lat, lon) for fname, lat, lon in (get_location(d) for d in lowest_dirs)}
    ref = open(args.referencefile)
    no_by_fname = {}
    for no, bogusname in enumerate(ref, 1):
        bogusname = bogusname.strip()[:-4]
        for fname in lat_lon_by_fname.keys():
            if bogusname.endswith(fname):
                no_by_fname[fname] = no
                
    #pprint(no_by_fname)
    output = []
    max_out = 0;
    for fname, (lat, lon) in lat_lon_by_fname.items():
        try:
            f = open('../Data/output/%sLeafAreaIndex.sci' % no_by_fname[fname])
            val = float(f.read().split("\n")[-2])
            output.append([lat, lon, val, fname])
            max_out = max(max_out, val)
        except IOError:
            pass

    #output = [(lat, lon, val / max_out) for lat, lon, val in output] # pre messing-with normalizing data, it was this
    #output = [(lat, lon, val) for lat, lon, val in output]

    #vals = [v for lat, lon, v in output]
    #plt.hist(vals, bins=100)
    #plt.show()

    json.dump(output, open(args.output,'w+')) # uncomment this when done trying to figure out how to normalize

            

    #(lat, lon): float(open(dfname).read().splitlines()[-2]) for dfname, (lat, lon) in }



    #pprint(lat_lon_by_fname)
    """
    for d in lowest_dirs:
        #reader(d) # this if want to "read" the epw files. else

        # 3/30/17 get locations

        fname, lat, lon = get_location(d)
        print(fname, lat, lon)

        """

    # below is what is used to do
    #reader(sys.argv)
