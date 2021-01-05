kubectl -n prow create configmap config --from-file=config.yaml=./config.yaml --dry-run -o yaml | kubectl -n prow  replace configmap config -f -
kubectl -n prow create configmap plugins  --from-file=plugins.yaml=./plugins.yaml --dry-run -o yaml | kubectl -n prow replace configmap plugins -f -
