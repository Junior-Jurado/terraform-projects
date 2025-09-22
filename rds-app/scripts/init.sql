DROP TABLE IF EXISTS roles CASCADE;
CREATE TABLE roles(
    id BIGSERIAL PRIMARY KEY,
    rol VARCHAR(255) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users(
	id BIGSERIAL PRIMARY KEY,
	user_name VARCHAR(255) NOT NULL UNIQUE,
	email VARCHAR(255) NOT NULL UNIQUE,
	password VARCHAR(255) NOT NULL,
	rol BIGSERIAL NOT NULL,
	session_token VARCHAR(255) NULL,
	created_at TIMESTAMP(0) NOT NULL,
	updated_at TIMESTAMP(0) NOT NULL,
    FOREIGN KEY (rol) REFERENCES roles(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS states CASCADE;
CREATE TABLE states(
    id BIGSERIAL PRIMARY KEY,
    estate VARCHAR(255) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS projects CASCADE;
CREATE TABLE projects(
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    start_date DATE,
    state_id BIGSERIAL,
    created_by_id BIGSERIAL,
    FOREIGN KEY (created_by_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (state_id) REFERENCES states(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS project_assigment CASCADE;
CREATE TABLE project_assigment(
    id BIGSERIAL PRIMARY KEY,
    user_id BIGSERIAL NOT NULL,
    project_id BIGSERIAL NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS user_histories CASCADE;
CREATE TABLE user_histories(
    id BIGSERIAL PRIMARY KEY,
    description TEXT NOT NULL,
    criteria TEXT NOT NULL,
    project_id BIGSERIAL NOT NULL,
    state_id BIGSERIAL NOT NULL,
    created_by_id BIGSERIAL NOT NULL,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (state_id) REFERENCES states(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (created_by_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS user_histories_assignment CASCADE;
CREATE TABLE user_histories_assignment(
    id BIGSERIAL PRIMARY KEY,
    user_history_id BIGSERIAL NOT NULL,
    user_id BIGSERIAL,
    FOREIGN KEY (user_history_id) REFERENCES user_histories(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS tasks CASCADE;
CREATE TABLE tasks(
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    user_history_id BIGSERIAL NOT NULL,
    state_id BIGSERIAL NOT NULL,
    create_by_id BIGSERIAL NOT NULL,
    FOREIGN KEY (state_id) REFERENCES states(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (user_history_id) REFERENCES user_histories(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (create_by_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS task_assignment CASCADE;
CREATE TABLE task_assignment(
    id BIGSERIAL PRIMARY KEY,
    task_id BIGSERIAL NOT NULL,
    user_id BIGSERIAL NOT NULL,
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS change_tracking_task CASCADE;
CREATE TABLE change_tracking_task(
    id BIGSERIAL PRIMARY KEY,
    change_date TIMESTAMP(0) NOT NULL,
    task_id BIGSERIAL NOT NULL,
    changed_by_id BIGSERIAL NOT NULL,
    FOREIGN KEY (changed_by_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS change_tracking_history CASCADE;
CREATE TABLE change_tracking_history(
    id BIGSERIAL PRIMARY KEY, 
    change_date TIMESTAMP(0) NOT NULL,
    user_histoy_id BIGSERIAL NOT NULL,
    changed_by_id BIGSERIAL NOT NULL,
    FOREIGN KEY (changed_by_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (user_histoy_id) REFERENCES user_histories(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO roles(rol) VALUES('Gerente');
INSERT INTO roles(rol) VALUES('Desarrollador');


INSERT INTO states(estate) VALUES('Nueva');
INSERT INTO states(estate) VALUES('En desarrollo');
INSERT INTO states(estate) VALUES('Finalizada');


INSERT INTO users(
	user_name,
	email,
	password,
	created_at,
	updated_at,
	rol
)
VALUES(
	'Junior Jurado',
	'juniorjurado2004@gmail.com',
	'123',
	'2024-02-17',
	'2024-02-17',
	1
);
