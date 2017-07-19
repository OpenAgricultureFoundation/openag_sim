import sys
import csv
import os
import json  # for outputting location info nicely
import argparse

parser = argparse.ArgumentParser()

# Directory where the original EPW files are located
parser.add_argument('--dir',
                    default='EPW')
# Full path to the reference file
parser.add_argument('--referencefile',
                    default='referenceFile.txt')  # later mod
# Parameter to obtain
parser.add_argument('--parameter',
                    default='LeafAreaIdex')
# Format of the output data
parser.add_argument('--format', default='csv')
# Output filename
parser.add_argument('--output', default='output.csv')  # later mod


def csv_writer(filename):
    writer = csv.writer(filename, dialect='excel')
    for row in output:
        writer.writerow(row)


def get_location(input_directory):
    epw = filter(lambda fname: fname.endswith(
        ".epw"), os.listdir(input_directory))[0]

    with open(input_directory + "/" + epw, "rb") as csvfile:
        weatherFile = csv.reader(csvfile)
        tup = next(weatherFile)
        return epw[:-4], tup[6], tup[7]

    for elt in os.listdir(input_directory):
        if not (elt.endswith(".epw")):
            continue
        with open(input_directory + "/" + elt, "rb") as csvfile:
            weatherFile = csv.reader(csvfile)


if __name__ == '__main__':
    args = parser.parse_args()
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

    output = []
    max_out = 0
    base_dir = os.path.dirname(args.referencefile)

    for fname, (lat, lon) in lat_lon_by_fname.items():
        try:
            f = open(base_dir +
                     '/%s' % no_by_fname[fname] +
                     '%s' % args.parameter + '.sci')
            val = float(f.read().split("\n")[-2])
            output.append([lat, lon, val, fname])
            max_out = max(max_out, val)
        except IOError:
            pass

    # Open Output file
    output_file = open(args.output, 'w+')

    # Write results
    if(args.format == 'json'):
        json.dump(output, output_file)
    elif(args.format == 'csv'):
        csv_writer(output_file)
