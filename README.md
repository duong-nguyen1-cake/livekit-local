# LiveKit Egress Test

## Prerequisites
### Install magefile
```
brew install magefile
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
