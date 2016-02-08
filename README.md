# drone-golang-container
A simple Docker container for [Drone](https://drone.io) to use while building and testing your [Go](https://golang.org) projects during [continuous integration](http://www.martinfowler.com/articles/continuousIntegration.html).

## Usage

```console
docker pull nycmonkey/drone-golang-container
```

## Sample .drone.yml file for your [Go](https://golang.org) project

```yaml
image: nycmonkey/drone-golang-container
env:
  - GOPATH=/var/cache/drone/src/github.com/<username>/<repository>/Godeps/_workspace:/var/cache/drone
script:
  - go build -v ./...
  - go test -v ./...
notify:
  email:
    recipients:
      - person@email-address.com
```

The above example assumes you are building a [Go](https://golang.org) project that used [godep](https://github.com/tools/godep) to vendor any library dependencies:

```console
$ go get github.com/tools/godep
```

Once you can build your project with `go install` and test it with `go test`, run the following command to vendor the dependencies:

```console
$ godep save -r
```

## Pointers for setting up your own [continuous integration](http://www.martinfowler.com/articles/continuousIntegration.html) server

I use a [Digital Ocean](https://digitalocean.com/) "droplet" running [Drone](https://github.com/drone/drone) on [CoreOS linux](https://https://coreos.com).  It costs me $10/month for the droplet plus the cost of registering a domain and maintaining a signed SSL certificate.  Digital Ocean has a helpful setup guide [here](https://www.digitalocean.com/community/tutorials/how-to-perform-continuous-integration-testing-with-drone-io-on-coreos-and-docker).

By default, CoreOS updates itself automatically and reboots.  To ensure that [Drone](https://github.com/drone/drone) starts up upon reboot, you can write a [systemd unit file](https://coreos.com/docs/launching-containers/launching/getting-started-with-systemd/).