# local-dev-setup

## Shell Profile
The key thing here is this snippet in `.profile`:
```
for PROFILE_SCRIPT in $( ls ~/.profile.d/*.sh ); do
  . $PROFILE_SCRIPT
done
```
This allows aliases & functions to be modularized. Any `.sh` script in `.profile.d` will be imported when a new shell is initialized or you do `source ~/.profile`.

## dnsmasq
This allows you to set up your system so that arbitrary subdomains of any domain you want can be routed to localhost. For example if you have an API running locally on port 8080, you can do:
```
$ sudo local-ssl-proxy --source=443 --target=8080
$ curl -k https://my-api.spslocal.in/
```

### Setup
##### 1. Install dnsmasq
`$ brew install dnsmasq`

##### 2. Ensure the directory the config goes in exists
`$ mkdir -pv $(brew --prefix)/etc/`

##### 3. Copy the config file
`$ cp /path/to/dnsmasq.conf $(brew --prefix)/etc/`

##### 4. Edit the config as needed
Change the `spslocal.in` domain to whatever you want or add additional entries of the form:

`address=/dom.ain/127.0.0.1`

##### 5. Start dnsmasq
`$ sudo brew services start dnsmasq`
This will also set it up to run automatically at startup.

##### 6. Check that it's working so far
```
$ dig any-random-thing.spslocal.in @127.0.0.1

; <<>> DiG 9.8.3-P1 <<>> any-random-thing.spslocal.in @127.0.0.1
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 55693
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;any-random-thing.spslocal.in.	IN	A

;; ANSWER SECTION:
any-random-thing.spslocal.in. 0	IN	A	127.0.0.1

;; Query time: 24 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Thu Oct 12 09:03:35 2017
;; MSG SIZE  rcvd: 62
```

##### 7. Ensure resolver directory exists
`$ mkdir -pv /etc/resolver`

##### 8. Add resolver configuration(s)
Each domain set up in `dnsmasq.conf` must have a corresponding config in `/etc/resolver` named the same as the domain and containing the text `nameserver 127.0.0.1`. For example, with the given `dnsmasq.conf` in this repo:
`$ sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/spslocal.in'`

##### 9. Check that it's working
See if the resolvers have been picked up and try a ping. `scutil --dns` will print out a wall of text but you should find resolvers listed in its output for the domain(s) you set up.
```
$ scutil --dns

...
resolver #8
  domain   : spslocal.in
  nameserver[0] : 127.0.0.1
  flags    : Request A records
Reachable, Directly Reachable Address
...

$ ping game-over-man.game-over.spslocal.in
PING game-over-man.game-over.spslocal.in (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: icmp_seq=0 ttl=64 time=0.037 ms
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.046 ms
64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.057 ms
64 bytes from 127.0.0.1: icmp_seq=3 ttl=64 time=0.040 ms
^C
--- game-over-man.game-over.spslocal.in ping statistics ---
4 packets transmitted, 4 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 0.037/0.045/0.057/0.008 ms
```

All credit to [this blog post](https://blog.thesparktree.com/local-development-with-wildcard-dns) for this set of instructions.
