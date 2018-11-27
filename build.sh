#!/bin/bash
#java build the app.
docker run --rm -v "$(pwd)":/home/gradle/project -w /home/gradle/project gradle:4.8.1 gradle clean build
pushd reviews-wlpcfg
    #plain build -- no ratings
    docker build -t "istio/examples-bookinfo-reviews-v1:${VERSION}" -t istio/examples-bookinfo-reviews-v1:latest --build-arg service_version=v1 .
    #with ratings black stars
    docker build -t "istio/examples-bookinfo-reviews-v2:${VERSION}" -t istio/examples-bookinfo-reviews-v2:latest --build-arg service_version=v2 \
        --build-arg enable_ratings=true .
    #with ratings red stars
    docker build -t "istio/examples-bookinfo-reviews-v3:${VERSION}" -t istio/examples-bookinfo-reviews-v3:latest --build-arg service_version=v3 \
        --build-arg enable_ratings=true --build-arg star_color=red .
popd
