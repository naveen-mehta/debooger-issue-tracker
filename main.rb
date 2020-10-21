require 'sinatra'
require 'sinatra/reloader'
require 'PG'
require 'pry'
require_relative 'db/data_access.rb'

get '/' do
  all_projects = fetch_all_projects
  new_projects = fetch_projects_new
  inprogress_projects = fetch_projects_inprogress
  closed_projects = fetch_projects_closed

  all_issues = fetch_all_issues
  new_issues = fetch_issues_new
  inprogress_issues = fetch_issues_inprogress
  closed_issues = fetch_issues_closed

  erb :index, locals: {
    all_projects: all_projects,
    new_projects: new_projects,
    inprogress_projects: inprogress_projects,
    closed_projects: closed_projects,
    all_issues: all_issues,
    new_issues: new_issues,
    inprogress_issues: inprogress_issues,
    closed_issues: closed_issues
  }
end









