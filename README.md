Showcase chef-metal for TYPO3 Server Team
==========================================

Experimental, be prepared for some rough edges! 

include machine definitions by defaul:

* build.docs.typo3 (enabled)
* forge/redmine (disabled)
* review/gerrit (disabled)
* mq/rabbitmq message server (disabled)

the machines are conneceted so you can test the mq broking (disabled)

Requirements
----------------------------------------

* virtualbox (recent!)
* vagrant (recent!)
* ruby with rake and bundler

Usage
-----------------------------------------

``` bash
git clone https://github.com/t3dev/t3stacks.git
cd t3stacks
rake
```

add hostnames to your /etc/hosts (automation in preparation)

```
   10.4.17.5      forge.typo3.vagrant
   10.4.17.6      mq.typo3.vagrant
   10.4.17.7      review.typo3.vagrant #(custom gerrit setup for TYPO3)
   10.4.17.8      gerrit.typo3.vagrant #("plain" gerrit recipe), disabled by default
   10.4.17.9      build,docs.typo3.vagrant #("plain" gerrit recipe), disabled by default
```

visit these url's:

* https://forge.typo3.vagrant
* http://review.typo3.vagrant
* http://mq.typo3.vagrant
* http://build.docs.typo3.vagrant


Howto
-----------------------------------------

### forge

login with admin/admin

set theme to typo3

add projects 'extensions' and 'packages'


### rabbitmq

An (admin) user 'admin' is created with password 'admin' so you can check the queues


config.json
------------------------------------------

### keys

machines = {}, array with machine definitions (attributes, run_list, ...)
enabled = [„xxx“,“bar“], List of machines to converge/build. Keys must be available in machines config.


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

