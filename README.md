Nextflow Starter Template
=========================
This is a simple starter template for creating [Nextflow](https://www.nextflow.io) projects with [Docker](https://docs.docker.com/engine/installation/).

Prerequisites
-------------
  - Nextflow
  - Java 1.7+
  - Docker

Quickstart
==========
Install Nextflow
----------------
```
$ curl -fsSL get.nextflow.io | bash
$ ./nextflow
$ mv nextflow /usr/local/bin
```

Clone Github Repository
-----------------------
```
$ git clone https://github.com/Najlabioinfo/nextflow_tmpl.git
$ cd nextflow_tmpl
```

Pull Docker Image
------------------
```
$ docker pull najlabioinfo/nextflowtuto
```

Usage
-----
```
$ nextflow run . -profile template --threads 2 --output output
```
or 
```
$ nextflow run . --help
```
or 
```
 nextflow run main.nf --username myname --output prj210920/ --data prj210920/data/
```


Pipeline Options
----------------
Option | Description
--------- | -----------
help | `Display help message.`
threads | `Number of threads to use for each process.`
output | `Directory to write output files to.`

Contact
=======
bhndevtools@gmail.com

License
=======
MIT