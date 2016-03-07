# spec/lib/tasks/reports_rake_spec.rb
require 'rails_helper'
require 'rspec/mocks/standalone'

describe "super_admin:help" do
	include_context "rake"
	before do
		allow(STDOUT).to receive(:puts)
	end
	describe "init" do
        it { expect(subject.prerequisites).to include("environment") }
	end
	it "outputs the help info" do
		subject.invoke
		expect(STDOUT).to have_received(:puts).ordered.with(" to list all users           rake super_admin:list_users   ")
		expect(STDOUT).to have_received(:puts).ordered.with(" to make a user an admin     rake super_admin:grant_admin_permission[< user's id >]   ")
		expect(STDOUT).to have_received(:puts).ordered.with(" to revoke admin privleges   rake super_admin:revoke_admin_permission[< user's id >]   ")
	end
end

describe "super_admin:list_users" do
	include_context "rake"

	let(:user_records) { double("user records") }
	let(:hirb_table) { double("user records table") }

	before do
		allow(User).to receive(:all).and_return(:user_records)
		allow(Hirb::Helpers::AutoTable).to receive(:render).with(:user_records, :fields=>[:email, :name, :id, :is_admin]).and_return(:hirb_table)
		allow(STDOUT).to receive(:puts)
	end

	describe "init" do
        it { expect(subject.prerequisites).to include("environment") }
	end
	it "retrieves all the User records" do
		subject.invoke
		expect(User).to have_received(:all)
	end
	it "generates a hirb table of all users with fields [:email, :name, :id, :is_admin]" do
		subject.invoke
		expect(Hirb::Helpers::AutoTable).to have_received(:render).with(:user_records, {:fields=>[:email, :name, :id, :is_admin]})
	end
	it "outputs the hirb table" do
		subject.invoke
		expect(STDOUT).to have_received(:puts).with(:hirb_table)
	end
	it "outputs the help info" do
		subject.invoke
		expect(STDOUT).to have_received(:puts).with("For syntax of how to grant or revoke admin privs, type rake super_admin:help")
	end
end



describe "super_admin:grant_admin_permission" do
	include_context "rake"
	
	describe "init" do
        it { expect(subject.prerequisites).to include("environment") }
	end

	describe "when id is not passed as a parameter" do
		before do
			allow(STDOUT).to receive(:puts)
		end
		it "should output usage" do
			subject.invoke
			expect(STDOUT).to have_received(:puts).with("usage: rake super_admin:grant_admin_permission[< user's id >]")
		end
	end

	context "no user with the given id is found in the db" do
		let(:user) { build(:user) }
		before do
			allow(User).to receive(:find_by).with({:id=>1}).and_return(nil)
			allow(STDOUT).to receive(:puts)
		end

		it "sets is_admin to true and saves the user" do
			subject.invoke(1)
			expect(STDOUT).to have_received(:puts).with("No user found with id: 1")
		end
	end

	context "user exists in the db" do
		let(:user) { build(:user) }
		let(:hirb_table) { double("hirb generated table") }
		before do
			allow(user).to receive(:save!)
			allow(User).to receive(:find_by).with({:id=>1}).and_return(user)
			allow(Hirb::Helpers::AutoTable).to receive(:render).with(user, :fields=>[:email, :name, :id, :is_admin]).and_return(:hirb_table)
			allow(STDOUT).to receive(:puts).with(:hirb_table)
		end
		it "generates a hirb table of the user with fields [:email, :name, :id, :is_admin]" do
			subject.invoke(1)
			expect(Hirb::Helpers::AutoTable).to have_received(:render).with(user, {:fields=>[:email, :name, :id, :is_admin]})
		end
		it "outputs the hirb table" do
			subject.invoke(1)
			expect(STDOUT).to have_received(:puts).with(:hirb_table)
		end
		it "sets is_admin to true and saves the user" do
			expect(user.is_admin).to eql(false)
			subject.invoke(1)
			expect(user.is_admin).to eql(true)
			expect(user).to have_received(:save!)
		end
	end
end

describe "super_admin:revoke_admin_permission" do
	include_context "rake"
	
	describe "init" do
        it { expect(subject.prerequisites).to include("environment") }
	end

	describe "when id is not passed as a parameter" do
		before do
			allow(STDOUT).to receive(:puts)
		end
		it "should output usage" do
			subject.invoke
			expect(STDOUT).to have_received(:puts).with("usage: rake super_admin:revoke_admin_permission[< user's id >]")
		end
	end

	context "no user with the given id is found in the db" do
		let(:user) { build(:admin) }
		before do
			allow(User).to receive(:find_by).with({:id=>1}).and_return(nil)
			allow(STDOUT).to receive(:puts)
		end

		it "sets is_admin to true and saves the user" do
			subject.invoke(1)
			expect(STDOUT).to have_received(:puts).with("No user found with id: 1")
		end
	end

	context "user exists in the db" do
		let(:user) { build(:admin) }
		let(:hirb_table) { double("hirb generated table") }
		before do
			allow(user).to receive(:save!)
			allow(User).to receive(:find_by).with({:id=>1}).and_return(user)
			allow(Hirb::Helpers::AutoTable).to receive(:render).with(user, :fields=>[:email, :name, :id, :is_admin]).and_return(:hirb_table)
			allow(STDOUT).to receive(:puts).with(:hirb_table)
		end
		it "generates a hirb table of the user with fields [:email, :name, :id, :is_admin]" do
			subject.invoke(1)
			expect(Hirb::Helpers::AutoTable).to have_received(:render).with(user, {:fields=>[:email, :name, :id, :is_admin]})
		end
		it "outputs the hirb table" do
			subject.invoke(1)
			expect(STDOUT).to have_received(:puts).with(:hirb_table)
		end
		it "sets is_admin to true and saves the user" do
			expect(user.is_admin).to eql(true)
			subject.invoke(1)
			expect(user.is_admin).to eql(false)
			expect(user).to have_received(:save!)
		end
	end
end











