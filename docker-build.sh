#!/bin/bash
docker-compose build --build-arg USER_NAME=$(whoami) solidity-proxy
