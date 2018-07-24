drop table if exists users;
CREATE TABLE users (
user_id varchar(6) PRIMARY KEY,
user_name varchar(50),
user_group varchar(50),
group_id varchar(50)
);
INSERT INTO users (user_id,user_name,user_group,group_id)
VALUES ('U1', 'Modesto', 'I.T.','G1');
INSERT INTO users (user_id,user_name,user_group,group_id)
VALUES ('U2', 'Ayine', 'I.T.','G1');
INSERT INTO users (user_id,user_name,user_group,group_id)
VALUES ('U3', 'Christopher', 'Sales','G2');
INSERT INTO users (user_id,user_name,user_group,group_id)
VALUES ('U4', 'Cheong woo', 'Sales','G2');
INSERT INTO users (user_id,user_name,user_group,group_id)
VALUES ('U5', 'Saulat', 'Administration','G3');
INSERT INTO users (user_id,user_name,user_group,group_id)
VALUES ('U6', 'Heidy', NULL,NULL);

drop table if exists user_group;
CREATE TABLE user_group (
group_id varchar(6) PRIMARY KEY,
group_name varchar(50)
);
INSERT INTO user_group (group_id,group_name)
VALUES ('G1', 'I.T.');
INSERT INTO user_group (group_id,group_name)
VALUES ('G2', 'Sales');
INSERT INTO user_group (group_id,group_name)
VALUES ('G3', 'Administration');
INSERT INTO user_group (group_id,group_name)
VALUES ('G4', 'Operations');

drop table if exists rooms;
CREATE TABLE rooms (
room_id varchar(6) PRIMARY KEY,
room_name varchar(50)
);
INSERT INTO rooms (room_id,room_name)
VALUES ('R1', '101');
INSERT INTO rooms (room_id,room_name)
VALUES ('R2', '102');
INSERT INTO rooms (room_id,room_name)
VALUES ('R3', 'Auditorium A');
INSERT INTO rooms (room_id,room_name)
VALUES ('R4', 'Auditorium B');

drop table if exists group_access;
CREATE TABLE group_access(
group_id varchar(50),
group_name varchar (50),
room_id varchar (50),
room_name varchar(50)
);

INSERT INTO group_access (group_id, group_name, room_id,room_name)
VALUES ('G1', 'I.T.','R1','101');
INSERT INTO group_access (group_id, group_name, room_id,room_name)
VALUES ('G1', 'I.T.','R2','102');
INSERT INTO group_access (group_id, group_name, room_id,room_name)
VALUES ('G2', 'Sales','R2','102');
INSERT INTO group_access (group_id, group_name, room_id,room_name)
VALUES ('G2', 'Sales','R2','102');
INSERT INTO group_access (group_id, group_name, room_id,room_name)
VALUES ('G3', 'Administration',NULL,NULL);
INSERT INTO group_access (group_id, group_name, room_id,room_name)
VALUES ('G4', 'Operations',NULL,NULL);


#All groups, and the users in each group. 
#A group should appear even if there are no users assigned to the group.
SELECT * FROM user_group
LEFT JOIN users ON user_group.group_id = users.group_id;
# All rooms, and the groups assigned to each room. 
# The rooms should appear even if no groups have been assigned to them.
SELECT * from rooms
LEFT JOIN group_access ON rooms.room_id = group_access.room_id;

SELECT * from users
LEFT JOIN group_access ON users.group_id = group_access.group_id
group by users.user_name ASC, users.group_id, group_access.room_name;