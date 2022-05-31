# AWS SSM Session Connector
## Description

With this tool, you can connect AWS instances with using SSM Session Manager via Terminal.
## Requirements

- You need ```aws-cli``` and ```Session Manager Plugin``` .
- For Session Manager Plugin, check this :  https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html

## Installation

- You can use this command to install ```ssmctl``` tool :

#### For MacOS & Linux :
```
curl https://raw.githubusercontent.com/sefaydinelli/ssmctl/main/ssmctl.sh > ssm && \
    sudo cp ssm /usr/local/bin/ && \
    sudo chmod +x /usr/local/bin/ssm
```

After this, you can use ```ssm help``` command.




