
import yaml
import matplotlib.pyplot as plt

def plot_points_from_yaml(file_path):
    with open(file_path, 'r') as file:
        data = yaml.safe_load(file)

    x_values = []
    y_values = []

    firstTime = 0
    window = 7
    for point in data:
        if(data[point]):
            if data[point].get('header') is not None:
                time = data[point]['header']['stamp'].get('sec')   
                timeNS = data[point]['header']['stamp'].get('nanosec')   
                time += timeNS / 1e9
                if firstTime == 0:
                    firstTime = time
            dataAmount = len(data[point].get('data'))
            # print(str(time) + ":" + str(timeNS) + " Data amt: " + str(dataAmount))
            if(window >= time - firstTime):
                x_values.append(time)
                y_values.append(dataAmount)

    print("Finished gathering. Plotting now")

    plt.scatter(x_values, y_values)
    plt.xlabel('Time (s)')
    plt.ylabel('Data size')
    plt.title('Correction data')
    plt.show()

# Example usage
yaml_file = 'dataAnalysis/data/output.yaml'
plot_points_from_yaml(yaml_file)