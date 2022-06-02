web:
	kubectl port-forward svc/argocd-server -n argocd 8080:443

passwd:
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

app:
	kubectl port-forward svc/myapp-service -n myapp-dev 8000:8000

app-helm:
	kubectl port-forward svc/myapp-helm-service -n myapp-helm-dev 8000:8000
