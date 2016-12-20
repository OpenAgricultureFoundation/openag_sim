import sys
import os
import errno

from io import BytesIO
import urllib2
from urllib2 import urlopen
from zipfile import ZipFile

def path_creator(data, legend):
    absolute_path = absolute_path_generator(data, legend)
    mkdir_p(absolute_path)
    return absolute_path

def absolute_path_generator(field_list, legend):
    type_of_data = "EPW"

    index_country = legend.index('country')
    index_station_name = legend.index('station_name')
    index_data_source = legend.index('data_source')

    relative_path = type_of_data + "/" + \
                    field_list[index_country] + "/" + \
                    field_list[index_station_name].split(".")[0] + "/" + \
                    field_list[index_data_source]

    absolute_path = os.getcwd() + "/" + relative_path
    
    return absolute_path

def mkdir_p(path):
    try:
        os.makedirs(path)
    except OSError as exc: 
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else:
            raise
        
def retrieve_data(url,path):
    download_file(url)
    uncompress_file(path)
    
def download_file(url):

    req = urllib2.Request(url, headers={'User-Agent' : "Magic Browser"}) 
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
    zf.extractall(path = directory)
    # close the ZipFile instance
    zf.close()
    # remove file
    os.remove("/tmp/tempfile.zip")

def display_downloading_info(data,count,size):

    print "Downloading: " + data[0]
    print "File: " + str(count) + "/" + str(size)
        
def epw_retriever(args):           
    
    csv_file=open(args[1])
    list_weather_files=csv_file.read().split("\n")
    epw_file_index = list_weather_files[0].split(",")
    epw_file_list = list_weather_files[1:]
    
    for idx, epw_file in enumerate(epw_file_list):
        if epw_file_list[-1]==epw_file:
            break

        data = epw_file.split(",")
        path = path_creator(data,epw_file_index)

        url = data[epw_file_index.index('http_link')]
        retrieve_data(url,path)

        display_downloading_info(data,idx,len(epw_file_list))     
        
if __name__ == '__main__':
    epw_retriever(sys.argv)

            
