[![](https://images.microbadger.com/badges/image/busybox42/karmabot.svg)](https://microbadger.com/images/busybox42/karmabot "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/busybox42/karmabot.svg)](https://microbadger.com/images/busybox42/karmabot "Get your own version badge on microbadger.com")
# Karmabot
Slack bot for trolling karma. 

## What? Why?
In a slack channel I use there is a bot which has a karma module.  Messaging the bot with "fubar++" or "fubar--" will add or subtract the karma value for fubar. This was created as a troll response to a "war" of sorts between perl and ruby developers in slack.

This docker image runs a ruby script to add positive karma to ruby and negative karma to perl with a random sleep between 5 and 20 minutes. As to not just keep adding karma once the war is won I had set a random limit on when to add karma. After initialization the script will add karma to ruby if it is less than a random number between 500 and 1000.  Likewise, it will subtract karma from perl if it is greater than a random number between -1000 and -500.

## Running in Docker
```bash
docker pull busybox42/karmabot
docker run -it --restart=always --name karmabot -d -e TOKEN=<Legacy Slack Token> -e CHANNEL=<channel id> busybox42/karmabot
```

## Building Manually
Build manually if you want to modify the karmabot.rb and/or if you want to run in kubernetes.
```bash
git clone https://github.com/busybox42/karmabot.git 
cd  karmabot
docker build -t karmabot .
```  
  
## Running with Kubernetes
To run in kubernetes first manually build the image.

After the image is built you can either run this command with your slack legacy token, channel id:
```bash
kubectl run --image=karmabot karma-app --env="TOKEN=<Slack legacy token>" --env="CHANNEL=<channel id>" --image-pull-policy=Never --replicas=1
```
or modify the karma-app.yaml file adding your legacy token and channel id:
```bash
kubectl apply -f karma-app.yaml
```

### Scaling in Kubernetes
Because who doesn't want to scale their trolling?
```bash
kubectl scale deployment karma-app --replicas=3 
```
