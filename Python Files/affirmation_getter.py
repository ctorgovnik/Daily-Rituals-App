import requests

url = "https://www.louisehay.com/affirmations/"
response = requests.get(url)
affirmations = response.text
print(affirmations)