output "argocd_namespace" {
  value       = kubernetes_namespace.argocd.metadata[0].name
  description = "Namespace in cui è stato installato ArgoCD"
}

output "helm_release_status" {
  value       = helm_release.argocd.status
  description = "Stato della release Helm di ArgoCD"
}