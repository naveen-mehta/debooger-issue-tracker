def run_sql(sql)
    db = PG.connect(dbname: "debooger")
    results = db.exec(sql)
    db.close
    return results 
end

def fetch_all_projects 
    run_sql("SELECT * FROM projects;")
end

def fetch_all_issues 
    run_sql("SELECT * FROM issues;")
end

def fetch_issues_inprogress
    run_sql("SELECT * FROM issues WHERE issue_status = 'in-progress';")
end

def fetch_issues_closed
    run_sql("SELECT * FROM issues WHERE issue_status = 'closed';")
end

def fetch_issues_new
    run_sql("SELECT * FROM issues WHERE issue_status = 'new';")
end

def fetch_projects_inprogress
    run_sql("SELECT * FROM projects WHERE project_status = 'in-progress';")
end

def fetch_projects_closed
    run_sql("SELECT * FROM projects WHERE project_status = 'closed';")
end

def fetch_projects_new
    run_sql("SELECT * FROM projects WHERE project_status = 'new';")
end

def create_new_issue(title, description, project_id, status, submitted_by)
    run_sql("INSERT INTO issues (issue_name, issue_description, project_id, issue_status, submitted_by) VALUES ('#{title}', '#{description}', #{project_id}, '#{status}', '#{submitted_by}');")
end

def create_new_project(title, description, status, owner, submitted_by)
    run_sql("INSERT INTO projects (project_name, project_description, project_status, project_owner, submitted_by) VALUES ('#{title}', '#{description}', '#{status}', '#{owner}', '#{submitted_by}');")
end

def fetch_issue_edit(id)
    run_sql("SELECT * FROM issues WHERE issue_id = #{id}")
end

def update_issue(id, title, description, project_id, status, submitted_by)
    run_sql (
    "UPDATE issues
        SET issue_name = '#{title}',
            issue_description = '#{description}',
            project_id = #{project_id},
            issue_status = '#{status}',
            submitted_by = '#{submitted_by}'
        WHERE issue_id = #{id};"
    )
end

def fetch_project_by_id(id)
    run_sql("SELECT * FROM projects WHERE project_id = #{id}")
end

def update_project(id, title, description, owner, status, submitted_by)
    run_sql (
    "UPDATE projects
        SET project_name = '#{title}',
            project_description = '#{description}',
            project_owner = '#{owner}',
            project_status = '#{status}',
            submitted_by = '#{submitted_by}'
        WHERE project_id = #{id};"
    )
end

def delete_issue(id)
    run_sql("DELETE FROM issues WHERE issue_id = #{id};")
end

def delete_project(id)
    run_sql("DELETE FROM projects WHERE project_id = #{id};")
end

def find_user_by_email(email)
    results = run_sql("SELECT * FROM users WHERE email = '#{email}';")
    return results[0]
end

