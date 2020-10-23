
$params.username = "someusername"

/* 
 * Greeting the workflow user
 */
process Greeting {
    
    input:
    path username 
     
    output:
    println "Hello: $params.username"

}

process GreetingPlus {
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

/*Pipeline data inputs*/
/*__params.srainput="./data/sra/sraIds.txt"__*/
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

process FastqcDocker {
    echo true
	publishDir "${params.outdir}"
	container 'najlabioinfo/sra:latest'

    script:
    """
    docker run -t --name sraimage najlabioinfo/sra fastqc --version
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