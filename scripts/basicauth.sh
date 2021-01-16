#!/bin/bash

###
# Usage: basicauth.sh [clustername-prefix] [username] [zone]" 1>&2
# Note : After writing kubeconfig file, you can copy it to ~/.kube/config and run kubectl command without KUBECONFIG env var.
###

#CLUSTER_NAME="gke01"
#USER_NAME="user01"
#LOCATION="asia-northeast1-a"
CLUSTER_NAME="${1:-gke01}"
USER_NAME="${2:-user01}"
LOCATION="${3:-asia-northeast1-a}"


# Get cluster metadata
echo -n "Fetching cluster metadata..."
CLUSTER="$(gcloud container clusters describe ${CLUSTER_NAME}-${USER_NAME} --zone ${LOCATION} --format=json)"
echo "done."

# Encode CA Cert in Base64
CA_CERT_B64="$(echo $CLUSTER | jq -r '.masterAuth.clusterCaCertificate')"

# Get cluster endpoint
GKE_ENDPOINT="$(echo $CLUSTER | jq -r '.endpoint')"

# Get Basic Auth Pass (In GKE, user is hardcoded as "admin"
BASIC_PASS="$(echo $CLUSTER | jq -r '.masterAuth.password')"

echo -n "Writing file: ${CLUSTER_NAME}-${USER_NAME}-kubeconfig..."
cat > "${CLUSTER_NAME}-${USER_NAME}-kubeconfig" <<EOF
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${CA_CERT_B64}
    server: https://${GKE_ENDPOINT}
  name: gke
contexts:
- context:
    cluster: gke
    user: gke
  name: gke
current-context: gke
kind: Config
preferences: {}
users:
- name: gke
  user:
    password: "${BASIC_PASS}"
    username: "admin"
EOF
echo "done."

#echo "Running: KUBECONFIG=${CLUSTER_NAME}-${USER_NAME}-kubeconfig kubectl get clusterroles"
#sleep 1
#KUBECONFIG=${CLUSTER_NAME}-${USER_NAME}-kubeconfig kubectl get clusterroles

#echo ""
#echo "KUBECONFIG=${CLUSTER_NAME}-${USER_NAME}-kubeconfig kubectl ..."
