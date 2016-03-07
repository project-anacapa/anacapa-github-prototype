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
1. Execute `rake db:migrate`
1. Execute `rails s`
1. The rails server should now be running on http://localhost:3000
