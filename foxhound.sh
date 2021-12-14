#!/bin/bash
#                                                    ░░      
#                                                    ░░░░░░  
#                                                      ░░▒▒░░
#                                                      ▒▒▓▓██
#                                                      ░░▓▓▓▓
#                                                      ▒▒▒▒▓▓
#                                                    ▒▒▒▒▓▓▓▓
#                                                    ▒▒▒▒▓▓▓▓
#            ▒▒    ▒▒              ▒▒▒▒▒▒▒▒▒▒      ▒▒▒▒▓▓▒▒  
#            ▓▓▒▒  ▓▓▒▒        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    
#            ▒▒▓▓░░▒▒▒▒      ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒░░    
#            ▒▒▒▒▒▒▒▒▒▒░░  ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓░░  ░░      
#          ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓  
#  ▒▒▒▒░░▒▒▒▒▓▓▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒
#░░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▓▓
#  ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓  ▓▓▓▓▒▒▒▒▒▒▓▓
#        ▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓  ▓▓▓▓▒▒▒▒▒▒▓▓
#                    ▒▒▒▒▒▒▒▒▓▓▓▓▓▓        ▓▓    ▒▒
#            ░░░░░░░░▓▓▓▓▓▓▒▒▓▓▒▒░░        ▓▓    ▓▓
#        ▒▒░░▒▒░░  ▓▓▓▓▓▓▒▒▒▒░░          ▒▒▓▓  ░░░░
#          ░░  ▒▒▒▒░░░░  ░░              ░░          
###### Foxhound Symlink Hack Monitoring and Reporting #######

# Funtionality to implement:
- daily symlink hack scan
- manual symlink hack scan
- format reports as json, send to monitoring tool via curl or wget
- build the monitoring tool as a php web app
- possibly automate detecting targeted sites/accounts
- may need to discard initial scan results if the script will follow the intended workflow (report upon detection, ideally within 24 hours of the hack occurring > immediate restore) since there are too many already symlinked servers. 
- add lockfile in case of the scan taking longer than 24 hours

# Indicators of infection
- suspicious wp admin user names
- suspicious email accounts in shadow files
- suspicious cronjobs
- suspicious .contactinfo and .contactemail files
- specific known symlink kits


# Other things that may need to be added:
- WHMCS detection
- root .accesshash symlink detection
- kcare detection
