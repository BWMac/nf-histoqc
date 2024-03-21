process HISTOQC {
    
    tag {"$meta.id"}

    container 'ghcr.io/mc2-center/nf-histoqc:latest'
    
    publishDir "${params.outDir}/$images", mode: 'copy', pattern: "*.png"

    input:
    tuple val(meta), path(images)
    val config_string
    path custom_config

    output:
    path "out/results.tsv", emit: results
    path "out/error.log", emit: errors
    path "out/$images/*.png", emit: masks
    
    script:
    """
    # Add the logic for the if config_string or custom_config here
    # Check if custom_config points to "empty.txt"
    if [[ "$custom_config" == *empty.txt ]]; then
        # If yes, use the config_string
        ini="$config_string"
    else
        # If no, use the path to custom_config
        ini=$custom_config
    fi

    echo "Using config: \$ini"
    python -m histoqc $images -o out -c \$ini
    """
}
