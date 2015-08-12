# github-auto-deploy

> Python webserver that listens for webhooks on a reposity and then does a pull to get latest code   
> 
forked from [http://logsol.github.io/Github-Auto-Deploy/](http://logsol.github.io/Github-Auto-Deploy/)   

>Requires linux, apache


## Project setup

#### Install required software

 - python
 - git
```bash
sudo apt-get install python git
```

#### Get Github Auto Deploy
Get a copy of this repo, store in "/opt".  We can't keep this in the home dir because that is encrypted and doesn't stay running after logging out
```bash
cd /opt
git clone https://github.com/USGS-WiM/Github-Auto-Deploy.git
```

#### Start autodeploy as a background service
This command starts and keeps the service running as a background service

```bash
 /usr/bin/nohup python /opt/Github-Auto-Deploy/GitAutoDeploy.py > /dev/null 2>&1 &
```

#### Setup crontab to keep service running
This shell script checks to make sure the GitAutoDeploy.py script is running every 5 minutes

```bash
crontab -e
crontab -u ubuntu -l; echo "*/5 * * * * /opt/chkGitAutoDeploy.sh"
```

## Add a new project to auto-deploy

#### 1.  Get initial clones of repositories to be auto-deployed
This command will get a copy of the repository that will be the base for the deployment.  Run this from your home folder, ie "/home/ubuntu"
```bash
cd /home/ubuntu
git clone https://github.com/USGS-WiM/StreamStats.git
```

#### 2.  Set up symobolic links for apache 
This creates a symbolic link between the github repository in your home folder and the apache web server home folder.  Here we can specify to only make the symbolic link from a specific folder in the github reposity, ie "/dist" in the example below.

```bash
ln -s /home/ubuntu/streamstats/dist /var/www/html/streamstats
```

#### 3.  Edit auto-deploy configuration file
 Edit the file "/opt/Github-Auto-Deploy/GitAutoDeploy.conf.json"
```bash
sudo nano /opt/Github-Auto-Deploy/GitAutoDeploy.conf.json
```

add an object like:
```javascript
{
   "url": "https://github.com/USGS-WiM/NSS",
   "path": "/home/ubuntu/NSS",
   "deploy": "echo deploying"
}
```

#### 4.  Set up webhook on Github.com
On the Github page go to a repository, then go to "Settings" on the right, then "Webhooks & Services", "Add webhook" under "Webhooks."  Add the url of your machine + port (e.g. http://example.com:8001).  Specify Content type as application/json.   Leave the event as just the push event.

