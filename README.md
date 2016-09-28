# Clean Devtools

## Build

### Unix

First set up your local clone of this repository and be sure to check out all submodules by running

```
git clone https://github.com/timjs/clean-devtools.git
cd clean-devtools
git submodule init
git submodule update
```

After the clone you have to build the Clean compiler for your platform

```
cd Dependencies/clean-compiler
make
cd -
```

Now you can build this project using `cpm`

```
cpm make
```

### Windows

Good question...
