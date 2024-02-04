
# kubectl create -f https://dev.operatorhub.io/install/group-sync-operator.yaml

kubectl create -f ldap-groupsync.yaml

kubectl  create secret generic ldap-group-sync --from-literal=username=admin --from-literal=password=adminpassword
