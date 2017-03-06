import sys
import csv
import os

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


def reader(args):
    input_directory = str(args[1])

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

            outputParameter(newRainAvg, temperatureAvg,
                            radiationAvg, input_directory, fileName)

if __name__ == '__main__':
    reader(sys.argv)
