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

