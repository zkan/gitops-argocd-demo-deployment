# gitops-argocd-demo-deployment

## Deploying My App

```sh
kubectl create namespace myapp-dev
kubectl apply -f myapp/dev -n myapp-dev
```

## Deploying My App with Helm

Render chart templates locally:

```sh
helm template myapp-helm myapp-helm -f myapp-helm/values-dev.yaml
```

Install chart

```sh
kubectl create namespace myapp-helm
helm upgrade --install myapp-helm myapp-helm -f myapp-helm/values-dev.yaml -n myapp-helm
```

Uninstall chart

```sh
helm uninstall myapp-helm -n myapp-helm
```

## Deploying My App with Argo CD

## Installing Argo CD

```sh
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

or

```sh
kubectl create namespace argocd
kubectl apply -n argocd -f bootstrap/overlays/default
```

Ref: https://argo-cd.readthedocs.io/en/stable/getting_started/

Access Argo CD with port-forwarding

```sh
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

or

```sh
make web
```

Get the default password

```sh
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

or

```sh
make passwd
```

Create Argo CD Projects

```sh
kubectl apply -f components/argocdprojects/
```

Create Argo CD Applications

```sh
kubectl apply -f components/applicationsets/app.yaml
kubectl apply -f components/applicationsets/app-helm.yaml
```

or

```sh
kubectl apply -f components/applicationsets
```

Try to edit the deployment:

```sh
kubectl edit deployment -n myapp myapp-deployment
```

or

```sh
kubectl edit deployment -n myapp-helm myapp-helm-deployment
```

We'll see that Argo CD will revert back to the desired state.

## Cleaning Up

```sh
kubectl delete -f components/applicationsets
kubectl delete -f components/argocdprojects
kubectl delete ns myapp-dev
kubectl delete ns myapp-helm-dev
kubectl delete ns argocd
```
