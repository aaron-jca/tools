import os
import re
import yaml
from datetime import datetime

import matplotlib.pyplot as plt
from matplotlib.dates import ( DateFormatter, date2num)

def find_substrings(string, symb1, symb2):
    pattern = re.escape(symb1) + r'.*?' + re.escape(symb2) # Regular expression pattern
    substrings = re.findall(pattern, string)
    return substrings

def write_to_file(filename, data):
    if os.path.isfile(filename):
        # Clear the contents of the file
        f = open(filename, 'r+')
        f.truncate(0) # need '0' when using r+

    with open(filename, 'w+') as file:
        yaml.dump(data, file)

def parseSatellites(input_file, output_file):
    print("Parsing satellites")
    with open(input_file, 'r') as file:
        data = file.read()

        entries = find_substrings(data, '$', '@')
        satelliteCount = []
        for entry in entries:
            numSatellites = entry.split(' ')[3]
            satelliteCount.append(int(numSatellites))

    # printing from left and right - only need one of each
    modifiedCount =  [satelliteCount[i] for i in range(len(satelliteCount)) if i % 2 == 0]
    modifiedCount = satelliteCount
    write_to_file(output_file, modifiedCount)
    print("finished parsing satellite count - wrote results to " + output_file)
    return modifiedCount

def parseTime(input_file, output_file):
    print("Parsing time")
    with open(input_file, 'r') as file:
        data = file.read()

        entries = find_substrings(data, '%', '#')
        times = []
        for entry in entries:
            time = entry.split(' ')[1]
            times.append(time)

    # printing from left and right - only need one of each
    modifiedTimes =  [times[i] for i in range(len(times)) if i % 2 == 0]
    modifiedTimes = times

    finalTimes = []
    for time in modifiedTimes:
        t = datetime.strptime(time, '%m/%d/%YT%H:%M:%S')
        finalTimes.append(t)

    write_to_file(output_file, modifiedTimes)
    print("finished parsing times - wrote results to " + output_file)
    return finalTimes


def parseHz(input_file, output_file):
    print("Parsing hz")
    with open(input_file, 'r') as file:
        data = file.read()
        lines = data.split('\n')

        hz = []
        for line in lines:
            l = line.split(" ")
            if l[0] == 'average':
                hz.append(float(l[2]))

    write_to_file(output_file, hz)
    print("finished parsing hz - wrote results to " + output_file)
    return hz

def analyse(sat_data, hz_data, time_data):

    print("Plotting data")

    min_length = min(len(sat_data), len(hz_data), len(time_data))

    sat_data = sat_data[:min_length]
    hz_data = hz_data[:min_length]
    time_data = time_data[:min_length]

    slimmed_sat = []
    slimmed_hz = []
    slimmed_time = []

    jump = 5
    for i in range(int(len(sat_data)/jump)):
        ind = i * jump
        if ind < len(sat_data):
            slimmed_sat.append(sat_data[ind])
            slimmed_hz.append(hz_data[ind])
            slimmed_time.append(time_data[ind])

    formatted_time = date2num(slimmed_time)

    fig, axs = plt.subplots(2, 1)
    axs[0].plot(formatted_time, slimmed_sat, label='Satellite Count', color='red')
    axs[0].set_xlabel('time')
    axs[0].set_ylabel('sat count')

    axs[1].plot(formatted_time, slimmed_hz, label='Hz')
    axs[1].set_xlabel('time')
    axs[1].set_ylabel('hz')

    axs[0].xaxis.set_major_formatter(DateFormatter("%m/%d-%H:%M"))
    axs[1].xaxis.set_major_formatter(DateFormatter("%m/%d-%H:%M"))

    fig.tight_layout()
    plt.show()

# Usage example
input_file_satellite = 'dataAnalysis/data/satellite_data.log'
output_file_satellite = 'dataAnalysis/data/output_satellite.yaml'

input_file_hz = 'dataAnalysis/data/hz_data_all_const_100_per4.yaml'
output_file_hz = 'dataAnalysis/data/output_hz.yaml'

times = parseTime(input_file_satellite, 'times.log')
satelliteData = parseSatellites(input_file_satellite, output_file_satellite)
hzData = parseHz(input_file_hz, output_file_hz)
analyse(satelliteData, hzData, times)
