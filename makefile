check:
	./tools/check.sh
plugins:
	kubectl create configmap plugins --from-file=plugins.yaml=${PWD}/samples/plugins.yaml --dry-run -o yaml  | kubectl replace configmap plugins -f -

config:
	kubectl create configmap config --from-file=config.yaml=${PWD}/samples/config.yaml --dry-run -o yaml | kubectl replace configmap config -f -