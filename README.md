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
$ nextflow run . --help
```
or 
```
 nextflow run main.nf --username myname --output prj210920/ --data prj210920/data/
```
or
```
$ nextflow run . -profile template --threads 2 --output output
```


Pipeline Options
----------------
Option | Description
--------- | -----------
help | `Display help message.`
threads | `Number of threads to use for each process.`
output | `Directory to write output files to.`


References
===========
https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit
https://www.ncbi.nlm.nih.gov/sra/docs/sradownload/#download-sequence-data-files-usi
https://learn.gencore.bio.nyu.edu/nextflow/#docker-step-7
https://github.com/nextflow-io/patterns


Contact
=======
bhndevtools@gmail.com

License
=======
MIT