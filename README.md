# A quick https-server

Are you tired of not being able to quickly and easily run https locally?

This script solves the problem!

## Dependencies

1. This script is written in `sh`, but tested on `zsh` on Ubuntu 22.04. 
1. openssl is required. 
1. node is required. 

## On checkout

Install with

```
npm ci
```

## Usage

```
npm start -- website/root/dir
```

Stop the https-server running with `CTRL-C`.

## How it works. 

* It creates a folder `tmp` in the current directory.
* It createds certificates in `tmp` using `openssl`.
* It runs the http-server module in https mode using the certificates.
* When you stop the server, the script automatically deletes the `tmp` folder.
