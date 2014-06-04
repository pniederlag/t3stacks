sandbox/playground for chef-metal usage
=========================================

Highly experimental! 
default config will give you a local dev environment with three machines:

* forge/redmine
* review/gerrit
* mq/rabbitmq message server

tha machines are conneceted so you can test the mq broking

Usage
-----------------------------------------

* git clone
* rake
* add hostnames to your /etc/hosts (automation in preparation)

   10.4.17.5      forge.typo3.vagrant
   10.4.17.6      mq.typo3.vagrant
   10.4.17.7      review.typo3.vagrant


ToDo/Known Problems
-----------------------------------------

[DONE] debian lsb package must be installed (otherwise node.lsb.name breaks!)


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

check wether it is feasible to get this running in docker
check on using profiles as mentioned by chef-metal (I couldn't get it to work)


