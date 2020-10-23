#!/usr/bin/env nextflow


 

VERSION="0.1.0"

log.info "===================================================================="
log.info " Nextflow Pipeline _template   (v${VERSION})  by NajlaBioinfo       "
log.info "===================================================================="


params.help = ""
params.threads = 1
params.output = "./output"
params.data = "./data"
params.username = "someusername"

/*Hardware params*/
threads = params.threads






if(params.help) {
    log.info ''
    log.info 'Starter Template'
    log.info ''
    log.info 'Usage: '
    log.info '    nextflow run . -profile template [options]'
    log.info ''
    log.info 'Script Options: '
    log.info '    --username    str	user name of wf'
    log.info '    --threads		INT	Number of threads to use'
    log.info '    --output		DIR	Directory to write output files'
    log.info '    --data		DIR	Directory to read data files'
    log.info '    --help		BOOL	Display help message'
    log.info ''

    return
}


process Greeting {
    echo true

    input:
    params.username
    params.output
    params.data

    output:
    println "Hello: $params.username"
    println "ResultPath: $params.output"
    println "DataPath: $params.data" 
    
    script:
    """
    python $baseDir/bin/argcheck.py ${params.username} $baseDir/${params.data} $baseDir/${params.output}
    """
}

params.srainput = "$baseDir/${params.data}sra/sraIds.txt"
sraIds = Channel.create()
Channel
    .from(file(params.srainput))
    .splitCsv(sep:'\t', header: true)
    .map { it.Run_s }
    .into(sraIds)

process SraDownload {
    echo true

    input:
    params.srainput
    val id from sraIds


    output:
    println "Reading from:  $params.srainput"

    
    script:
    """
    echo "Step 1/2 Prefetch ...."
    echo "Downloading .... $id"
    docker run -t --name $id -v /root/ncbi/public/sra/ -v $baseDir/${params.data}sra/srafiles/ najlabioinfo/nextflowtuto prefetch ${id}
    docker cp $id:/root/ncbi/public/sra/${id}.sra $baseDir/${params.data}sra/srafiles/
    docker stop $id
    docker rm $id
    """
}


params.prefinput = "$baseDir/${params.data}sra/sraIds.txt"
params.fastqinput="$baseDir/${params.data}fastq/"
prefetchIds = Channel.create()
Channel
    .from(file(params.prefinput))
    .splitCsv(sep:'\t', header: true)
    .map { it.Run_s }
    .into(prefetchIds)

process FastqDumpDocker {
    echo true
	publishDir "${params.output}"
	container 'najlabioinfo/nextflowtuto:latest'

   input:
    params.prefinput
    params.output
    params.fastqinput
    val idsra from prefetchIds

    script:
    """
    echo "Step 2/2 Fastq-dump ...."
    docker run -t --name $idsra"f"  najlabioinfo/nextflowtuto  fastq-dump -X 5 -Z ${idsra} > $params.fastqinput/$idsra".fastq" 
    docker stop $idsra"f"
    docker rm $idsra"f"
    """
}


process SayingBye {
    echo true

    input:
    params.username

    output:
    println "Thank you - $params.username - for using  Nextflow template \nMore infos : bhndevtools@gmail.com"

    script:
    """
    echo "Goodbye"
    """
}