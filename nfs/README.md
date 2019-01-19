## NFS Provisioner with helm installation guideline
```
helm fetch --untar stable/nfs-server-provisioner
```nfs in
### to install with custom values
```
k create ns storage
k create -f pv-stoaragens.yaml
kubens storage
helm install --name nfsserver --values ./myValues.yaml # if you fetched installation /vagrant/dnmler/nfs-server-provisioner
helm install --name nfsserver --values ./myValues.yaml stable/nfs-server-provisioner # if you fetched installation /vagrant/dnmler/nfs-server-provisioner
```

### provision PV with the created PVC since helm install doesn't create PV automatically. 
### first change pv.yaml to set the PVC created
```
kubectl create -f pv.yaml
kubectl get pv,pvc,pods 
```
