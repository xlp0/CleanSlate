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
Then, copy the mountPoint data image that contains the MediaWiki/MariaDB data content. For instance, the https://roadmaps.mit.edu data content in stored in this format. The overall file structure is under /data/xlp_k8s. When one wish to move the entire content of this website to a new machine, just compress the whole content of /data/xlp_k8s, and decompress to the same absolute location, after <code>setupDockerAndK8s.sh</code> is done, just issue the following command:
```
 sudo ./launch.sh
```

For Jenkins installation, please type
```
 sudo ./Installation.sh
```

