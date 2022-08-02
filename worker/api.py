import time
import requests


def getCatImage(delay):

    time.sleep(delay)
    url = requests.get(
        "https://api.thecatapi.com/v1/images/search").json()[0]['url']

    return url
