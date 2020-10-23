CREATE DATABASE debooger;

DROP TABLE IF EXISTS issues;
DROP TABLE IF EXISTS projects;

CREATE TYPE status_options AS ENUM ('new', 'in-progress', 'closed');

CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(200) NOT NULL,
    project_description TEXT NOT NULL,
    project_owner VARCHAR(100) NOT NULL,
    project_status status_options,
    created timestamp default current_timestamp
);

ALTER TABLE projects ADD COLUMN submitted_by VARCHAR(100) NOT NULL;

CREATE TABLE issues (
    issue_id SERIAL PRIMARY KEY,
    issue_name TEXT NOT NULL,
    issue_description TEXT NOT NULL,
    issue_status status_options,
    submitted_by VARCHAR(100) NOT NULL,
    project_id INT,
    created timestamp default current_timestamp,
    CONSTRAINT fk_projects
        FOREIGN KEY(project_id)
            REFERENCES projects(project_id)
            ON DELETE SET NULL
);

INSERT INTO projects (project_name, project_description, project_status, project_owner) VALUES ('Debooger issue tracking tool', 'Will include a dashboard, project details page, issue tracking functionality and user roles assignment', 'new', 'Naveen M');

INSERT INTO projects (project_name, project_description, project_status, project_owner) VALUES ('Add Sidebar', 'design, icons, menu, background, css/positioning', 'in-progress', 'Naveen M');

INSERT INTO projects (project_name, project_description, project_status, project_owner) VALUES ('Add Navigation', 'logo, menu, logout button, layout.erb updates', 'closed', 'Naveen M');

INSERT INTO issues (issue_name, issue_description, submitted_by, project_id, issue_status) VALUES ('Dashboard page updates', 'Page should display 1. Projects summary - total, open, completed. 2. Issues summary - submitted, unassigned, closed, in progress', 'Naveen M', 1, 'new');


