# gitops-argocd-demo-deployment

## Deploying My App with Helm

Render chart templates locally:

```sh
helm template myapp-helm myapp/dev-helm -f myapp/dev-helm/values-dev.yaml
```

Install chart

```sh
helm upgrade --install myapp-helm myapp/dev-helm -f myapp/dev-helm/values-dev.yaml
```

Uninstall chart

```sh
helm uninstall myapp-helm
```
