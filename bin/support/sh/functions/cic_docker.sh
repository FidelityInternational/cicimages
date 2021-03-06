#!/usr/bin/env bash
function volume_path() {
    local prefix=$1
    echo "/vols/${prefix}_${RANDOM}"
}

function cic_volumes_container() {
    echo "cic_volumes"
}

function cic_network() {
    echo "cic"
}

function cic_image_repository() {
    echo "${CIC_IMAGE}"
}

function cic_image_version() {
    echo "${CIC_IMAGE_VERSION}"
}

function cic_image() {
    echo "$(cic_image_repository):$(cic_image_version)"
}

function cic_tag() {
    echo "cic_container-${RANDOM}"
}


function cic_volume_mkdir_p(){
    local path=$1
    docker run \
        --network "$(cic_network)" \
        --volumes-from "$(cic_volumes_container)" \
        "$(cic_image)" \
        /bin/bash -c "mkdir -p ${path}"
}
function copy_to_cic_volume() {
    local path=$1
    local volume_path=$2

    cic_volume_mkdir_p "${volume_path}"
    docker cp "${path}" "$(cic_volumes_container):${volume_path}" > /dev/null
}

