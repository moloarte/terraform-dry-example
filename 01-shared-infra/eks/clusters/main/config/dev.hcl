inputs = {
  "cluster_version"                = "1.29",
  "cluster_endpoint_public_access" = true,
  "cluster_addons"                 = {
    "coredns" = {
      "most_recent" = false
    },
    "kube-proxy" = {
      "most_recent" = false
    },
    "vpc-cni" = {
      "most_recent" = false
    }
  }
}
