#from Prof. Conrad
#https://github.com/project-awesome/pa-skills-oauth-cancan/blob/master/lib/tasks/super_admin.rake
# see http://railsguides.net/how-to-generate-rake-task/ for custom task generation
# requires hirb gem


namespace :super_admin do

  desc "Help"
  task :help => [:environment] do |t|
    puts " to list all users           rake super_admin:list_users   "
    puts " to list all admins          rake super_admin:list_admins   "
    puts " to list all non-admins      rake super_admin:list_non_admins   "
    puts " to make a user an admin     rake super_admin:grant_admin_permission[< user's id >]   "
    puts " to revoke admin privleges   rake super_admin:revoke_admin_permission[< user's id >]   "
  end

  desc "Lists all users"
  task :list_users => [:environment] do |t, args|
    users = User.all
    puts Hirb::Helpers::AutoTable.render users, :fields=>[:email, :name, :id, :is_admin]
    puts "For syntax of how to grant or revoke admin privs, type rake super_admin:help"
  end

  desc "Lists all admins"
  task :list_admins => [:environment] do |t, args|
    users = User.with_role(:admin)
    puts Hirb::Helpers::AutoTable.render users, :fields=>[:email, :name, :id, :is_admin]
    puts "For syntax of how to grant or revoke admin privs, type rake super_admin:help"
  end

  desc "Lists all non-admins"
  task :list_non_admins => [:environment] do |t, args|
    users = User.all - User.with_role(:admin).to_a
    puts Hirb::Helpers::AutoTable.render users, :fields=>[:email, :name, :id, :is_admin]
    puts "For syntax of how to grant or revoke admin privs, type rake super_admin:help"
  end
  
  desc "Grants a user admin permission"
  task :grant_admin_permission, [:id] => [:environment] do |t, args|
    if !args.id
      puts "usage: rake super_admin:grant_admin_permission[< user's id >]"
    else
      user = User.find_by(id: args.id)
      if !user
        puts "No user found with id: #{args.id}"
      else
        user.add_role "admin"
        puts Hirb::Helpers::AutoTable.render user, :fields=>[:email, :name, :id, :is_admin]
      end
    end
  end

  desc "Revokes a user admin permission"
  task :revoke_admin_permission, [:id] => [:environment] do |t, args|
    if !args.id
      puts "usage: rake super_admin:revoke_admin_permission[< user's id >]"
    else
      user = User.find_by(id: args.id)
      if !user
        puts "No user found with id: #{args.id}"
      else
        user.remove_role "admin"
        puts Hirb::Helpers::AutoTable.render user, :fields=>[:email, :name, :id, :is_admin]
      end
    end
  end



end
