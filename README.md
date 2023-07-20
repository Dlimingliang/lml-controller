## Running

**Prerequisite**: Since the lml-controller uses `apps/v1` deployments, the Kubernetes cluster version should be greater than 1.9.

```sh
# assumes you have a working kubeconfig, not required if operating in-cluster
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o lml-controller .
./lml-controller -kubeconfig=$HOME/.kube/config

# create a CustomResourceDefinition
kubectl create -f artifacts/crd-status-subresource.yaml

# create a custom resource of type Foo
kubectl create -f artifacts/lml.yaml

# check deployments created through the custom resource
kubectl get deployments
```