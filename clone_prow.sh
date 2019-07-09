#!/bin/bash

gfw_hub="gcr.io/k8s-prow"
tag="v20190703-1f4d61631"
repos=('hook' 'plank' 'deck' 'tide' 'sinker' 'status-reconciler' 'horologium')

for image in ${repos[@]};do
    full_image=${gfw_hub}/${image}:$tag
    new_image=magicsong/${image}:$tag
    docker pull $full_image
    docker tag $full_image $new_image
    docker push $new_image
done

echo "clone is done"