process HISTOQC {

    maxForks 20
    
    tag {"$meta.id"}

    container 'ghcr.io/mc2-center/nf-histoqc:latest'
    
    publishDir "${params.outDir}/$images", mode: 'copy', pattern: "*.png"

    input:
    tuple val(meta), path(images)

    output:
    path "out/results.tsv", emit: results
    path "out/error.log", emit: errors
    path "*.png", emit: masks
    
    script:
    """
    python -m histoqc -c ${params.config} $images -o out
    mv out/$images/*.png .
    """
}
