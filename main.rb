require 'sinatra'
require 'sinatra/reloader'
require 'PG'
require 'pry'
require_relative 'db/data_access.rb'

get '/' do
  all_projects = fetch_all_projects()
  new_projects = fetch_projects_new()
  inprogress_projects = fetch_projects_inprogress()
  closed_projects = fetch_projects_closed()

  all_issues = fetch_all_issues()
  new_issues = fetch_issues_new()
  inprogress_issues = fetch_issues_inprogress()
  closed_issues = fetch_issues_closed()

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

get '/issues/new' do
  erb :create_issue
end

post '/issues' do
  create_new_issue(params["issue_title"], params["issue_description"], params["project_id"], params["issue_status"], params["submitted_by"])
  redirect '/issues'
end

get '/issues' do
  all_issues = fetch_all_issues()
  erb :all_issues, locals: { all_issues: all_issues }
end

get '/issues/:id/edit' do
  issue = fetch_issue_edit(params["id"])
  erb :edit_issue, locals: { issue: issue[0] }
end

patch '/issues/:id' do
  update_issue(params["id"], params["issue_title"], params["issue_description"], params["project_id"], params["issue_status"], params["submitted_by"])
  redirect '/issues'
end

get '/projects/new' do
  erb :create_project
end

get '/projects' do
  all_projects = fetch_all_projects()
  erb :all_projects, locals: { all_projects: all_projects }
end

post '/projects' do
  create_new_project(params["project_title"], params["project_description"], params["project_status"], params["project_owner"], params["submitted_by"])
  redirect '/projects'
end

patch '/projects/:id' do
  update_project(params["id"], params["project_title"], params["project_description"], params["project_owner"], params["project_status"], params["submitted_by"])
  redirect '/projects'
end

