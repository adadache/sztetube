SET SERVEROUTPUT ON

	CREATE TABLE users (
		user_id NUMBER(10) NOT NULL,
		email VARCHAR2(255) NOT NULL,
		passwords VARCHAR2(255) NOT NULL,
		fname VARCHAR2(255) NOT NULL,
		lname VARCHAR2(255) NOT NULL,
		PRIMARY KEY(user_id)
	);

	CREATE TABLE category (
		category_id NUMBER(10) NOT NULL,
		name VARCHAR2(255) NOT NULL,
		parent_id NUMBER(10),
		PRIMARY KEY(category_id),
		FOREIGN KEY (parent_id) REFERENCES category (category_id)
	);

	CREATE TABLE videos (
		video_id NUMBER(10) NOT NULL,
		name VARCHAR2(255) NOT NULL,
		description VARCHAR2(255),
		viewss NUMBER(10),
		dates Date NOT NULL,
		filename VARCHAR2(255),
		user_id NUMBER(10),
		category_id INT NOT NULL,
		PRIMARY KEY(video_id),
		FOREIGN KEY (user_id) REFERENCES users (user_id),
		FOREIGN KEY (category_id) REFERENCES category (category_id)
	);

	CREATE TABLE comments (
		comment_id NUMBER(10) NOT NULL,
		comment_text VARCHAR2(255) NOT NULL,
		user_id NUMBER(10),
		video_id NUMBER(10),
		PRIMARY KEY(comment_id),
		FOREIGN KEY (video_id) REFERENCES videos (video_id),
		FOREIGN KEY (user_id) REFERENCES users (user_id)
	);
    
    CREATE TABLE watched (
		user_id NUMBER(10),
		video_id NUMBER(10),
		FOREIGN KEY (video_id) REFERENCES videos (video_id),
		FOREIGN KEY (user_id) REFERENCES users (user_id)
	);

	CREATE TABLE playlist (
		playlist_id NUMBER(10) NOT NULL,
		name VARCHAR2(255) NOT NULL,
		user_id NUMBER(10),
		PRIMARY KEY(playlist_id),
		FOREIGN KEY (user_id) REFERENCES users (user_id)
	);

	CREATE TABLE playlistvideo (
		playlist_id NUMBER(10) NOT NULL,	
		video_id NUMBER(10) NOT NULL,	
		FOREIGN KEY (playlist_id) REFERENCES playlist (playlist_id),
		FOREIGN KEY (video_id) REFERENCES videos (video_id)
	);	

	CREATE TABLE tags (
		tag_id number(10) NOT NULL,
		name VARCHAR2(255) NOT NULL,
		category_id number(10),
		PRIMARY KEY(tag_id),
		FOREIGN KEY (category_id) REFERENCES category (category_id)
	);

	CREATE TABLE videotags (
		tag_id number(10) NOT NULL,		
		video_id NUMBER(10) NOT NULL,
		FOREIGN KEY (tag_id) REFERENCES tags (tag_id),
		FOREIGN KEY (video_id) REFERENCES videos (video_id)
	);


DECLARE
  TYPE userarray IS VARRAY(150) OF VARCHAR2(200);     
  names userarray;
  total integer;
BEGIN

  INSERT ALL
    INTO category (category_id, name) VALUES (0,'Nature ')
    INTO category (category_id, name) VALUES (5,'Weather / Seasons ')
    INTO category (category_id, name) VALUES (14,'Animal ')
    INTO category (category_id, name) VALUES (21,'Social / People ')
    INTO category (category_id, name) VALUES (30,'Holidays / Celebrations ')
    INTO category (category_id, name) VALUES (39,'Family ')
    INTO category (category_id, name) VALUES (43,'Art / Photography ')
    INTO category (category_id, name) VALUES (51,'Urban ')
    INTO category (category_id, name) VALUES (56,'Food ')
    INTO category (category_id, name) VALUES (62,'Fashion ')
    INTO category (category_id, name) VALUES (77,'Celebrities ')
    INTO category (category_id, name) VALUES (97,'Entertainment ')
    INTO category (category_id, name) VALUES (102,'Electronics ')
    INTO category (category_id, name) VALUES (106,'Follow / Shoutout / Like / Comment ')
    INTO category (category_id, name) VALUES (112,'Travel / Active / Sports')
    INTO category (category_id, name, parent_id) VALUES (1, 'General', 0)
    INTO category (category_id, name, parent_id) VALUES (2, 'Beach', 0)
    INTO category (category_id, name, parent_id) VALUES (3, 'Sunset / Sunrise', 0)
    INTO category (category_id, name, parent_id) VALUES (4, 'Flowers', 0)
    INTO category (category_id, name, parent_id) VALUES (6, 'Sunny', 5)
    INTO category (category_id, name, parent_id) VALUES (7, 'Cloudy', 5)
    INTO category (category_id, name, parent_id) VALUES (8, 'Raining', 5)
    INTO category (category_id, name, parent_id) VALUES (9, 'Snowing', 5)
    INTO category (category_id, name, parent_id) VALUES (10, 'Spring', 5)
    INTO category (category_id, name, parent_id) VALUES (11, 'Summer', 5)
    INTO category (category_id, name, parent_id) VALUES (12, 'Fall', 5)
    INTO category (category_id, name, parent_id) VALUES (13, 'Winter', 5)
    INTO category (category_id, name, parent_id) VALUES (15, 'General', 14)
    INTO category (category_id, name, parent_id) VALUES (16, 'Dogs', 14)
    INTO category (category_id, name, parent_id) VALUES (17, 'Cats', 14)
    INTO category (category_id, name, parent_id) VALUES (18, 'Horses', 14)
    INTO category (category_id, name, parent_id) VALUES (19, 'Insects', 14)
    INTO category (category_id, name, parent_id) VALUES (20, 'Fish', 14)
    INTO category (category_id, name, parent_id) VALUES (22, 'General', 21)
    INTO category (category_id, name, parent_id) VALUES (23, 'Selfies', 21)
    INTO category (category_id, name, parent_id) VALUES (24, 'Girls', 21)
    INTO category (category_id, name, parent_id) VALUES (25, 'Guys', 21)
    INTO category (category_id, name, parent_id) VALUES (26, 'Love', 21)
    INTO category (category_id, name, parent_id) VALUES (27, 'Friends', 21)
    INTO category (category_id, name, parent_id) VALUES (28, 'Good Morning', 21)
    INTO category (category_id, name, parent_id) VALUES (29, 'Good Night', 21)
    INTO category (category_id, name, parent_id) VALUES (31, 'Party', 30)
    INTO category (category_id, name, parent_id) VALUES (32, 'Birthday', 30)
    INTO category (category_id, name, parent_id) VALUES (33, 'Wedding', 30)
    INTO category (category_id, name, parent_id) VALUES (34, 'Thanksgiving', 30)
    INTO category (category_id, name, parent_id) VALUES (35, 'Halloween', 30)
    INTO category (category_id, name, parent_id) VALUES (36, 'Christmas', 30)
    INTO category (category_id, name, parent_id) VALUES (37, 'New Years Day', 30)
    INTO category (category_id, name, parent_id) VALUES (38, 'Holidays', 30)
    INTO category (category_id, name, parent_id) VALUES (40, 'General', 39)
    INTO category (category_id, name, parent_id) VALUES (41, 'Babies', 39)
    INTO category (category_id, name, parent_id) VALUES (42, 'Kids', 39)
    INTO category (category_id, name, parent_id) VALUES (44, 'Art', 43)
    INTO category (category_id, name, parent_id) VALUES (45, 'Photography', 43)
    INTO category (category_id, name, parent_id) VALUES (46, 'HDR', 43)
    INTO category (category_id, name, parent_id) VALUES (47, 'Black & White', 43)
    INTO category (category_id, name, parent_id) VALUES (48, 'Minimalism', 43)
    INTO category (category_id, name, parent_id) VALUES (49, 'Abstract', 43)
    INTO category (category_id, name, parent_id) VALUES (50, 'Instagram', 43)
    INTO category (category_id, name, parent_id) VALUES (52, 'Architecture', 51)
    INTO category (category_id, name, parent_id) VALUES (53, 'Street Art', 51)
    INTO category (category_id, name, parent_id) VALUES (54, 'VSCO', 51)
    INTO category (category_id, name, parent_id) VALUES (55, 'VSCO 2', 51)
    INTO category (category_id, name, parent_id) VALUES (57, 'General', 56)
    INTO category (category_id, name, parent_id) VALUES (58, 'Dessert', 56)
    INTO category (category_id, name, parent_id) VALUES (59, 'Drinks', 56)
    INTO category (category_id, name, parent_id) VALUES (60, 'Coffee', 56)
    INTO category (category_id, name, parent_id) VALUES (61, 'Tea', 56)
    INTO category (category_id, name, parent_id) VALUES (63, 'Fashion', 62)
    INTO category (category_id, name, parent_id) VALUES (64, 'Fashion (Girls)', 62)
    INTO category (category_id, name, parent_id) VALUES (65, 'Fashion (Guys)', 62)
    INTO category (category_id, name, parent_id) VALUES (66, 'OOTD / Outfit Of The Day', 62)
    INTO category (category_id, name, parent_id) VALUES (67, 'Nails', 62)
    INTO category (category_id, name, parent_id) VALUES (68, 'Hair', 62)
    INTO category (category_id, name, parent_id) VALUES (69, 'Makeup', 62)
    INTO category (category_id, name, parent_id) VALUES (70, 'Jewelry', 62)
    INTO category (category_id, name, parent_id) VALUES (71, 'Bracelets', 62)
    INTO category (category_id, name, parent_id) VALUES (72, 'Earrings', 62)
    INTO category (category_id, name, parent_id) VALUES (73, 'High Heels', 62)
    INTO category (category_id, name, parent_id) VALUES (74, 'Sneakers', 62)
    INTO category (category_id, name, parent_id) VALUES (75, 'Tattoos', 62)
    INTO category (category_id, name, parent_id) VALUES (76, 'Piercings', 62)
    INTO category (category_id, name, parent_id) VALUES (78, 'One Direction', 77)
    INTO category (category_id, name, parent_id) VALUES (79, 'Justin Bieber', 77)
    INTO category (category_id, name, parent_id) VALUES (80, 'Taylor Swift', 77)
    INTO category (category_id, name, parent_id) VALUES (81, 'Katy Perry', 77)
    INTO category (category_id, name, parent_id) VALUES (82, 'Liam Payne', 77)
    INTO category (category_id, name, parent_id) VALUES (83, 'Niall Horan', 77)
    INTO category (category_id, name, parent_id) VALUES (84, 'Louis Tomlinson', 77)
    INTO category (category_id, name, parent_id) VALUES (85, 'Zayn Malik', 77)
    INTO category (category_id, name, parent_id) VALUES (86, 'Harry Styles', 77)
    INTO category (category_id, name, parent_id) VALUES (87, 'Lil Wayne', 77)
    INTO category (category_id, name, parent_id) VALUES (88, 'Drake', 77)
    INTO category (category_id, name, parent_id) VALUES (89, 'Selena Gomez', 77)
    INTO category (category_id, name, parent_id) VALUES (90, 'Miley Cyrus', 77)
    INTO category (category_id, name, parent_id) VALUES (91, 'Demi Lovato', 77)
    INTO category (category_id, name, parent_id) VALUES (92, 'Ariana Grande', 77)
    INTO category (category_id, name, parent_id) VALUES (93, 'Chris Brown', 77)
    INTO category (category_id, name, parent_id) VALUES (94, 'Rihanna', 77)
    INTO category (category_id, name, parent_id) VALUES (95, 'Austin Mahone', 77)
    INTO category (category_id, name, parent_id) VALUES (96, '5 Seconds of Summer', 77)
    INTO category (category_id, name, parent_id) VALUES (98, 'Music', 97)
    INTO category (category_id, name, parent_id) VALUES (99, 'Movies', 97)
    INTO category (category_id, name, parent_id) VALUES (100, 'Books', 97)
    INTO category (category_id, name, parent_id) VALUES (101, 'Video Games', 97)
    INTO category (category_id, name, parent_id) VALUES (103, 'General', 102)
    INTO category (category_id, name, parent_id) VALUES (104, 'iPhone', 102)
    INTO category (category_id, name, parent_id) VALUES (105, 'Android', 102)
    INTO category (category_id, name, parent_id) VALUES (107, 'FSLC (Follow / Shoutout / Like / Comment)', 106)
    INTO category (category_id, name, parent_id) VALUES (108, 'Follow', 106)
    INTO category (category_id, name, parent_id) VALUES (109, 'Shoutout', 106)
    INTO category (category_id, name, parent_id) VALUES (110, 'Like', 106)
    INTO category (category_id, name, parent_id) VALUES (111, 'Comment', 106)
    INTO category (category_id, name, parent_id) VALUES (113, 'Travel', 112)
    INTO category (category_id, name, parent_id) VALUES (114, 'Cars', 112)
    INTO category (category_id, name, parent_id) VALUES (115, 'Motorcycles', 112)
    INTO category (category_id, name, parent_id) VALUES (116, 'Skateboarding', 112)
    INTO category (category_id, name, parent_id) VALUES (117, 'Health / Fitness', 112)
    INTO category (category_id, name, parent_id) VALUES (118, 'Bodybuilding', 112)
    INTO category (category_id, name, parent_id) VALUES (119, 'Sports', 112)
    INTO category (category_id, name, parent_id) VALUES (120, 'Running', 112)
    INTO category (category_id, name, parent_id) VALUES (121, 'Dance', 112)
    INTO category (category_id, name, parent_id) VALUES (122, 'Cheerleading', 112)
    INTO category (category_id, name, parent_id) VALUES (123, 'Gymnastics', 112)
    INTO category (category_id, name, parent_id) VALUES (124, 'Basketball', 112)
    INTO category (category_id, name, parent_id) VALUES (125, 'Soccer', 112)
    INTO category (category_id, name, parent_id) VALUES (126, 'Football', 112)
    INTO category (category_id, name, parent_id) VALUES (127, 'Baseball', 112)
    INTO category (category_id, name, parent_id) VALUES (128, 'Hockey', 112)
    INTO category (category_id, name, parent_id) VALUES (129, 'Super Bowl 2014', 112)
    INTO category (category_id, name, parent_id) VALUES (130, 'Seattle Seahawks', 112)
    INTO category (category_id, name, parent_id) VALUES (131, 'Denver Broncos', 112)
    INTO category (category_id, name, parent_id) VALUES (132, 'San Francisco 49ers', 112)
    INTO category (category_id, name, parent_id) VALUES (133, 'Baltimore Ravens', 112) 
    INTO tags (tag_id, name, category_id) VALUES (0, 'nature', 1)
    INTO tags (tag_id, name, category_id) VALUES (1, 'TagsForLikes.com', 1)
    INTO tags (tag_id, name, category_id) VALUES (2, 'TagsForLikesApp', 1)
    INTO tags (tag_id, name, category_id) VALUES (3, 'sky', 1)
    INTO tags (tag_id, name, category_id) VALUES (4, 'sun', 1)
    INTO tags (tag_id, name, category_id) VALUES (5, 'summer', 1)
    INTO tags (tag_id, name, category_id) VALUES (6, 'beach', 2)
    INTO tags (tag_id, name, category_id) VALUES (7, 'sunset', 3)
    INTO tags (tag_id, name, category_id) VALUES (8, 'flowers', 4)
    INTO tags (tag_id, name, category_id) VALUES (9, 'sun', 6)
    INTO tags (tag_id, name, category_id) VALUES (10, 'clouds', 7)
    INTO tags (tag_id, name, category_id) VALUES (11, 'rain', 8)
    INTO tags (tag_id, name, category_id) VALUES (12, 'snow', 9)
    INTO tags (tag_id, name, category_id) VALUES (13, 'spring', 10)
    INTO tags (tag_id, name, category_id) VALUES (14, 'summer', 11)
    INTO tags (tag_id, name, category_id) VALUES (15, 'fall', 12)
    INTO tags (tag_id, name, category_id) VALUES (16, 'winter', 13)
    INTO tags (tag_id, name, category_id) VALUES (17, 'animals', 15)
    INTO tags (tag_id, name, category_id) VALUES (18, 'dog', 16)
    INTO tags (tag_id, name, category_id) VALUES (19, 'cat', 17)
    INTO tags (tag_id, name, category_id) VALUES (20, 'horses', 18)
    INTO tags (tag_id, name, category_id) VALUES (21, 'insects', 19)
    INTO tags (tag_id, name, category_id) VALUES (22, 'fish', 20)
    INTO tags (tag_id, name, category_id) VALUES (23, 'love', 22)
    INTO tags (tag_id, name, category_id) VALUES (24, 'selfie', 23)
    INTO tags (tag_id, name, category_id) VALUES (25, 'girl', 24)
    INTO tags (tag_id, name, category_id) VALUES (26, 'guys', 25)
    INTO tags (tag_id, name, category_id) VALUES (27, 'love', 26)
    INTO tags (tag_id, name, category_id) VALUES (28, 'friend', 27)
    INTO tags (tag_id, name, category_id) VALUES (29, 'goodmorning', 28)
    INTO tags (tag_id, name, category_id) VALUES (30, 'goodnight', 29)
    INTO tags (tag_id, name, category_id) VALUES (31, 'party', 31)
    INTO tags (tag_id, name, category_id) VALUES (32, 'birthday', 32)
    INTO tags (tag_id, name, category_id) VALUES (33, 'wedding', 33)
    INTO tags (tag_id, name, category_id) VALUES (34, 'thanksgiving', 34)
    INTO tags (tag_id, name, category_id) VALUES (35, 'halloween', 35)
    INTO tags (tag_id, name, category_id) VALUES (36, 'christmas', 36)
    INTO tags (tag_id, name, category_id) VALUES (37, 'happynewyear', 37)
    INTO tags (tag_id, name, category_id) VALUES (38, 'happyholidays', 38)
    INTO tags (tag_id, name, category_id) VALUES (39, 'family', 40)
    INTO tags (tag_id, name, category_id) VALUES (40, 'baby', 41)
    INTO tags (tag_id, name, category_id) VALUES (41, 'kids', 42)
    INTO tags (tag_id, name, category_id) VALUES (42, 'art', 44)
    INTO tags (tag_id, name, category_id) VALUES (43, 'photo', 45)
    INTO tags (tag_id, name, category_id) VALUES (44, 'hdr', 46)
    INTO tags (tag_id, name, category_id) VALUES (45, 'blackandwhite', 47)
    INTO tags (tag_id, name, category_id) VALUES (46, 'minimalism', 48)
    INTO tags (tag_id, name, category_id) VALUES (47, 'abstract', 49)
    INTO tags (tag_id, name, category_id) VALUES (48, 'instagrammers', 50)
    INTO tags (tag_id, name, category_id) VALUES (49, 'architecture', 52)
    INTO tags (tag_id, name, category_id) VALUES (50, 'streetart', 53)
    INTO tags (tag_id, name, category_id) VALUES (51, 'vsco', 54)
    INTO tags (tag_id, name, category_id) VALUES (52, 'vscoeurope', 55)
    INTO tags (tag_id, name, category_id) VALUES (53, 'food', 57)
    INTO tags (tag_id, name, category_id) VALUES (54, 'dessert', 58)
    INTO tags (tag_id, name, category_id) VALUES (55, 'drink', 59)
    INTO tags (tag_id, name, category_id) VALUES (56, 'coffee', 60)
    INTO tags (tag_id, name, category_id) VALUES (57, 'tea', 61)
    INTO tags (tag_id, name, category_id) VALUES (58, 'fashion', 63)
    INTO tags (tag_id, name, category_id) VALUES (59, 'fashion', 64)
    INTO tags (tag_id, name, category_id) VALUES (60, 'fashion', 65)
    INTO tags (tag_id, name, category_id) VALUES (61, 'ootd', 66)
    INTO tags (tag_id, name, category_id) VALUES (62, 'nails', 67)
    INTO tags (tag_id, name, category_id) VALUES (63, 'hair', 68)
    INTO tags (tag_id, name, category_id) VALUES (64, 'makeup', 69)
    INTO tags (tag_id, name, category_id) VALUES (65, 'jewelry', 70)
    INTO tags (tag_id, name, category_id) VALUES (66, 'bracelets', 71)
    INTO tags (tag_id, name, category_id) VALUES (67, 'earrings', 72)
    INTO tags (tag_id, name, category_id) VALUES (68, 'highheels', 73)
    INTO tags (tag_id, name, category_id) VALUES (69, 'shoes', 74)
    INTO tags (tag_id, name, category_id) VALUES (70, 'tattoo', 75)
    INTO tags (tag_id, name, category_id) VALUES (71, 'piercing', 76)
    INTO tags (tag_id, name, category_id) VALUES (72, 'onedirection', 78)
    INTO tags (tag_id, name, category_id) VALUES (73, 'justin', 79)
    INTO tags (tag_id, name, category_id) VALUES (74, 'taylor', 80)
    INTO tags (tag_id, name, category_id) VALUES (75, 'katy', 81)
    INTO tags (tag_id, name, category_id) VALUES (76, 'liampayne', 82)
    INTO tags (tag_id, name, category_id) VALUES (77, 'niallhoran', 83)
    INTO tags (tag_id, name, category_id) VALUES (78, 'louistomlinson', 84)
    INTO tags (tag_id, name, category_id) VALUES (79, 'zaynmalik', 85)
    INTO tags (tag_id, name, category_id) VALUES (80, 'harrystyles', 86)
    INTO tags (tag_id, name, category_id) VALUES (81, 'lilwayne', 87)
    INTO tags (tag_id, name, category_id) VALUES (82, 'drake', 88)
    INTO tags (tag_id, name, category_id) VALUES (83, 'selenagomez', 89)
    INTO tags (tag_id, name, category_id) VALUES (84, 'mileycyrus', 90)
    INTO tags (tag_id, name, category_id) VALUES (85, 'demilovato', 91)
    INTO tags (tag_id, name, category_id) VALUES (86, 'ariana', 92)
    INTO tags (tag_id, name, category_id) VALUES (87, 'chrisbrown', 93)
    INTO tags (tag_id, name, category_id) VALUES (88, 'rihanna', 94)
    INTO tags (tag_id, name, category_id) VALUES (89, 'austin', 95)
    INTO tags (tag_id, name, category_id) VALUES (90, '5sos', 96)
    INTO tags (tag_id, name, category_id) VALUES (91, 'music', 98)
    INTO tags (tag_id, name, category_id) VALUES (92, 'movies', 99)
    INTO tags (tag_id, name, category_id) VALUES (93, 'books', 100)
    INTO tags (tag_id, name, category_id) VALUES (94, 'videogames', 101)
    INTO tags (tag_id, name, category_id) VALUES (95, 'electronics', 103)
    INTO tags (tag_id, name, category_id) VALUES (96, 'iphone', 104)
    INTO tags (tag_id, name, category_id) VALUES (97, 'android', 105)
    INTO tags (tag_id, name, category_id) VALUES (98, 'fslc', 107)
    INTO tags (tag_id, name, category_id) VALUES (99, 'follow', 108)
    INTO tags (tag_id, name, category_id) VALUES (100, 'shoutout', 109)
    INTO tags (tag_id, name, category_id) VALUES (101, 'followme', 110)
    INTO tags (tag_id, name, category_id) VALUES (102, 'comment', 111)
    INTO tags (tag_id, name, category_id) VALUES (103, 'travel', 113)
    INTO tags (tag_id, name, category_id) VALUES (104, 'cars', 114)
    INTO tags (tag_id, name, category_id) VALUES (105, 'motorcycle', 115)
    INTO tags (tag_id, name, category_id) VALUES (106, 'skateboarding', 116)
    INTO tags (tag_id, name, category_id) VALUES (107, 'health', 117)
    INTO tags (tag_id, name, category_id) VALUES (108, 'instafit', 118)
    INTO tags (tag_id, name, category_id) VALUES (109, 'sports', 119)
    INTO tags (tag_id, name, category_id) VALUES (110, 'run', 120)
    INTO tags (tag_id, name, category_id) VALUES (111, 'dance', 121)
    INTO tags (tag_id, name, category_id) VALUES (112, 'cheer', 122)
    INTO tags (tag_id, name, category_id) VALUES (113, 'gymnastics', 123)
    INTO tags (tag_id, name, category_id) VALUES (114, 'basketball', 124)
    INTO tags (tag_id, name, category_id) VALUES (115, 'soccer', 125)
    INTO tags (tag_id, name, category_id) VALUES (116, 'football', 126)
    INTO tags (tag_id, name, category_id) VALUES (117, 'baseball', 127)
    INTO tags (tag_id, name, category_id) VALUES (118, 'hockey', 128)
    INTO tags (tag_id, name, category_id) VALUES (119, 'superbowl', 129)
    INTO tags (tag_id, name, category_id) VALUES (120, 'seahawks', 130)
    INTO tags (tag_id, name, category_id) VALUES (121, 'broncos', 131)
    INTO tags (tag_id, name, category_id) VALUES (122, '49ers', 132)
    INTO tags (tag_id, name, category_id) VALUES (123, 'ravens', 133)
  SELECT * FROM dual;
  
  /* user generator */
   names := userarray('111111','123456','12345678','abc123','abramov','account','accounting','ad','adm','admin','administrator','adver','advert','advertising','afanasev','agafonov','agata','aksenov','aleksander','aleksandrov','alekse','alenka','alexe','alexeev','alla','anatol','andre','andreev','andrey','anna','anya','ao','aozt','arhipov','art','avdeev','avto','bank','baranov','Baseball','belousov','bill','billing','blinov','bobrov','bogdanov','buh','buhg','buhgalter','buhgalteria','business','bux','catchthismail','company','contact','contactus','corp','design','dir','director','direktor','dragon','economist','edu','email','er','expert','export','fabrika','fin','finance','ftp','glavbuh','glavbux','glbuh','helloitmenice','help','holding','home','hr','iamjustsendingthisleter','info','ingthisleter','job','john','kadry','letmein','mail','manager','marketing','marketing','mike','mogggnomgon','monkey','moscow','mysql','office','ok','oracle','password','personal','petgord34truew','post','postmaster','pr','qwerty','rbury','reklama','root','root','sale','sales','secretar','sekretar','support','test','testing','thisisjusttestletter','trade','uploader','user','webmaster','www-data');
   total := names.count;
   FOR i in 1 .. total LOOP
    INSERT INTO users VALUES(i,names(i),'12345',names(i),names(i));
   END LOOP;
   
   /* video and comment generator */
   total := 123;
   FOR i in 0 .. 123 LOOP
    INSERT INTO videos VALUES (i,'namne','DESCRIPTION',(i*50), (SELECT DATE),'video',i,i);
    INSERT INTO comments VALUES (i,'COMMENT FOR VIDEO', total,i);
    INSERT INTO videotags VALUES ((SELECT tag_id FROM tags WHERE category_id == i),i);
    total := (total-1);
   END LOOP;
   
   /* WATCHED */
   FOR i in 0 .. 80 LOOP
    FOR x in 0 .. 25 LOOP
      INSERT INTO watched VALUES (x,i);
    END LOOP;
   END LOOP;
   
   /* PLAYLIST */
   FOR i in 0 .. 50 LOOP
    INSERT INTO playlist VALUES (i,'PLAYLIST1',i);
   END LOOP;
   
   FOR i in 0 .. 25 LOOP
    FOR x in 0 .. 50 LOOP
      INSERT INTO playlistvideo VALUES (i,x);
    END LOOP;
   END LOOP;
  
END;
