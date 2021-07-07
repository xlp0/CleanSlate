# CleanSlate docker deployment
This sub project is designed to have a minimalistic MediaWiki docker deployment.
It follows PKC's (Personal Knowledge Container) convention in mounting backup and mountPoint directories.
It also allows users to launch the process with just one command line instruction:
```
~CleanSlate/dockerDeployment/$ ./up.sh
```

This sub project also has a Makefile. One may also use the three instructions to trigger scripted actions: They are:
```
~CleanSlate/dockerDeployment/$ make init
```

This is for launching the ./up.sh script. So the behavior is identical to do ./up.sh

The second instruction is:
```
~CleanSlate/dockerDeployment/$ make shutdown
```
and 
```
~CleanSlate/dockerDeployment/$ make removeAllImages
```
The detailed behaviors of these two makefile target names can be examined in the Makefile.


# Usage Cases

To serve MediaWiki on localhost, it often needs to specify a port number to distinguish between different web apps. 

Simply go to the .env in this directory, and change the PORT_NUMBER to a value of your choice. It is recommended NOT to use PORT_NUMBER under 1024. 
For example, the .env is set to 5320 in the following syntax:
```
PORT_NUMBER=5320
```
