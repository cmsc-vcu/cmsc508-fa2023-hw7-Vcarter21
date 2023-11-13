# hw7-ddl.sql

## DO NOT RENAME OR OTHERWISE CHANGE THE SECTION TITLES OR ORDER.
## The autograder will look for specific code sections. If it can't find them, you'll get a "0"

# Code specifications.
# 0. Where there a conflict between the problem statement in the google doc and this file, this file wins.
# 1. Complete all sections below.
# 2. Table names must MATCH EXACTLY to schemas provided.
# 3. Define primary keys in each table as appropriate.
# 4. Define foreign keys connecting tables as appropriate.
# 5. Assign ID to skills, people, roles manually (you must pick the ID number!)
# 6. Assign ID in the peopleskills and peopleroles automatically (use auto_increment)
# 7. Data types: ONLY use "int", "varchar(255)", "varchar(4096)" or "date" as appropriate.

# Section 1
# Drops all tables.  This section should be amended as new tables are added.

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS peopleroles;
DROP TABLE IF EXISTS peopleskills;
# ... 
SET FOREIGN_KEY_CHECKS=1;

# Section 2
# Create skills( id,name, description, tag, url, time_commitment)
# ID, name, description and tag cannot be NULL. Other fields can default to NULL.
# tag is a skill category grouping.  You can assign it based on your skill descriptions.
# time committment offers some sense of how much time was required (or will be required) to gain the skill.
# You can assign the skill descriptions.  Please be creative!

drop table if exists skills;
CREATE TABLE skills (
    id int NOT NULL,
    name varchar(255) NOT NULL,
    description varchar(255) NOT NULL DEFAULT '(default description)',
    tag varchar(255) NOT NULL,
    primary key (id)
);

select * from skils;

# Section 3
# Populate skills
# Populates the skills table with eight skills, their tag fields must exactly contain “Skill 1”, “Skill 2”, etc.
# You can assign skill names.  Please be creative!

insert into skills ( id, name, tag ) values
    ( 1,'swimming','Skill 1'),
    ( 2,'cooking','Skill 2'),
    ( 3,'drawing','Skill 3'),
    ( 4,'painting','Skill 4'),
    ( 5,'braiding','Skill 5'),
    ( 6,'knitting','Skill 6'),
    ( 7,'juggling','Skill 7'),
    ( 8,'singing','Skill 8')
    ;

# Section 4
# Create people( id,first_name, last_name, email, linkedin_url, headshot_url, discord_handle, brief_bio, date_joined)
# ID cannot be null, Last name cannot be null, date joined cannot be NULL.
# All other fields can default to NULL.

drop table if exists people;
CREATE TABLE people (
    people_id int,
    people_last_name VARCHAR(256) NOT NULL,
    PRIMARY KEY (people_id)
);

# Section 5
# Populate people with six people.
# Their last names must exactly be “Person 1”, “Person 2”, etc.
# Other fields are for you to assign.

insert into people (people_id,people_last_name) values
(1, 'Person 1'),
(2, 'Person 2'),
(3, 'Person 3'),
(4, 'Person 4'),
(5, 'Person 5'),
(6, 'Person 6')
;

# Section 6
# Create peopleskills( id, skills_id, people_id, date_acquired )
# None of the fields can ba NULL. ID can be auto_increment.

drop table if exists peopleskills;
create table peopleskills (
    id int auto_increment,
    skills_id int,
    people_id int,
    date_acquired date default (current_date),
    primary key (id),
    foreign key (skills_id) references skills (id),
    foreign key (people_id) references people (people_id),
    unique (skills_id,people_id)
);

# Section 7
# Populate peopleskills such that:
# Person 1 has skills 1,3,6;
# Person 2 has skills 3,4,5;
# Person 3 has skills 1,5;
# Person 4 has no skills;
# Person 5 has skills 3,6;
# Person 6 has skills 2,3,4;
# Person 7 has skills 3,5,6;
# Person 8 has skills 1,3,5,6;
# Person 9 has skills 2,5,6;
# Person 10 has skills 1,4,5;
# Note that no one has yet acquired skills 7 and 8.
 
 insert into peopleskills (people_id,skills_id) values
    (1,1),
    (1,3),
    (1,5),
    (2,1),
    (2,4),
    (3,3),
    (3,4),
    (3,5),
    (5,3);

    insert into peopleskills (people_id,skills_id) values
        (6,1);

    select * from peopleskills;
    select count(*) from peopleskills;

SELECT
    people_last_name,
    name,
    tag
from
    peopleskills a
    inner join people b on (a.people_id=b.people_id)
    inner join skills c on (a.skills_id=c.id)
WHERE
    people_last_name='Person 1'
order BY
    name,
    people_last_name
;


SELECT
        people_last_name,
    from
        people
    order BY
        people_last_name;



delete from skills where id=3;


SELECT
    people_last_name
from
    people A
        left join peopleskills b on (a.people_id=b.people_id)
WHERE
    b.people_id is NULL
;


# Section 8
# Create roles( id, name, sort_priority )
# sort_priority is an integer and is used to provide an order for sorting roles

drop table if exists roles;
CREATE TABLE roles (
    id int,
    name varchar(255),
    sort_priority int,
    PRIMARY KEY (id)
);

# Section 9
# Populate roles
# Designer, Developer, Recruit, Team Lead, Boss, Mentor
# Sort priority is assigned numerically in the order listed above (Designer=10, Developer=20, Recruit=30, etc.)

INSERT INTO roles (id, name, sort_priority) VALUES
(1, 'Designer', 10),
(2, 'Developer', 20),
(3, 'Recruit', 30),
(4, 'Team Lead', 40),
(5, 'Boss', 50),
(6, 'Mentor', 60);


# Section 10
# Create peopleroles( id, people_id, role_id, date_assigned )
# None of the fields can be null.  ID can be auto_increment

drop table if exists peopleroles;
create table peopleroles (
    id int auto_increment,
    people_id int,
    role_id int,
    date_assigned date default (current_date),
    primary key (id),
    foreign key (role_id) references roles (id),
    foreign key (people_id) references people (people_id)
);

# Section 11
# Populate peopleroles
# Person 1 is Developer 
# Person 2 is Boss, Mentor
# Person 3 is Developer and Team Lead
# Person 4 is Recruit
# person 5 is Recruit
# Person 6 is Developer and Designer
# Person 7 is Designer
# Person 8 is Designer and Team Lead
# Person 9 is Developer
# Person 10 is Developer and Designer

insert into peopleroles (people_id, role_id) values
    (1, 2),          
    (2, 5), (2, 6),  
    (3, 2), (3, 4),  
    (4, 3),          
    (5, 3),         
    (6, 2), (6, 1),  
    (7, 1),          
    (8, 1), (8, 4),  
    (9, 2),          
    (10, 2), (10, 1); 
    
    insert into peopleskills (people_id,skills_id) values
        (6,1);
