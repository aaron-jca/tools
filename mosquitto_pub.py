import subprocess

def main():
   # update loop
   t = 0
   while True:
    subprocess.Popen(["mosquitto_pub",  "-t", "/hello", "-h", "localhost", "-p", "1883",  "-f", "data"]) 

main()