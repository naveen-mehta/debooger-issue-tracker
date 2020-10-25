require 'bcrypt'
require 'pg'
require_relative 'data_access.rb'

email = 'nm@ga.co'
password_digest = BCrypt::Password.create('spitfire1')

# sql = "INSERT INTO users (email, password_digest) VALUES ('#{email}', '#{password_digest}');"

sql = "INSERT INTO users (email, password_digest, user_role, user_job_title) VALUES ('#{email}', '#{password_digest}', 'admin', 'Project Manager');"
run_sql(sql)
