variable "kubeconfig_path" {
  type        = string
  description = "Percorso del file kubeconfig locale"
  default     = "~/.kube/config"
}

variable "argocd_namespace" {
  type        = string
  description = "Namespace per l'installazione di ArgoCD"
  default     = "argocd"
}