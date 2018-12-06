## NFS Provisioner with helm installation guideline
```
helm fetch --untar stable/nfs-server-provisioner
```nfs in
### to install with custom values
```
helm install --name nfs --values ./myValues.yaml # if you fetched installation /vagrant/dnmler/nfs-server-provisioner
```

### provision PV with the created PVC since helm install doesn't create PV automatically. 
### first change pv.yaml to set the PVC created
```
kubectl create -f pv.yaml
kubectl get pv,pvc,pods 
```