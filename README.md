sandbox/playground for chef-metal usage
=========================================

Highly experimental! 
First boot succeeded for forge (2014-05-31)


Usage
-----------------------------------------

* (you need some items in data_bags/certificates/  and data_bags/users/! Ask for help!)
* git clone
* rake

ToDo/Known Problems
-----------------------------------------

debian lsb package must be installed (otherwise node.lsb.name breaks!)


Misc
-----------------------------------------

Heavily inspired by chef-metal and ec-metal repos

rake default task will pull dependencies by running bundler for gems and berks for cookbooks


