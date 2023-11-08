import yaml

def separate_yaml_entries(input_file, output_file):
    with open(input_file, 'r') as file:
        data = file.read()

        entries = data.split('---')

        counter = 0
        yaml_file = yaml.safe_load(file) or {}

        for entry in entries:
            data = yaml.safe_load(entry)
            packetString = "packet_" + str(counter)
            yaml_file[packetString] = data
            counter += 1
            
    # Clear the contents of the file
    f = open(output_file, 'r+')
    f.truncate(0) # need '0' when using r+

    with open(output_file, 'w') as file:
        yaml.dump(yaml_file, file)


# Usage example
input_file = 'dataAnalysis/data/nav_sat_data.yaml'
output_file = 'dataAnalysis/data/output.yaml'
separate_yaml_entries(input_file, output_file)