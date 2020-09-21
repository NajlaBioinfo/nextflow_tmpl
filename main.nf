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
