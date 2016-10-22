# NZBget Docker

## Installation

## Usage
$ docker run -d --restart=always --name nzbget -p 6789:6789 -v /docker/config/nzbget/:/config -v /download/:/downloads icetail/docker-nzbget
