RUNTIME_VERSION=0.0.1
SIDECAR_VERSION=0.0.1
PYTHON_EXEC=python

.PHONY: python
python: python-latest

.PHONY: python-all
python-all: python-3.4 python-3.5 python-3.6 python-3.7

.PHONY: python-%
python-%:
	$(eval RUNTIME_NAME = hydrosphere/serving-grpc-runtime-python-$*)
	docker build --no-cache --build-arg PYTHON_IMAGE_VERSION=$* --build-arg SIDECAR_VERSION=$(SIDECAR_VERSION) -t $(RUNTIME_NAME):$(RUNTIME_VERSION) .

run:
	${PYTHON_EXEC} src/main.py

.PHONY: test
test: test-runtime

test-runtime:
	cd test && $(PYTHON_EXEC) test.py

clean: clean-pyc

clean-pyc:
	find . -name "*.pyc" -type f -delete
	find . -name "*.pyo" -type f -delete
