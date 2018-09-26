
import paho.mqtt.client as mqtt
from time import sleep
import random

broker="test.mosquitto.org"
topic_pub='v1/devices/me/telemetry'


client = mqtt.Client()

client.username_pw_set("C1_TEST_TOKEN")
client.connect('165.227.153.40', 31494, 1)

for i in range(50000):
    x = random.randrange(20, 100)
    print x
    msg = '{"windSpeed":"'+ str(x) + '"}'
    client.publish(topic_pub, msg)
    sleep(3)
