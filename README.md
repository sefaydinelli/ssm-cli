# AWS SSM Session Connector
## Description

With this tool, you can connect AWS instances with using SSM Session Manager via Terminal.
## Requirements

- You need ```aws-cli``` and ```Session Manager Plugin``` .
- For Session Manager Plugin, check this :  https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html

## Installation

- You can use this command to install ```ssmctl``` tool :

#### For MacOS :
```
curl https://raw.githubusercontent.com/sefaydinelli/ssmctl/main/ssmctl.sh >> ssmctl && \
    sudo cp ssmctl /usr/local/bin/ && \
    sudo chmod +x /usr/local/bin/ssmctl
```

#### For Ubuntu :
```
curl https://raw.githubusercontent.com/sefaydinelli/ssmctl/main/ssmctl.sh >> ssmctl && \
    sudo mv ssmctl /usr/bin/ && \
    sudo chmod +x /usr/bin/ssmctl
```

After this, you can use ```ssmctl help``` command.




