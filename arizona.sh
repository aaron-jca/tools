#!/bin/bash

ssh -o ProxyCommand="ssh  -W %h:%p -p 2281 -o ServerAliveInterval=60 jca@3.86.34.250" -o ServerAliveInterval=60 jca@127.0.0.1 -p 4444 -L0.0.0.0:7722:localhost:22

