# CleanSlate
Installing Infrastructure provisioning tools from scratch.

# Usage Cases

For Jenkins installation, please type
```
 sudo ./Installation.sh
```

For a fresh installation of the original XLP system, follow the three steps
```
 sudo ./setupDockerAndK8s.sh
```
While waint for <code>setupDockerAndK8s.sh</code> to finish, you need to locate a <code>mountPoint</code> data image file. A <code>mountPoint</code> image file is a file that contains the entire states of a Kubernetes system that packaged with PKC's (Personal Knowledge Container) way of migrating knowledge content.
For instance, the https://roadmaps.mit.edu data content in stored in this format. All data content that is unique to a <code>PKC instance</code> is stored under /data/xlp_k8s. When one wish to move the entire content of one <code>PKC</code> to a new machine, just compress the whole content of /data/xlp_k8s, and decompress to the same absolute location, after <code>setupDockerAndK8s.sh</code> is done, just issue the following command:
```
 sudo ./launch.sh
```

For Jenkins installation, please type
```
 sudo ./Installation.sh
```

