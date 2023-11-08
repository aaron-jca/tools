import requests
#ROS node running locally on port 4000, 

url = 'http://localhost:4000/app/service/all_alarms_service/machine_1'
header = {'accept': 'application/json'}

#increment_int32 uses test_msgs/srv/BasicTypes, set the relevant fields.
body = {}
response = requests.post(url, headers=header, json=body)

print(f"Making a request to {url}")
#status of the request: 200, 404, etc
print(f"Response Code: {response.status_code}")

#ROS response in json format
print(response.json())

print("\nFinished. Goodbye!")
