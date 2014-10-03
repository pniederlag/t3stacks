Showcase chef-metal for TYPO3 Server Team
==========================================

t3stacks is an effort to provide a generic runtime
environment for chef-cookbooks used by the typo3.org project.

Potential use cases include testing and development of cookbooks as well
as providing development environments of applications used within the typo3.org project
(for example redmine, docs, ...)

We currently ship/provide machine definitions/setups for these environments:

* build.docs.typo3
* forge/redmine
* review/gerrit
* mq/rabbitmq message server

Experimental, be prepared for some rough edges!
Documentation is NOT complete/finished, please be prepared to have a look at the source (rake tasks,...).

Requirements
----------------------------------------

* virtualbox (recent!)
* vagrant (recent!)
* ruby with rake and bundler (recent version, Mac OS system ruby is NOT sufficient, rvm is known to be troublesome)

Quickstart
-----------------------------------------

``` bash
git clone https://github.com/t3dev/t3stacks.git
cd t3stacks
rake
```

add hostnames to your /etc/hosts (automation in preparation)

```
   # forge/redmine setup with TYPO3 customisations
   10.4.17.5      forge.typo3.vagrant
   # rabbitmq mq server
   10.4.17.6      mq.typo3.vagrant
   # custom gerrit setup for TYPO3
   10.4.17.7      review.typo3.vagrant
   # "plain" gerrit recipe
   10.4.17.8      gerrit.typo3.vagrant
   # build.docs
   10.4.17.9      build.docs.typo3.vagrant
```

visit these url's:

* https://forge.typo3.vagrant
* http://review.typo3.vagrant
* http://mq.typo3.vagrant
* http://build.docs.typo3.vagrant

Usage
------------------------------------------
``` bash
# list available tasks
rake -T

# ssh into machine (replace builddocs with the machine that you want to ssh to
rake ssh[builddocs]
```

you can ssh to the machines with vagrant/vagrant for username/password from "anywhere"

config.json
------------------------------------------

### keys

machines = {}, array with machine definitions (attributes, run_list, ...)
enabled = [„xxx“,“bar“], List of machines to converge/build. Keys must be available in machines config.


Notes on individual machines
-----------------------------------------

### forge

login with admin/admin

set theme to typo3

add projects 'extensions' and 'packages'


### rabbitmq

An (admin) user 'admin' is created with password 'admin' so you can check the queues


Known Problems
-----------------------------------------

* ssh/config required so berks can isolate the t3-gerrit cookbook from review.typo3.org with your credentials
* [DONE] Debian "lsb-release" package must be installed (otherwise node.lsb.codename breaks!)


Misc
-----------------------------------------

Heavily inspired by chef-metal and ec-metal repos

rake default task will:
* generate some keys
* copy the config.json.example to config.json
* pull dependencies by running bundler for gems and berks for cookbooks
* use chef-client -z (local mode against chef-zero server) for the default recipe

the machines key in config.json can be used to generate any other machine

ToDo
------------------------------------------

* check wether it is feasible to get this running in docker
* check on using profiles as mentioned by chef-metal (I couldn't get it to work)
* find out about the converge true attribute in the machine ressource (it seems required to set this if for example data_bag/users is updated only)

