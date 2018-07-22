-- Videos table.  Create one table to keep track of the videos.
-- This table should include a unique ID, the title of the video,
-- the length in minutes, and the URL.  Populate the table with 
-- at least three related videos from YouTube or other publicly available resources. 
drop table if exists videos;
CREATE TABLE videos (
unique_id varchar(6) PRIMARY KEY,
title varchar(50),
URL varchar(50),
length varchar(50)
);
drop table if exists reviewers;

INSERT INTO videos (unique_id,title,URL,length)
VALUES (000001, 'How to Transfer a Photo to Tiles', 'https://www.youtube.com/watch?v=f9uSPmM0sec','04:02');
INSERT INTO videos (unique_id,title,URL,length)
VALUES (000002, 'Transfer a Photo to Wood with Mod Podge', 'https://www.youtube.com/watch?v=0MPS_MA-qIY','07:33');
INSERT INTO videos (unique_id,title,URL,length)
VALUES (000003, 'Transfer Photos with Mod Podge', 'https://www.youtube.com/watch?v=GGSp6GUmrfw','02:31');
#2. Create and populate Reviewers table.  
#Create a second table that provides at least two user reviews for each of at least two of the videos.  
#These should be imaginary reviews that include columns for the user’s name (“Asher”, “Cyd”, etc.), 
#the rating (which could be NULL, or a number between 0 and 5), and a short text review (“Loved it!”).  
#There should be a column that links back to the ID column in the table of videos. 
CREATE TABLE Reviewers (
user_name varchar(50),
rating integer,
review varchar(50),
unique_id varchar(6)
);

INSERT INTO Reviewers (user_name,rating,review,unique_id)
VALUES ('craftyMaMa', 4, 'makes a perfect christmas gift!',000001 );
INSERT INTO Reviewers (user_name,rating,review,unique_id)
VALUES ('lilCraftz', 3, 'I would have used a sponge to apply',000002 );
INSERT INTO Reviewers (user_name,rating,review,unique_id)
VALUES ('DIY_Dad', 5, 'cannot wait to try!',000001 );
INSERT INTO Reviewers (user_name,rating,review,unique_id)
VALUES ('DIY_Krafter', 4, 'adding this to my pinterest!',000002);

#3. Report on Video Reviews.  Write a JOIN statement that shows information from both tables. 
SELECT * FROM videos
LEFT JOIN Reviewers ON videos.unique_id = Reviewers.unique_id
UNION
SELECT * FROM videos
RIGHT JOIN Reviewers ON videos.unique_id = Reviewers.unique_id;
