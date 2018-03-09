SCION for Android
====

A fork of the [Netsec-SCION](https://github.com/netsec-ethz/netsec-scion) repository. For more information on SCION read the [original README](https://github.com/stschwar/scion/blob/termux-modifications/README-orig.md) or visit https://www.scion-architecture.net.

This fork specifically focuses on implementation of SCION on Android devices. Since it currently is mainly developed for Linux environments and its code base is based heavily on both [Python](https://www.python.org/) and [Go](https://golang.org/), to make it run on Android devices the [Termux](https://github.com/termux/termux-app) app project is used.

Termux is an open-sourced Android app that emulates a Terminal off an Arch-Linux environment. For more information on Termux, visit the [Project website](https://termux.com/) or the corresponding [Wiki](https://wiki.termux.com/wiki/Main_Page).

[Download Termux App from Google Play Store](https://play.google.com/store/apps/details?id=com.termux)

## Prerequisites
Make yourself familiar with Termux and how to interact with it. You preferrably want to setup an SSH connection and work from a computer. Here is [how to setup an SSH connection with Termux](https://glow.li/technology/2015/11/06/run-an-ssh-server-on-your-android-with-termux/).

It is expected that you know how to work with Android devices on a more advanced level. Especially, you ought to know how to push files to a device through ADB.

Install Termux on an Android device and start the App.

#### Install required packages

To install packages run:
```
$ pkg install <package-name>
```

The following packages are required to run SCION:

```
termux-setup-storage
termux-exec
ssh
git
python/Python3
python2
clang
make
python-dev
libffi-dev
openssl-dev
openssl-tools
```
#### Installing correct Go version

Another important dependency is the Go runtime. SCION relies on a specific version branch (currently 1.9.x). Termux' package repository is supposedly already ahead on a newer version of Go. If that is the case, the correct version has to be built for Termux.

Termux has a repository for building packages, called [termux-packages](https://github.com/termux/termux-packages).

To build a package follow the instructions on the [termux-packages](https://github.com/termux/termux-packages) page. An older version of Go can be built by modifying the build script in the ```packages/golang/``` folder and setting in the correct version and SHA hash. Same has to be done within the ```build-package.sh``` script.

For convenience, this repo holds a prebuilt version of Go 1.9.4 and its dependencies within ```debian-packages```. This build, however, is specific for ARMv8a/aarch64 devices. If you need the packages for another architecture, you have to build it yourself.

Install all ```.deb``` packages with
```
$ dpkg -i debian-packages/*.deb
```

#### Build Cap'n Proto

SCION requires [Cap'n Proto](https://capnproto.org/). It can be built within the Termux environment:

```
$ curl -O https://capnproto.org/capnproto-c++-0.6.1.tar.gz
$ tar zxf capnproto-c++-0.6.1.tar.gz
$ cd capnproto-c++-0.6.1

make PREFIX=$PREFIX
make PREFIX=$PREFIX install
```

## Install SCION

The steps are similar to those from the original repo with a few modifications:

1. Make sure that you have a
   [Go workspace](https://golang.org/doc/code.html#GOPATH) setup, and that
   `$GOPATH/bin` can be found in your `$PATH` variable. For example:

    ```
    $ echo 'export GOPATH="$HOME/go"' >> ~/.profile
    $ echo 'export PATH="$HOME/.local/bin:$GOPATH/bin:$PATH"' >> ~/.profile
    $ source ~/.profile
    $ mkdir -p "$GOPATH"
    ```

1. Check out SCION into the appropriate directory inside your go workspace (or
   put a symlink into the go workspace to point to your existing scion
   checkout):
   ```
   $ mkdir -p "$GOPATH/src/github.com/scionproto"
   $ cd "$GOPATH/src/github.com/scionproto"
   
   $ git clone --recursive -b termux-modifications git@github.com:stschwar/scion
   $ cd scion
   ```
   If you don't have a github account, or haven't setup ssh access to it, this
   command will make git use https instead:
   `git config --global url.https://github.com/.insteadOf git@github.com:`
