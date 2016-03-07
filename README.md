# anacapa-github-prototype
Spike, see: https://www.pivotaltracker.com/n/projects/1519297

To run this web server:

1. Fork and/or clone this repo
1. Ensure you have `postgresql` [installed](https://wiki.postgresql.org/wiki/Detailed_installation_guides) and running on localhost
1. Execute `bundle install`
  * If you have a problem installing `pg`, try running
    * `sudo env ARCHFLAGS='-arch x86_64' gem install pg`
1. Create a file called `.env` in the project root,
  * You can run `cp .env.example .env`
  * Populate the `GITHUB_CLIENT_ID` and `GITHUB_CLIENT_SECRET` with your own Github App configurations
  * Instructions on how to do this [here](https://help.github.com/enterprise/11.10.340/admin/articles/configuring-github-oauth/)
  * Look at an example configuration below
1. If you are running this for the first time, run `rake db:create`
1. Execute `rake db:migrate`
1. Execute `rails s`
1. The rails server should now be running on http://localhost:3000

To set initial admin:

1. First, sign into your application at [http://localhost:3000](http://localhost:3000)
1. On the command line in your project root, you can run `rake super_admin:help` to show all super_admin instructions
```
169-231-82-184:anacapa-github-prototype johndoe$ rake super_admin:help
 to list all users           rake super_admin:list_users   
 to list all admins          rake super_admin:list_admins   
 to list all non-admins      rake super_admin:list_non_admins   
 to make a user an admin     rake super_admin:grant_admin_permission[< user's id >]   
 to revoke admin privleges   rake super_admin:revoke_admin_permission[< user's id >] 
```
1. To make yourself an admin, first find yourself by running `rake super_admin:list_users`
```
169-231-82-184:anacapa-github-prototype johndoe$ rake super_admin:list_users
+---------------------+----------+----+----------+
| email               | name     | id | is_admin |
+---------------------+----------+----+----------+
| johndoe@cs.ucsb.edu | John Doe | 1  | false    |
+---------------------+----------+----+----------+
1 row in set
For syntax of how to grant or revoke admin privs, type rake super_admin:help
```
1. Find the `id` corresponding to your user and run `rake super_admin:grant_admin_permission[<what you found>]`
```
169-231-82-184:anacapa-github-prototype johndoe$ rake super_admin:grant_admin_permission[1]
+---------------------+----------+----+----------+
| email               | name     | id | is_admin |
+---------------------+----------+----+----------+
| johndoe@cs.ucsb.edu | John Doe | 1  | true     |
+---------------------+----------+----+----------+
1 row in set
169-231-82-184:anacapa-github-prototype johndoe$
```
1. You should now see a link to "Admin Panel" when you sign in to your website.


#### Example OAuth Config Example

![OAuth Config Example](https://github.com/ncbrown1/anacapa-github-prototype/raw/master/oauth_settings_example.png "Example OAuth Configurations")
