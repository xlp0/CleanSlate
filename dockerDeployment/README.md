# CleanSlate docker deployment
This sub project is designed to have a minimalistic installation.

# Usage Cases

To serve MediaWiki on localhost, it often needs to specify a port number to distinguish between different web apps. 

Simply go to the .env in this directory, and change the PORT_NUMBER to a value of your choice. It is recommended NOT to use PORT_NUMBER under 1024. 
For example, the .env is set to 5320 in the following syntax:
```
PORT_NUMBER=5320
```
