check:
	./tools/check.sh
plugins:
	kubectl create configmap plugins --from-file=plugins.yaml=${PWD}/samples/plugins.yaml --dry-run -o yaml  | kubectl replace configmap plugins -f -