
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