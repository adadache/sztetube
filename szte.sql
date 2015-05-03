/* 
* Table creator 
*
*
* http://www.tagsforlikes.com/
$('.tags:nth-of-type(7) .row').first().remove();
$('.tags:nth-of-type(7) .row').last().remove();
$('h6').remove();
$('br').remove();
var tags = [];
$('h3 a').each(function(){
	var category = $(this).text();
	category = category.replace("►  ", "");
	if (category !== ''){
		var subCat = [];
		$(this).parents('.aisle').find('h4').each(function(){
			var name = $(this).text();
			var tags = $(this).next().text();
			tags = tags.replace("#", "");
			tags = tags.split(" ");
			subCat[name] = tags;
		});
		tags[category] = subCat;

	}
	
});
*/

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
  TYPE tagsarray IS VARRAY(1200) OF VARCHAR2(200);
  TYPE userarray IS VARRAY(150) OF VARCHAR2(200);
  tags tagsarray;
  
  total integer;
BEGIN
  /* Tags upload */
   tags := tagsarray('love', 'TagsForLikes', 'TagsForLikesApp', 'TFLers', 'tweegram', 'photooftheday', '20likes', 'amazing', 'smile', 'follow4follow', 'like4like', 'look', 'instalike', 'igers', 'picoftheday', 'food', 'instadaily', 'instafollow', 'followme', 'girl', 'iphoneonly', 'instagood', 'bestoftheday', 'instacool', 'instago', 'all_shots', 'follow', 'webstagram', 'colorful', 'style', 'swag', 'fun', 'instagramers', 'TagsForLikes', 'TagsForLikesApp', 'food', 'smile', 'pretty', 'followme', 'nature', 'lol', 'dog', 'hair', 'onedirection', 'sunset', 'swag', 'throwbackthursday', 'instagood', 'beach', 'statigram', 'friends', 'hot', 'funny', 'blue', 'life', 'art', 'instahub', 'photo', 'cool', 'pink', 'bestoftheday', 'clouds', 'amazing', 'TagsForLikes', 'TagsForLikesApp', 'followme', 'all_shots', 'textgram', 'family', 'instago', 'igaddict', 'awesome', 'girls', 'instagood', 'my', 'bored', 'baby', 'music', 'red', 'green', 'water', 'harrystyles', 'bestoftheday', 'black', 'party', 'white', 'yum', 'flower', '2012', 'night', 'instalove', 'niallhoran', 'jj_forum', 'nature', 'TagsForLikes', 'TagsForLikesApp', 'sky', 'sun', 'summer', 'beach', 'beautiful', 'pretty', 'sunset', 'sunrise', 'blue', 'flowers', 'night', 'tree', 'twilight', 'clouds', 'beauty', 'light', 'cloudporn', 'photooftheday', 'love', 'green', 'skylovers', 'dusk', 'weather', 'day', 'red', 'iphonesia', 'mothernature', 'beach', 'sun', 'nature', 'water', 'TagsForLikes', 'TagsForLikesApp', 'TFLers', 'ocean', 'lake', 'instagood', 'photooftheday', 'beautiful', 'sky', 'clouds', 'cloudporn', 'fun', 'pretty', 'sand', 'reflection', 'amazing', 'beauty', 'beautiful', 'shore', 'waterfoam', 'seashore', 'waves', 'wave', 'sunset', 'sunrise', 'sun', 'TagsForLikes', 'TagsForLikesApp', 'TFLers', 'pretty', 'beautiful', 'red', 'orange', 'pink', 'sky', 'skyporn', 'cloudporn', 'nature', 'clouds', 'horizon', 'photooftheday', 'instagood', 'gorgeous', 'warm', 'view', 'night', 'morning', 'silhouette', 'instasky', 'all_sunsets', 'flowers', 'flower', 'TagsForLikes', 'petal', 'petals', 'nature', 'beautiful', 'love', 'pretty', 'plants', 'blossom', 'sopretty', 'spring', 'summer', 'flowerstagram', 'flowersofinstagram', 'flowerstyles_gf', 'flowerslovers', 'flowerporn', 'botanical', 'floral', 'florals', 'insta_pick_blossom', 'flowermagic', 'instablooms', 'bloom', 'blooms', 'botanical', 'floweroftheday', 'sun', 'sunny', 'sunnyday', 'TagsForLikes', 'TagsForLikesApp', 'sunnydays', 'sunlight', 'light', 'sunshine', 'shine', 'nature', 'sky', 'skywatcher', 'thesun', 'sunrays', 'photooftheday', 'beautiful', 'beautifulday', 'weather', 'summer', 'goodday', 'goodweather', 'instasunny', 'instasun', 'instagood', 'clearskies', 'clearsky', 'blueskies', 'lookup', 'bright', 'brightsun', 'clouds', 'cloud', 'cloudporn', 'TagsForLikes', 'TagsForLikesApp', 'weather', 'lookup', 'sky', 'skies', 'skyporn', 'cloudy', 'instacloud', 'instaclouds', 'instagood', 'nature', 'beautiful', 'gloomy', 'skyline', 'horizon', 'overcast', 'instasky', 'epicsky', 'crazyclouds', 'photooftheday', 'cloud_skye', 'skyback', 'insta_sky_lovers', 'iskyhub', 'rain', 'raining', 'rainyday', 'TagsForLikes', 'TagsForLikesApp', 'pouring', 'rainydays', 'water', 'clouds', 'cloudy', 'photooftheday', 'puddle', 'umbrella', 'instagood', 'gloomy', 'rainyweather', 'rainydayz', 'splash', 'TFLers', 'downpour', 'instarain', 'snow', 'snowing', 'winter', 'TagsForLikes', 'cold', 'ice', 'white', 'weather', 'sky', 'skies', 'frosty', 'frost', 'chilly', 'TFLers', 'nature', 'snowflakes', 'instagood', 'instawinter', 'instasnow', 'photooftheday', 'snowfall', 'blizzard', 'spring', 'blossom', 'flowers', 'TagsForLikes', 'beautiful', 'season', 'seasons', 'instaspring', 'instagood', 'springtime', 'color', 'ilovespring', 'warm', 'sunny', 'sun', 'tree', 'pretty', 'TFLers', 'trees', 'flower', 'bloom', 'colorful', 'summer', 'summertime', 'sun', 'TagsForLikes', 'hot', 'sunny', 'warm', 'fun', 'beautiful', 'sky', 'clearskys', 'season', 'seasons', 'instagood', 'instasummer', 'photooftheday', 'nature', 'TFLers', 'clearsky', 'bluesky', 'vacationtime', 'weather', 'summerweather', 'sunshine', 'summertimeshine', 'fall', 'autumn', 'leaves', 'TagsForLikes', 'falltime', 'season', 'seasons', 'instafall', 'instagood', 'TFLers', 'instaautumn', 'photooftheday', 'leaf', 'foliage', 'colorful', 'orange', 'red', 'autumnweather', 'fallweather', 'nature', 'winter', 'cold', 'holidays', 'TagsForLikes', 'TagsForLikesApp', 'snow', 'rain', 'christmas', 'snowing', 'blizzard', 'snowflakes', 'wintertime', 'staywarm', 'cloudy', 'instawinter', 'instagood', 'holidayseason', 'photooftheday', 'season', 'seasons', 'nature', 'animals', 'animal', 'pet', 'TagsForLikes', 'TagsForLikesApp', 'dog', 'cat', 'dogs', 'cats', 'photooftheday', 'cute', 'pets', 'instagood', 'animales', 'cute', 'love', 'nature', 'animallovers', 'pets_of_instagram', 'petstagram', 'petsagram', 'dog', 'dog', 'puppy', 'pup', 'TagsForLikes', 'TagsForLikesApp', 'cute', 'eyes', 'instagood', 'dogs_of_instagram', 'pet', 'pets', 'animal', 'animals', 'petstagram', 'petsagram', 'dogsitting', 'photooftheday', 'dogsofinstagram', 'ilovemydog', 'instagramdogs', 'nature', 'dogstagram', 'dogoftheday', 'lovedogs', 'lovepuppies', 'hound', 'adorable', 'doglover', 'instapuppy', 'instadog', 'cat', 'cats', 'TagsForLikes', 'TagsForLikesApp', 'catsagram', 'catstagram', 'instagood', 'kitten', 'kitty', 'kittens', 'pet', 'pets', 'animal', 'animals', 'petstagram', 'petsagram', 'photooftheday', 'catsofinstagram', 'ilovemycat', 'instagramcats', 'nature', 'catoftheday', 'lovecats', 'furry', 'sleeping', 'lovekittens', 'adorable', 'catlover', 'instacat', 'horses', 'horse', 'horsesofinstagram', 'TagsForLikes', 'TagsForLikesApp', 'horseshow', 'horseshoe', 'horses_of_instagram', 'horsestagram', 'instahorses', 'wild', 'mane', 'instagood', 'grass', 'field', 'farm', 'nature', 'pony', 'ponies', 'ilovemyhorse', 'babyhorse', 'beautiful', 'pretty', 'photooftheday', 'gallop', 'jockey', 'rider', 'riders', 'riding', 'insects', 'insect', 'bug', 'bugs', 'TagsForLikes', 'TagsForLikesApp', 'bugslife', 'macro', 'closeup', 'nature', 'animals', 'animals', 'instanature', 'instagood', 'macrogardener', 'macrophotography', 'creature', 'creatures', 'macro_creature_feature', 'photooftheday', 'wildlife', 'nature_shooters', 'earth', 'naturelover', 'lovenature', 'fish', 'aquarium', 'fishtank', 'TagsForLikes', 'TagsForLikesApp', 'fishporn', 'instafish', 'instagood', 'swim', 'swimming', 'water', 'coral', 'reef', 'reeftank', 'tropical', 'tropicalfish', 'aquaria', 'photooftheday', 'saltwater', 'freshwater', 'beautiful', 'ocean', 'watertank', 'love', 'TagsForLikes', 'TagsForLikesApp', 'photooftheday', 'me', 'instamood', 'cute', 'igers', 'picoftheday', 'girl', 'guy', 'beautiful', 'fashion', 'instagramers', 'follow', 'smile', 'pretty', 'followme', 'friends', 'hair', 'swag', 'photo', 'life', 'funny', 'cool', 'hot', 'bored', 'portrait', 'baby', 'girls', 'iphonesia', 'selfie', 'selfienation', 'selfies', 'TagsForLikes', 'TFLers', 'TagsForLikesApp', 'me', 'love', 'pretty', 'handsome', 'instagood', 'instaselfie', 'selfietime', 'face', 'shamelessselefie', 'life', 'hair', 'portrait', 'igers', 'fun', 'followme', 'instalove', 'smile', 'igdaily', 'eyes', 'follow', 'girl', 'girls', 'love', 'TagsForLikes', 'TFLers', 'me', 'cute', 'picoftheday', 'beautiful', 'photooftheday', 'instagood', 'fun', 'smile', 'pretty', 'follow', 'followme', 'hair', 'friends', 'lady', 'swag', 'hot', 'cool', 'kik', 'fashion', 'igers', 'instagramers', 'style', 'sweet', 'eyes', 'beauty', 'guys', 'guy', 'boy', 'TagsForLikes', 'TFLers', 'boys');   
   total := tags.count;
   FOR i in 1 .. total LOOP
    INSERT INTO tags VALUES(i,tags(i));
   END LOOP;
   
   names := userarray('111111','123456','12345678','abc123','abramov','account','accounting','ad','adm','admin','administrator','adver','advert','advertising','afanasev','agafonov','agata','aksenov','aleksander','aleksandrov','alekse','alenka','alexe','alexeev','alla','anatol','andre','andreev','andrey','anna','anya','ao','aozt','arhipov','art','avdeev','avto','bank','baranov','Baseball','belousov','bill','billing','blinov','bobrov','bogdanov','buh','buhg','buhgalter','buhgalteria','business','bux','catchthismail','company','contact','contactus','corp','design','dir','director','direktor','dragon','economist','edu','email','er','expert','export','fabrika','fin','finance','ftp','glavbuh','glavbux','glbuh','helloitmenice','help','holding','home','hr','iamjustsendingthisleter','info','ingthisleter','job','john','kadry','letmein','mail','manager','marketing','marketing','mike','mogggnomgon','monkey','moscow','mysql','office','ok','oracle','password','personal','petgord34truew','post','postmaster','pr','qwerty','rbury','reklama','root','root','sale','sales','secretar','sekretar','support','test','testing','thisisjusttestletter','trade','uploader','user','webmaster','www-data');
   total := names.count;
      FOR i in 1 .. total LOOP
    INSERT INTO names VALUES(i,names(i),'12345',names(i),names(i));
   END LOOP;
END;
