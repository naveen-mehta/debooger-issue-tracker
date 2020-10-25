require 'sinatra'
require 'sinatra/reloader'
require 'PG'
require 'pry'
require_relative 'db/data_access.rb'
require 'bcrypt'

enable :sessions

def logged_in?()
  if session[:user_id]
    true
  else
    false
  end
end

get '/login' do
  erb :login
end

get '/' do
  if logged_in?
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
  else 
    redirect '/login'
  end 
end

get '/issues/new' do
  if logged_in?
    erb :create_issue
  else 
    redirect '/login'
  end
end

post '/issues' do
  create_new_issue(params["issue_title"], params["issue_description"], params["project_id"], params["issue_status"], params["submitted_by"])
  redirect '/issues'
end

get '/issues' do
  if logged_in?
    all_issues = fetch_all_issues()
    erb :all_issues, locals: { all_issues: all_issues }
  else 
    redirect '/login'
  end
end

get '/issues/:id/edit' do
  if logged_in?
    issue = fetch_issue_edit(params["id"])
    erb :edit_issue, locals: { issue: issue[0] }
  else 
    redirect '/login'
  end
end

patch '/issues/:id' do
  update_issue(params["id"], params["issue_title"], params["issue_description"], params["project_id"], params["issue_status"], params["submitted_by"])
  redirect '/issues'
end

delete '/issues/:id' do
  delete_issue(params["id"])
  redirect '/issues'
end

get '/projects/new' do
  if logged_in?
    erb :create_project
  else
    redirect '/login'
  end
end

get '/projects' do
  if logged_in?
    all_projects = fetch_all_projects()
    erb :all_projects, locals: { all_projects: all_projects }
  else
    redirect '/login' 
  end 
end

post '/projects' do
  create_new_project(params["project_title"], params["project_description"], params["project_status"], params["project_owner"], params["submitted_by"])
  redirect '/projects'
end

get '/projects/:id/edit' do
  if logged_in?
    project = fetch_project_by_id(params["id"])
    erb :edit_project, locals: { project: project[0] }
  else
    redirect '/login' 
  end  
end

patch '/projects/:id' do
  update_project(params["id"], params["project_title"], params["project_description"], params["project_owner"], params["project_status"], params["submitted_by"])
  redirect '/projects'
end

delete '/projects/:id' do
  delete_project(params["id"])
  redirect '/projects'
end

# login
get '/login' do
  erb :login
end

post '/sessions' do  
  user = find_user_by_email(params['email'])
  if BCrypt::Password.new(user['password_digest']) == params['password']
    session[:user_id] = user['user_id']
    redirect "/"
  else
    erb :login
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect '/login'
end

get '/projects/:id' do
  if logged_in?
    project = fetch_project_by_id(params['id'])
    issue = fetch_issue_by_projectID(params['id'])
    erb :index, locals: {
      project: project[0],
      issue: issue[0]
    }
  else 
    redirect '/login'
  end 
end

