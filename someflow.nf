/* 
 * include requires tasks 
 */
include { greeting } from './sometask.nf'


/* 
 * define the data analysis workflow 
 */
workflow pipFlow {
    // required inputs
    take:
      username
      output
      data
      
    // workflow implementation
    main:
      greeting(username,output,data)
}