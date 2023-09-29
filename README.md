# LiveKit Egress Test

## Prerequisites
### Install magefile
https://magefile.org/
```
brew install mage
```

### LiveKit server
```
git clone git@github.com:livekit/livekit.git
cd livekit
mage build
```

### LiveKit Egress
```
git clone git@github.com:livekit/egress.git
cd egress
mage build
```

## Run
```
docker-compose up
```
