import sys
import os
import errno

from io import BytesIO
import urllib2
import unicodedata

from urllib2 import urlopen
from zipfile import ZipFile


def strip_accents(s):
    # decode from cp1252 encoding instead of the implicit ascii encoding used
    # by unicode()
    s = s.decode("cp1252")
    s = unicodedata.normalize('NFKD', s).encode('ascii', 'ignore')
    return s


def path_creator(data, legend):

    absolute_path = absolute_path_generator(data, legend)

    try:
        mkdir_p(absolute_path)
    except:
        raise

    return absolute_path


def absolute_path_generator(field_list, legend):
    type_of_data = "EPW"

    index_country = legend.index('country')
    index_station_name = legend.index('station_name')
    index_data_source = legend.index('data_source')

    Detail = len(field_list[index_station_name].split("."))

    Prefecture = ''
    Province = ''
    City = ''

    if (Detail == 1):
        Prefecture = strip_accents(
            field_list[index_station_name].split(".")[0])
    elif (Detail == 2):
        Prefecture = strip_accents(
            field_list[index_station_name].split(".")[0])
        Province = strip_accents(field_list[index_station_name].split(".")[1])
    else:
        Prefecture = strip_accents(
            field_list[index_station_name].split(".")[0])
        Province = strip_accents(field_list[index_station_name].split(".")[1])
        City = strip_accents(field_list[index_station_name].split(".")[2])

    relative_path = type_of_data + "/" +\
        field_list[index_country] + "/" +\
        Prefecture + "/" +\
        Province + "/" +\
        City + "/" +\
        field_list[index_data_source]

    absolute_path = os.getcwd() + "/" + relative_path

    return absolute_path


def mkdir_p(path):
    try:
        os.makedirs(path)
    except OSError as exc:
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            raise


def retrieve_data(url, path):
    download_file(url)
    uncompress_file(path)


def download_file(url):

    req = urllib2.Request(url, headers={'User-Agent': "Mozilla/5.0"})
    zipresp = urllib2.urlopen(req)

    # Create a new file on the hard drive
    tempzip = open("/tmp/tempfile.zip", "wb")
    # Write the contents of the downloaded file into the new file
    tempzip.write(zipresp.read())
    # Close the newly-created file
    tempzip.close()


def uncompress_file(directory):

    # Re-open the newly-created file with ZipFile()
    zf = ZipFile("/tmp/tempfile.zip")
    # Extract its contents into /tmp/mystuff
    # note that extractall will automatically create the path
    zf.extractall(path=directory)
    # close the ZipFile instance
    zf.close()
    # remove file
    os.remove("/tmp/tempfile.zip")


def display_downloading_info(data, count, size):

    ID = data[0]
    print "Downloading: " + ID
    print "File: " + str(count) + "/" + str(size)


def epw_retriever(args):

    csv_file = open(args[1])
    list_weather_files = csv_file.read().split("\n")
    epw_file_index = list_weather_files[0].split(",")
    epw_file_list = list_weather_files[1:]

    for idx, epw_file in enumerate(epw_file_list):
        if epw_file_list[-1] == epw_file:
            break

        data = epw_file.split(",")

        try:
            path = path_creator(data, epw_file_index)
            url = data[epw_file_index.index('http_link')]
            retrieve_data(url, path)
            display_downloading_info(data, idx, len(epw_file_list))

        except KeyboardInterrupt:
            sys.exit()

        except:
            print data[0] + " This file is already in the directory structure "

if __name__ == '__main__':
    epw_retriever(sys.argv)
