require 'sinatra'
require 'sinatra/reloader'
require 'PG'
require 'pry'
require_relative 'db/data_access.rb'

get '/' do
  projects = fetch_all_projects
  issues = fetch_all_issues
  erb :index, locals: {
    projects: projects,
    issues: issues
  }
end







