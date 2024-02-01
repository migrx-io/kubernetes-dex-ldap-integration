rm -rf ~/.kube/cache/

SVC_PORT="$(kubectl get -n dex svc/dex -o json | jq '.spec.ports[0].nodePort')"

kubectl config unset users.oidc

kubectl config set-credentials oidc \
    --exec-api-version=client.authentication.k8s.io/v1beta1 \
    --exec-command=kubectl \
    --exec-arg=oidc-login \
    --exec-arg=get-token \
    --exec-arg=--oidc-issuer-url=https://dex.dex.svc:$SVC_PORT \
    --exec-arg=--oidc-redirect-url-hostname=dex.dex.svc \
    --exec-arg=--oidc-client-id=example-app \
    --exec-arg=--oidc-client-secret=ZXhhbXBsZS1hcHAtc2VjcmV0 \
    --exec-arg=--oidc-extra-scope=email \
    --exec-arg=--certificate-authority=`pwd`/tls-setup/_certs/ca.pem

kubectl --user=oidc get nodes
