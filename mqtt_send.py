import paho.mqtt.client as mqtt
from time import sleep
import time
import json


# Define the broker and port
broker = "localhost"  # Replace with your broker IP address
port = 1883  # Common port for MQTT

# Define the topic and the message
topic = "/hello"  # Replace with your topic
json_msg =     {
      "header": {
        "stamp": {
          "sec": 5678,
          "nanosec": 1234
        },
        "frame_id": "FrameIdTest"
      },
      "state": "",
      "master_switch": "",
      "calibration_status": "",
      "position": {
        "header": {
          "stamp": {
            "sec": 0,
            "nanosec": 0
          },
          "frame_id": ""
        },
        "status": {
          "status": 1,
          "service": 0
        },
        "latitude": 1.23,
        "longitude": 1245.1245,
        "altitude": 23.0,
        "position_covariance": [
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ],
        "position_covariance_type": 0
      },
      "cog": {
        "header": {
          "stamp": {
            "sec": 0,
            "nanosec": 0
          },
          "frame_id": ""
        },
        "direction": 0,
        "variance": 0,
        "valid": False,
        "is_course_over_ground": False
      },
      "sog": {
        "header": {
          "stamp": {
            "sec": 0,
            "nanosec": 0
          },
          "frame_id": ""
        },
        "speed": 0,
        "variance": 0,
        "status": 0,
        "valid": False,
        "source": 0
      },
      "inclination": {
        "header": {
          "stamp": {
            "sec": 0,
            "nanosec": 0
          },
          "frame_id": ""
        },
        "roll": 2,
        "pitch": 5,
        "valid": True
      },
      "guidance_command": {
        "header": {
          "stamp": {
            "sec": 0,
            "nanosec": 0
          },
          "frame_id": ""
        },
        "target_speed": 0,
        "target_acceleration": 0,
        "target_curvature": 0,
        "target_curvature_rate": 0
      },
      "active_track_id": "",
      "implement_width": 0,
      "active_wayline_index": 0,
      "cross_track_error": 0,
      "activate_request": False
    }
  # Replace with your message
message = json.dumps(json_msg)

client_id = "mqtt_spammer"
# Create an MQTT client instance
client = mqtt.Client(client_id=client_id)

# Connect to the broker
client.connect(broker, port, 60)

while True:
    # Publish the message to the topic
    sleep(0.5)
    client.publish(topic, message)
    print(f"Message '' sent to topic '{topic}' time: {time.time()}")   

# Disconnect from the broker
client.disconnect()

print(f"Message '{message}' sent to topic '{topic}'")