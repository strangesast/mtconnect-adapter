from debian

run apt-get update && apt-get install -y netcat

cmd ["nc", "adapter", "7878"]
