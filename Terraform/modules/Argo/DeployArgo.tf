resource "null_resource" "Deploy_Argo_Secret" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/ArgoApp/secret.yaml"
  }

  depends_on = [
    helm_release.ArgoCD,
    helm_release.argo_image_updater
  ]

}

resource "kubectl_manifest" "Argo_App" {
  yaml_body = templatefile("${path.module}/ArgoApp/argoApp.yaml.tpl", {
    account_id     = var.Account_ID
    region         = var.region
    frontend_repo  = var.FrontEnd_ECR_repository_name
    backend_repo   = var.BackEnd_ECR_repository_name
    App_Chart_Repo = var.App_Chart_Repo
  })

  depends_on = [
    helm_release.ArgoCD,
    helm_release.argo_image_updater,
    null_resource.Deploy_Argo_Secret,
  ]
}
