#!/usr/bin/env nextflow
params.name             = "RNA-seq"
params.reads            = "/data/fastq/*{*_R1,*_R2}.fastq.gz"
params.email		= "cierrajanewalker@me.com"


log.info "RNA-seq Pipeline"
log.info "====================================="
log.info "name         : ${params.name}"
log.info "reads        : ${params.reads}"
log.info "\n"
log.info "email	       : ${params.email}"

reads = Channel.fromFilePairs(params.reads, size: -1)
// the output is basically two outputs .. [id, [files1, file2]]

process view_reads {
	
	publishDir "results"

	input:
	// sample id and file are the two outputs from the channel above. 
	set sample_id, file(read_files) from reads

	output:
	file "*.txt"	

	script:
	"""
	# this inside part is bash script! 
	zcat ${read_files[[1]]} | head > ${sample_id}_reads.txt
	"""

}
