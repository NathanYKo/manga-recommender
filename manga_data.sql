--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Postgres.app)
-- Dumped by pg_dump version 16.2 (Postgres.app)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: genres; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.genres (
    genre_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.genres OWNER TO neondb_owner;

--
-- Name: manga; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.manga (
    manga_id integer NOT NULL,
    title character varying(255) NOT NULL,
    title_english character varying(255),
    title_japanese character varying(255),
    synopsis text,
    image_url character varying(255),
    score numeric(3,2),
    scored_by integer,
    rank integer,
    popularity integer,
    status character varying(50),
    publishing boolean,
    published_from timestamp with time zone,
    published_to timestamp with time zone,
    chapters integer,
    volumes integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.manga OWNER TO neondb_owner;

--
-- Name: manga_genres; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.manga_genres (
    manga_id integer NOT NULL,
    genre_id integer NOT NULL
);


ALTER TABLE public.manga_genres OWNER TO neondb_owner;

--
-- Name: user_ratings; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.user_ratings (
    user_id integer NOT NULL,
    manga_id integer NOT NULL,
    rating integer NOT NULL,
    review text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_ratings_rating_check CHECK (((rating >= 1) AND (rating <= 10)))
);


ALTER TABLE public.user_ratings OWNER TO neondb_owner;

--
-- Name: users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO neondb_owner;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO neondb_owner;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.genres (genre_id, name) FROM stdin;
8	Drama
37	Supernatural
26	Girls Love
10	Fantasy
46	Award Winning
24	Sci-Fi
45	Suspense
36	Slice of Life
7	Mystery
28	Boys Love
30	Sports
22	Romance
47	Gourmet
14	Horror
4	Comedy
1	Action
2	Adventure
9	Ecchi
49	Erotica
\.


--
-- Data for Name: manga; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.manga (manga_id, title, title_english, title_japanese, synopsis, image_url, score, scored_by, rank, popularity, status, publishing, published_from, published_to, chapters, volumes, created_at, updated_at) FROM stdin;
1	Monster	Monster	MONSTER	Kenzou Tenma, a renowned Japanese neurosurgeon working in post-war Germany, faces a difficult choice: to operate on Johan Liebert, an orphan boy on the verge of death, or on the mayor of Düsseldorf. In the end, Tenma decides to gamble his reputation by saving Johan, effectively leaving the mayor for dead.\n\nAs a consequence of his actions, hospital director Heinemann strips Tenma of his position, and Heinemann's daughter Eva breaks off their engagement. Disgraced and shunned by his colleagues, Tenma loses all hope of a successful career—that is, until the mysterious killing of Heinemann gives him another chance.\n\nNine years later, Tenma is the head of the surgical department and close to becoming the director himself. Although all seems well for him at first, he soon becomes entangled in a chain of gruesome murders that have taken place throughout Germany. The culprit is a monster—the same one that Tenma saved on that fateful day nine years ago.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/258224l.jpg	9.16	106716	5	28	Finished	f	1994-12-04 16:00:00-08	2001-12-19 16:00:00-08	162	18	2025-02-27 18:13:17.713117-08	2025-02-27 18:13:17.713117-08
2	Berserk	Berserk	ベルセルク	Guts, a former mercenary now known as the Black Swordsman, is out for revenge. After a tumultuous childhood, he finally finds someone he respects and believes he can trust, only to have everything fall apart when this person takes away everything important to Guts for the purpose of fulfilling his own desires. Now marked for death, Guts becomes condemned to a fate in which he is relentlessly pursued by demonic beings.\n\nSetting out on a dreadful quest riddled with misfortune, Guts, armed with a massive sword and monstrous strength, will let nothing stop him, not even death itself, until he is finally able to take the head of the one who stripped him—and his loved one—of their humanity.\n\n[Written by MAL Rewrite]\n\nIncluded one-shot:\nVolume 14: Berserk: The Prototype	https://cdn.myanimelist.net/images/manga/1/157897l.jpg	9.47	370770	1	1	Publishing	t	1989-08-24 17:00:00-07	\N	\N	\N	2025-02-27 18:13:17.772889-08	2025-02-27 18:13:17.772889-08
3	20th Century Boys	20th Century Boys	20世紀少年	As the 20th century approaches its end, people all over the world are anxious that the world is changing. And probably not for the better.\n\nKenji Endo is a normal convenience store manager who's just trying to get by. But when he learns that one of his old friends going by the name "Donkey" has suddenly committed suicide, and that a new cult led by a figure known as "Friend" is becoming more notorious, Kenji starts to feel that something isn't right. With a few key clues left behind by his deceased friend, Kenji realizes that this cult is much more than he ever thought it would be—not only is this mysterious organization directly targeting him and his childhood friends, but the whole world also faces a grave danger that only the friends have the key to stop.\n\nKenji's simple life of barely making ends meet is flipped upside down when he reunites with his childhood friends, and together they must figure out the truth of how their past is connected to the cult, as the turn of the century could mean the possible end of the world.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/5/260006l.jpg	8.94	99527	17	25	Finished	f	1999-09-26 17:00:00-07	2006-04-23 17:00:00-07	249	22	2025-02-27 18:13:17.889-08	2025-02-27 18:13:17.889-08
4	Yokohama Kaidashi Kikou	Yokohama Kaidashi Kikou	ヨコハマ買い出し紀行	In a post-apocalyptic world where an environmental disaster led to the eruption of Mt. Fuji and the inundation of Yokohama, the age of humans is in its twilight. Alpha Hatsuseno is an android and the namesake of a small cafe outside Yokohama. As her owner is away on a trip indefinitely, she has been left responsible for running the cafe. Although she rarely gets any customers, Alpha remains outgoing and cheerful.\n\nWhile Alpha awaits her owner's homecoming, she explores the vicinity with her scooter and camera. Throughout her journeys, she meets new people and other androids, making memories along the way.\n\nYokohama Kaidashi Kikou is a beautiful, laid-back story centered around Alpha's daily activities, emphasizing the passing of time in everyday life.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/171813l.jpg	8.65	19942	74	207	Finished	f	1994-04-24 17:00:00-07	2006-02-24 16:00:00-08	142	14	2025-02-27 18:13:17.99232-08	2025-02-27 18:13:17.99232-08
7	Hajime no Ippo	Hajime no Ippo: Fighting Spirit!	はじめの一歩	Makunouchi Ippo is a 16-year-old high school student who helps his mother run the family business. His hefty workload impedes his social life, making him an easy target for bullies. One day, while being beaten up by a group of high school students, Ippo is saved by a boxer named Mamoru Takamura, and is brought to the Kamogawa Boxing Gym.\n\nThis afterschool bullying session turns his life around for the better, as Ippo discovers his latent talent for boxing and decides to practice the sport professionally. However, Mamoru doubts Ippo's determination and assigns him a task deemed impossible to complete; but the resolute Ippo trains tirelessly to fulfill his mission. Along the way, he finds out what it means to attain true strength while making new friends and fighting formidable foes.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/250313l.jpg	8.74	39188	51	166	Publishing	t	1989-09-26 17:00:00-07	\N	\N	\N	2025-02-27 18:13:18.064247-08	2025-02-27 18:13:18.064247-08
8	Full Moon wo Sagashite	Full Moon wo Sagashite	満月〈フルムーン〉をさがして	At the tender age of 12, Mitsuki Kouyama has a sarcoma in her throat. Though this rare cancer can be cured by removing her vocal cords, Mitsuki refuses because of her desire to become a pop singer and keep her childhood promise to Eichi Sakurai, her first love who left for America. Unable to both heal and keep her voice, she allows her health to deteriorate, as she accepts her tragic fate.\n\nOne day, while escaping the home of her music-hating grandmother to attend an audition, Mitsuki meets two shinigami, Takuto Kira and Meroko Yui. Realizing that Mitsuki can see them, Takuto and Meroko reveal to her that she will die in a year. Moved by her plight, Takuto allows Mitsuki the chance to pursue her dream by giving her the ability to transform into a healthy sixteen-year-old girl. After being chosen for a contract with Seed Records, Mitsuki makes her debut under the stage name Full Moon and chooses to pursue her dream music career before her life's end.\n\n[Written by MAL Rewrite]\n\n\nIncluded one-shot:\nVolume 2: Ginyuu Meika	https://cdn.myanimelist.net/images/manga/3/175970l.jpg	8.02	19327	723	473	Finished	f	2001-11-30 16:00:00-08	2004-04-29 17:00:00-07	35	7	2025-02-27 18:13:18.119023-08	2025-02-27 18:13:18.119023-08
9	Tsubasa: RESERVoir CHRoNiCLE	Tsubasa: RESERVoir CHRoNiCLE	ツバサ -RESERVoir CHRoNiCLE-	Warmhearted Syaoran has always been friends with Sakura—the princess of the Clow Kingdom who holds an extraordinary power capable of changing the world. When a mysterious man attempts to monopolize Sakura's ability, her memories scatter throughout different worlds in the form of feathers. To save Sakura, Syaoran seeks help from the Dimensional Witch and meets two other travelers—Kurogane and Fai D. Flourite.\n\nKurogane, a capable fighter and ninja, has been banished from his homeworld and wishes to return. In contrast, Fai, a magician from Celes, wants to traverse different worlds to avoid his home and past. As the price to cross dimensions, each of the three must sacrifice their most valued possession. For Sakura's sake, Syaoran agrees to give away their relationship as payment to the Dimensional Witch. With firm determination, Syaoran, Kurogane, and Fai begin journeying through numerous worlds to fight against their ill-fated destinies.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/272410l.jpg	8.29	37634	315	197	Finished	f	2003-05-20 17:00:00-07	2009-10-06 17:00:00-07	233	28	2025-02-27 18:13:18.207577-08	2025-02-27 18:13:18.207577-08
10	xxxHOLiC	xxxHOLiC	xxxHOLiC	Living alone after his parents passed away, Kimihiro Watanuki is a high school student who can see otherworldly creatures that are attracted to him. His days are plagued by these nuisances, and he wishes to rid himself of this inconvenience. One fateful day, as Kimihiro is being chased by a horde of spirits, his feet bring him into a mysterious store to seek shelter. Here he meets Yuuko Ichihara, the mistress of this supposed store, who claims to be able to grant wishes. Yuuko offers to grant Kimihiro's, as long as he pays an appropriate price.\n\nThus begins Kimihiro's time working in her store to earn the payment necessary for his wish. In Yuuko's employ, he must become further involved with spirits and the supernatural before he can leave that world behind. How will he fare in the inexplicable encounters that await him?\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/217533l.jpg	8.37	33208	238	185	Finished	f	2003-02-23 16:00:00-08	2011-02-08 16:00:00-08	213	19	2025-02-27 18:13:18.300587-08	2025-02-27 18:13:18.300587-08
11	Naruto	Naruto	NARUTO―ナルト―	Whenever Naruto Uzumaki proclaims that he will someday become the Hokage—a title bestowed upon the best ninja in the Village Hidden in the Leaves—no one takes him seriously. Since birth, Naruto has been shunned and ridiculed by his fellow villagers. But their contempt isn't because Naruto is loud-mouthed, mischievous, or because of his ineptitude in the ninja arts, but because there is a demon inside him. Prior to Naruto's birth, the powerful and deadly Nine-Tailed Fox attacked the village. In order to stop the rampage, the Fourth Hokage sacrificed his life to seal the demon inside the body of the newborn Naruto.\n\nAnd so when he is assigned to Team 7—along with his new teammates Sasuke Uchiha and Sakura Haruno, under the mentorship of veteran ninja Kakashi Hatake—Naruto is forced to work together with other people for the first time in his life. Through undergoing vigorous training and taking on challenging missions, Naruto must learn what it means to work in a team and carve his own route toward becoming a full-fledged ninja recognized by his village.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/249658l.jpg	8.07	279061	629	12	Finished	f	1999-09-20 17:00:00-07	2014-11-09 16:00:00-08	700	72	2025-02-27 18:13:18.397195-08	2025-02-27 18:13:18.397195-08
12	Bleach	Bleach	BLEACH	For as long as he can remember, high school student Ichigo Kurosaki has been able to see the spirits of the dead, but that has not stopped him from leading an ordinary life. One day, Ichigo returns home to find an intruder in his room who introduces herself as Rukia Kuchiki, a Soul Reaper tasked with helping souls pass over. Suddenly, the two are jolted from their conversation when a Hollow—an evil spirit known for consuming souls—attacks. As Ichigo makes a brash attempt to stop the Hollow, Rukia steps in and shields him from a counterattack. Injured and unable to keep fighting, Rukia suggests a risky plan—transfer half of her Soul Reaper powers to Ichigo. He accepts and, to Rukia's surprise, ends up absorbing her powers entirely, allowing him to easily dispatch the Hollow.\n\nNow a Soul Reaper himself, Ichigo must take up Rukia's duties of exterminating Hollows and protecting spirits, both living and dead. Along with his friends Orihime Inoue and Yasutora Sado—who later discover spiritual abilities of their own—Ichigo soon learns that the consequences of becoming a Soul Reaper and dealing with the world of spirits are far greater than he ever imagined.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/180031l.jpg	7.89	247265	1024	15	Finished	f	2001-08-06 17:00:00-07	2016-08-21 17:00:00-07	705	74	2025-02-27 18:13:18.453753-08	2025-02-27 18:13:18.453753-08
13	One Piece	One Piece	ONE PIECE	Gol D. Roger, a man referred to as the King of the Pirates, is set to be executed by the World Government. But just before his demise, he confirms the existence of a great treasure, One Piece, located somewhere within the vast ocean known as the Grand Line. Announcing that One Piece can be claimed by anyone worthy enough to reach it, the King of the Pirates is executed and the Great Age of Pirates begins.\n\nTwenty-two years later, a young man by the name of Monkey D. Luffy is ready to embark on his own adventure, searching for One Piece and striving to become the new King of the Pirates. Armed with just a straw hat, a small boat, and an elastic body, he sets out on a fantastic journey to gather his own crew and a worthy ship that will take them across the Grand Line to claim the greatest status on the high seas.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/253146l.jpg	9.22	398228	4	4	Publishing	t	1997-07-21 17:00:00-07	\N	\N	\N	2025-02-27 18:13:18.537928-08	2025-02-27 18:13:18.537928-08
14	Rave	Rave Master	RAVE	Fifty years ago, the wielders of the sacred Rave stones fought against an onslaught caused by demon stones called Dark Bring. This war resulted in an explosion known as "Overdrive"—a blast so powerful that it sent the Dark Bring into a deep slumber and scattered the pieces of Rave across the world.\n\nIn the present, Haru Glory lives a peaceful life on Garage Island until one day, he catches the creature Plue while fishing. Plue is later recognized by Shiba Roses, an old man who happens to be the original Rave Master. Shiba explains that the Dark Bring has resurfaced, and that to stop it, assembling the scattered parts of Rave is of utmost urgency. However, before Shiba can leave on this mission, he is attacked by a soldier from the evil organization Demon Card, forcing him to transfer the power of Rave to Haru. With the fate of humankind resting on his shoulders, the new Rave Master begins his quest to find the scattered Rave fragments.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/255624l.jpg	7.84	24064	1182	336	Finished	f	1999-07-06 17:00:00-07	2005-07-26 17:00:00-07	298	35	2025-02-27 18:13:18.599927-08	2025-02-27 18:13:18.599927-08
15	Mahou Sensei Negima!	Negima! Magister Negi Magi	魔法先生ネギま!	Negi Springfield, a 10-year-old wizard who recently graduated from Merdiana Magic Academy in Wales, hopes to achieve two things—to find his missing father, who was once known as the Thousand Master, and to become a Magister Magi, someone who helps the everyday world through magic. To reach his latter goal, he is assigned one last task: to teach English at a middle school in Japan.\n\nMuch to his surprise and dismay, he not only discovers that his homeroom class consists of 31 girls, but also ends up revealing his true identity as a magician to Asuna Kagurazaka, one of his new students. Negi must now negotiate with the girl and face his most difficult challenge yet—to keep his identity a secret as he tackles magical threats both from within and outside of Mahora Academy, all the while keeping a watchful eye out for his lost father.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/259286l.jpg	7.91	36152	965	216	Finished	f	2003-02-25 16:00:00-08	2012-03-13 17:00:00-07	355	38	2025-02-27 18:13:18.674-08	2025-02-27 18:13:18.674-08
55	Aishiteruze Baby★★	Aishiteruze Baby	愛してるぜ ベイベ★★	Kippei Katakura is a high school playboy who fills his days with any girl he can. In reality, he only has eyes for one girl in particular—Kokoro Tokunaga. One day, Kippei's family introduces him to his five-year-old cousin, Yuzuru Sakashita, whose mother has abandoned her. Kippei is assigned the task of being Yuzuru's caregiver until her mother returns, and the young girl quickly grows attached to him.\n\nThrough Yuzuru's influence and the intimate bond that forms between them, Kippei learns not only about childcare, but also about developing meaningful relationships. As Kippei balances his time between Kokoro and Yuzuru, they all grow together and learn more about each other, their feelings, and the true meaning of family.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/166559l.jpg	7.89	12271	1019	849	Finished	f	2002-03-01 16:00:00-08	2004-11-30 16:00:00-08	33	7	2025-02-27 18:13:22.228726-08	2025-02-27 18:13:22.228726-08
16	Love Hina	Love Hina	ラブひな	It is said that if a couple gets into the University of Tokyo together, they will live happily ever after. However, for Keitarou Urashima, UTokyo is a distant dream. After failing the entrance exams twice already, he decides to stay at his grandmother's inn in Tokyo in order to prepare for his third attempt. He is, therefore, surprised when he finds out that not only has his grandmother gone on a long vacation, but the inn has also become the Hinata House, an all-girls dormitory!\n\nUnfortunately for Keitarou, a series of misunderstandings during his first visit leave him with five untrusting tenants. But when Haruka Urashima, his aunt who works at the dorm, brings up that he is supposedly a UTokyo student, the girls' impressions of him quickly change, and they reluctantly allow him to stay. Feeling guilty about the lie, he slowly gets to know his new neighbors: the cute yet violent Naru Narusegawa, the cheeky and opportunistic Mitsune Konno, the soft-spoken Shinobu Maehara, the straight-laced Motoko Aoyama, and the mischievous Kaolla Su.\n\nThus continues the unpopular Keitarou's difficult journey to get into UTokyo, all for the chance to fulfill his childhood promise to the only girl who has ever shown any interest in him and maybe, just maybe, meet her again.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/259287l.jpg	7.77	37235	1448	239	Finished	f	1998-10-20 17:00:00-07	2001-10-30 16:00:00-08	120	14	2025-02-27 18:13:18.848825-08	2025-02-27 18:13:18.848825-08
17	Kareshi Kanojo no Jijou	Kare Kano: His and Her Circumstances	彼氏彼女の事情	Yukino Miyazawa is the perfect model student. Pretty, kind, good at sports, always at the top of her class. But she's not all that she seems. It's all an act of deception; she is really the self-confessed 'queen of vanity,' and her only goal in life is winning the praise and admiration of everyone around her.\n\nWhen she enters high school, she finally meets her match: Souichirou Arima, a handsome, athletic, popular, and very intelligent young boy. Ever since he stole the top seat in the class from her, Yukino has hated him, and has been plotting on how to take back her former place as the object of all other students' admiration.\n\nWhat she wasn't expecting, however, was that Souichirou, the very boy she hated, would confess his love for her. Or that he would find out about her deception—and use it to blackmail her!\n\nTogether, they discover that they have more in common than they knew, and they slowly begin to bring out each other's inner selves.\n\n(Source: MU)\n\nIncluded one-shots:\nVolume 1: Tora to Chameleon: Yakusoku wa Isshukan (The Tiger and the Chameleon: A Promise for One Week)\nVolume 4: Ashita Mata Mori de Aou ne (Meet Me Again Tomorrow in the Forest)\nVolume 8: Abareru Ousama (The Raging King)	https://cdn.myanimelist.net/images/manga/1/267780l.jpg	8.14	14734	521	462	Finished	f	1995-12-21 16:00:00-08	2005-05-09 17:00:00-07	108	21	2025-02-27 18:13:18.960517-08	2025-02-27 18:13:18.960517-08
18	Kodomo no Omocha	Kodocha: Sana's Stage	こどものおもちゃ	Sana Kurata, a child actress, faces many problems in her classroom, including a major one - her bullying classmate, Akito Hayama. Sana's outgoing and friendly nature leads her to work towards correcting all of the problems around her. Her 'meddling' irritates Hayama but at the same time captivates him, just as Hayama's gloomy nature irritates Sana and compels her to change him. As these two opposites attract each other, they face many hardships which bring them closer to a mutual understanding.\n\n(Source: ANN)	https://cdn.myanimelist.net/images/manga/1/267715l.jpg	8.29	10952	316	830	Finished	f	1994-07-01 17:00:00-07	1998-10-02 17:00:00-07	54	10	2025-02-27 18:13:19.055425-08	2025-02-27 18:13:19.055425-08
19	GetBackers	GetBackers	GetBackers -奪還屋-	Blonde, hip, pragmatic and cool, Ginji Amano has the power to generate currents with his body like an electric eel. Brunette, equally hip, bespectacled and rambunctious, Ban Mido has the mystically mysterious 'Evil Eye,' the power to create illusions in the minds of his foes. Together, they are the GetBackers, the best retrieval team in the world. They can get back anything taken from clients, and their success rate is (almost) 100%! However, first they have to get some clients—and soon—or this spry detective duo will starve on the streets!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/169369l.jpg	7.61	5921	2252	1341	Finished	f	1999-03-23 16:00:00-08	2007-02-20 16:00:00-08	344	39	2025-02-27 18:13:19.16587-08	2025-02-27 18:13:19.16587-08
20	Hikaru no Go	Hikaru no Go	ヒカルの碁	When Hikaru Shindou discovers an old go board in his grandfather's attic, he is greeted by the spirit of an ancient go master, Fujiwara no Sai. Sai spent his life teaching the techniques of the board game to an emperor during the Heian era, and now in his ghostly state, he is eager to share his passion with the unsuspecting Hikaru. The only problem is that Hikaru is not all that interested in board games. But Sai is not easily dissuaded. Pressured by Sai's unrelenting desire to pursue something he refers to as the "Divine Move," Hikaru begrudgingly consents to playing the game, executing moves as dictated by Sai. But slowly, intrigued by the dedication of his peers, he begins to learn the basics of the game.\n\nAs Hikaru enters into the world of go, guided by his intangible tutor and inspired by his rival, Akira Touya, he cannot help but be drawn into the complex game as he grows determined to prove his own abilities. In a coming-of-age story centering around an ancient board game, Hikaru no Go tells the story of a boy maturing through the pursuit of his newfound passion.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/170574l.jpg	8.11	23343	563	372	Finished	f	1998-12-07 16:00:00-08	2003-07-13 17:00:00-07	198	23	2025-02-27 18:13:19.300995-08	2025-02-27 18:13:19.300995-08
21	Death Note	Death Note	DEATH NOTE	Ryuk, a god of death, drops his Death Note into the human world for personal pleasure. In Japan, prodigious high school student Light Yagami stumbles upon it. Inside the notebook, he finds a chilling message: those whose names are written in it shall die. Its nonsensical nature amuses Light; but when he tests its power by writing the name of a criminal in it, they suddenly meet their demise.\n\nRealizing the Death Note's vast potential, Light commences a series of nefarious murders under the pseudonym "Kira," vowing to cleanse the world of corrupt individuals and create a perfect society where crime ceases to exist. However, the police quickly catch on, and they enlist the help of L—a mastermind detective—to uncover the culprit.\n\nDeath Note tells the thrilling tale of Light and L as they clash in a great battle-of-minds, one that will determine the future of the world.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/258245l.jpg	8.69	234651	63	14	Finished	f	2003-11-30 16:00:00-08	2006-05-14 17:00:00-07	108	12	2025-02-27 18:13:19.406109-08	2025-02-27 18:13:19.406109-08
41	Busou Renkin	Buso Renkin	武装錬金	Busou Renkin is the story of the teenager Kazuki Mutou, who dies trying to save a girl who was being attacked by an eerie monster. The next morning, however, Kazuki is left wondering whether it was all a dream. Lo and behold, the girl, the monster, and his death are all real! The girl, Tokiko Tsumura, was actually trying to slay the homunculus (a beast that can take the form of humans, but whose main source of food is people), but Kazuki got in her way. To revive Kazuki, Tokiko replaces his heart with a "kakugane," an alchemic device that allows him to summon a lance with which to fight the monsters. It turns out that Tokiko is a member of Renkin Kenshi (Alchemist Soldiers)—an organization sworn to protect the world from the diabolical creatures. Soon, Kazuki joins Tokiko in her quest to terminate the sinister being that creates and controls the homunculus.\n\n(Source: VIZ Media)\n\nIncluded one-shot:\nVolume 10: Embalming: Dead Body and Bride	https://cdn.myanimelist.net/images/manga/2/149583l.jpg	7.22	8412	5829	1145	Finished	f	2003-06-22 17:00:00-07	2006-04-24 17:00:00-07	83	10	2025-02-27 18:13:21.145271-08	2025-02-27 18:13:21.145271-08
22	Rurouni Kenshin: Meiji Kenkaku Romantan	Rurouni Kenshin: Meiji Swordsman Romantic Story	るろうに剣心 -明治剣客浪漫譚-	Ten years have passed since the end of Bakumatsu, an era of war that saw the uprising of citizens against the Tokugawa shogunate. The revolutionaries wanted to create a time of peace, and a thriving country free from oppression. The new age of Meiji has come, but peace has not yet been achieved. Swords are banned but people are still murdered in the streets. Orphans of war veterans are left with nowhere to go, while the government seems content to just line their pockets with money.\n\nOne wandering samurai, Kenshin Himura, still works to make sure the values he fought for are worth the lives spent to bring about the new era. Once known as Hitokiri Battousai, he was feared as the most ruthless killer of all the revolutionaries. Now haunted by guilt, Kenshin has sworn never to kill again in atonement for the lives he took, and he may never know peace until killing is a thing of the past.\n\nNow in the 11th year of Meiji, Kenshin stumbles upon Kaoru Kamiya, owner and head instructor of a small dojo being threatened to close its doors. The police force is powerless to stop the string of murders done in the name of her dojo by a man claiming to be the famous Battousai. Kenshin's wanderings pause for now as he joins Kaoru to clear both their names. But how long can he stay before his past catches up to him?\n\n[Written by MAL Rewrite]\n\nIncluded one-shot:\nVolume 28: Meteor Strike	https://cdn.myanimelist.net/images/manga/2/127583l.jpg	8.54	49071	124	145	Finished	f	1994-04-11 17:00:00-07	1999-09-20 17:00:00-07	259	28	2025-02-27 18:13:19.454784-08	2025-02-27 18:13:19.454784-08
23	Ranma ½	Ranma 1/2	らんま½	Soun Tendou runs the Tendou Martial Arts School accompanied by his three daughters: Akane, Nabiki, and Kasumi. One day, the sisters' lives are turned upside down when their father announces that he has promised one of them to be married to a fellow martial artist's son in hopes of carrying on the family legacy. In addition to their mixed reactions, when the fiancé arrives, the last thing the Tendou family expects is Ranma Saotome and his father, Genma.\n\nRanma has been training in China with his father until an unfortunate accident changed them both. Now, when water touches them, Ranma turns into a girl and Genma into a giant panda. Ranma ½ follows Ranma as he attempts to get along with his newly betrothed, the youngest of the Tendou sisters, Akane. As the two begin to attend the same school, they deal with fellow friends and rivals, all of whom have something to say about their engagement.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/156534l.jpg	7.99	26416	781	319	Finished	f	1987-08-04 17:00:00-07	1996-02-20 16:00:00-08	407	38	2025-02-27 18:13:19.521663-08	2025-02-27 18:13:19.521663-08
24	D.Gray-man	D.Gray-man	D.Gray-man	Thousands of years ago, there existed those gifted with the power of God. Their mission: to destroy the ominous evils that lurk in the darkness known as "Akuma." Led by the Milenium Earl, Akuma seek to destroy fragments of "Innocence," the only weapons capable of harming the Earl and his army and bring about the Great Flood from a hundred years ago. \n\nTo prevent this tragedy from happening, the Black Order was formed as an organization dedicated to fighting the Earl. They recruit Exorcists, those with the inherent ability to accomodate Innocence, to fight against the Akuma.\n\nIn the late 19th century, Allen Walker—a white-haired boy armed with Innocence that takes the form of his entire left arm and a cursed eye that can see Akuma—is sent to the Black Order. There, Allen meets various comrades from the Order—the mercurial Yuu Kanda, the kindhearted Lenalee Lee, and the cheerful yet mysterious Lavi. Despite their different personalities, they have one goal in mind: to bring salvation to the souls of Akuma and prevent the Earl from destroying the world.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/240470l.jpg	8.28	64584	330	72	Publishing	t	2004-05-30 17:00:00-07	\N	\N	\N	2025-02-27 18:13:19.619275-08	2025-02-27 18:13:19.619275-08
25	Fullmetal Alchemist	Fullmetal Alchemist	鋼の錬金術師	Alchemists are knowledgeable and naturally talented individuals who can manipulate and modify matter due to their art. Yet despite the wide range of possibilities, alchemy is not as all-powerful as most would believe. Human transmutation is strictly forbidden, and whoever attempts it risks severe consequences. Even so, siblings Edward and Alphonse Elric decide to ignore this great taboo and bring their mother back to life. Unfortunately, not only do they fail in resurrecting her, they also pay an extremely high price for their arrogance: Edward loses his left leg and Alphonse his entire body. Furthermore, Edward also gives up his right arm in order to seal his brother's soul into a suit of armor.\n\nYears later, the young alchemists travel across the country looking for the Philosopher's Stone, in the hopes of recovering their old bodies with its power. However, their quest for the fated stone also leads them to unravel far darker secrets than they could ever imagine.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/243675l.jpg	9.04	162991	8	20	Finished	f	2001-07-11 17:00:00-07	2010-09-10 17:00:00-07	116	27	2025-02-27 18:13:19.714178-08	2025-02-27 18:13:19.714178-08
26	Hunter x Hunter	Hunter x Hunter	HUNTER×HUNTER	"Secret treasure hoards, undiscovered wealth... mystical places, unexplored frontiers... 'The mysterious unknown.' There's magic in such words for those captivated by its spell. They are called 'Hunters'!"\n\nGon Freecss wants to become a Hunter so he can find his father, a man who abandoned him to pursue a life of adventure. But it's not that simple: only one in one hundred thousand can pass the Hunter Exam, and that is just the first obstacle on his journey. During the Hunter Exam, Gon befriends many other potential Hunters, such as the mysterious Killua; the revenge-driven Kurapika; and Leorio, who aims to become a doctor. There's a world of adventure and peril awaiting, and those who embrace it with open arms can become the greatest Hunters of them all!\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/253119l.jpg	8.76	133429	47	22	Publishing	t	1998-03-02 16:00:00-08	\N	\N	\N	2025-02-27 18:13:19.833861-08	2025-02-27 18:13:19.833861-08
27	X	X	X	Six years ago, Kamui Shirou and siblings Fuuma and Kotori Monou were inseparable childhood friends. After the sudden, gruesome death of the Monou siblings' mother, Kamui was taken away from Tokyo by his own mother. In the years that passed, the two lived peacefully while Kamui strengthened his innate telekinetic abilities. When his mother passes away in 1999, her dying wish prompts him to return to Tokyo to face his "destiny."\n\nWhen Kamui reappears in the city, his attitude has taken a drastic turn, and he displays the growth of his powers through violent confrontations in the streets. Various opponents come after him asking if he is "Kamui," but they seem to be demanding something far more significant than his name. These fighters represent two opposite factions—the Dragons of Heaven and the Dragons of Earth—who each wish to recruit him to their cause. Piecing together clues about the apocalyptic "promised day," Kamui realizes that he holds the fate of the world in his hands. Depending on which group of Dragons he allies himself with, he can either choose to save the world—or end it.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/267781l.jpg	8.09	8842	602	706	On Hiatus	f	1992-03-23 16:00:00-08	2003-03-23 16:00:00-08	158	18	2025-02-27 18:13:20.023595-08	2025-02-27 18:13:20.023595-08
28	Nana	Nana	NANA	Nana Komatsu is a naive, unmotivated girl who spends her high school days chasing one crush after the other. Despite continually facing failure in her quest for love, her spirits have never dampened. At the age of 20, she finds herself on a train to Tokyo with hopes of reuniting with her current boyfriend.\n\nNana Osaki, on the other hand, is feisty and prideful. After joining a local band during her high school days, she falls in love with music and one of the band members. However, when faced with the choice between her relationship and her musical career, she chooses the latter and separates from her boyfriend. On her 20th birthday, she boards the same train to Tokyo, like her namesake, where she aims to become a top vocalist.\n\nThe two girls with the same name but very different aspirations find themselves sitting together on their journey to the city, and, as fate would have it, eventually share the same apartment. A deep and unique bond is then forged, where they will support each other in this saga of love, music, friendship, and heartbreak.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/262324l.jpg	8.80	47756	42	78	On Hiatus	f	2000-05-25 17:00:00-07	2009-05-25 17:00:00-07	84	21	2025-02-27 18:13:20.099732-08	2025-02-27 18:13:20.099732-08
29	Paradise Kiss	Paradise Kiss	パラダイス・キス	After two eccentrically dressed individuals ambush her, high school student Yukari Hayasaka promptly passes out due to shock. She soon awakens to find herself surrounded by even more strangely dressed people in the basement studio of Paradise Kiss—a fashion design club composed of four students from Yazawa School for the Arts. Although it seems like Yukari has been kidnapped, the older students explain that they only approached her to see if she would model their collection for an upcoming fashion show.\n\nBeing a senior with a busy schedule, Yukari furiously rejects the group's offer. But when she drops her student passbook in her haste to leave, the ringleader of the group, George Koizumi, picks it up and uses it as a means to coerce Yukari into considering their request. After hearing about the other members' unbridled ambition, Yukari is inspired to reevaluate her own circumstances and eventually agrees to help them out.\n\nNow as Paradise Kiss' model, Yukari must learn to balance her new responsibilities with her hectic personal life. However, the more time she spends with George and the rest of the team, the harder it becomes for her to avoid getting swept up in the glitz and glamor of the fashion world.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/262323l.jpg	8.29	22595	317	313	Finished	f	1999-03-22 16:00:00-08	2003-03-21 16:00:00-08	48	5	2025-02-27 18:13:20.163846-08	2025-02-27 18:13:20.163846-08
30	Ouran Koukou Host Club	Ouran High School Host Club	桜蘭高校ホスト部	At Ouran High School, an academy where only the children of the rich and powerful attend, there exists a club consisting of the most elite of the student body: the legendary Host Club. Within the club's room, six beautiful, bored boys spend their time entertaining equally beautiful and bored girls.\n\nHaruhi Fujioka, a poor scholarship student, has no interest in the Host Club—until she breaks a valuable vase in their clubroom. After being mistaken for a boy, Haruhi is forced by Kyouya Ootori to work for the Host Club to repay her debt. Tamaki Suou, the princely leader of the club, eagerly takes her under his wing to teach her the ways of the host.\n\nThings, however, are never quite so simple with the Host Club around. Even the most mundane events can turn into huge spectacles with the likes of prankster twins Hikaru and Kaoru Hitachiin, stoic Takashi Morinozuka, and sweet Mitsukuni "Hunny" Haninozuka. The crazy adventures of the Host Club are just beginning, and Haruhi must learn how to survive in the glitzy world of the hosts.\n\n[Written by MAL Rewrite]\n\nNote: The final volume contains a special bonus chapter where the group travels to Spain.	https://cdn.myanimelist.net/images/manga/3/267782l.jpg	8.50	61480	149	100	Finished	f	2002-07-23 17:00:00-07	2010-09-23 17:00:00-07	87	18	2025-02-27 18:13:20.231784-08	2025-02-27 18:13:20.231784-08
31	Lovely★Complex	Love★Com	ラブ★コン	When the taller than average 172 cm Risa Koizumi learns that her occasional nemesis, the shorter than average 156 cm Atsushi Ootani, is romantically interested in her friend, she decides to team up with him. After all, she also has feelings for his friend. Unluckily, however, their respective crushes fall for each other instead. Determined to find new love after their recent misfortunes, the pair decide to cheer each other on while maintaining their usual dynamic of constant bickering. \n\nAlthough they continually deny it, Risa and Ootani are more similar than they like to admit: they both have unusual heights, failing grades, identical tastes in food, and a tendency to act extremely childish. Together, they inspire laughter among their peers as a so-called comedic duo. Could the love that these two are looking for be closer than they think?\n\n[Written by MAL Rewrite]\n\n\nIncluded one-shots:\nVolume 12: Hoshi ni Nattemo Aishiteru\nVolume 16: Bokura no Ibasho	https://cdn.myanimelist.net/images/manga/1/209659l.jpg	8.32	28871	282	255	Finished	f	2001-08-12 17:00:00-07	2007-08-12 17:00:00-07	68	17	2025-02-27 18:13:20.307389-08	2025-02-27 18:13:20.307389-08
32	666 Satan	O-Parts Hunter	666〜サタン〜	In the not too distant future, mankind battles over O-Parts, relics from an ancient civilization. It takes a special kind of person to unlock the full potential of these remnants from the past, and a unique breed of humans known as O.P.T.s (or O-Parts Tacticians) become a force to be reckoned with. Unfortunately, O-Parts can be used for good or evil purposes.\n\nJio is a young boy with a tragic past who only trusts one thing in the world: money. Little does he suspect that he is actually a very powerful O.P.T., and inside him sleeps a demon of incredible ferocity. He meets up with a girl named Ruby, and together they decide to embark on a dangerous quest to discover as many O-Parts as they can. Will Jio help Ruby realize her dream of becoming a world famous treasure hunter? More importantly, will Ruby help Jio realize his dream of--world domination?!\n\n(Source: Viz Media)\n\nIncluded one-shots:\nVolume 6: Trigger	https://cdn.myanimelist.net/images/manga/3/267783l.jpg	7.42	16976	3608	529	Finished	f	2001-08-10 17:00:00-07	2007-12-11 16:00:00-08	78	19	2025-02-27 18:13:20.39323-08	2025-02-27 18:13:20.39323-08
33	Pita-Ten	Pita-Ten	ぴたテン	Kotarou Higuchi is a sixth-grade student who not only has to work hard to get into a good middle school, but he also has to deal with the responsibilities that come with living in an apartment all by himself. One day, while leaving for school, he is greeted with a surprise: an unfamiliar, older girl in a frilly black dress is waiting by his front door, asking to be friends with him!\n\nDespite his attempts at ignoring her, the strange girl determinedly follows Kotarou all the way to school and back. Giving in, Kotarou finds out that the strange girl's name is Misha and that she is his new neighbor, supposedly from Heaven to work on becoming a full-time angel. What will become of Kotarou and his life with this "clingy angel"?\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/191236l.jpg	7.32	4121	4610	2676	Finished	f	1999-08-26 17:00:00-07	2003-06-26 17:00:00-07	47	8	2025-02-27 18:13:20.538049-08	2025-02-27 18:13:20.538049-08
34	Di Gi Charat: Koushiki Comic Anthology	Di Gi Charat	デ・ジ・キャラット 公式コミックアンソロジー	On planet Di Gi Charat, little Digiko was a pampered princess. Now living on Earth, the green-haired moppet is working for minimum wage at a hobby shop in Japan. Who ever said it was easy being cute? Based on the popular anime series, Di Gi Charat also features bratty Usada, shy boy Minagawa, and Digiko's wacky companions Puchiko and Gemo! \n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/1/267784l.jpg	6.52	684	16246	10595	Finished	f	1998-06-30 17:00:00-07	2000-02-29 16:00:00-08	72	4	2025-02-27 18:13:20.624259-08	2025-02-27 18:13:20.624259-08
35	Kamichama Karin	Kamichama Karin	かみちゃまかりん	After the death of her beloved cat, orphan Karin Hanazono is left lonesome and empty. As she does not have any friends and performs poorly at school, her mean-spirited aunt resents having to take care of her. Wholeheartedly believing that God will grant her salvation one day, she tightly holds onto the ring that her mother passed down to her.\n\nSeeking solace by spending time at her late cat's grave, Karin unexpectedly meets a boy named Kazune Kuujou, who claims he is looking for God. However, Kazune calls her weak for relying on her deceased cat for comfort. Angered by the insult, Karin subconsciously channels energy into her mother's ring. Soon enough, she begins to excel at school and classmates compliment her for the first time. Unbeknownst to her, the ring has bestowed her godly powers.\n\nThe revelation of the ring's transcendent strength catches the eyes of not only Kazune but also more sinister figures who wish to take advantage of Karin for nefarious purposes. Karin must now use her newly acquired gift to fight back against these malicious forces, unaware of the truth behind her heritage and the existence of others with similar abilities.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/267789l.jpg	7.49	6289	3041	1678	Finished	f	2002-11-01 16:00:00-08	2008-04-02 17:00:00-07	32	7	2025-02-27 18:13:20.694943-08	2025-02-27 18:13:20.694943-08
36	Kamikaze Kaitou Jeanne	Phantom Thief Jeanne	神風怪盗ジャンヌ	It's nearly the end of the century, and one girl has been breaking the news: Kaitou Jeanne, a phantom thief supposedly sent by God, has been stealing paintings all around the city. Her real identity is Maron Kusakabe, a 16-year-old rhythmic gymnastics enthusiast and student at Momokuri Academy— something unknown to all, even her best friend Miyako Toudaiji, who is in charge of the police chase for Jeanne.\n\nHidden inside the paintings Maron steals are demons sent by the demon lord, who plans to weaken God's power by having his minions possess human hearts. Assisted by the minor angel Finn Fish, it is up to Maron as the reincarnation of Jeanne d'Arc to assume her alter ego, hunt down the cursed paintings, and seal the vile demons away. However, the tough job of balancing this duty with her lonesome high school life only proves more challenging when a mysterious new phantom thief makes his appearance—Kaitou Sinbad.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/267790l.jpg	7.79	10961	1353	939	Finished	f	1997-12-28 16:00:00-08	2000-06-02 17:00:00-07	33	7	2025-02-27 18:13:20.771028-08	2025-02-27 18:13:20.771028-08
37	Shinshi Doumei Cross	The Gentleman's Alliance Cross	紳士同盟†	Imperial Academy is an elite private school whose student body is divided into the ranks of Gold, Silver, and Bronze. Depending on your family's wealth and your individual merit, you can be classified as a Silver or Bronze student. However, there is only one Gold student, and this year that person is Shizumasa Touguu—nicknamed "the Emperor" because he is the Student Council President.\n\nWhen she was very young, Haine Otomiya fell in love with Shizumasa, after reading the children's picture book that he authored. She had met him twice before attending Imperial Academy, but as a Bronze student, her rank is far below his, so she has been unable to approach him at school. \n\nHaine jumps at an opportunity to get close to Shizumasa, and she unexpectedly becomes his bodyguard as well as a member of the Student Council. It seems like a dream come true for her, but soon she will learn that everyone in the Student Council is hiding secrets, and her own shameful history cannot be forgotten either.\n\n[Written by MAL Rewrite]\n\n\nIncluded one-shots	https://cdn.myanimelist.net/images/manga/3/257940l.jpg	7.84	12705	1193	719	Finished	f	2004-08-02 17:00:00-07	2008-06-02 17:00:00-07	59	11	2025-02-27 18:13:20.857482-08	2025-02-27 18:13:20.857482-08
38	+Anima	+Anima	+ANIMA	+Anima are rare and mysterious human-like beings capable of transforming their body into the form of an animal, but they are ostracised from society by humans. Cooro, a young orphaned +Anima with the abilities of a crow, struggles to find acceptance and belonging. Having been found on a church altar as a baby, he knows little of his origins and his species despite the poor reputation they receive. Thus, he resolves to search for more of his kind.\n\nTogether with his newfound companions—Husky, Nana Alba, and Senri—Cooro embarks on a quest to meet other outcasts and discover their place in an unforgiving world. As the bond between the four +Anima grows to become unbreakable throughout their travels, a sense of adventure seems everlasting. However, the group soon realizes that finding somewhere to belong might prove more challenging than previously anticipated.\n\n+Anima follows the hardships and adventures of Cooro and his friends as they learn of the difficulties and prejudice experienced by their kin.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/267791l.jpg	7.65	10929	2000	902	Finished	f	1999-12-26 16:00:00-08	2005-01-26 16:00:00-08	59	10	2025-02-27 18:13:20.92752-08	2025-02-27 18:13:20.92752-08
39	Zombie Powder.	Zombiepowder.	ZOMBIEPOWDER.	Gamma Akutabi is a mysterious figure, drifting through the western desert with a giant sword slung over his shoulder and a right arm made completely of metal spreading up and over his cheek. He searches endlessly for a mythical set of 12 Rings of the Dead—jewelry said to give life to the possessor. These rings are hunted by mercenaries and outlaws alike for a wide variety of reasons, but Gamma seeks to grant himself eternal life by possessing all 12.\n\nGamma comes across teenager John Elwood Shepherd in his travels, who decides to follow Gamma after a brutal fight claims the life of his sister. Elwood seeks to use the Rings of the Dead to bring his sister back to life and quickly develops an admiration for Gamma, whose combat prowess saves Elwood's life time after time. Along the way, the two travelers encounter new friends and old allies from Gamma's past, working with them to defeat enemies who seek to use the Rings of the Dead for their own nefarious purposes.\n\n[Written by MAL Rewrite]\n\nIncluded one-shots:\nVolume 2: Ultra Unholy Hearted Machine\nVolume 3: Kokumashi Urara (Rune Master Urara)\nVolume 4: Bad Shield United	https://cdn.myanimelist.net/images/manga/3/180035l.jpg	6.96	7652	9616	1266	Finished	f	1999-07-19 17:00:00-07	2000-02-14 16:00:00-08	30	4	2025-02-27 18:13:20.980274-08	2025-02-27 18:13:20.980274-08
40	Black Cat	Black Cat	BLACK CAT	Train Heartnet is an amicable bounty hunter—known as a "Sweeper"—with a talent for sharpshooting. Working alongside his cool-headed partner Sven Vollfied, they hunt down wanted criminals. Unfortunately, however, despite their efforts, the dynamic duo always seems to be short on money, which forces them to accept a job from the beautiful Rinslet Walker, a sly thief for hire, and a mysterious girl named Eve.\n\nHowever, the motley crew soon discovers a terrible plot to revolutionize the world, and the mastermind is someone Train knows and loathes with a passion. As the plan is set into motion, it is soon made clear that behind the carefree sharpshooter's smiling face lies a tragic past and an insatiable desire for revenge.\n\n[Written by MAL Rewrite]\n\nIncluded one-shot:\nVolume 8: Stray Cat (pilot)	https://cdn.myanimelist.net/images/manga/2/186071l.jpg	7.78	22784	1400	349	Finished	f	2000-07-10 17:00:00-07	2004-06-13 17:00:00-07	187	20	2025-02-27 18:13:21.061349-08	2025-02-27 18:13:21.061349-08
169	Comic Party	Comic Party	こみっくパーティー	The plot centers on Kazuki Sendo, whose passion and talent for painting and drawing propels him into the world of doujinshi (underground comics). Soon, Kazuki's everyday life is consumed by the fanboy life and his girlfriend is beginning to have some serious doubts about him... Sure, his new career as a struggling artist has begun, but at what cost to his friends and family? (Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/5/755l.jpg	6.85	1008	11313	8641	Finished	f	2000-12-31 16:00:00-08	2005-02-28 16:00:00-08	49	5	2025-02-27 18:13:31.379978-08	2025-02-27 18:13:31.379978-08
42	Dragon Ball	Dragon Ball	ドラゴンボール	Bulma, a headstrong 16-year-old girl, is on a quest to find the mythical Dragon Balls—seven scattered magic orbs that grant the finder a single wish. She has but one desire in mind: a perfect boyfriend. On her journey, Bulma stumbles upon Gokuu Son, a powerful orphan who has only ever known one human besides her. Gokuu possesses one of the Dragon Balls, it being a memento from his late grandfather. In exchange for it, Bulma invites Gokuu to be a companion in her travels.\n\nBy Bulma's side, Gokuu discovers a world completely alien to him. Powerful enemies embark on their own pursuits of the Dragon Balls, pushing Gokuu beyond his limits in order to protect Bulma and their growing circle of allies. However, Gokuu has secrets unbeknownst to even himself; the incredible strength within him stems from a mysterious source, one that threatens the many people he grows to hold dear.\n\nAs his prowess in martial arts flourishes, Gokuu attracts stronger opponents whose villainous plans could collapse beneath his might. He undertakes the endless venture of combat training to defend his loved ones and the fate of the planet itself.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/267793l.jpg	8.44	104072	190	62	Finished	f	1984-11-19 16:00:00-08	1995-05-22 17:00:00-07	520	42	2025-02-27 18:13:21.235884-08	2025-02-27 18:13:21.235884-08
43	Eyeshield 21	Eyeshield 21	アイシールド21	Timid, diminutive, and frequently the target of bullies, Sena Kobayakawa has just enrolled at Deimon Private High School. When he angers a group of delinquents by refusing to act as their errand boy, he makes an incredibly speedy getaway, an ability he has developed through years of running from his tormentors.\n\nYouichi Hiruma—the demonic captain of the Deimon Devil Bats football team—happens to be nearby, and seeing Sena's "golden legs" at work, forcibly recruits him as a running back despite Sena's desire to be team manager instead. Made to don the number 21 jersey and a special helmet to hide his identity as a player, Sena becomes "Eyeshield 21," the team's closely guarded secret weapon. Soon he realizes his love for the sport, and aims to help the Devil Bats reach the Christmas Bowl, the high school football championship.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/165586l.jpg	8.46	37132	180	204	Finished	f	2002-07-22 17:00:00-07	2009-06-14 17:00:00-07	333	37	2025-02-27 18:13:21.329132-08	2025-02-27 18:13:21.329132-08
44	Gintama	Gin Tama	銀魂	During the Edo period, Japan is suddenly invaded by alien creatures known as the Amanto. Despite the samurai's attempts to combat the extraterrestrial menace, the Shogun soon realizes that their efforts are futile and decides to surrender. This marks the beginning of an uneasy agreement between the Shogunate and Amanto, one that results in a countrywide sword ban and the disappearance of the samurai spirit.\n\nHowever, there exists one eccentric individual who wields a wooden sword and refuses to let his samurai status die. Now that his kind is no longer needed, Gintoki Sakata performs various odd jobs around town in order to make ends meet. Joined by his self-proclaimed disciple Shinpachi Shimura, the fearsome alien Kagura, and a giant dog named Sadaharu, they run the business known as Yorozuya, often getting caught up in all sorts of crazy and hilarious shenanigans.\n\n[Written by MAL Rewrite]\n\nIncluded one-shots:\nVolume 1: Dandelion\nVolume 2: Shirokuro (Black and White)\nVolume 24: 13\nVolume 38: Bankara-san ga Tooru	https://cdn.myanimelist.net/images/manga/3/267795l.jpg	8.63	40608	83	153	Finished	f	2003-12-07 16:00:00-08	2019-06-19 17:00:00-07	709	77	2025-02-27 18:13:21.360991-08	2025-02-27 18:13:21.360991-08
45	Ichigo 100%	Strawberry 100%	いちご100%	Strawberry panties backdropped against a sunset sky—that was aspiring film director Junpei Manaka's introduction to a mysterious beauty at his middle school. Suspecting the girl is his classmate Aya Toujou, Junpei sets out to get in touch with her to refilm that skirt flip for "artistic" reasons. However, when he bumps into her the next day, he sees a girl that looks vastly different from the one in his memories.\n\nJust when Junpei thinks he is back to the drawing board, he runs into the school's darling, Tsukasa Nishino, boldly declaring that she is wearing strawberry panties for the day. Convincing himself that Tsukasa is the girl he has been looking for all along, Junpei starts planning his confession—all for the sake of becoming her boyfriend and filming her panties!\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/259714l.jpg	7.75	21466	1507	364	Finished	f	2002-02-18 16:00:00-08	2005-07-31 17:00:00-07	167	19	2025-02-27 18:13:21.433714-08	2025-02-27 18:13:21.433714-08
46	Kannade	\N	神撫手	Akito Hayama is the infamous God Hand, an art thief who steals only masterpieces. But these arn't your ordinary art pieces, they're actually copies made by Akito's missing mother. Akito is caught by an underground art broker and consequently learns the reason for the disappearance of his mother. In a attempt to save himself, a new found ability 'Kannade' emerges within Akito, as well as the quest to find certain art pieces by Akito's mother and what Kannade's fate really is.\n\nIncluded one-shot:\nVolume 2: Kannade (pilot), God Hand	https://cdn.myanimelist.net/images/manga/3/267796l.jpg	6.78	110	12499	26706	Finished	f	2003-09-21 17:00:00-07	2003-12-14 16:00:00-08	15	2	2025-02-27 18:13:21.528838-08	2025-02-27 18:13:21.528838-08
47	Katekyou Hitman Reborn!	Reborn!	家庭教師〈かてきょー〉ヒットマンREBORN!	The life of Tsunayoshi "No-Good Tsuna" Sawada is a complete wreck. Terrible grades, horrible fitness, and a non-existent social life means he has no reason to attend school, especially after discovering that his crush, Kyouko Sasagawa, is already seeing someone. Unbeknownst to him however, the blood of Giotto, the great Vongola the First, runs through his veins.\n\nEnter home tutor Reborn, an infant who claims to be the world's greatest hitman. Under orders from Vongola the Ninth, Reborn has come to train Tsuna to become a worthy successor to the famous Vongola Famiglia name. Tsuna, however, refuses, and claims that he will never become a mafia boss. How will the world's greatest hitman react to such opposition? Will he force Tsuna to adhere? Or will he use this unwillingness to his advantage? This is a story of a reluctant successor as he takes on the responsibilities of becoming the underworld's next ruling mafia leader, with the help of his friends and a one-of-a-kind home tutor.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/253085l.jpg	8.10	68424	585	103	Finished	f	2004-05-23 17:00:00-07	2012-11-11 16:00:00-08	411	42	2025-02-27 18:13:21.594613-08	2025-02-27 18:13:21.594613-08
48	Pretty Face	Pretty Face	プリティフェイス	Randou Masashi is a brash karate star who strikes fear in everyone around him. But despite his intimidating presence, he is secretly in love with the sweet and beautiful Rina Kurimi. Unfortunately, Randou is involved in a horrific bus accident, which leaves him comatose and with a disfigured face. A year later, he awakes to discover something utterly shocking—his face now resembles Rina's!\n\nRandou learns that he has been under the care of a surgeon named Jun Manabe, who reconstructed Randou's face based on a picture he had of Rina. Moreover, Randou is presumed dead, and his parents have moved away as a result. Distraught, Randou crosses paths with Rina and is mistaken for her twin sister Yuna, who fled from her house two years ago. Although Randou initially wished to restore his face, seeing Rina elated makes him reconsider his decision.\n\nHowever, a boy disguising himself as a girl is as absurd as it sounds, and being surrounded by troublesome individuals only makes it more difficult. Nevertheless, Randou is adamant about concealing his identity until he finds the real Yuna.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/123699l.jpg	7.56	10137	2550	1053	Finished	f	2002-05-13 17:00:00-07	2003-06-08 17:00:00-07	53	6	2025-02-27 18:13:21.69524-08	2025-02-27 18:13:21.69524-08
49	Tennis no Oujisama	The Prince of Tennis	テニスの王子様	Seishun Academy is home to one of the best middle school tennis teams in all of Japan. Freshman tennis prodigy Ryouma Echizen enrolls in the prestigious institution with his eyes set on claiming a regular position on the Boys' Tennis Team. As the son of legendary tennis player Samurai Nanjirou, Ryouma is sick of living in his shadow and wishes to surpass him someday. He is confident in his skills and has the cocky attitude to match. His teammates, however, are reluctant to accept him into their starting lineup, as he hasn't proven himself worthy of the spot.\n\nSeishun's ultimate goal is to make it to the National Tournament by the end of the year, but they first have to make it through the Kanto Regionals to even qualify for a spot in it. With their new "super rookie" on the team, Seishun is ready to take on anything that comes their way. With a varied assortment of rivals and opponents that can threaten their chance at the title, the Seishun team needs to give it their all in order to rise to the top.\n\n[Written by MAL Rewrite]\n\nIncluded one-shot:\nVolume 5: Tennis no Oujisama (pilot)	https://cdn.myanimelist.net/images/manga/3/153238l.jpg	7.69	13782	1815	703	Finished	f	1999-07-05 17:00:00-07	2008-03-02 16:00:00-08	382	42	2025-02-27 18:13:21.754477-08	2025-02-27 18:13:21.754477-08
50	Shaman King	Shaman King	シャーマンキング	Shamans are extraordinary individuals with the ability to communicate with ghosts, spirits, and gods, which are invisible to ordinary people. The Shaman Fight—a prestigious tournament pitting shamans from all over the world against each other—is held every five hundred years, where the winner is crowned Shaman King. This title allows the current incumbent to call upon the Great Spirit and shape the world as they see fit.\n \nFinding himself late for class one night, Manta Oyamada, an ordinary middle school student, decides to take a shortcut through the local cemetery. Noticing him, a lone boy sitting on a gravestone invites Manta to stargaze with "them." Realizing that "them" refers to the boy and his ghostly friends, Manta flees in terror. Later, the boy introduces himself as You Asakura, a Shaman-in-training, and demonstrates his powers by teaming up with the ghost of six-hundred-year-old samurai Amidamaru to save Manta from a group of thugs. You befriends Manta due to his ability to see spirits, and with the help of Amidamaru, they set out to accomplish You's goal of becoming the next Shaman King.\n\n[Written by MAL Rewrite]\n\nNote: This entry is for the original printing of Shaman King. Please see Shaman King (Kanzenban Edition) for the chapters not included in this edition.	https://cdn.myanimelist.net/images/manga/2/255376l.jpg	7.77	37363	1438	215	Finished	f	1998-06-29 17:00:00-07	2004-08-29 17:00:00-07	288	32	2025-02-27 18:13:21.790227-08	2025-02-27 18:13:21.790227-08
51	Slam Dunk	Slam Dunk	SLAM DUNK	Hanamichi Sakuragi, a tall, boisterous teenager with flame-red hair and physical strength beyond his years, is eager to put an end to his rejection streak of 50 and finally score a girlfriend as he begins his first year of Shohoku High. However, his reputation for delinquency and destructiveness precedes him, and most of his fellow students subsequently avoid him like the plague. As his first day of school ends, he is left with two strong thoughts: "I hate basketball" and "I need a girlfriend."\n\nHaruko Akagi, ignorant of Hanamichi's history of misbehavior, notices his immense height and unwittingly approaches him, asking whether or not he likes basketball. Overcome by the fact that a girl is speaking to him, the red-haired giant blurts out a yes despite his true feelings. At the gym, Haruko asks if he can do a slam dunk. Though a complete novice, Hanamachi palms the ball and makes the leap...but overshoots, slamming his head into the backboard. Amazed by his near-inhuman physical abilities, Haruko quickly notifies the school's basketball captain of his feat. With this, Hanamichi is unexpectedly thrust into a world of competition for a girl he barely knows, but he soon discovers that there is perhaps more to basketball than he once thought.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/258749l.jpg	9.08	82453	6	51	Finished	f	1990-09-17 17:00:00-07	1996-06-03 17:00:00-07	276	31	2025-02-27 18:13:21.900568-08	2025-02-27 18:13:21.900568-08
52	Whistle!	Whistle!	ホイッスル!	Everybody has a dream, and for Shou Kazamatsuri, that dream is simple: he wants to be the best soccer player he can possibly be. He's the spirited leader of the Josui Junior High team and everyone looks up to him. In turn, he tries to keep the team together at any cost!\n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/1/267799l.jpg	7.72	3007	1660	3498	Finished	f	1998-02-23 16:00:00-08	2002-10-07 17:00:00-07	216	24	2025-02-27 18:13:21.934104-08	2025-02-27 18:13:21.934104-08
53	Yuu☆Yuu☆Hakusho	Yu Yu Hakusho	幽☆遊☆白書	Fourteen-year-old thug Yuusuke Urameshi spends his days skipping school and causing trouble for the adults in his life. Yuusuke regularly engages in street brawls against rival Kazuma Kuwabara and ridicules his childhood friend Keiko Yukimura. Filled with self-loathing and the burden of an alcoholic mother, Yuusuke sacrifices it all in a split-second decision—he tackles a small child out of the way of an oncoming car, losing his life in the process.\n\nSpirit guide Botan intervenes, allowing Yuusuke to see how the people in his life react to his death; he is moved by the emotional ruin his loss causes his mother, Keiko, and even Kuwabara. Additionally, due to his death's heroic nature, he receives an opportunity to return to life from the Spirit World ruler's son, Koenma.\n\nKoenma hires Yuusuke as a "Spirit Detective" and tasks him with solving a series of increasingly challenging paranormal mysteries. Battling and befriending demons such as the beautiful Kurama and hostile Hiei, Yuusuke further develops and utilizes his skills as a fighter. But as dark forces move in the Underworld, Yuusuke struggles alongside his companions to defend everything he took for granted.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/250027l.jpg	8.18	33640	456	222	Finished	f	1990-11-19 16:00:00-08	1994-07-11 17:00:00-07	176	19	2025-02-27 18:13:21.967917-08	2025-02-27 18:13:21.967917-08
54	Yu☆Gi☆Oh!	Yu-Gi-Oh!	遊☆戯☆王	High school student Yuugi Mutou spends his days being bullied between classes and his nights playing board games and solving puzzles in his bedroom. Yuugi's penchant for gameplay comes from his grandfather, whose game shop also serves as a house for the two.\n\nOne night, Yuugi manages to solve the Millennium Puzzle, a seemingly impossible challenge that awakens his inner darkness and converts it into an alternate persona: Yami Yuugi. Transforming into the more bold and dangerous persona against his will in moments of great distress, Yuugi begins to moonlight as a vengeful vigilante, challenging bullies and evil-doers to risky games where failure results in fates worse than death.\n\nYuugi and his alter ego befriend some of the very students who once bullied him, forming unbreakable companionships with them. But the group must contend with villains far deadlier than the high school punks they originally rallied against, enemies who use games for nefarious purposes and threaten Yuugi and his friends' very lives.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/262097l.jpg	7.67	20648	1897	433	Finished	f	1996-09-16 17:00:00-07	2004-03-07 16:00:00-08	343	38	2025-02-27 18:13:22.075107-08	2025-02-27 18:13:22.075107-08
56	Caramel Diary	\N	きゃらめるダイアリー	Hana loves the school, caramel and...drawing manga! Her speciality: Drawing romance stories! In real life, her heart beats for the cool Taro, but she's too shy to tell him...unfortunately, Marie, her rival, has decided to steal him!\n\n(Source: M.N.M.)	https://cdn.myanimelist.net/images/manga/3/261021l.jpg	6.58	510	15446	16154	Finished	f	1999-03-17 16:00:00-08	1999-09-17 17:00:00-07	5	1	2025-02-27 18:13:22.324622-08	2025-02-27 18:13:22.324622-08
57	Hanazakari no Kimitachi e	Hana-Kimi: For You in Full Blossom	花ざかりの君たちへ	After seeing Izumi Sano at a high jump competition, Mizuki Ashiya became completely enamored by him—even moving from the United States to Japan and enrolling in the same institute as him. However, Sano's academy is an all-boys school!\n\nDue to her bright personality, Mizuki quickly befriends her class without drawing suspension to her gender. To her surprise, she ends up being not only Sano's classmate but also his roommate. Though she is now able to admire Sano in close proximity, she learns that Sano has quit high jumping and refuses to pick up the sport ever again for unknown reasons. Moreover, the academy's doctor, Hokuto Umeda, might be onto Mizuki's facade. Now, Mizuki has to find a way to reignite Sano's passion—all without revealing her secret.\n\n[Written by MAL Rewrite]\n\nIncluded one-shots:\nVolume 1: Natsu no Ori (The Cage of Summer)\nVolume 4: Kawaki no Tsuki (The Thirsty Moon)	https://cdn.myanimelist.net/images/manga/3/262555l.jpg	8.27	17477	344	498	Finished	f	1996-08-19 17:00:00-07	2004-08-19 17:00:00-07	148	23	2025-02-27 18:13:22.385042-08	2025-02-27 18:13:22.385042-08
58	W-Juliet	W-Juliet	Wジュリエット	Makoto Amano wants to become an actor, but his stern father has decreed that the only way Makoto can pursue his dream is to spend the last two years of high school as a girl! He quickly makes friends with popular tomboy Ito Miura, another drama enthusiast at this new high school and the only student to find out his secret—but are they more than pals?\n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/3/256786l.jpg	7.89	4104	1025	2130	Finished	f	1997-10-14 17:00:00-07	2002-11-19 16:00:00-08	79	14	2025-02-27 18:13:22.454077-08	2025-02-27 18:13:22.454077-08
59	√W.P.B.	\N	√W.P.B.	One day, as Suzuri was walking past a river, she suddenly saw a HUGE peach slowly flowing! Due to the fact she has not eaten since the start of her journey, she decided to just conclude the huge peach was a god sent and did the most logical thing anyone would have done—eat it. However, just as she had her first bite, a young male jumps out of the peach! And before Suzuri knows it, she's the 18th master to Momo who could do anything that Suzuri commands! What kind of danger would they encounter on their journey as they face a god that goes by the name Kyuui? And what dark secret does Momo have!?\n\n(Source: Sakura-Crisis)	https://cdn.myanimelist.net/images/manga/2/169856l.jpg	\N	\N	20427	27766	Finished	f	2002-09-17 17:00:00-07	2004-07-16 17:00:00-07	12	2	2025-02-27 18:13:22.543947-08	2025-02-27 18:13:22.543947-08
60	π	\N	π（パイ）	Pi is a constant that defines a circle. It is never-ending, and to Sawaki Yumeto, it is a majestic number that has a direct relationship to his other favorite thing, boobs. One day, he realizes that there is a mystic relationship between pi and the perfect breasts. He conducted research and did calculations to determine what the perfect breasts are but he needed more raw data. Yumeto used to be unpopular and ugly, but to further his quest, he shed blood, sweat and tears to change his appearance and style to that of a handsome young man.\n\nWhen Tamura Jun, a classmate that has been absent for the majority of the school year, returns, Yumeto realizes that she might have the perfect boobs that he has been searching for. But getting to them is going to be harder than he could possibly imagine.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/1/267899l.jpg	\N	\N	20428	24173	Finished	f	2002-09-08 17:00:00-07	2005-02-20 16:00:00-08	101	9	2025-02-27 18:13:22.641767-08	2025-02-27 18:13:22.641767-08
61	Seito no Shucho Kyoushi no Honbun	...But, I'm Your Teacher	生徒の主張・教師の本分	1-2. Student's Request Teacher's Duty\n3, Sakase! Takae no Hana\n4. Honey Happy Baby\n5. Voice Box\n6. Scandal Kiss\n7. The View Through the Lens	https://cdn.myanimelist.net/images/manga/2/267900l.jpg	6.45	544	\N	15128	Finished	f	1997-06-30 17:00:00-07	\N	7	1	2025-02-27 18:13:22.734322-08	2025-02-27 18:13:22.734322-08
62	± Junkie	\N	±ジャンキー	A short shoujo story about a girl who wants to continue the family tradition of her family…that is, get married at 16 and have a girl child at 17! A very crazy story about a very crazy girl named Ren who falls in love with one of the most popular boys in school, Juuya, at first sight!\n\n(Source: StarryHeaven)	https://cdn.myanimelist.net/images/manga/2/112127l.jpg	6.15	731	19242	12873	Finished	f	2003-06-02 17:00:00-07	2003-09-02 17:00:00-07	4	1	2025-02-27 18:13:22.826788-08	2025-02-27 18:13:22.826788-08
63	"Aruto" no "A"	\N	「あると」の「あ」	Aruto Kashiwayama is a budding pianist. She lodges at a famous conductor's house. Aruto's relationships with the conductor's son Hokuto and her first love Masaru are revealed.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/2/164540l.jpg	\N	\N	20429	34045	Finished	f	1988-11-11 16:00:00-08	1989-12-31 16:00:00-08	\N	4	2025-02-27 18:13:22.875106-08	2025-02-27 18:13:22.875106-08
64	13 Nichi wa Kinyoubi?	\N	13日は金曜日?	Ema is obsessed with ghosts, and is even part of her school's occult club. She'll do anything that has to do with some crazy superstition about ghosts or spirits, and make sure that she goes out of her way to do it. Ema is known for this at school, and the series follows her pursues to find ghosts. Ema, unfortunately, cannot see the things that she loves, unlike a few of her friends...\n\n(Source: StarryHeaven) \n\nIncluded one-shots:\nVolume 1: Shuugaku Ryoko no Susume\nVolume 3: Time Capsule and Happy End no Tsukurikata	https://cdn.myanimelist.net/images/manga/3/83691l.jpg	6.73	300	13252	17346	Finished	f	2003-03-02 16:00:00-08	2004-10-17 17:00:00-07	15	3	2025-02-27 18:13:22.937328-08	2025-02-27 18:13:22.937328-08
65	17-sai: Hajimete no H	\N	17歳 初めてのＨ	A collection of short stories revolving around a girl's first time!\n\n1. Shounen no Susume (A Boy's Suggestion) [Shinjo Mayu]\n2. Virgin Beast [Minami Kanan]\n3. Daitan ni Ikou!!! (Become Daring) [Ayukawa Mio]\n4. Itsumo Anata to Asagaeri! (When I'm with You, I Won't Be Home 'til Morning!) [Kousaka Yuuka]\n5. Koigokoro (The Awakening of Love) [Sakurai Miya]\n6. Kiss Kiss Kiss♥ ( Smooch Smooch Smooch) [Masuzaki Yoshino]\n7. Amai Yokubou (Sweet Desires) [Shigano Iori]	https://cdn.myanimelist.net/images/manga/3/267903l.jpg	6.44	2192	17191	5205	Finished	f	2001-06-25 17:00:00-07	\N	7	1	2025-02-27 18:13:22.98574-08	2025-02-27 18:13:22.98574-08
66	Ninin ga Shinobuden	Ninja Nonsense	ニニンがシノブ伝	Shinobu is the only girl that goes to the secret Ninja Academy, which is presided over by a strange, yellow, ball-organism, Onsokumaru. While he knows nothing about being a ninja master, he loses no opportunity to exploit the dim but cute Shinobu. On a mission to steal all the panties from area high school girls, Shinobu meets Kaede who gets drawn into the surreal, ecchi, but fun world of Shinobu.\n\n(Source: ANN)	https://cdn.myanimelist.net/images/manga/3/143955l.jpg	6.82	327	11756	14519	Finished	f	2000-07-17 17:00:00-07	2006-01-20 16:00:00-08	68	4	2025-02-27 18:13:23.043605-08	2025-02-27 18:13:23.043605-08
67	2001-ya Monogatari	2001 Nights	2001夜物語	Regardless of time and place, space has always been a primary subject of mankind's awe and fascination. Steadfast in discovering the truth behind their own existence, humans have continued to venture out far into the unknown, ready to confront any hurdle that comes along the way. Although the path ahead is one full of uncertainties, as long as humanity remains persistent in their endeavors, they may ultimately learn to understand each other and come closer to unraveling the intriguing mysteries of the universe.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/267904l.jpg	7.68	1641	1845	3721	Finished	f	1984-05-04 17:00:00-07	1986-05-05 17:00:00-07	20	3	2025-02-27 18:13:23.081565-08	2025-02-27 18:13:23.081565-08
68	3.3.7 Byooshi!!	\N	3.3.7ビョーシ!!	By all the usual measures, he could be considered a pretty useless guy: a scholastic failure, an athletic disaster, and a chronic loser... But Fukuda Shinichi has one passion: cheering for others! The 18-year-old captain of North Kanto Southern High's Cheerleading squad decides to make the most of his summer by attending cram school in Tokyo, only to find out that the whole trip was a sham! Things are looking up when he and his friend meet up with two cute Tokyo girls; too bad the girls brought them to a rip-off bar and took off! Ditched by his one remaining friend and stuck with an impossibly high bar bill, Fuku-kun's life couldn't get any worse! But just then he gets saved by Ume, his role model and former cheerleading squad captain! What is he doing in Tokyo... and why does everyone around seem to know and respect him? Without anywhere else to go, Fuku-kun decides follow Ume to his job, only to discover that... he's a male gigolo?!? Fukuda's summer of cheering others on has begun... and the streets of Tokyo's red-light district will never be the same!	https://cdn.myanimelist.net/images/manga/1/267905l.jpg	7.08	981	7799	7859	Finished	f	2001-07-24 17:00:00-07	2003-06-10 17:00:00-07	86	10	2025-02-27 18:13:23.132579-08	2025-02-27 18:13:23.132579-08
69	"Suki" to Ienai.	\N	“すき”と言えない。	Shiina has 2 secrets. She loves her brother Kiri a lot, and Kiri doesn't know that they are not blood related. She doesn't know what to do, she's been hiding it for a long time, and no one knows she loves him.\n\n(Source: MangaFox)	https://cdn.myanimelist.net/images/manga/2/267906l.jpg	6.73	3493	13253	3901	Finished	f	2006-10-13 17:00:00-07	\N	1	\N	2025-02-27 18:13:23.217677-08	2025-02-27 18:13:23.217677-08
70	Übel Blatt	Ubel Blatt	Übel Blatt ～ユーベルブラット～	When Wischtech threatened to invade the fiefs of Szaalanden, the Emperor dispatched fourteen youths. Of these, the Seven Heroes halted the invasion to herald a time of prosperity while the four Lances of Betrayal were supposedly defeated.\n\nTwo decades later, the Lances of Betrayal have reappeared and formed a bandit militia near the frontier fief Gormbark. A man with the black sword and a scar over his left eye slays an entire troop of that militia. He is identified as a boy, Kóinzell, and becomes as much an object of fear as of hope even as his own past, motivations, and purpose are a mystery to those he meets in his travel.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/2/55347l.jpg	7.60	19439	2304	290	Finished	f	2004-12-02 16:00:00-08	2019-03-24 17:00:00-07	167	23	2025-02-27 18:13:23.25534-08	2025-02-27 18:13:23.25534-08
71	Zettai Kareshi.	Absolute Boyfriend	絶対彼氏。	High school student Riiko Izawa has gone through a series of unrequited crushes. Each time she works up the courage to confess to a boy, he rejects her on the spot. After yet another rejection, Riiko becomes dejected and takes a walk through a nearby park. There, she discovers a lost phone and returns it to its owner.\n\nThe owner of the phone, Gaku Namikiri, is bizarre, to say the least. A traveling salesman, he pesters Riiko to accept one of his company's products as a reward. She tells him, sarcastically, that what she wants most of all is a boyfriend. Unfazed, he directs her to visit a website advertising "lover figures," which she assumes to be dolls. Despite her skepticism about the company's integrity, the face of the "Nightly Series 01" model enchants Riiko, and she registers for a three-day free trial. She is shocked when a life-sized naked boy is actually delivered to her the next day!\n\nRiiko follows instructions to activate the very realistic robot with a kiss, and for the next three days, Night Tenjou is the best boyfriend she could ask for. However, Gaku reappears to inform her that she missed the deadline to cancel the free trial, and now she owes one hundred million yen. Alternatively, she can decide to keep Night and act as a beta tester so that the company can collect data in order to improve their future products. What choice does Riiko have? She is broke, and what's more, she has already begun to fall for the artificially intelligent Night...\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/185981l.jpg	7.66	22094	1930	487	Finished	f	2003-05-19 17:00:00-07	2004-10-04 17:00:00-07	35	6	2025-02-27 18:13:23.337989-08	2025-02-27 18:13:23.337989-08
72	Abenobashi Mahou☆Shoutengai	Magical Shopping Arcade Abenobashi	アベノ橋 魔法☆商店街	Sasshi's world is in disarray. His best gal pal, Arumi, is about to move away, and his Osaka neighborhood is being demolished in the name of urban renewal.\n\nHowever, this little neighborhood has some surprises under its concrete—it's actually a portal to parallel universes. And when this section of the city is leveled, the portal is cracked wide open. Sasshi and Arumi soon find themselves being hurtled from one strange world to the next! Making matters even more surreal, is the fact that these worlds seem to spoof and mock popular movies, video games, manga and anime!\n\n(Source: TokyoPop)	https://cdn.myanimelist.net/images/manga/1/267907l.jpg	6.53	881	16100	9107	Finished	f	2001-07-25 17:00:00-07	2002-06-25 17:00:00-07	12	2	2025-02-27 18:13:23.421098-08	2025-02-27 18:13:23.421098-08
73	Tenjou Tenge	Tenjho Tenge	天上天下	In one unusual Tokyo high school, education takes a backseat to brawling as warring clubs wreak havoc in the hallways and chaos in the classrooms, all vying to be the baddest team around! Although they often contribute their fair share, only a handful of students serve to stem the tide of violence in this untamed outpost. These are the few, the proud, the powerful: the members of the Juken Club!\n\n(Source: CMX)	https://cdn.myanimelist.net/images/manga/3/267909l.jpg	7.24	12319	5516	635	Finished	f	1997-10-17 17:00:00-07	2010-08-18 17:00:00-07	136	22	2025-02-27 18:13:23.516531-08	2025-02-27 18:13:23.516531-08
74	Air Gear	Air Gear	エア・ギア	Itsuki Minami needs no introduction—everybody's heard of the "Babyface" of the Eastside. He's the toughest kid at Higashi Junior High School, easy on the eyes but dangerously tough when he needs to be. Plus, Itsuki lives with the mysterious and sexy Noyamano sisters. Life is never dull, but it becomes dangerous when Itsuki leads his school to victory over some vindictive Westside punks with gangster connections. Now he stands to lose his school, his friends, and everything he cares about. But in his darkest hour, the Noyamano girls come to Itsuki's aid. They can teach him a powerful skill that will save their school from the gangsters' siege–and introduce Itsuki to a thrilling and terrifying new world.\n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/1/167489l.jpg	7.78	40141	1402	188	Finished	f	2002-11-05 16:00:00-08	2012-05-22 17:00:00-07	358	37	2025-02-27 18:13:23.623692-08	2025-02-27 18:13:23.623692-08
83	Ayashi no Ceres	Ceres: Celestial Legend	妖しのセレス	Aya and her twin brother Aki thought they were going to a celebration of their sixteenth birthday at their grandfather's home, but the funeral-like atmosphere tips them off that something's not right. Their "birthday present" turns out to be a mummified hand—the power of which forces an awakening within Aya, and painful wounds all over Aki's body! Grandfather Mikage announces that Aki will be heir to the Mikage fortune, and Aya must die! But Aya has allies in the athletic cook and martial artist Yuuhi, and the attractive, mysterious Touya. But can even two handsome and resourceful guys save Aya when it's her own power that's out of control?\n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/3/160959l.jpg	7.56	6972	2545	1425	Finished	f	1996-08-04 17:00:00-07	2000-01-19 16:00:00-08	83	14	2025-02-27 18:13:24.417348-08	2025-02-27 18:13:24.417348-08
75	Ai yori Aoshi	Ai yori Aoshi	藍より青し	Kaoru Hanabishi is a kind, earnest college student with many friends and potential love interests. One day at the train station, he meets a beautiful girl wearing a kimono, who has plans to visit someone but is struggling with directions. Kaoru decides to help her find her way; however, upon arrival at the location, they find an empty plot of land. While searching for any outstanding clues, the girl shows Kaoru a photo of the person she is looking for.\n\nAs destiny would have it, Kaoru immediately recognizes the individual as himself with his childhood friend—the previously betrothed Aoi Sakuraba from the esteemed Sakuraba family—who is now sitting across from him. Their wedding was canceled many years prior after Kaoru left the highly regarded Hanabishi clan for personal reasons. Despite their time apart, Aoi remains committed to Kaoru.\n \nWith this fateful encounter, Kaoru and Aoi are reunited, though they must keep their relationship a secret to preserve the reputation of the Sakuraba family. This is only complicated by the different women that Kaoru finds himself surrounded by. Even so, Kaoru and Aoi wish to learn more about each other and stay together against their families' wishes.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/184631l.jpg	7.52	5959	2803	1537	Finished	f	1998-11-26 16:00:00-08	2005-08-25 17:00:00-07	153	17	2025-02-27 18:13:23.712457-08	2025-02-27 18:13:23.712457-08
76	Akachan to Boku	Baby & Me	赤ちゃんと僕	Takuya is a normal Japanese elementary student whose mother died not very long ago, leaving him alone with his father and his baby brother Minoru. But his father is a busy man, and Takuya has to look after Minoru. Because of this responsibility that would normally never burden a child of his age, Takuya sometimes resents his fate and his baby brother... but his love for Minoru gives him the strength to carry on.\n\n(Source: ANN)\n\nIncluded one-shots:\nVolume 2: Time Limit\nVolume 4: Secret Boy ni Tee Dasuna!!\nVolume 6: Baka de Karukute Wagamama de\nVolume 15: Natsu to Kimi no Irradiation	https://cdn.myanimelist.net/images/manga/3/179184l.jpg	7.66	947	1931	7585	Finished	f	1991-05-01 17:00:00-07	1997-06-19 17:00:00-07	108	18	2025-02-27 18:13:23.823252-08	2025-02-27 18:13:23.823252-08
77	Alice 19th	Alice 19th	ありす19th	The story follows Alice Seno, a 15-year-old girl forever shadowed by her older sister Mayura, who is good at everything she does. At school she is known as "Mayura's little sister" and is relentlessly tormented by the older girls who know that Alice is too weak to fight back.\n\nAlice harbors a deep affection for Kyo Wakamiya, a handsome upperclassman who is on the archery team with Mayura. On the way to school one day, Alice rescues a white rabbit from the road despite the danger to herself, but gets rescued by Kyo and receives a bracelet with a single red stone. The rabbit she saves, however, is no ordinary rabbit. She reveals her true form to Alice and introduces herself as Nyozeka. Alice is told that she is destined to become a Lotis Master. The Lotis Masters use the power of words and communication to enter the Inner Heart of others. It is a powerful ability to be used carefully as Alice soon finds out.\n\nUsing the power of the Lotis Words, which reveal themselves to be in the form of runes, Alice accidentally makes her older sister disappear during a dispute over Kyo, whom Mayura had begun dating. Alice then must use the Lotis Words to try and bring her sister back from the dark. She is joined by Kyo who proves to have the Lotis powers as well, and by Frey, another Lotis master who had trained with the masters and arrives with the intention to marry Alice. Unfortunately, Mayura has been taken by the power of the Maram Words, the dark reflection of the Lotis Words. Their only hope lies in Alice and Kyo becoming the legendary Neo-Masters to discover the lost word bonding both Maram and Lotis.\n\n(Source: Mangatraders)	https://cdn.myanimelist.net/images/manga/3/258981l.jpg	7.33	8675	4465	1261	Finished	f	2001-06-19 17:00:00-07	2003-03-04 16:00:00-08	40	7	2025-02-27 18:13:23.906317-08	2025-02-27 18:13:23.906317-08
78	Alichino	Alichino	ALICHINO 〜アリキーノ〜	Beautiful creatures called 'Alichino' grant any wish to those who find them--but at a price!\n\nA young lady searching for an Alichino wants to bring her brother back to life. She meets Tsugiri, a handsome young man who she thinks is an Alichino. While Tsugiri turns out to be a mere mortal, he does have a mysterious connection with these rare creatures--a connection that brings him and those around him grave danger!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/267910l.jpg	7.03	1959	8443	4399	Finished	f	1998-10-31 16:00:00-08	2001-04-30 17:00:00-07	17	3	2025-02-27 18:13:24.008816-08	2025-02-27 18:13:24.008816-08
79	Sora wa Akai Kawa no Hotori	Red River	天は赤い河のほとり	A seemingly ordinary modern day teenager, Yuri, is suddenly whisked away to the Hittite empire in ancient Anatolia, where an ambitious queen wants the girl for a blood sacrifice in order to murder all heirs but her son, thus seizing control of the throne. Luckily, the timely intervention of Prince Kail saves Yuri from the queen's grasp. Kail promises to send Yuri back to her home, but the queen's persistent schemes to kill them both, plus their growing feelings for each other, keep those plans delayed.\n\n(Source: Wikipedia)\n\nIncluded one-shot:\nVolume 28: Orontes Renka	https://cdn.myanimelist.net/images/manga/2/260695l.jpg	8.28	9620	329	765	Finished	f	1995-01-04 16:00:00-08	2002-06-04 17:00:00-07	96	28	2025-02-27 18:13:24.086883-08	2025-02-27 18:13:24.086883-08
80	Angelic Layer	Angelic Layer	ANGELIC LAYER	In the future, the most popular game in the world is Angelic Layer. Contestants must raise and train their own 'Angels' (or fighting dolls) to compete in tournaments. Enter Misaki Suzuhara, sixth grade Angelic Layer prodigy. With her speed-type angel, Hikaru, many people think Misaki stands a chance at winning the championship. She'll have a lot of help along the way, but the road to victory will be not be an easy route, especially for someone as young as Misaki.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/179060l.jpg	7.11	7711	7284	1366	Finished	f	1998-12-25 16:00:00-08	2001-09-25 17:00:00-07	28	5	2025-02-27 18:13:24.219321-08	2025-02-27 18:13:24.219321-08
81	Aria	Aria	ARIA	In the distant future, humanity has terraformed Mars into an oceanic planet to suit their needs. Now known as Aqua, the planet serves as a new home for people discontent with living on Manhome—the planet formerly known as Earth. Being a perfect imitation of Manhome's Venice, the town of Neo-Venezia has inherited all of the rustic charms of the original. Gondolas weave their way through the waterways of the dreamy town while nostalgic alleys await those who travel on foot.\n\nAkari Mizunashi, a young Manhome native, has recently made Neo-Venezia her new home. To pursue her dream of becoming a gondolier tour guide—or Undine—Akari joins the Aria Company, one of the most renowned water guide companies in town. As she basks in a simple lifestyle unavailable on Manhome, Akari cheerily ambles through her daily life in Neo-Venezia: the town where magic and miracles abound.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/202644l.jpg	8.62	10904	90	459	Finished	f	2002-02-27 16:00:00-08	2008-02-28 16:00:00-08	67	12	2025-02-27 18:13:24.313495-08	2025-02-27 18:13:24.313495-08
143	Beautiful People	Beautiful People	beautiful people	Beautiful People is a manga comprised of six profound and thought-provoking short stories.\n\n1. Seppakuhime (Princess White Snow)\n2. World's End\n3. Anti-Telephonica (Electric Angel)\n4. Stalker no Onna (The Lady Stalker)\n5. Beautiful People\n6. Kuuki no Naka wo Nukeru Sora (Blue Sky)	https://cdn.myanimelist.net/images/manga/1/173682l.jpg	7.15	1939	6774	4924	Finished	f	2001-09-30 17:00:00-07	\N	6	1	2025-02-27 18:13:29.396866-08	2025-02-27 18:13:29.396866-08
84	Fushigi Yuugi	Fushigi Yugi	ふしぎ遊戯	While visiting the National Library, junior-high students Miaka Yuuki and Yui Hongo are transported into the world of a mysterious book set in ancient China, "The Universe of The Four Gods." Miaka suddenly finds herself with the responsibility of being the priestess of Suzaku, and must find all of her celestial warriors for the purpose of summoning Suzaku for three wishes. However, the enemy nation of the god Seiryuu has manipulated Yui into becoming the priestess of Seiryuu. As enemies, the former best friends begin their long struggle to summon their respective gods and obtain their wishes...\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/267911l.jpg	7.63	10945	2124	802	Finished	f	1992-04-30 17:00:00-07	1996-06-30 17:00:00-07	106	18	2025-02-27 18:13:24.55936-08	2025-02-27 18:13:24.55936-08
85	Azumanga Daioh	Azumanga Daioh	あずまんが大王	Chiyo Mihama is a child prodigy who has skipped several grades to end up in high school. On her first day, she discovers that her class is full of eccentric individuals. Sakaki, who towers over Chiyo, is aloof and intimidating; Tomo Takino is loud and annoying; Ayumu "Osaka" Kasuga is absentminded but great at solving riddles; Koyomi "Yomi" Mizuhara is obsessed with diets and loves karaoke despite her awful singing; and Kagura, who is a competitive tomboy.\n\nAs the classmates become good friends over time, they experience their everyday lives together—things like school, studying, going on summer trips, and engaging in all kinds of shenanigans!\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/259651l.jpg	8.36	26434	253	309	Finished	f	1999-01-17 16:00:00-08	2002-03-20 16:00:00-08	69	4	2025-02-27 18:13:24.685446-08	2025-02-27 18:13:24.685446-08
86	Time Stranger Kyoko	Time Stranger Kyoko	時空異邦人KYOKO	From the creator of Full Moon wo Sagashite comes a story set in the 30th century, when the whole world is ruled under one kingdom named Earth. Princess Kyouko is about to turn 16 years old, and a large celebration will be held throughout the country. Unknown to the people, the princess has secretly been living among them as Kyouko Suomi, a headstrong and selfish junior high student. Kyouko has never appeared at any of the kingdom's past ceremonies, and doesn't plan to attend this ceremony either, for doing so will end her youthful school life.\n\nHowever, her father, the king of Earth, offers her another option—Kyouko must find the 12 telepaths who can use the God Stones in order to wake up her twin sister, Princess Ui, who has been asleep since her birth. If Kyouko succeeds, the king will allow her to live however she likes, and will pass on her duties to her sister. Accepting this offer, Kyouko is given the first of the God Stones, the Time-Space Stone, and will need to find the remaining God Stones and their users, with the help of her two bodyguards Sakataki and Hizuki Jin.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/175908l.jpg	7.17	4798	6429	2261	Finished	f	2000-08-02 17:00:00-07	2001-08-02 17:00:00-07	13	3	2025-02-27 18:13:24.748052-08	2025-02-27 18:13:24.748052-08
87	Tactics	Tactics	tactics	Meet Kantarou, a folklore scholar living in the Taisho period. Ever since he was a child, he has been able to see and talk to various spirits. But now that Kantarou's all grown up, he moonlights as an exorcist solving the problems of ghosts and demons...all with the help of Haruka, the legendary demon-eating tengu!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/158123l.jpg	7.33	985	4466	6194	Finished	f	2000-12-17 16:00:00-08	2013-04-14 17:00:00-07	82	15	2025-02-27 18:13:24.831059-08	2025-02-27 18:13:24.831059-08
88	Angel/Dust	Angel/Dust	ANGEL/DUST	A mysterious creature has fallen from the sky and landed right at young Yuina's feet! Branded as the master of this new angelic being, Yuina is forced into an otherworldly pact, one that will take her beyond the clouds and into battle against a new and yet hauntingly familiar evil, one that patiently waits in the shadows.\n\n(Source: ADV)	https://cdn.myanimelist.net/images/manga/1/179773l.jpg	6.35	2084	18039	5224	Finished	f	2000-04-09 17:00:00-07	2000-12-08 16:00:00-08	9	1	2025-02-27 18:13:24.884893-08	2025-02-27 18:13:24.884893-08
89	Gals!	GALS!	GALS！	Self-styled Kogal queen Kotobuki Ran and her friends just wanna have fun, which includes shopping, hanging out, and scamming meals off gullible guys. Unfortunately, their "hood"—Shibuya—is in constant danger of being despoiled by dirty old men, street gangs, nasty Kogal rivals, and other societal evils. But with a little help from her friends and a toughness born of coming from a family full of cops, Ran takes on the bad guys (and gals) with gusto!\n\n(Source: CMX)	https://cdn.myanimelist.net/images/manga/3/267912l.jpg	7.41	1713	3749	5137	Finished	f	1999-07-31 17:00:00-07	2002-07-14 17:00:00-07	40	10	2025-02-27 18:13:24.938064-08	2025-02-27 18:13:24.938064-08
90	Loveless	Loveless	LOVELESS	Aoyagi Ritsuka is one troubled 6th grader. Two years ago, he mysteriously lost his memory and developed an alternate personality. His mother constantly berates (and occasionally beats) him, asking what happened to the "real" Ritsuka, and his only defender and friend, his older brother Seimei, was recently killed.\n\nSuddenly, Seimei's apparent "friend," Soubi, appears. Soubi tells him that Ritsuka's true name is "Loveless," and that Soubi was assigned by Seimei to take care of Ritsuka and protect him. Ritsuka soon gets sucked into a bizzare underground society where teams of people, a "Fighter Unit," and a "Sacrifice," battle using elaborate and beautifully-phrased spells.\n\nHe seeks both acceptance of himself, and the answer to the mystery of who killed his brother and why.\n\n(Source: TokyoPop)	https://cdn.myanimelist.net/images/manga/2/171051l.jpg	7.61	11232	2229	669	On Hiatus	f	2001-11-16 16:00:00-08	2017-07-27 17:00:00-07	\N	13	2025-02-27 18:13:25.034311-08	2025-02-27 18:13:25.034311-08
91	Marmalade Boy	Marmalade Boy	ママレード・ボーイ	All Miki Koishikawa wanted was an ordinary family and that's exactly what she had until her parents decided to move in with another couple and turned Miki's world upside down. Now she lives in a house with four parents and her totally cute stepbrother Yuu. It's bad enough being brought into her parents' strange soap opera, but Miki will star in a soap of her own as she deals with friends having affairs, trying to survive in school and ending up torn between her long-time crush, Ginta, and her new stepbrother!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/262987l.jpg	7.57	9230	2470	1074	Finished	f	1992-04-30 17:00:00-07	1995-09-30 17:00:00-07	40	8	2025-02-27 18:13:25.127772-08	2025-02-27 18:13:25.127772-08
92	Bishoujo Senshi Sailor Moon	Sailor Moon	美少女戦士セーラームーン	"In the name of the moon, I shall punish you!"\n\nUsagi Tsukino is a cheerful 14-year-old who attends Juuban Municipal Junior High School. She prefers eating and playing video games to studying, which results in her notably poor grades. She also gets easily upset, whether by baseless insults or reasonable reprimands. It is very unlikely that she could be known as anything but a bad influence and a crybaby, but that begins to change when she meets a black cat.\n\nGiven a special brooch from the black cat named Luna, Usagi can use it to transform into a guardian of justice named Sailor Moon! She is now tasked to protect the Earth from all that is evil and to find both a missing princess and a sacred jewel known as the Mystical Silver Crystal. Whether she likes it or not, Usagi's beautiful transformation marks the start of meeting the mysterious Tuxedo Mask, fighting alongside new comrades, and learning to take responsibility in this acclaimed magical girl classic.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/4/260613l.jpg	8.19	25291	448	303	Finished	f	1991-12-27 16:00:00-08	1997-02-02 16:00:00-08	61	18	2025-02-27 18:13:25.218996-08	2025-02-27 18:13:25.218996-08
93	Megami Kouhosei	The Candidate for Goddess	女神候補生	It is the year 4088. It has been over one thousand years since the Crisis of Systems (Lost Property), which resulted in the destruction of four planetary systems, leaving only a single inhabitable planet, Zion. Mankind is forced to live in space colonies, since that one planet is constantly being invaded by alien life forms that have come to be known as Victim.\n\nTo stop the aliens and to allow people to land on Zion, mankind has developed the astronomical humanoid weapons, Ingrids, also known as Goddesses. G.O.A. (Goddess Operation Academy) is a school dedicated to the training of young men to pilot these Ingrids...\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/180628l.jpg	6.86	963	11187	8614	Finished	f	1996-10-31 16:00:00-08	2000-12-31 16:00:00-08	27	5	2025-02-27 18:13:25.304045-08	2025-02-27 18:13:25.304045-08
94	D.N.Angel	D.N. Angel	D・N・ANGEL	Daisuke Niwa is an ordinary, if slightly unlucky, middle school student. On his fourteenth birthday, he comes down with a 'condition' that has plagued the men in his family for three hundred years. When he sees his crush, Risa, he transforms into his alter ego, the phantom thief Dark Mousy. Unfortunately, when Dark Mousy sees his crush, Risa's twin Riku, he transforms back into Daisuke. The only cure for this craziness is if Daisuke can get Risa to fall in love with him...\n\n(Source: Tokyopop)\n\nIncluded one-shots:\nVolume 1: Namaiki no 'N' (N is for Nishiki)\nVolume 2: OumagaAGAIN (The Demon Returns)\nVolume 4: Kanno-ke wa Kanai Anzen. (Protecting The Kanno House)	https://cdn.myanimelist.net/images/manga/2/145023l.jpg	7.41	13736	3697	626	Finished	f	1996-12-31 16:00:00-08	2021-01-21 16:00:00-08	108	20	2025-02-27 18:13:25.375042-08	2025-02-27 18:13:25.375042-08
95	Lagoon Engine	Lagoon Engine	ラグーンエンジン	Yen and Jin are brothers in elementary school and successors in the Ragun family craft of defeating evil spirits. In this world, the battle with spirits comes down to a game of guessing your opponent's "name." Once you know the name you gain control over the fight. Both Yen and Jin have secret names only they know... and must keep them secret or risk death!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/179821l.jpg	6.92	429	10240	15435	On Hiatus	f	2001-12-31 16:00:00-08	2007-10-31 17:00:00-07	31	7	2025-02-27 18:13:25.456206-08	2025-02-27 18:13:25.456206-08
96	Lagoon Engine Einsatz	Lagoon Engine Einsatz	ラグーンエンジン アインザッツ	Sakis, the Scion and Godslayer, gets entangled in a deadly incident when an unknown ship enters Lagoonarian airspace. After uncovering explosives along with the seeds of Abomination, Sakis begins a quest to uncover the mysteries surrounding the Ancient Gods!	https://cdn.myanimelist.net/images/manga/2/179820l.jpg	6.80	226	12174	19389	Finished	f	2004-09-30 17:00:00-07	2005-06-30 17:00:00-07	10	1	2025-02-27 18:13:25.531809-08	2025-02-27 18:13:25.531809-08
97	DearS	DearS	ディアーズ	Aliens have landed on Earth and are now a normal part of society. These beautiful beings have been given the name "DearS" and are trusted and welcomed by most humans. In order for the "DearS" to learn Earth\\'s customs, they are sent to random high schools to "home-stay." When Takeya helps a DearS in his school, she calls him "Master." Thus begins the humorous life of Takeya and his sexy alien follower, Ren, who tries to figure out the wacky customs of this place called Earth! (Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/265668l.jpg	7.12	5802	7124	1878	Finished	f	2001-08-26 17:00:00-07	2005-09-26 17:00:00-07	47	8	2025-02-27 18:13:25.634301-08	2025-02-27 18:13:25.634301-08
98	Rozen Maiden	Rozen Maiden	Rozen Maiden	The legendary dollmaker Rozen created several unique dolls throughout his life, but it was not the materials he used that made them special. Known as Rozen Maidens, each doll was imbued with a Rosa Mystica—a precious gem that gives them life. But these dolls have a specific purpose: they must fight each other in a contest called the Alice Game. The winner becomes Alice, the perfect girl who will have the chance to meet their father and creator.\n\nJun Sakurada, a middle school shut-in, experiences the Alice Game up close and personal when one of these dolls arrives at his house. After winding her up with the spring provided, she comes to life and introduces herself as Shinku, the fifth Rozen Maiden. Despite Jun quickly becoming annoyed by her haughty attitude, they find themselves working together when they are attacked by another doll. At Shinku's behest, Jun becomes her medium, allowing her to use his life force as a power to defeat their enemies.\n\nIn the aftermath of the fight, more Rozen Maidens appear and decide to live at Jun's house. But can there be any peace when their very existence means they must fight each other?\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/271890l.jpg	7.76	7351	1492	1045	Finished	f	2002-08-11 17:00:00-07	2007-05-29 17:00:00-07	46	8	2025-02-27 18:13:25.737281-08	2025-02-27 18:13:25.737281-08
99	Zombie-Loan	Zombie-Loan	ZOMBIE-LOAN	Michiru Kita’s a weak-spirited girl who has a hard time saying what’s on her mind. One day, she notices mysterious, ring-like markings around the necks of two of her classmates, Chika Akatsuki and Shito Tachibana — two boys who miraculously survived a horrible accident six months before. Michiru, possessing the rare ability to see these rings, knows that they warn of impending death. Thinking that, perhaps, she can do something to save her classmates’ lives, she approaches them... but it seems the boys have already made a different kind of deal and garnered themselves a heavy debt \n\n(Source: Yen Press)	https://cdn.myanimelist.net/images/manga/3/267914l.jpg	7.32	7243	4631	1058	Finished	f	2002-10-17 17:00:00-07	2011-02-17 16:00:00-08	83	13	2025-02-27 18:13:25.815004-08	2025-02-27 18:13:25.815004-08
100	Prism Palette	\N	プリズムパレット	Based on an ero-game, Prism Palette is Peach-Pit’s (famous for DearS, Zombie Loan, Rozen Maiden and assorted other manga) first publication. It follows the main character, Masaki Shirai, as he spends his days at school, surrounded by beautiful girls. (Source: AT-Translations)	https://cdn.myanimelist.net/images/manga/3/267915l.jpg	6.18	285	19098	20171	Finished	f	2001-08-31 17:00:00-07	\N	10	1	2025-02-27 18:13:25.945894-08	2025-02-27 18:13:25.945894-08
101	Shugo Chara!	Shugo Chara!	しゅごキャラ！	What kind of person will I become? What can I do for myself? Children ponder those very questions, and from those thoughts, the "Heart's Egg" is born. Unseen by most, the Heart's Egg remains hidden within every individual, and represents a person's own ideal character.\n\nWhile adjusting to life at a new school, Amu Hinamori has unintentionally gained a reputation for being "cool and spicy." Unhappy with her outward persona, Amu often wonders how she can act more like her true self. Her desire for change is manifested when one morning, Amu awakens to find three eggs beneath her. They hatch to reveal Ran, Miki and Suu—three "Guardian Characters," each an embodiment of Amu's ideal self.\n\nShugo Chara! follows Amu's journey as the trio begin to show her just how much potential she has, encountering other Guardian Characters, and a few troublesome experiences along the way.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/135293l.jpg	7.71	19928	1672	464	Finished	f	2005-12-27 16:00:00-08	2010-08-02 17:00:00-07	55	12	2025-02-27 18:13:26.004107-08	2025-02-27 18:13:26.004107-08
144	Kamisama Damono♥	Because I'm the Goddess	神様だもの♥	Goddess Pandora was sent to Earth to collect "gifts" that were spread among humans. She has a nice body that can temp anyone who looks at her, but when she uses her powers, she shrinks to a young girl's body. The only way to gain her power back is to kiss her reluctant peon, Aoi.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/625l.jpg	6.73	723	13255	11391	Finished	f	2003-11-24 16:00:00-08	2004-12-23 16:00:00-08	19	3	2025-02-27 18:13:29.477661-08	2025-02-27 18:13:29.477661-08
102	Fruits Basket	Fruits Basket	フルーツバスケット	Tooru Honda is an orphan with nowhere to go but a tent in the woods, until the Souma family takes her in. However, the Souma family is no ordinary family, and they hide a grave secret: when they are hugged by someone of the opposite gender, they turn into animals from the Chinese zodiac!\n\nNow, Tooru must help Kyou and Yuki Souma hide their curse from their classmates, as well as her friends Arisa Uotani and Saki Hanajima. As she is drawn further into the mysterious world of the Soumas, she meets more of the family, forging friendships along the way.\n\nBut this curse has caused much suffering; it has broken many Soumas. Despite this, Tooru may just be able to heal their hearts and soothe their souls.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/269697l.jpg	8.53	74640	134	81	Finished	f	1998-07-17 17:00:00-07	2006-11-19 16:00:00-08	136	23	2025-02-27 18:13:26.095368-08	2025-02-27 18:13:26.095368-08
103	Never Give Up!	Never Give Up!	ネバギバ！	At the age of four, Kiri Minase fell in love with her childhood friend Tohya Enishi and proposed to him. Their families, however, were not very supportive of this match. Both children have parents who work as models and to whom they owe their good looks. The trouble is, Kiri inherited chiseled masculine features from her father and Tohya inherited his mother's delicate beauty. For years, Kiri has been working hard toward becoming a girl worthy of Tohya, but even now, she faces constant reminders that everyone regards her as unsuitable for him due to her lack of femininity.\n\nOne day, Tohya is scouted by a fashion photographer and agrees to work as a model for the agency owned by Kiri's mother. Kiri is concerned that Tohya will be preyed upon by other men in the fashion world, and so she begs her mother to hire her as well. Her wish is granted with a twist, as she is forced to pose as a male model under the name "Tatsuki." During their first photo shoot, it seems that Kiri's worries are well-founded when the photographer won't keep his hands off Tohya. With the desire to protect Tohya warring against the fear that she will appear undesirable to him the longer she pretends to be male, Kiri must come to terms with her identity and decide if outer beauty is really more important than what lies inside.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/270458l.jpg	7.37	888	4119	6802	Finished	f	1999-02-04 16:00:00-08	2002-12-04 16:00:00-08	77	13	2025-02-27 18:13:26.184312-08	2025-02-27 18:13:26.184312-08
104	Yotsuba to!	Yotsuba&!	よつばと!	While most people find the world mundane, five-year-old Yotsuba Koiwai sees it as a treasure trove of amazing bustle and wonderful places to explore. When she and her adoptive father, Yousuke, move to a new city, the energetic young girl naturally sets out to investigate the neighborhood on her own.\n\nAfter a few incidents at the local park, the Koiwais become acquainted with their neighbors, the Ayase family. Their three daughters—mischievous college student Asagi, responsible high school student Fuuka, and kindhearted grade school student Ena—eventually all take a liking to Yotsuba and join in on her antics, despite their sheer ridicule.\n\nFrom learning how to use a swing to figuring out how to stop global warming with air conditioners, Yotsuba's ability to infallibly find fun in everything, both amazes and annoys the people around her. Along with Yousuke, the Ayases, and friends she makes along the way, Yotsuba embarks on daily adventures, each one a step in her quest to enjoy the simple things in life.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/5/259524l.jpg	8.90	57688	23	70	Publishing	t	2003-03-20 16:00:00-08	\N	\N	\N	2025-02-27 18:13:26.264778-08	2025-02-27 18:13:26.264778-08
105	Kekkaishi	Kekkaishi	結界師	By night, junior high student Yoshimori Sumimura is a "kekkaishi"—a demon-hunter who specializes in creating magical barriers around his prey. By day, Yoshimori's got some other demons to battle: an addiction to sweets and a seriously crotchety grandfather! Yoshimori's pretty 16-year-old neighbor and childhood friend, Tokine Yukimura, is also a kekkaishi, but their families are feuding over who is the true practitioner of the art. \n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/5/207702l.jpg	7.98	14032	803	604	Finished	f	2004-02-17 16:00:00-08	2011-04-05 17:00:00-07	345	35	2025-02-27 18:13:26.35082-08	2025-02-27 18:13:26.35082-08
106	Cardcaptor Sakura	Cardcaptor Sakura	カードキャプターさくら	"Herein lie the Clow Cards—if their seal is broken, disaster shall befall this world..."\n\nSakura Kinomoto is an energetic and sweet 10-year-old girl attending Tomoeda Elementary School. One day not long after entering the fourth grade, Sakura finds a mysterious book titled The Clow hidden within her father's bookshelves. Upon opening it, a small, winged creature with an Osakan accent comes out of the book and introduces itself as Keroberos, the Creature of the Seal who guards magical cards known as the Clow Cards and keeps them from escaping the book.\n\nUnfortunately for the plushy guardian, it seems that the Clow Cards have already escaped—and now Sakura is tasked with capturing them before the cards unleash their powers and cause havoc all over Tomoeda! With the support of the tiny guardian who she nicknames "Kero" and her best friend, Tomoyo Daidouji, Sakura must wield a magical bird-shaped key and use her new powers as the Cardcaptor to maintain peace and ensure that everything is alright.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/259289l.jpg	8.37	32422	241	253	Finished	f	1996-05-01 17:00:00-07	2000-07-02 17:00:00-07	50	12	2025-02-27 18:13:26.435973-08	2025-02-27 18:13:26.435973-08
107	Chobits	Chobits	ちょびっツ	After enduring four years of high school, Hideki Motosuwa strives to get into the university of his choice by attending cram school in Tokyo. Concurrently, he works daily shifts at a bar to make ends meet, thus missing out on the world's latest invention—human-like computers called Persocoms. Longing for a persocom of his own, Hideki is met with a stroke of luck when he stumbles upon a cute abandoned persocom in a garbage pile.\n\nUpon finding the power button, Hideki finds his newfound robot to be faulty and only capable of uttering the word "Chii"—which Hideki decides to name her after. Chii, however, is no ordinary persocom: capable of thinking and learning on her own, she is a legendary type of robot known as a Chobit. Now, it is up to Hideki to teach Chii how to live an ordinary life and to uncover the truth behind the elusive chobits series.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/260812l.jpg	7.78	37596	1403	234	Finished	f	2000-09-24 17:00:00-07	2002-10-27 16:00:00-08	88	8	2025-02-27 18:13:26.544817-08	2025-02-27 18:13:26.544817-08
108	Gouhou Drug	Legal Drug	合法ドラッグ	Snow surrounds the 17-year-old Kazahaya Kudou while he fights not to lose consciousness amid the freezing landscape. Luckily, a cold-blooded young man named Rikuo Himura saves him and brings him to his boss, Kakei, owner of Green Drugstore. Out of necessity, Kazahaya agrees to become Kakei's employee.\n\nHowever, Kazahaya's job is not limited to organizing shelves and dealing with customers. Due to his ability to see strange things, Kazahaya is commissioned to complete dangerous assignments in exchange for money. Begrudgingly paired, Kazehaya and Rikuo—who also seems to possess unique powers—must take on these missions while confronting ghosts from the past that are hunting them down.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/185400l.jpg	7.36	5571	4203	1692	Finished	f	2000-10-05 17:00:00-07	2003-07-23 17:00:00-07	18	3	2025-02-27 18:13:26.649456-08	2025-02-27 18:13:26.649456-08
109	Wish	Wish	Wish	Walking home from work one night, Shuuichirou Kudou encounters a child-like being with wings trapped on a tree branch. After he saves the creature, they introduce themselves as Kohaku, an angel from Heaven. Skeptical of the supernatural, Shuuichirou ignores Kohaku and goes back home, dismissing it as a dream.\n\nThe next day, Shuuichirou finds Kohaku in his garden, who has now taken on their true form. They tell him that, for his kindness, they want to grant him any wish. However, Shuuichirou is content with what he has and declines. Kohaku decides that, instead of doing nothing, they will stay with their savior until he desires something only they can deliver.\n\nAlthough Kohaku becomes accustomed to their homely life with Shuuichirou, they cannot remain on Earth for long due to being tormented by Kouryuu—a mischievous devil—and his sidekicks. In addition, Kohaku is on borrowed time to find the missing archangel Hisui and must hurry before they are both banished from Heaven forever.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/157425l.jpg	7.42	7345	3641	1471	Finished	f	1995-10-05 17:00:00-07	1998-06-05 17:00:00-07	26	4	2025-02-27 18:13:26.718791-08	2025-02-27 18:13:26.718791-08
110	AI ga Tomaranai!	A.I. Love you	AIが止まらない！	Hitoshi Kobe is pretty dumb, not good at sports, and extremely unpopular. The only thing he IS good at really is creating artificial intelligence programs on his computer. His greatest work is number 30, one which very accurately simulates talking to an actual girl. One dark and stormy night, a freak lightning strike causes number Thirty to emerge from his computer screen as a real girl, and sends Hitoshi's life on a turn for the crazy.\n\n(Source: ANN)	https://cdn.myanimelist.net/images/manga/3/54753l.jpg	6.94	3274	9916	3038	Finished	f	1994-04-05 17:00:00-07	1997-08-19 17:00:00-07	55	9	2025-02-27 18:13:26.795676-08	2025-02-27 18:13:26.795676-08
111	Mahoromatic	\N	まほろまてぃっく	Vesper is a secret agency fighting an army of alien invaders by using super-powerful battle androids. Mahoro is Vesper\\'s most powerful battle android and has won many battles, but she has little operating time left and soon will cease to function. However, if she lays down her arms and conserves her remaining power, the time she has left can be prolonged to just over a year. Mahoro is given an opportunity to live the remaining time she has as a normal human. She chooses to live as a maid for Suguru, a phenomenally messy high school student who lives by himself after his family passed away.\n\n(Source: ANN)	https://cdn.myanimelist.net/images/manga/1/180649l.jpg	7.38	1490	4012	5492	Finished	f	1998-11-30 16:00:00-08	2004-07-25 17:00:00-07	45	8	2025-02-27 18:13:26.897785-08	2025-02-27 18:13:26.897785-08
112	Shin Shunkaden	The Legend of Chun Hyang	新・春香伝	Chun Hyang is a young girl who lives in a village ruled by a tyrannical Yang Ban. When her mother Wall Mae tragically dies, Chun Hyang sets of on an adventure with Mong Ryong, a young traveler who holds the empire's most powerful office as the Am-Hang-Osa. Based on a Korean legend.\n\n(Source: ANN)	https://cdn.myanimelist.net/images/manga/1/272019l.jpg	6.90	1934	10514	5689	Finished	f	1992-10-19 17:00:00-07	1994-02-19 16:00:00-08	3	1	2025-02-27 18:13:27.017246-08	2025-02-27 18:13:27.017246-08
113	Clover	Clover	Clover	Retiring as a soldier of the government of a high-tech city, Fay Ryu Kazuhiko's transition into civilian life is cut short when his superior, General Ko, summons him. Having a leaf imprinted onto his hand by code, Kazuhiko is entrusted with a secret task to deliver a "package"—a girl with white hair and evergreen eyes whom he finds singing in a birdcage-like building. All Kazuhiko knows is that her name is Suu, and for whatever reason, she wishes to go to Fairy Park.\n\nAs his friends Lan and Gingetsu help set up a transport module for the duo, Kazuhiko suspects that there is more to Suu than he knows. Not only is their transport intercepted, but the two are also pursued by Bols—a face that is uncomfortably familiar to Kazuhiko and who seems to have received his own mission to seek out Suu. The truth behind the discreet nature of this operation, Suu's existence, and even a possible connection between her and Kazuhiko may all be linked to just one word: clover.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/257992l.jpg	7.51	6983	2897	1117	Finished	f	1996-12-31 16:00:00-08	1998-12-31 16:00:00-08	20	4	2025-02-27 18:13:27.13569-08	2025-02-27 18:13:27.13569-08
114	Erementar Gerad	Elemental Gelade	EREMENTAR GERAD	Coud is a young sky pirate who discovered a girl with mysterious powers on what had seemed like a routine mission. Ren has the ability to lend Coud bizarre fighting capabilities (his arm turns into a giant blade of some sort), being part of a race of beings called Edel Reid, but being the possessor of a stone called the Elemental Gelade, she has powers even beyond the norm.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/260247l.jpg	7.47	3739	3151	2298	Finished	f	2002-02-27 16:00:00-08	2009-12-27 16:00:00-08	96	18	2025-02-27 18:13:27.229488-08	2025-02-27 18:13:27.229488-08
115	Erementar Gerad: Aozora no Senki	Erementar Gerade: Flag of Bluesky	EREMENTAR GERAD －蒼空の戦旗－	The Kingdom of the Sun, Fuajarl was ruthlessly invaded by the Garden of Eden. They came seeking the King's Edel Raid, rumored to be one of the Shichikou-houju (Seven Glittering Jewels).\n\nSensing their intent, the King hid his daughter with his Edel Raid and fought against the invasion but was defeated in battle that resulted in the desert kingdom being blanketed in a sheet of white snow.\n\nEscaping capture, the Crown Princess Achea Fuajarl XIV reacted with Jeen, the King's Edel Raid, and along with Puffe, the Kingdom's only mechanic, fled Fuajarl in an ancient tank. They are on a journey to restore the Kingdom and exact vengeance on the Garden of Eden.\n\nThis story takes place two years after Erementar Gerad.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/2/158740l.jpg	7.06	518	8033	10559	Publishing	t	2003-06-15 17:00:00-07	\N	\N	\N	2025-02-27 18:13:27.323899-08	2025-02-27 18:13:27.323899-08
116	.hack//G.U.+	.hack//G.U.+	.hack//G.U.+	It is the year 2017, and the stakes have gotten even higher in the massively multiplayer online game The World--now The World R:2, a dangerous place overrun by player killers, where lawlessness abounds. The PKK Haseo, known as "The Terror of Death," is a fearsome foe who punishes those who want to slay other players. But things have gotten personal as Haseo tries to track down the killer Tri-Edge, who has threatened the real life of his friend Shino...\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/4/126081l.jpg	7.29	2567	4982	3995	Finished	f	2005-12-31 16:00:00-08	2008-12-31 16:00:00-08	26	5	2025-02-27 18:13:27.41406-08	2025-02-27 18:13:27.41406-08
117	.hack//Tasogare no Udewa Densetsu	.hack//Legend of the Twilight	.hack//黄昏の腕輪伝説	Welcome to The World, the most advanced online game ever created. In The World you can be anyone you want to be, act out your adventure fantasies and through teamwork and determination, you can even become a hero. 14-year-old twins Shuugo and Rena just won a contest that lets them play as the legendary avatars 'Kite' and 'Black Rose.' Armed with the power of the Twilight Bracelet, the two must discover what is causing rogue monsters to infect The World and carry on the legend of the .hackers.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/191726l.jpg	7.03	10151	8444	1226	Finished	f	2001-12-09 16:00:00-08	2003-10-09 17:00:00-07	24	3	2025-02-27 18:13:27.478393-08	2025-02-27 18:13:27.478393-08
170	Mondaiteiki Sakuhinshu	Confidential Confessions	問題提起 作品集	Confidential Confessions is a shocking new manga series that deals with many of the hard-hitting issues that teens face today. Using emotionally moving story lines and multi-dimensional characters, each groundbreaking volume tackles such topics as teen prostitution, rape, HIV, stalkers, suicide, and sexual harassment. \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/11131l.jpg	7.68	2023	1846	3661	Finished	f	1999-12-31 16:00:00-08	2001-12-31 16:00:00-08	23	6	2025-02-27 18:13:31.414852-08	2025-02-27 18:13:31.414852-08
118	Kobato.	Kobato.	こばと。	In a certain city in Japan, one's heart faintly shimmers above the rest—a seemingly odd and naive brunette named Kobato Hanato. Despite appearing to wander around, the pure-hearted girl aspires to fulfill one precious wish: to reach a particular place. But for it to be granted, she must learn how to heal the wounded hearts of the people and collect them in a magic bottle.\n\nHowever, the world can be confusing for such an innocent girl. Her companion Ioryogi can be quite rough in teaching her common sense, especially for a talking blue dog plushie! Luckily for Kobato, a certain quaint place with a troubled history seems to be—and may be looking for—a glimmer of hope.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/154345l.jpg	7.92	9323	932	888	Finished	f	2004-12-17 16:00:00-08	2011-07-07 17:00:00-07	40	6	2025-02-27 18:13:27.573987-08	2025-02-27 18:13:27.573987-08
119	Magic Knight Rayearth	Magic Knight Rayearth	魔法騎士〈マジックナイト〉レイアース	Three high school girls—hot-blooded Hikaru Shidou, haughty Umi Ryuuzaki, and gentle Fuu Hououji—have just met at Tokyo Tower when they hear a call for help that pulls them into another world. They are soon greeted by Guru Clef, a youthful-looking man who informs them that they are the legendary Magic Knights summoned by Princess Emeraude to save this magical land known as Cephiro.\n\nWhile Hikaru finds the prospect exciting, Umi and Fuu simply want to return to their own world. Unfortunately for them, Clef explains that they cannot go home until they have saved Cephiro and banished the monsters plaguing it. In order to do so, they have to rescue Princess Emeraude from the clutches of the powerful Lord Zagato. To stand a chance against him, they must revive mysterious beings called Rune Gods.\n\nAs Clef grants the trio armor and magic, one of Zagato's servants attacks, forcing the guru to send the girls away to the weaponsmith Presea and the rabbit-like guide Mokona, who can further equip them for their journey. Though they have a long way to go, Hikaru, Umi, and Fuu will show that they have what it takes to live up to their titles as Magic Knights and bring salvation to Cephiro.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/272013l.jpg	7.59	10951	2331	922	Finished	f	1993-10-31 16:00:00-08	1995-01-31 16:00:00-08	15	3	2025-02-27 18:13:27.647975-08	2025-02-27 18:13:27.647975-08
120	Maburaho	\N	まぶらほ	His name is Kazuki Shikimori, 17 years old. He attends Aoi Academy, a school for elite magicians. Each magician has a set limit of spells, and performing more spells than the limit allows will cause the user to turn into dust. In this case, the number of magic Kazuki can use is far below the average in his school. Then one day, all of a sudden, three girls appear before him. But of all the things that they are after, it is his GENES. And for Kazuki, the girls' appearances may also spell his doom, as he soon realizes that his magic count is decreasing ever steadily.\n\n(Source: ANN)	https://cdn.myanimelist.net/images/manga/1/180923l.jpg	7.05	190	8137	16936	Finished	f	2001-12-19 16:00:00-08	2015-03-19 17:00:00-07	133	22	2025-02-27 18:13:27.714698-08	2025-02-27 18:13:27.714698-08
121	Hotel Africa	Hotel Africa	호텔 아프리카	Alone, in the middle of the Utah desert, lies the Hotel Africa. Anything is possible here. A world of joy, heartache, and friendship has traveled through its doors. Follow along with Elvis, our narrator, as he brings the history of this desolate hotel to life, weaving tales of his widowed mother, an unlikely pair of vagabonds, and a strange hotel guest... \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/5429l.jpg	\N	\N	20430	30376	Publishing	t	2004-12-31 16:00:00-08	\N	\N	\N	2025-02-27 18:13:27.774487-08	2025-02-27 18:13:27.774487-08
122	Angel Cup	Angel Cup	엔젤컵	Angel Cup tackles the highs and lows of girls' soccer at Hansin High. So-jin and Shin-bee are fiercely competitive and will play against anyone, including boys, for their beloved sport. Can our heroines navigate the fakes, fouls and penalties in the games of life and love well enough to reach their goal of being champs? \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/5434l.jpg	6.76	138	12729	25945	Finished	f	2000-12-31 16:00:00-08	\N	35	5	2025-02-27 18:13:27.842852-08	2025-02-27 18:13:27.842852-08
123	Tenshi no Su	Angel Nest	天使の巣	A woman named Natsu finds Ken, her husband, with another woman when she comes home from work one day. Ken confesses that he is in love with the girl, mi, and asks Natsu for a divorce. Natsu doesn't really feel shocked OR sad, for some strange reason. All she can think of is what she has learned from her five years with Ken, and how she can move forward. Then, one sleepless night, she sees an angel sitting on her balcony... and soon after, the angel begins living with her. \n\nIncluded in this volume are three more short manga stories: God Knows Everything, Tea Time and Dispensation of Heaven.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/114665l.jpg	6.55	296	15806	20103	Finished	f	1999-12-31 16:00:00-08	\N	7	1	2025-02-27 18:13:27.886899-08	2025-02-27 18:13:27.886899-08
124	Aqua	Aqua	AQUA	The year is 2301, one hundred fifty years since terraforming operations began on the planet Aqua—formerly known as Mars—causing it to be almost entirely covered with water. Aqua's capital, Neo-Venezia, is a near-perfect copy of the wonderful, dreamy city of Venice back on Manhome—previously known as Earth. Citizens and tourists alike take their time exploring the city and admiring its rustic charm, especially by riding one of the many gondolas gliding along the waterways.\n\nHighly skilled and knowledgeable women known as Undines navigate the gondolas and act as tour guides of Neo-Venezia. Originating from Manhome, several well-renowned Undine companies have made their home in the capital, with many young girls aspiring to join their ranks.\n\nChasing her dream of becoming an Undine, Manhome native Akari Mizunashi begins her training as an apprentice at the Aria Company. Soon after arriving in town, she becomes acquainted with her mentor Alicia Florence, a pudgy cat named Aria Pokoteng, and Aika S. Granzchesta, a fellow Undine apprentice from the Himeya Company. Together with her new friends, Akari strives to become a full-fledged Undine while taking in all the magical sights and sounds that Neo-Venezia generously offers.\n\n[Written by MAL Rewrite]\n\nIncluded one-shot:\nVolume 2: Othello Game (Ebony &amp; Ivory)	https://cdn.myanimelist.net/images/manga/1/153102l.jpg	7.92	9202	933	1033	Finished	f	2001-01-26 16:00:00-08	2001-09-27 17:00:00-07	10	2	2025-02-27 18:13:27.943372-08	2025-02-27 18:13:27.943372-08
125	Arcana	Arcana	아르카나	Inez is a young orphan girl with a special gift that allows her to communicate with all creatures. A great destiny awaits her, the nature of which she is yet unaware. As our story opens, Inez is traveling with an old wizard named Kaager and a faithful dog named Zode. Her country is about to plunge into its first winter in one hundred years and ominous signs abound concerning the return of a demon-race which threatens the country's fragile peace. Can little Inez—via a magic amulet—bring back her country's ancient dragon protector in time?\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/263936l.jpg	6.87	657	11031	10000	Finished	f	2002-12-31 16:00:00-08	\N	23	11	2025-02-27 18:13:28.009322-08	2025-02-27 18:13:28.009322-08
157	Imadoki!	Nowadays	イマドキ	For Tanpopo Yamazaki, life at the elitist Meio Academy seems way out of her league. The daughters of wealthy families snub her, other students make light of the fact that she actually tested into Meio instead of relying on family connections, and the cute boy she saw tending a dandelion the day before wouldn't even acknowledge her existence. Hoping to make friends and have some fun, Tanpopo starts up a gardening committee, but will this help her survive in a school where superficiality and nepotism reign supreme? \n\n(Source: Viz)	https://cdn.myanimelist.net/images/manga/3/82696l.jpg	7.55	7142	2590	1584	Finished	f	2000-04-30 17:00:00-07	2001-06-30 17:00:00-07	26	5	2025-02-27 18:13:30.438229-08	2025-02-27 18:13:30.438229-08
126	Archlord	Archlord	아크로드	The great warrior Leon Manas, son of the legendary Nathan Manas, now carries the powerful sword Brumhart. Though this blade is coveted by many, only the heirs to the House of Manas can wield it. But that doesn’t stop the sinister from trying. Ernan, once trusted knight of the House of Manas, murders his commander, robs him Brumhart and orders the death of Leon’s only son, Zian. But the men sent to perform this infanticide come up against a mysterious figure in a dark cloak who defeats them only to disappear with child into the thick of the Tass Forest. Sixteen years later, Ernan has become a feared tyrant, but still has not been able to unsheathe Brumhart. Thus begins the tale of this desperate king and the young boy who would be one.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/262334l.jpg	6.73	1061	13254	8793	Finished	f	2005-09-29 17:00:00-07	2007-12-31 16:00:00-08	46	6	2025-02-27 18:13:28.045362-08	2025-02-27 18:13:28.045362-08
127	Ark Angels	\N	Ark Angels	From a small lake nestled in a secluded forest far from the edge of town something strange emerged one day: Three young girls. The three girls, Shem, Hamu and Japheth, are sisters from another world. Equipped with magical powers, they are charged with saving all the creatures of Earth from becoming extinct. However, there is someone or something sinister trying to stop them. While saving our world from destruction, these sisters live like normal human girls: They go to school, work at a flower shop, hang around with friends and even fall in love...\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/286805l.jpg	6.33	521	18156	15017	Finished	f	2006-12-31 16:00:00-08	\N	12	3	2025-02-27 18:13:28.137212-08	2025-02-27 18:13:28.137212-08
128	Petshop of Horrors	Pet Shop of Horrors	Petshop of Horrors (ペットショップ オブ ホラーズ)	Beyond the mist-filled alleyways in the concrete crevices of Los Angeles' Chinatown hides a mysterious pet shop, home to many bizarre yet friendly creatures. The store's proprietor is an enigmatic young man who goes by the name of Count D.\n\nCount D welcomes those who feel lonely and wounded through the doors of his shop, claiming to sell "love, dreams, and hope" in the form of the fantastic beasts that lie within. Each creature comes with a special contract accompanied by a set of rules. However, he warns customers that he cannot be held accountable for any consequences of breaking the rules.\n\nShort-tempered detective Leon Orcot traces the source of several crimes back to Count D and what the former considers to be a pet shop of horrors. Determined to find proof that the Count is a criminal, he begins to pay regular visits to the shop.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/5/212566l.jpg	8.23	10642	387	539	Finished	f	1994-12-31 16:00:00-08	1997-12-31 16:00:00-08	41	10	2025-02-27 18:13:28.205018-08	2025-02-27 18:13:28.205018-08
129	Birth	Arm of Kannon	BIRTH バース	Deep within the mountains of Tibet, secluded from the mortal world, sits The Arm of Kannon, an instrument of inconceivably wicked power, resting safely outside the grasp of humanity... until now.\nAn archeologist, Juzo Mikami, dizzied with tales of The Arm's power and determined to unlock the mystery behind this Buddhist secret, sets out on a journey to find this ancient artifact and is never heard from again, leaving behind his wife and children. Three years later, he returns to his family, however he isn't the man he was, and his family will never be the same.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/201290l.jpg	6.30	269	18402	15386	Finished	f	1997-12-31 16:00:00-08	2002-12-31 16:00:00-08	17	9	2025-02-27 18:13:28.32234-08	2025-02-27 18:13:28.32234-08
130	Clamp Gakuen Tanteidan	Clamp School Detectives	CLAMP学園探偵団	Akira, Nokoru, and Suoh are the student council heads in the Elementary department of the CLAMP university. After one encounter with a damsel in distress, Nokoru turns the group into a group of sleuths out to make the world safe for everyone of the female sex. \n\n(Source: ANN)	https://cdn.myanimelist.net/images/manga/1/260110l.jpg	6.82	2819	11757	3948	Finished	f	1991-12-31 16:00:00-08	1993-09-30 17:00:00-07	12	3	2025-02-27 18:13:28.405762-08	2025-02-27 18:13:28.405762-08
131	Aromatic Bitters	The Aromatic Bitters	アロマチック・ビターズ	When two gal pals go on road trip, anything can happen! Sayumi and Hide are two friends cursed with the same fate: They're both stuck in dead-end relationships, and neither can find her way out. When they decide to hit the road and go to Hide's country home for the summer, they learn loads about love, life, and each other. Aromatic Bitters follows the lives of two women with nothing left to lose but their inhibitions.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/114685l.jpg	6.59	165	15321	23808	Finished	f	2000-12-31 16:00:00-08	2002-12-31 16:00:00-08	11	2	2025-02-27 18:13:28.428881-08	2025-02-27 18:13:28.428881-08
132	B'T X	B'T X	B'T X	The story begins with Teppei Takamiya, as he travels to China after years of living quietly in the fictional Kamui Island. He attempts to reunite with his brother Koutarou, who left Germany five years ago to study robotics at a university. Unfortunately, no sooner than his brother begins an exhibition about an advanced form of machine, he's kidnapped by a mecha in the shape of a wasp and a servant of the Machine Empire. Teppei starts a chase, using a gauntlet known as the "Messiah Fist" to hold onto the wasp as it travels to a secretive base in the Gobi Desert which serves as the Empire's headquarters.\n\nGetting thrown into a garbage heap and facing a cyborg he somehow is familiar with, Teppei's blood awakens a relic from the past; a kirin-type B't known only as "X" which, five years ago, was considered the most powerful B't in existence. Both are equally stubborn, although quite different in many ways, and after a few initial squabbles, X resolves to help Teppei in his quest to save his brother.\n\n(Source: TVTropes)	https://cdn.myanimelist.net/images/manga/3/205170l.jpg	6.66	559	14342	12749	Finished	f	1994-10-25 17:00:00-07	1999-12-25 16:00:00-08	63	16	2025-02-27 18:13:28.505675-08	2025-02-27 18:13:28.505675-08
133	Tokyo Babylon	Tokyo Babylon	東京 BABYLON	Subaru Sumeragi is the 13th head of his powerful onmyouji clan. Until the time comes when he must succeed his grandmother fully, Subaru is allowed to live in Tokyo with his fraternal twin, Hokuto. While Subaru is kind and shy, Hokuto has exuberance to spare, and her favorite pastime is designing bold matching outfits for the two of them to wear. Her next favorite thing to do is try to set up Subaru with their veterinarian friend Seishirou Sakurazuka who, oddly enough, is always readily available to accompany the Sumeragis throughout the city.\n\nSubaru has to resolve a variety of spiritual conflicts in Tokyo: some are cases formally brought to him by clients, and others are matters in which he decides to involve himself. A selfless teenager, he empathizes with others to the point that their pain may as well be his own. This leaves him vulnerable in a city where nearly everyone makes decisions that only benefit themselves as individuals. Hokuto hopes that if Subaru develops feelings for Seishirou, their relationship will be the one thing that he never gives up for the sake of anyone else. However, is Seishirou the best candidate for her brother's love, or is he hiding sinister secrets?\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/260527l.jpg	7.96	7935	826	886	Finished	f	1989-12-31 16:00:00-08	1992-12-31 16:00:00-08	18	7	2025-02-27 18:13:28.671889-08	2025-02-27 18:13:28.671889-08
167	Chronicles of the Cursed Sword	Chronicles of the Cursed Sword	파검기	Rey Yan was an orphan with no home, no skills, and no purpose. But when he comes upon the PaSa sword, a cursed blade made from the bones of the demon king, he suddenly finds himself with the power to be a great hero. The sword's creator is the evil Shiyan, the royal vizier who needs the sword to assist him in releasing his ancestor, the demon king. (Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/243134l.jpg	6.96	727	9530	8729	Finished	f	1998-12-31 16:00:00-08	2008-12-31 16:00:00-08	163	37	2025-02-27 18:13:31.159733-08	2025-02-27 18:13:31.159733-08
134	MÄR	MÄR	MÄR	Ginta Toramizu is a 14-year-old kid who doesn't have a lot going for him: he's near-sighted, doesn't do well in school, sucks at sports, and to top it off—he's short! But Ginta is a dreamer and has had the same dream 102 times, always in the same fantasy world, where he is a hero blessed with all the abilities he lacks in real life.\n\nOne day, a supernatural figure appears at Ginta's school and summons him to a mysterious and exciting new world! In this strange universe filled with magic and wonder, he is strong, tough, agile—and he can see without his glasses! Thus, Ginta begins a mystical quest in search of the magical items known as "ÄRMS," one of which may have the power to send him home. Joining him on this epic journey are his companion Jack and the valuable living, talking, mustachioed iron-ball weapon known as "Babbo," which everyone wants but, it seems, only Ginta can possess! \n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/1/165744l.jpg	7.35	9038	4306	1222	Finished	f	2003-04-30 17:00:00-07	2006-06-30 17:00:00-07	161	15	2025-02-27 18:13:28.731284-08	2025-02-27 18:13:28.731284-08
135	MÄR Omega	MÄR Omega	メル Ω, メル オメガ	Young Kai has been passionately idolizing Ginta ever since his heroic battle in the War Games of six years ago. Since then, ARMs have become a common thing, Guardians especially! Kai himself doesn't have one though, and dreams big of being able to get an ARM like Ginta's! When his caretaker, the old ARM-smith that took him in after his parents' deaths, sends him out on an errand, he is attacked by a bandit from "chess"! In his escape attempt, he finds more than he bargained for when he comes across Babbo! But, now with Babbo's awakening, the fake ARMs are going out of control! Is it Kai's turn to save MAR Heaven following in his hero's footsteps?\n\n(Source: Project Kurai Ryu)	https://cdn.myanimelist.net/images/manga/1/33509l.jpg	6.03	1642	19652	5964	Finished	f	2006-08-31 17:00:00-07	2007-06-12 17:00:00-07	39	4	2025-02-27 18:13:28.796634-08	2025-02-27 18:13:28.796634-08
136	Rekka no Honoo	Flame of Recca	烈火の炎	Often considered untrustworthy, Japanese ninja were in fact unwaveringly loyal to their masters. But in modern-day Japan, high school student and self-proclaimed ninja Rekka Hanabishi finds it difficult to carry on their legacy, that is, until he saves a cute girl named Yanagi Sakoshita from a group of delinquents.\n\nIn the aftermath of the event, Rekka deems Yanagi worthy of being his master, swearing to protect her. As a sign of their trust, the two reveal their most valuable secrets to each other: Yanagi can quickly heal wounds, while Rekka can create fire with just a snap of his fingers. However, their dazzling exchange does not go unnoticed as a mysterious woman called Kage Houshi appears. She somehow knows about their powers and threatens them, claiming Rekka must be returned, for he is the only one who can kill her.\n\nThe pair hold their ground, but before things can escalate any further, Kage Houshi calmly leaves. Thinking the crisis is over, Rekka and Yanagi continue their daily lives, unaware that they are about to be dragged into a centuries-long ninja conspiracy with the lives of their friends and their own on the line.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/186157l.jpg	7.70	7241	1740	1319	Finished	f	1995-03-21 16:00:00-08	2002-10-29 16:00:00-08	330	33	2025-02-27 18:13:28.896039-08	2025-02-27 18:13:28.896039-08
137	R.O.D: Read or Die	Read or Die	R.O.D -READ OR DIE-	Yomiko Readman's love for literature goes far beyond any run-of-the-mill bookworm's! In fact, she has a supernatural ability to manipulate paper in the most amazing ways. From turning a tiny scrap into a lethal throwing dagger to making a single sheet hard enough to block bullets, she's only limited by her imagination. She uses her phenomenal power to seek out legendary books containing secret information that, in the wrong hands, could be dangerous. Backed by a Special Operations Division in England, Yomiko has her hands full battling evildoers, saving the world, and trying to find time to curl up with a good book.\n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/3/266047l.jpg	6.97	1837	9416	4123	Finished	f	1999-12-17 16:00:00-08	2002-05-17 17:00:00-07	30	4	2025-02-27 18:13:29.001805-08	2025-02-27 18:13:29.001805-08
138	Baby Birth	Baby Birth	ベイビィバース	An ancient seal has been broken, sending a flood of demons into the mortal realm. Hizuru Oborozuki and Takuya Hijou, descendants of the great savior who banished the demons in the past, must fight the evil spirits using their mystical powers. In order to give the world a fighting chance, Takuya uses his music to transform Hizuru into a beautiful warrior. Some things are worth fighting for, but is the Earth one of them?\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/618l.jpg	6.08	284	19493	19894	Finished	f	2001-04-30 17:00:00-07	2002-07-31 17:00:00-07	21	2	2025-02-27 18:13:29.093842-08	2025-02-27 18:13:29.093842-08
139	Ba_ku	Ba_ku	ばく	1-3. Ba_ku\n4-5. Mephisto	https://cdn.myanimelist.net/images/manga/3/160715l.jpg	6.92	502	10241	15976	Finished	f	2003-04-30 17:00:00-07	\N	5	1	2025-02-27 18:13:29.148895-08	2025-02-27 18:13:29.148895-08
140	Bakuretsu Hunters	Sorcerer Hunters	爆れつハンター	In an age of magic and sorcery, the world is divided between those who have supernatural powers and those who don't. Fighting for justice and against black magic and evildoers everywhere are the Sorcerer Hunters: Gateau, Carrot, Chocolat, Mocha, and the rest of the gang. Their quest is to destroy each of the Platina stones- the objects the evil sorcerers use for creating their black magic - in an entertaining mix of farce and adventure.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/304839l.jpg	7.02	712	8628	9972	Finished	f	1993-07-31 17:00:00-07	1998-09-30 17:00:00-07	72	13	2025-02-27 18:13:29.198166-08	2025-02-27 18:13:29.198166-08
141	Battle Club	Battle Club	バトルクラブ	When freshman transfer Mokichi arrives at Swan Academy High, he's got a chance to start over with a clean slate. He's got a plan, too. Kick the butts of the toughest guys in school, prove himself to be the baddest dude around, and run the whole shebang. Problem is, it's his butt that gets kicked that first day. Completely humiliated, Mokichi joins the Wrestling Club in hopes of learning to fight. There he meets unlikely allies, Tamako and Higuchi, two of the hottest battle babes to ever roll their sweaty bods over Swan Academy's gym mats. And Mokichi's gonna need all the friends he can get, what with the likes of the Karate Club looking to "break in" the new kid in the worst way possible. \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/172727l.jpg	6.45	1519	17110	5267	Finished	f	2004-04-27 17:00:00-07	2006-03-06 16:00:00-08	47	6	2025-02-27 18:13:29.268323-08	2025-02-27 18:13:29.268323-08
142	Battle Royale	Battle Royale	バトル・ロワイアル	Every year, a class is randomly chosen to be placed in a deserted area where they are forced to kill each other in order to survive. Initially believing to be on a graduation trip, Shuuya Nanahara and the rest of Shiroiwa Junior High's Class B find that they have been chosen to participate in this game of life and death known as The Program.\n\nWaking up to the realization that they have been quarantined on an island, the 42 students discover they have been fitted with metal collars which will detonate if certain conditions are not met. In order to obtain freedom, they must slaughter everyone else by whatever means necessary, and the last one standing is deemed the winner. As each member of the class heads down their own path, Shuuya makes it his goal to get off the island without playing the game in order to put an end to this madness once and for all.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/262978l.jpg	7.85	32670	1149	223	Finished	f	1999-12-31 16:00:00-08	2004-12-31 16:00:00-08	119	15	2025-02-27 18:13:29.339633-08	2025-02-27 18:13:29.339633-08
145	Beck	BECK: Mongolian Chop Squad	BECK	Yukio "Koyuki" Tanaka wasted away his middle school days listening to Japanese pop music and apathetically trudging through life—until a casual run-in with the enigmatic guitarist Ryuusuke "Ray" Minami. Through this encounter, Koyuki realizes what he has been missing all this time as Ray introduces him to western rock music and jumpstarts his desire to play guitar.\n\nAlthough various struggles plague his path to rock fame, Koyuki refuses to abandon the passion that gave his life purpose, balancing it together with school, work, and friends. Beck tells the story of the love and trial that accompanies pursuing a professional career in music as Koyuki and Ray work toward realizing the guitarist's dream of the ultimate band.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/253274l.jpg	8.69	29917	65	189	Finished	f	2000-02-16 16:00:00-08	2008-06-04 17:00:00-07	103	34	2025-02-27 18:13:29.565132-08	2025-02-27 18:13:29.565132-08
146	Sheets no Sukima	Between the Sheets	シーツの隙間	Between the Sheets features the unusual friendship from the nearly inseparable Saki and Minako. Minako carries a fervent torch for the other girl – a passion of which Saki is initially ignorant. But when Minako sleeps with Saki's boyfriend Ken (just to see what Saki sees in him), the true nature of Minako's obsession begins to reveal itself... provoking an understandably strong reaction from Saki. \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/265983l.jpg	6.26	412	18650	15449	Finished	f	1995-07-31 17:00:00-07	1995-12-31 16:00:00-08	6	1	2025-02-27 18:13:29.624393-08	2025-02-27 18:13:29.624393-08
147	Sono Mukou no Mukougawa	Beyond the Beyond	その向こうの向こう側	Futaba, a boy that has grown up in an overprotected family, suddenly finds himself on the other side of the world, where he meets Kiara, the Amaranthine. They journey to find Kiara's true master, and along the way they meet a curious cast of characters, including the wizard Belbel and the prince Virid.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/4/138525l.jpg	7.27	442	5223	14769	Finished	f	2004-02-29 16:00:00-08	2008-01-31 16:00:00-08	38	6	2025-02-27 18:13:29.672548-08	2025-02-27 18:13:29.672548-08
148	Bird Kiss	\N	버드 키스	Remember the story of the Frog Prince? A little girl kisses a frog to get back her ball, and ends up with a frog for a husband! Only after she’s completely ignored and abused him does she realize the frog has changed into a handsome prince! Miyoul is a feisty high schooler whose only thoughts are of the hottest boy in school, Guelin. But her childhood friend, Heerack, who acts as her personal lackey, is deeply in love with her. Will Miyoul be able to see which is the frog and which is her true prince? (Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/264960l.jpg	6.72	405	13397	15861	Finished	f	2001-12-31 16:00:00-08	\N	30	5	2025-02-27 18:13:29.756213-08	2025-02-27 18:13:29.756213-08
149	Blame!	Blame!	BLAME!	In an enormous steel labyrinth riddled with horrifying creatures, humanity is forced to isolate itself in small enclaves while living in constant fear of its annihilation. In this dystopia, only a strange young man known as Killy is brave enough to traverse its unforgiving territories. \n\nPossessing superhuman strength and a rare Graviton Beam Emitter, Killy fights off bloodthirsty beasts and other fiendish forces in his desperate search for a human with the Net Terminal Gene—genetic information that holds the potential to restore the corrupt world. \n\nThe dark world of Blame! follows Killy as he meets new people, sheds more blood, and draws closer to finding the Net Terminal Gene. Through these exploits, the true nature of the world is slowly pieced together.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/174389l.jpg	8.29	47181	320	69	Finished	f	1997-01-24 16:00:00-08	2003-07-24 17:00:00-07	66	10	2025-02-27 18:13:29.806074-08	2025-02-27 18:13:29.806074-08
150	Western Shotgun	Blazin' Barrels	웨스턴샷건	Sting may look harmless and naïve, but he's really an excellent fighter and a wannabe bounty hunter in the futuristic Wild West. When he comes across a notice that advertises a reward for the criminal outfit named Gold Romany, he decides that capturing the all-girl gang of bad guys is his ticket to fame and fortune! Filled with a colorful cast of unforgettable characters--Chuck Black, Maria Lopez and Leanne "Fast Sword" McDuff--Min-Seo Park has created one wild tumbleweed tale filled with adventure galore and plenty of shotgun action!\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/3/86309l.jpg	6.75	160	12880	23502	Finished	f	1999-12-31 16:00:00-08	2009-12-31 16:00:00-08	\N	40	2025-02-27 18:13:29.90618-08	2025-02-27 18:13:29.90618-08
151	Yato no Kamitsukai	Blood Sucker: Legend of Zipangu	夜刀の神つかい	Three centuries ago, a vampire by the name of Migiri was running a reign of terror across Japan when a hero named Naonosuke Kobayashi cut off his head and sent him to eternal rest... until now.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/259886l.jpg	6.70	311	13635	12996	Finished	f	1993-12-31 16:00:00-08	2006-12-31 16:00:00-08	72	12	2025-02-27 18:13:30.032434-08	2025-02-27 18:13:30.032434-08
152	Boys Be...	Boys Be...	BOYS BE…	An anthology of stories about ordinary high school guys and their relationships...or lack thereof. Boys Be... takes a look at the trials of love and loss from a refreshing point of view and often adds interesting insight into what a relationship is like from an average guys point of view!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/183366l.jpg	6.49	389	16560	10953	Finished	f	1991-07-23 17:00:00-07	1996-10-29 16:00:00-08	255	32	2025-02-27 18:13:30.129238-08	2025-02-27 18:13:30.129238-08
153	Boys Be... 2nd Season	Boys Be II	BOYS BE... 2nd Season	\N	https://cdn.myanimelist.net/images/manga/3/169855l.jpg	6.93	159	9979	23095	Finished	f	1996-11-05 16:00:00-08	2000-02-22 16:00:00-08	157	20	2025-02-27 18:13:30.218506-08	2025-02-27 18:13:30.218506-08
155	Brain Powerd	Brain Powered	ブレンパワード	The discovery of an alien organic vessel submerged in the ocean reveals a plot to unleash planetary destruction... A collective of evil scientists called the Reclaimers works to hasten mankind's extinction. As one of Earth's defenders, Hime Utsumiya fights on a team of mecha called Brain Powered's to combat them. Unfortunately the Reclaimers also have these mecha and mankind's fate hangs in the balance.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/76769l.jpg	6.26	481	18669	13785	Finished	f	1997-11-25 16:00:00-08	2000-10-25 17:00:00-07	26	4	2025-02-27 18:13:30.286811-08	2025-02-27 18:13:30.286811-08
156	Sennen no Yuki	Millennium Snow	千年の雪	Chiyuki Matsuoka's given name literally means "thousand snow," and it embodies her parents' wish for her to witness the first snowfall of the year perennially. This wish is exceedingly optimistic due to Chiyuki's heart condition, which increases the risk of seizures and decreases her life expectancy. The doctor who presided over her birth said she would be lucky to live 15 years.\n\nChiyuki is 17 years old when she meets the unlikely vampire Touya Kanou. He claims to hate blood, and he refuses to find a human partner with whom to share the rest of his life. Touya is 18 now, but if he took blood continually from a partner, then they both might live to be a thousand years old. \n\nChiyuki immediately volunteers to be Touya's partner, but he shoves her away in disgust, inadvertently learning of her poor health when she starts to spasm. Touya treats Chiyuki more kindly after that, but still refuses to drink her blood. She begins to suspect that there is a different reason why he keeps turning her down, but will she live long enough to discover the truth?\n\n[Written by MAL Rewrite]\n\n\nIncluded one-shot:\nVolume 1: Isshunkan no Romance (A Romance of One Moment)	https://cdn.myanimelist.net/images/manga/1/143101l.jpg	7.58	7728	2406	1196	Finished	f	2000-11-23 16:00:00-08	2013-12-09 16:00:00-08	18	4	2025-02-27 18:13:30.354936-08	2025-02-27 18:13:30.354936-08
158	Ghost Hunt	Ghost Hunt	ゴーストハント	Mai Taniyama's school has an ancient, abandoned, and allegedly cursed building. Whenever it is about to be torn down, a series of unsettling deaths occur and halt the demolition. To prove it is haunted, Mai and her friends try to summon a specter by telling ghost stories. No ghosts appear, but the group encounters Kazuya Shibuya, a 17-year-old transfer student. Though her friends are charmed by Kazuya's attractive looks and great manners, Mai does not trust him.\n\nFollowing a mishap, Mai discovers Kazuya's real identity as the president of Shibuya Psychic Research, a group hired by the school principal to investigate the building's rumored paranormal activity. As a consequence of her actions, Mai must temporarily help Kazuya if she does not want to pay him damages. Joined by other individuals experienced with the supernatural—former Buddhist monk Houshou Takigawa, self-proclaimed Shinto priestess Ayako Matsusaki, famous medium Masako Hara, and Catholic priest John Brown—Mai and Kazuya must uncover the mystery surrounding the building before any more innocent lives are lost.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/181311l.jpg	8.22	5840	404	1228	Finished	f	1997-12-05 16:00:00-08	2010-09-29 17:00:00-07	43	12	2025-02-27 18:13:30.512823-08	2025-02-27 18:13:30.512823-08
159	Brave Story: Shinsetsu	\N	ブレイブ・ストーリー～新説～	Wataru Mitani's life was as ordinary as any other until he found the new transfer student to his school battling a giant monster in his neighborhood. In search of clues to this, he finds a door to a world called Vision, a fantasy world where magic exists. When Wataru's life starts to crumble around him, he embarks on a journey beyond the door to change the fate that has befallen his family. \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/4/251324l.jpg	6.78	408	12500	12522	Finished	f	2004-04-08 17:00:00-07	2008-05-08 17:00:00-07	199	20	2025-02-27 18:13:30.608079-08	2025-02-27 18:13:30.608079-08
160	School Rumble	School Rumble	スクールランブル	She...is a second-year high school student with a single all-consuming question: Will the boy she likes ever really notice her? He...is the school's most notorious juvenile delinquent and he's suddenly come to a shocking realization: He's got a huge crush, and now he must tell her how he feels. Life-changing obsessions, colossal foul-ups, grand schemes, deep-seated anxieties, and raging hormones—School Rumble portrays high school as it really is: over-the-top comedy!\n\n(Source: Kodansha USA)	https://cdn.myanimelist.net/images/manga/3/5267l.jpg	7.97	14070	815	620	Finished	f	2002-10-22 17:00:00-07	2008-07-22 17:00:00-07	345	22	2025-02-27 18:13:30.656532-08	2025-02-27 18:13:30.656532-08
161	Brigadoon: Marin to Melan	Brigadoon	BRIGADOON まりんとメラン	Imagine waking up one day to find that the sky around has been engulfed by an unidentifiable mechanical presence. Imagine that this new sky opens up and releases a Monomakia, a living weapon, whose sole purpose is to end your life. That's exactly what happens to 13-year-old Marin Asagi, an orphaned girl living in an alternate version of Tokyo in the 1970's. Young Marin's only chance to survive rests with Melan Blue, the Gun-Swordsman, who is destined to protect her. With arms made of weapons, the power of flight, and retractable body armor, Melan is a powerful bodyguard indeed.\n\nWho is sending the Monamakia? Why do they want Marin dead? Who sent Melan to protect her? What is the secret of Brigadoon? With her new protector by her side Marin sets out across two worlds to discover the answers.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/1/200076l.jpg	6.64	233	14627	22471	Finished	f	1999-12-31 16:00:00-08	2000-12-31 16:00:00-08	10	2	2025-02-27 18:13:30.714445-08	2025-02-27 18:13:30.714445-08
162	Bus Gamer	Bus Gamer	BUS GAMER	Toki Mishiba, Nobuto Nakajo, and Kazuo Saitou are hired to play the Biz Game, a game much like capture the flag, only with company secrets and insane amounts of money involved. At first they think it's a crazy but fun way to get some money, but as the game goes on, they hear stories about mysterious deaths on the news, and recognize the victims as members of the teams they've beaten in the game. When one of the losers of a game dies right in front of them, they realize what is really at stake—their very lives!\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/1/160474l.jpg	7.24	1054	5517	8351	Finished	f	1998-12-31 16:00:00-08	2001-11-27 16:00:00-08	11	1	2025-02-27 18:13:30.779116-08	2025-02-27 18:13:30.779116-08
163	Kimi ni shika Kikoenai	Calling You	きみにしか聞こえない	A volume featuring two short stories. Calling You—A lonely pair of high school students begin to psychically communicate through the “cell phones in their heads.” Their connection grows, and they discover that they’re not only separated by distance, but by time, as well. Kids—a story about high school bullying and abuse.\n\nNote: Kiyohara Hiro also did a manga based on the same story.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/3/262341l.jpg	7.28	1216	5085	7684	Finished	f	2003-11-30 16:00:00-08	\N	5	1	2025-02-27 18:13:30.860212-08	2025-02-27 18:13:30.860212-08
164	Nousatsu Junkie	Nosatsu Junkie	悩殺ジャンキー	Naka is an aspiring young model with a problem: her face tenses up into a terrifying spectacle whenever she gets nervous on photo shoots! Naka's rival is Umi, the hottest model at their agency. But Naka soon discovers Umi's secret—and hilarity ensues behind the cameras!\n\n(Source: TokyoPop)\n\nIncluded one-shots:\nVolume 6: Nozoite Mitakute Shikatanai (Peeping)\nVolume 11: Kaeru ga Iku Taiwan na Hibi	https://cdn.myanimelist.net/images/manga/3/170561l.jpg	7.92	5043	931	1664	Finished	f	2003-10-03 17:00:00-07	2008-11-19 16:00:00-08	96	16	2025-02-27 18:13:30.902174-08	2025-02-27 18:13:30.902174-08
165	Cherry Juice	Cherry Juice	チェリージュース	In this awkward love-triangle between two step- siblings, -Otome and Minami- and a best friend, Amane, the three are trapped in a web of love. After getting along for five years, Otome and Minami's peaceful relationship takes a turn in the wrong direction when Amane confesses his love to Otome. What will Otome do?\n\n(Source: TokyoPop)	https://cdn.myanimelist.net/images/manga/2/164439l.jpg	7.20	5858	6089	1913	Finished	f	2004-06-02 17:00:00-07	2006-03-16 16:00:00-08	21	4	2025-02-27 18:13:30.964123-08	2025-02-27 18:13:30.964123-08
166	Chou Shinri Genshou Nouryokusha Nanaki	Psychic Power Nanaki	超心理現象能力者 ナナキ	After being hit by a car, strange things begin to happen around Nanaki Shunsuke. He is eventually approached by another young man named Ao, who tells Nanaki that he has been sending Ao his telepathic "voice," and that the accident seems to have awakened some sort of supernatural powers within Nanaki.\n\nThough less than enthusiastic about the idea, Nanaki eventually agrees to join LOCK, The Paranormal Investigations Agency, and partner up with Ao to investigate various cases dealing with the supernatural. However, Nanaki's powers are rather unstable, and Ao seems to have some reason to carry a great mistrust and annoyance for his new partner, making Nanaki's days in his new position a rather trying ordeal. But as they work alongside one another in their pathetically understaffed branch of LOCK, the two find ways they might manage to keep working together, perhaps even without getting the other killed in the process.\n\n(Source: MU)\n\nIncluded one-shot:\nVolume 3: Divine: Bokura wa Hikari wo Mita	https://cdn.myanimelist.net/images/manga/2/272909l.jpg	7.06	384	8037	16584	Finished	f	2003-10-19 17:00:00-07	2004-10-04 17:00:00-07	17	3	2025-02-27 18:13:31.017459-08	2025-02-27 18:13:31.017459-08
168	Chrono Code	Chrono Code	리버사이드	Three people cross time and space to find each other, and to try to change destiny. But with a powerful satellite, a secret code and the future police out hunting, one girl with amnesia, who may be the key to everything, must discover the true nature of her past... and her friends.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/5/753l.jpg	\N	\N	20431	31002	Finished	f	2005-07-11 17:00:00-07	2005-10-10 17:00:00-07	18	2	2025-02-27 18:13:31.278366-08	2025-02-27 18:13:31.278366-08
171	Deai	Confidential Confessions: Deai	であい	A continuation of the gripping and cutting-edge Confidential Confessions, this series deals exclusively with the seedy underbelly of the sex industry. Using emotionally moving storylines and multi-dimensional characters, here is a shocking look into the hard-hitting issues that teens face today. Enlightening without being preachy, Confidential Confessions speaks to teens in a heartfelt, authentic way. \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/152535l.jpg	7.26	393	5329	14317	Finished	f	\N	\N	8	2	2025-02-27 18:13:31.47193-08	2025-02-27 18:13:31.47193-08
172	Corrector Yui	Corrector Yui	コレクター・ユイ	In the year 2020, computers are everywhere. From digital teachers to cars that drive themselves, computers are an integral part of everyone's lives—everyone's, that is, except Yui Kasuga's. The 14-year-old daydreamer can't tell a Pentium chip from a Dorito! Very shortly, she will be called on to save the world from the mother of all computer viruses... and she can't even be bothered to stay awake in class!\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/2/178097l.jpg	6.46	279	16965	18655	Finished	f	1999-03-31 16:00:00-08	1999-11-30 16:00:00-08	11	5	2025-02-27 18:13:31.503197-08	2025-02-27 18:13:31.503197-08
173	Cowboy Bebop	Cowboy Bebop	カウボーイビバップ	Spike, Jet, Faye and Ed—cowboys on the new frontier. Together this band of interplanetary bounty hunters takes on the jobs that anyone in their right mind would turn down. \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/5/166652l.jpg	7.15	7425	6685	1135	Finished	f	1999-04-07 17:00:00-07	2000-04-09 17:00:00-07	11	3	2025-02-27 18:13:31.584332-08	2025-02-27 18:13:31.584332-08
174	Shooting Star Bebop: Cowboy Bebop	Cowboy Bebop: Shooting Star	シューティングスタービバップ―カウボーイビバップ	Kai Lucas hires the Bebop crew to find his mischievous doppelganger, but the bounty goes bust and Spike and Jet once again find themselves broke - and hungry. And to add to their woes, Spike ends up mysteriously on the police's most wanted list, either the butt of a joke or the victim of a severe computer glitch. But what's worse, being targeted by every bounty hunter in the solar system, or taking on a kid-genius, a genius puppy and a genus: fatale, species: femme as part of the crew. Well, if Scorpion or the Dragon Head Family doesn't kill them, the extra mouths to feed certainly will.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/176770l.jpg	6.71	2104	13596	3803	Finished	f	1998-04-30 17:00:00-07	1998-10-09 17:00:00-07	10	2	2025-02-27 18:13:31.663715-08	2025-02-27 18:13:31.663715-08
175	Touhou Sangetsusei: Eastern and Little Nature Deity	\N	東方三月精 Eastern and Little Nature Deity	Fairies in the hidden land of Gensokyo are natural pranksters and love to play tricks on humans and youkai alike. This fact is especially apparent for three fairies: Sunny Milk, Luna Child, and Star Sapphire. Having unique abilities that make them more powerful than the average fairy, they do almost anything they can to get a laugh out of their "victims." However, considering that fairies are known as one of the weakest creatures around, their pranks are usually harmless. Even so, the rowdy trio's mischief is more than enough to bring trouble to anyone's day!\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/4/6687l.jpg	6.96	2209	9531	4335	Finished	f	2005-03-25 16:00:00-08	2006-03-24 16:00:00-08	5	1	2025-02-27 18:13:31.742904-08	2025-02-27 18:13:31.742904-08
176	Chocotto Sister	Chocotto Sister	ちょこッとSister	Haruma Kawagoe is an only child. A long time ago, at Christmastime, his mother miscarried the child that was to have been his baby sister. That night, young Haruma knelt down and offered up an earnest prayer: "Please make my mother well again, and please give me a little sister." Years have passed, and Haruma has nearly forgotten his prayer. But Santa hasn't.... one Christmas, when Haruma is least expecting it, he gets an unusual present - his sister. (Source:ANN)	https://cdn.myanimelist.net/images/manga/2/752l.jpg	7.07	1624	7923	5750	Finished	f	2003-12-18 16:00:00-08	2007-04-26 17:00:00-07	71	8	2025-02-27 18:13:31.792693-08	2025-02-27 18:13:31.792693-08
177	Tsuiteru Kanojo	\N	ツイてるカノジョ	Have you ever lost anything that was so precious to you, that if it were gone you wouldn't know what to do? For Otokawa Natsuru, that item is a keychain. Hearing from Kazama Miori, a fellow student with renowned psychic powers, that taking something precious can help with relationships, Natsuru takes her keychain on a date with childhood friend Yanagi Eitaro. But somewhere along the date, her precious keychain is lost...\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/1/167457l.jpg	6.95	677	9720	11623	Finished	f	2004-08-08 17:00:00-07	2005-06-08 17:00:00-07	9	2	2025-02-27 18:13:31.900064-08	2025-02-27 18:13:31.900064-08
178	Bokutachi wa Asu ni Mukatte Ikiru no da	Living for Tomorrow	僕たちは明日に向かって生きるのだ	High school student Tasuku Mizuochi has a secret he knows and a secret he doesn't. Even though he punches, kicks, and otherwise abuses fellow karate team member, Ryouta, on a daily basis, Tasuku has hidden feelings for his childhood friend. When Tasuku's mother died, Ryouta was always there to comfort him, and these emotions grew over time to become something else. Confused and embarrassed by his secret crush, Tasuku takes his frustrations out on Ryouta to keep him from ever knowing the truth. When Tasuku learns that his late mother may have been an "ageman" (ah-gay-man)--a woman who brings men good fortune—he starts to believe he's inherited these powers, too. Can having the ability to influence luck give Tasuku and Ryouta a future together? Or will all the people crawling out of the woodwork wanting to use Tasuku's power cause him to run screaming for the hills?!\n\n(Source: DokiDoki)	https://cdn.myanimelist.net/images/manga/1/169822l.jpg	7.31	2331	\N	5144	Finished	f	2005-01-30 16:00:00-08	\N	7	1	2025-02-27 18:13:31.99195-08	2025-02-27 18:13:31.99195-08
179	Color	Color	カラー	When art student Takashiro Tsuda chose to show his painting, Color, in a gallery exhibition, he never dreamed that an uncannily similar painting would hang next to his – with the same title, even. Works of art come from the deepest depths of an artist’s soul, so how can anyone else be expressing themselves so much like Takashiro? Filled with a yearning to find his artistic soulmate, Takashiro goes off to art school in Tokyo and meets classmate Sakae Fujiwara. Soon, Takashiro learns that this is the artist he’s been searching for – the one who created a Color so much like his own – but Sakae is a guy! Can such a profound connection between two people transcend gender and become something more?\n\n(Source: Dokidoki)	https://cdn.myanimelist.net/images/manga/2/30585l.jpg	7.18	1797	\N	6449	Finished	f	1999-01-31 16:00:00-08	\N	5	1	2025-02-27 18:13:32.096377-08	2025-02-27 18:13:32.096377-08
180	Zurui Otoko	\N	ズルい男	Collection of oneshots.\n\n1) A strange man hired a younger man to act as his new lover to get rid of his ex-boyfriend who's stalking him. It turns out the younger man is a student in the class of the older man... Sweet and a bit of angst.\n\n2) True Blue - Momo and Harumi are childhood friends, and Harumi has always relied on Momo. One day he sees Momo walk into a hotel with an older man.\n\n3-5) The Lover in the secret room - Kou and Natsume are good friends and also happens to the Captain and Assistant Captain on the schools soccer team. Natsume has always liked Kou, until he finds out that Kou is going to study abroad in France. Oda, who's also on the team has liked Natsume from afar. He confesses his feelings for him and then chains him up in his home. (slight bondage)\n\n6) Kaoru and Sei have been living together ever since Kaorus' dad was sent overseas for work. Kaoru catches Sei making out. Sei tells him that he likes someone else, but he can never be with him.\n\n(From: Manga Fox)	https://cdn.myanimelist.net/images/manga/5/1347l.jpg	6.24	241	\N	23960	Finished	f	2000-12-31 16:00:00-08	\N	6	1	2025-02-27 18:13:32.171953-08	2025-02-27 18:13:32.171953-08
181	Zombieya Reiko	Reiko the Zombie Shop	ゾンビ屋れい子	Terror has struck the sleepy little town of Shiraike. A serial killer stalks the streets murdering innocent girls. Twenty-nine grisly murders have been committed, with no clues to catch the killer. That is, until the town receives a strange visitor: a beautiful young woman who can raise the dead. She is Reiko the Zombie Shop, necromancer for hire. For a price, she'll wake your dead, if only to find a clue to their demise, but she's not responsible for what the dead will say or do once they awaken! \n\n(Source: Dark Horse)	https://cdn.myanimelist.net/images/manga/1/252973l.jpg	6.98	280	9305	10886	Finished	f	1998-06-05 17:00:00-07	2004-03-05 16:00:00-08	58	11	2025-02-27 18:13:32.232348-08	2025-02-27 18:13:32.232348-08
182	Zombie Hunter	\N	死霊狩り	Unknown to the world aliens have begun to invade people's bodies. A young race car pilot named Toshio was won by a mysterious organization for a "test" for money. That test turned out to be a hellish training to become a Zombie Hunter. However, Toshio decided to return to a normal life but soon face the harsh reality of a Zombie Hunter. Surrounded by shallow figures and aliens Toshio accepts his new life as a Zombie Hunter ...\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/2/12307l.jpg	6.72	1449	13409	6223	Finished	f	1998-12-31 16:00:00-08	1999-12-31 16:00:00-08	26	4	2025-02-27 18:13:32.271604-08	2025-02-27 18:13:32.271604-08
183	Zoku Shishunki Miman Okotowari	\N	続・思春期未満お断り	Asuka, who lived in Hokkaido with her mother, moves to Tokyo to look for her father she has never even met before. When she gets to his house, he is not there, only his children who claim they have never met their father either. Asuka decides to stay with her "brother" and "sister" while she looks for their father. Her two "siblings" are living alone and things sorta complicate when Asuka and her "brother" start to fall for each other...\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/1/199144l.jpg	6.92	222	10242	20251	Finished	f	1992-01-13 16:00:00-08	1994-01-13 16:00:00-08	10	3	2025-02-27 18:13:32.345786-08	2025-02-27 18:13:32.345786-08
184	Shishunki Miman Okotowari	\N	思春期未満お断り	Higuchi Asuka's mother dies shortly after she tells her teenage daughter who her father is. Only knowing the family name "Sudou," Asuka goes in search to find her absent father.\n\nOn her journey, she finds a guy being rather rough with a younger girl. Unable to resist, Asuka steps in by battering the guy with her motorcycle. When she discovers it was a big misunderstanding (Manato was just trying to get his sister Kazusa to go home), she drives them back to their house.\n\nOnce there, Asuka finds out that Manato and Kazusa are the Sudou family she's been looking for, but the father isn't there, not to mention their mother also being dead since long ago. With no other leads, Asuka decides to move in as the big sister until their father shows up. Things get tricky when love builds within the complex family relationship...\n\n(Source: MU)\n\nIncluded one-shot:\nVolume 3: Otome no Jijou	https://cdn.myanimelist.net/images/manga/3/199142l.jpg	6.99	571	9096	12607	Finished	f	1990-12-19 16:00:00-08	1990-12-31 16:00:00-08	18	3	2025-02-27 18:13:32.409935-08	2025-02-27 18:13:32.409935-08
185	Shishunki Miman Okotowari Kanketsuhen	\N	思春期未満お断り・完結編	1. Shishunki Miman Okotowari Ending\nAt long last, Yuu Watase brings us the final chapter of the Shinshunki Miman Okotowari series. Manato returns from America, but he doesn't come with the best news for Asuka. This might be the last time he returns to Japan.\n\n2. Couple\nInaho has fallen in love with Takumi, the lead guitarist of a high school band. With hand-made gifts and her strange personality, she gets Takumi to ask her out. But only with a special biwa (a Japanese lute) can their relationship last.\n\n3. Chikyu no Arukikata\nAyuki just got dumped. On the same day, she hurt her ankle during track practice. Later, Ayuki gets trapped on the wrong train to the coast. On this train, she meets Hiroto, a guy who has quit school in search of himself. Ayuki wonders if she should do the same.  \n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/4/314673l.jpg	6.97	448	9393	16335	Finished	f	2000-05-31 17:00:00-07	\N	3	1	2025-02-27 18:13:32.490494-08	2025-02-27 18:13:32.490494-08
186	Zoku - Kindan no Koi wo Shiyou	\N	続・禁断の恋をしよう	A manga about werewolves and the continued adventures of Hisako and Yato. This volume falls between the prequel volume, Kindan no Koi wo Shiyou, and the longer main series, Kindan no Koi de Ikou.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/2/10852l.jpg	7.36	1639	4204	7091	Finished	f	2000-12-31 16:00:00-08	\N	4	1	2025-02-27 18:13:32.551529-08	2025-02-27 18:13:32.551529-08
187	Kindan no Koi wo Shiyou	\N	禁断の恋をしよう	Hisako was saved from a drunkard by a wolf. She decides to adopt the beautiful, and entrancing creature, but Hisako's new pet turns into a fine-looking guy! Somehow his entrancing eyes remain in her mind...\n\nOne-Shot: A Request to the Vampire\nRyouko is targeted as an anorexic, or shall we say, unappetizing, girl. But when her want to die overflows when she meets a vampire, he turns her world around.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/5/17066l.jpg	7.27	2545	5224	4560	Finished	f	1999-12-31 16:00:00-08	\N	5	1	2025-02-27 18:13:32.615923-08	2025-02-27 18:13:32.615923-08
188	Kindan no Koi de Ikou	\N	禁断の恋でいこう	Hisako is saved by a beautiful wolf that turns into an even more beautiful man...but can a relationship like this work!? The continuation of the story of Hisako and Yato seen in Kindan no Koi wo Shiyou and Zoku Kindan no Koi wo Shiyou!\n\n(Source: ShojoMagic)	https://cdn.myanimelist.net/images/manga/5/5717l.jpg	7.78	1859	1404	5191	Finished	f	2000-12-31 16:00:00-08	2004-12-31 16:00:00-08	50	10	2025-02-27 18:13:32.692066-08	2025-02-27 18:13:32.692066-08
190	Juunikyuu de Tsukamaete	Zodiac P.I.	十二宮でつかまえて	In recent times, a mysterious private investigator under the name of "Spica" has been solving crimes before the police arrive, leaving only a star mark nearby to indicate her involvement. The true identity of this rising star is Lili Hoshizawa, an energetic 13-year-old girl who enjoys solving mysteries, athletic activities, and running her mother's fortune-telling business, "Fortune Teller Spica." Using her knowledge of astrology, Lili reads clients' horoscopes by day and catches criminals by night!\n\nBut Lili soon finds that her carefree, crime-solving adventures will need some more caution when her childhood friend Hiromi Oikawa returns from America and is suspicious of her and Spica. His extensive studies in criminal psychology seems to have helped him in solving mysteries—rivaling Lili's astrology and crime-solving skills. But this zodiac detective has no time to worry about a possible rival, for there are many cases and mysteries out there that she must solve in the name of the star!\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/273992l.jpg	7.36	2266	4205	4747	Finished	f	2001-03-02 16:00:00-08	2002-12-02 16:00:00-08	20	4	2025-02-27 18:13:32.786478-08	2025-02-27 18:13:32.786478-08
191	Zipang	\N	ジパング	In the year 200X, a Japanese fleet consisting of 3 vessels leave on a mission to South America. After encountering a storm, the ship JDS Mirai find themselves without their escorts and in 1942, traveling towards the island of Midway to face the American fleet in one of largest battles in naval history. The crew of Mirai must decide whether or not to change the course of history by involving itself in WWII.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/1/209661l.jpg	7.61	777	2249	6030	Finished	f	2000-07-26 17:00:00-07	2009-11-04 16:00:00-08	422	43	2025-02-27 18:13:32.904927-08	2025-02-27 18:13:32.904927-08
192	Zip-Up Boy	\N	Zip-up Boy	High-school student Kazuki begins a casual sexual relationship with an older man after meeting in a bar. He becomes addicted to the affection but is perplexed by the indifference of his partner. Meanwhile, Kazuki's mother has decided to remarry Akira, the nicest guy you could imagine... unfortunately his brother Reiji just happens to be Kazuki's cold-hearted playmate. \n\n(Source: DokiDoki)\n\nIncluded one-shot: Inu to Shounen (A Dog and a Boy)	https://cdn.myanimelist.net/images/manga/2/152301l.jpg	5.80	285	\N	22968	Finished	f	1997-12-31 16:00:00-08	\N	4	1	2025-02-27 18:13:33.007453-08	2025-02-27 18:13:33.007453-08
193	Zig☆Zag	Zig☆Zag	ZIG☆ZAG	Freshly enrolled in Seifuu Academy, Takaaki Asakura (aka. Taiyou*-kun) is now living in a boys' dormitory. He has a strange and incomprehensible roommate named Sonoh Kirihara. Furthermore, his neighbor is Tatsuki Suwa, whom he hasn't seen since elementary school!? Meanwhile, he becomes friends with his classmates, Saho and Mei, and has high hopes for his new school life!\n\n(Source: Maboroshi Scanlation)\n\nIncluded one-shot:\nVolume 4: Heaven Company	https://cdn.myanimelist.net/images/manga/3/171468l.jpg	6.99	303	9156	16349	Finished	f	2004-09-23 17:00:00-07	2008-09-23 17:00:00-07	44	9	2025-02-27 18:13:33.086355-08	2025-02-27 18:13:33.086355-08
194	Mai	Mai, The Psychic Girl	舞	Mai is silly, giggly, and flirtatious - just like any other cute fourteen-year-old girl. As far as Mai is concerned, her telekinetic abilities are just good for practical jokes. But when the secret organization known as the Wisdom Alliance tries to exploit her as a weapon to enslave the world, her father puts his life on the line to protect her. And Mai soon learns the hard way that her powers are no joke, but capable of unbelievable, deadly force!\n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/1/279154l.jpg	6.71	584	13597	9785	Finished	f	1984-12-31 16:00:00-08	1985-12-31 16:00:00-08	53	6	2025-02-27 18:13:33.163259-08	2025-02-27 18:13:33.163259-08
195	Zig x Zag	\N	ZIG×ZAG	In an attempt to see her dad again, Yuuki and her brother Hiroaki decide to make a championship baseball team. Iria, the new transfer student, who is an oddball has star pitching potential. Yuuki forces him to join her team picking up others as they go along. \n\n(Source: MegKF)	https://cdn.myanimelist.net/images/manga/2/1028l.jpg	6.68	176	13957	26558	Finished	f	2000-11-12 16:00:00-08	2001-06-12 17:00:00-07	8	2	2025-02-27 18:13:33.215543-08	2025-02-27 18:13:33.215543-08
196	Zeus	Zeus	ゼウス	Kira Yuuki is a 15 year old boy whose only wish is to be a normal teenager. Despite what he wants, he isn't really human at all -- he's a Lemora Saramanda. There's a strange symbol on his palm, testimony to what his is. Inaba and Yukia are two of the Kira's closest friends. However, because he is a special type of his species, Kira is wanted by others for the power he can bring. The mysterious Rosen Kroitz Secret Society seems to know a great deal about the Saramanda, keeping them as pets and breeding them. One day, Kira is captured by his pursuers, and Inaba and Yukia chase after the car he's trapped in. The accident that follows changes everything for the friends, as does the appearance of Kira's older brother... (Source: Storm in Heaven)	https://cdn.myanimelist.net/images/manga/3/23202l.jpg	6.18	711	19099	13402	Finished	f	1997-09-30 17:00:00-07	1998-08-31 17:00:00-07	3	2	2025-02-27 18:13:33.270773-08	2025-02-27 18:13:33.270773-08
197	Zettai Unmei Houteishiki	\N	絶対運命方程式	Tamaki, the son of a Yakuza family, is friends with Tomoyuki who is 12 years older than him. One day, Tomoyuki kisses Tamaki. Tamaki becomes confused and runs away but before he has a chance to figure out his feelings, Tomoyuki goes abroad for 3 years without saying anything or keeping in touch with Tamaki. Now Tomoyuki is back in Japan but he's avoiding Tamaki. Can the two become close again? (Source: B-U)	https://cdn.myanimelist.net/images/manga/2/1345l.jpg	7.06	1037	\N	10483	Finished	f	2004-09-24 17:00:00-07	\N	4	1	2025-02-27 18:13:33.345699-08	2025-02-27 18:13:33.345699-08
198	Gravity Eyes	Gravity Eyes	グーラビティ・アイズ	This series is a spin-off of Tsumasaki ni Kiss following the character of Kyouya.\nfrom Dangerous Pleasure\n\nKyouya has left hosting to go to university and work at a regular job. That is when he meets an assistant professor, Kiriya, whose "cold eyes" have drawn him in.\n\nKyouya's problems begin with his restaurant boss who he has an emotional attachment to that he doesn't know how to deal with. He turns to Kiriya, who in turn has his own past to get over.\n\nWill Kyouya and Kiriya be able to overcome their pasts and find a future together?\n\nVolume 1 contains the Extra:  The Flower's Name\nVolume 2 contains the Extra:  Love Life	https://cdn.myanimelist.net/images/manga/3/17732l.jpg	7.61	1166	\N	9523	Finished	f	2006-12-31 16:00:00-08	2008-04-30 17:00:00-07	8	2	2025-02-27 18:13:33.427161-08	2025-02-27 18:13:33.427161-08
199	Ningyo Series	\N	人魚シリーズ	There is a legend that says if someone eats the flesh of a mermaid, they will attain immortality; but this myth contains a darker side, in that the devourer may die or become a monster. \n\nThe youthful Yuta has been wandering Japan in search of mermaids not to become immortal, but to break his curse of eternal life. Over five hundred years ago, he ate a mermaid; now, Yuta is in search of a cure, hoping the mermaids know the secret. When he stumbles upon a hidden village, he quickly learns that it is full of mermaids that live in an underground society centered around the murder and cultivation of young human women to maintain their own youth and immortality. \n\nTheir most recent victim, Mana, is given the flesh of a mermaid to eat in order to fulfill the recipe toward being a perfect candidate to be eaten. Yuta helps her escape, and they find themselves on a journey to live their lives as normal as they can.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/183364l.jpg	7.41	3185	3751	2644	Finished	f	1984-07-31 17:00:00-07	1994-01-31 16:00:00-08	16	3	2025-02-27 18:13:33.484061-08	2025-02-27 18:13:33.484061-08
200	Tsumasaki ni Kiss	A Gentleman's Kiss	爪先にキス	Yakuza heir Homura Yasobe has a secret lover, the young businessman Touji Karasuma. A resourceful man who will do whatever it takes to succeed; Touji is in fact the noble son of the rival company competing with Homura. If anyone were to find out, it would mean war between the groups! But can the two keep their rendezvous secret? An adult story of secret love between heirs with lives hanging in the balance! (Source: DMP)	https://cdn.myanimelist.net/images/manga/2/4927l.jpg	7.51	908	\N	11270	Finished	f	2004-12-31 16:00:00-08	2005-12-31 16:00:00-08	8	2	2025-02-27 18:13:33.564279-08	2025-02-27 18:13:33.564279-08
201	Kidou Keisatsu Patlabor	Mobile Police Patlabor	機動警察パトレイバー	In the near future, large mecha called Labors are made to assist in various reconstruction projects in major countries around the world that are being threatened by global warming. In Japan, the government has enacted Project Babylon in order to conduct land reclamation. Labors are also being pressed into police and military service aside from civilian use.\n\nHowever, terrorists are now attempting to use labors to make themselves heard, as well as common criminals, thugs and guerrillas. The National Police Agency established the Special Vehicles Division, an all-labor task force to combat the potential use of labors for criminal/terrorist activities.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/3/194559l.jpg	7.61	646	2252	7256	Finished	f	1988-03-22 16:00:00-08	1994-05-10 17:00:00-07	91	22	2025-02-27 18:13:33.643871-08	2025-02-27 18:13:33.643871-08
202	9th Sleep	9th Sleep	ナインス スリープ	The planet had died once before… On the day of Despaira, a god appeared in the sky and saved the world. His name was King Shishioh. But now with the throne of the king empty, a vicious battle between two brothers is unfolding. Who will ascend the throne?\n\n(Source: Juné)	https://cdn.myanimelist.net/images/manga/3/268329l.jpg	6.61	527	14967	15262	Finished	f	2003-12-31 16:00:00-08	\N	3	1	2025-02-27 18:13:33.753834-08	2025-02-27 18:13:33.753834-08
203	Ai no Chikara de Koi wo Suru no da	Crushing Love	愛のチカラで恋をするのだ	When rich, gorgeous and heartbroken Keiichiro Kuroda’s ex-lover asks for a loan, he makes a bet with the man: he’ll leave 5 million yen in a park with a sign that reads “Please Use Freely,” and if it gets turned into the police, his ex can borrow the money; if someone takes the money, Keiichiro can finally turn away the man who broke his heart.  But when the first person to spot the money ends up being a handsome young man in trouble, can Keiichiro give up on his quest for revenge and fall in love once more?\n\n(Source: Juné Manga)	https://cdn.myanimelist.net/images/manga/2/31095l.jpg	6.72	805	\N	10921	Finished	f	2005-12-31 16:00:00-08	\N	8	1	2025-02-27 18:13:33.817901-08	2025-02-27 18:13:33.817901-08
204	Ai no Kotodama	Words of Devotion	愛の言霊	After graduating from high school, Tachibana and Otani have finally confessed their love for each and are not living together. However, their life as "newlyweds" is rudely interrupted when they run into an old, high school classmate, Yuki. Otani has always been suspicious of the close friendship between Yuki and Tachibana; and honestly, his suspicions may not be that far off... Are the feelings between Yuki and Tachibana simply an ordinary crush, or could they be more?\n\n(Source: Juné)	https://cdn.myanimelist.net/images/manga/3/152302l.jpg	7.04	731	\N	12083	Finished	f	1999-12-31 16:00:00-08	2001-12-31 16:00:00-08	13	2	2025-02-27 18:13:33.919105-08	2025-02-27 18:13:33.919105-08
205	Akutai wa Toiki to Mazariau	Sweet Whisper	悪態は吐息とまざりあう	“Do not deceive a person. Do not threaten a person. Do not handcuff people. Any illegal activity is forbidden.” This is an excerpt from the deal between Natsume the salarymen in sales and the college kid Touji. It all began with a little stalking, some handcuffs, and an unexpected night in the slammer. Where will this budding love lead? (Source: MangaUpdates)\n\nIncludes the extra: Mutsugoto wa Akutai ni Torikawaru\nTouji's requests are getting more and more. Will Natsume give in to him?	https://cdn.myanimelist.net/images/manga/1/5936l.jpg	6.91	829	\N	11487	Finished	f	2004-12-31 16:00:00-08	\N	6	1	2025-02-27 18:13:33.970751-08	2025-02-27 18:13:33.970751-08
206	Kidou Senshi Gundam 0079	Mobile Suit Gundam 0079	機動戦士ガンダム0079	Mobile Suit Gundam 0079 is retelling of the story remembered so well in Japan-of a war occurring on Earth's not-so-far-off future, when humanity's millions living in orbiting space colonies begin to push for their independence from the government of Earth, and new weapon called a "Mobile suit" becomes the deciding factor in battle....\n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/1/301412l.jpg	7.26	344	5271	14161	Finished	f	1992-12-31 16:00:00-08	2004-12-31 16:00:00-08	72	12	2025-02-27 18:13:34.023681-08	2025-02-27 18:13:34.023681-08
207	Alcohol, Shirt, and Kiss	Alcohol, Shirt, and Kiss	酒とYシャツとキス	Crushed beneath the weight of lost love, Naru hopes to mend his broken heart by drinking his nights away with fellow detective Kita. The morning after their third night of drinking… they wake up naked? The cute but rough and wicked couple has arrived! (Source: DMP)	https://cdn.myanimelist.net/images/manga/2/5897l.jpg	6.87	390	\N	17553	Finished	f	2003-12-31 16:00:00-08	\N	9	1	2025-02-27 18:13:34.063413-08	2025-02-27 18:13:34.063413-08
208	Naichaisou yo.	Almost Crying	泣いちゃいそうよ。	1. Sky-Blue Elegy\n2. The Mer-Prince\n3. Milk Robot\n4. Second Hand\n5. Words to Send\n6. Celluloid Closet\n7. Almost Crying\n8. The Taste of First Love	https://cdn.myanimelist.net/images/manga/3/5489l.jpg	6.65	220	14469	20463	Finished	f	2002-10-28 16:00:00-08	\N	8	1	2025-02-27 18:13:34.124967-08	2025-02-27 18:13:34.124967-08
209	Seiyou Kottou Yougashiten	Antique Bakery	西洋骨董洋菓子店	A high school crush, a world-class pastry chef, a former middle-weight boxing champion...and a whole lot of cake! Ono has come a long way since the agonizing day in high school when he confessed his love to handsome Tachibana. Now, some 14 years later Ono, a world-class pastry chef and gay playboy has it all. No man can resist Ono's charms (or his cooking skills!), but he has just found a new position under a man named Tachibana. Can this be the only man who resisted his charms, and if so, will the man who once snubbed the "magically gay" Ono get his just desserts? And how in the heck did a former middleweight boxing champion wind up as Ono's cake boy?\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/2/279458l.jpg	7.63	1882	2123	4681	Finished	f	1999-04-27 17:00:00-07	2002-07-26 17:00:00-07	23	4	2025-02-27 18:13:34.166128-08	2025-02-27 18:13:34.166128-08
211	Kurumi no Naka	In the Walnut	胡桃の中	This is the story of Nakai, a filmmaking apprentice, and Tanizaki, the owner of the art gallery In the Walnut. The two of them have been friendly since their days studying art at university, and now their friendship is giving way to a burgeoning relationship. It's hard to get a grip on ordinary Tanizaki, and in reality there's another side to him—a con man side…! Touko Kawai provides a prescription for love in her latest popular series!\n\n(Source: Juné Manga)	https://cdn.myanimelist.net/images/manga/1/6148l.jpg	6.97	231	\N	20682	Finished	f	2002-08-04 17:00:00-07	2010-10-08 17:00:00-07	\N	3	2025-02-27 18:13:34.244054-08	2025-02-27 18:13:34.244054-08
212	Me ni wa Sayaka ni Mienedomo	Beyond My Touch	目にはさやかに見えねども	At his classmate Mamoru Takayama's funeral, Mizuno runs into boy of the hour--Takayama! Takayama is apparently unable to rest in peace because he has a lingering attachment to this world. His unfinished business is to steal Mizuno's lips! Will ghost Takayama's wish be fulfilled!? Also featured in this volume is an epilogue of the story plus a bonus romance story entitled "Gift."\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/1/5490l.jpg	7.09	713	\N	12728	Finished	f	2002-12-31 16:00:00-08	\N	6	1	2025-02-27 18:13:34.353415-08	2025-02-27 18:13:34.353415-08
213	Binetsu Kakumei	Sweet Revolution	微熱革命	Tatsuki and Oota are two beings from a supernatural, mythical realm, masquerading as "cousins" in the human world. Tatsuki is in fact the successor to Ryuu-Ou, the dragon king, and possesses the power of the Nyoi-Houshu, a magical dagger. Oota is a Zashiki Warashi, a protective house-spirit without a home, and is also Tatsuki's subservient lover. When their human classmate, Kouhei Misaki, accidentally witnesses the two having sex, he mistakenly believes that Tatsuki is forcing the quiet Oota into it, and he resolves to break the two apart.\n\n(Source: Juné)	https://cdn.myanimelist.net/images/manga/2/176521l.jpg	6.56	391	15633	18109	Finished	f	1999-12-31 16:00:00-08	\N	7	1	2025-02-27 18:13:34.409823-08	2025-02-27 18:13:34.409823-08
214	Kidou Senshi Gundam: The Origin	Mobile Suit Gundam: The Origin	機動戦士ガンダム THE ORIGIN	Zeon ace pilot, Commander Char Aznable, thought he could foil the Federation's plan to build a mobile suit by attacking their research base on colony Side 7. He was wrong. With a prototype already active, the besieged Federation forces strike back using their new weapon, the mobile suit Gundam, with devastating consequences. Amidst the fighting, young electronics wizard Amuro Ray is determined not to let his friends and family die in the crossfire. But what can one boy do to repel a squad of mobile suit-clad invaders?\n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/1/151300l.jpg	8.51	4342	144	1213	Finished	f	2001-06-24 17:00:00-07	2014-06-25 17:00:00-07	112	24	2025-02-27 18:13:34.462307-08	2025-02-27 18:13:34.462307-08
279	Kissing	Kissing	kissing キッシング	"The person I love is you, Haru!"\nHaru is shocked by the sudden confession from his best friend Kazushi and the passionate kiss that follows! However, he can't bring himself to see the perfect and widely admired Kazushi as anything more than a friend. Determined to win Haru's admiration and love, Kazushi steals a kiss every chance he can get. How long can Haru ward off his increasingly strong and bold advances?\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/3/6153l.jpg	7.18	919	\N	10894	Finished	f	2004-04-30 17:00:00-07	\N	5	1	2025-02-27 18:13:39.300653-08	2025-02-27 18:13:39.300653-08
215	Pixy Junket	Pixy Junket	ジャンケット	When an innocent pixy named "Pacifica" appears and attaches herself to young rapscallions Tatsuki and Shin, the government and a host of nefarious characters all want to kidnap her for their personal gain! The last surviving member of the royal family thinks Pacifica will grant him eternal life. A genie claims, "Pixies are the treasures of the world, with the poor to integrate anything and everything in the universe." Our heroes, frankly, care more about where their next gourmet meal is coming from. But it's hard to travel incognito when you're accompanied by a pretty little pixy with huge, translucent, shimmering wings! (Source: Viz)	https://cdn.myanimelist.net/images/manga/1/19l.jpg	\N	\N	20432	43689	Finished	f	1992-07-31 17:00:00-07	\N	6	1	2025-02-27 18:13:34.556715-08	2025-02-27 18:13:34.556715-08
216	RahXephon	RahXephon	ラーゼフォン	A mysterious orb envelops the city of Tokyo. All forms of communication are severed, leaving the inhabitants of the newly dubbed "Tokyo Jupiter" ignorant to their fate. Along with the United Nations, a special organization known as TERRA is formed: their mission is to liberate Tokyo from the otherwordly MU -- those responsible for Tokyo's capture. (Source: Viz Media)	https://cdn.myanimelist.net/images/manga/2/229880l.jpg	6.34	990	18052	9010	Finished	f	2001-09-18 17:00:00-07	2002-11-18 16:00:00-08	16	3	2025-02-27 18:13:34.601319-08	2025-02-27 18:13:34.601319-08
217	Boku dake no Ousama	My Only King	ボクだけの王さま	In the land of magic, a new king is being crowned. However, a mishap during the ceremonial rite causes the royal crest to be accidentally attached to a normal human, Kazuomi. To protect the crest from any villains who may be after it, Mewt, the cute and brave sorcerer, is dispatched to the human world. There, Mewt must live disguised as a girl, and as "she" and Kazuomi live under one roof together, the two begin to find themselves attracted to each other... \n\n(Source: Juné)	https://cdn.myanimelist.net/images/manga/3/11249l.jpg	6.56	332	\N	17913	Finished	f	2004-08-27 17:00:00-07	\N	8	1	2025-02-27 18:13:34.691746-08	2025-02-27 18:13:34.691746-08
218	Bokura no Oukoku	Our Kingdom	僕らの王国	Upon the death of his grandmother, country boy Akira Nonaka is taken in by the immensely wealthy and powerful Takatou family. there, he is told that he is a candidate to become next heir to the Takatou name. However, there is another candidate—the princely, handsome Rei, who turns out to be a cousin of Akira's. Far from being competitive, Rei shows no interest in the prospect of inheritance, and instead takes an immediate liking to Akira. Rei's aggressive shows of affection muddle the naive country boy, until Akira begins to discover a budding attraction towards Rei within himself.\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/3/170877l.jpg	7.45	909	\N	9683	Finished	f	1999-12-31 16:00:00-08	2006-12-31 16:00:00-08	27	6	2025-02-27 18:13:34.747752-08	2025-02-27 18:13:34.747752-08
219	Alive: Saishuu Shinkateki Shounen	Alive: The Final Evolution	アライブ 最終進化的少年	Taisuke Kanou is your average 16-year-old student. He has two close friends, Hirose and Megumi. Hirose has trouble with bullies, but Taisuke is always there to defend him, even though he just winds up getting beaten instead of Hirose. During class one day, Taisuke is hit by something unworldly and for that split second, he sees a vision of the universe. As he's walking home from school, he sees a girl fall and die in front of him, but his first thought is jealousy. He later finds out that the strange sensation that hit him is spreading throughout Japan. Those who are struck by it either commit suicide or "evolve," but the comrades that evolve usually have dark intentions for the rest of the world.\n\n(Source: ANN)	https://cdn.myanimelist.net/images/manga/1/185482l.jpg	7.77	9894	1450	728	Finished	f	2003-04-04 16:00:00-08	2010-02-05 16:00:00-08	83	21	2025-02-27 18:13:34.814274-08	2025-02-27 18:13:34.814274-08
220	Aventura	Adventura	Aventura	Lewin Randit is a first-year student attending the Gaius School of Witchcraft and Wizardry—except that he shows no aptitude for magic. Currently in training as a Swordsman, Lewin is constantly picked on by classmates and teachers alike for his lack of talent. But one day in the library, Lewin makes a couple of friends from the Magic division, and for the first time ever there are people who actually enjoy his company. However, a visit to the Magic division's labs goes awry when Lewin and his new friends accidentally unleash an army of undead! Now a team of inexperienced first-year students must fend off a magical dilemma that even the school professors would have trouble with.\n\n(Source: ANN)	https://cdn.myanimelist.net/images/manga/3/5261l.jpg	7.34	266	4439	16266	Discontinued	f	2005-05-25 17:00:00-07	2015-08-25 17:00:00-07	39	6	2025-02-27 18:13:34.903424-08	2025-02-27 18:13:34.903424-08
221	Basilisk: Kouga Ninpouchou	Basilisk: The Kouga Ninja Scrolls	バジリスク～甲賀忍法帖～	The Kouga Manjidani and the Iga Tsubagakure ninja clans have been sworn enemies for centuries, with only the Hanzo Hattori truce maintaining a tenuous peace between the two families. But years later, when former shogun Ieyasu Tokugawa faces a dispute to determine which of his two grandsons shall succeed their father, he decides to settle the matter through a proxy war. Selected to represent the respective candidates, the Kouga and Iga send 10 of their best fighters into a deadly battle, with the winning party deciding the rightful successor. Thus, the truce is revoked and the ruthless bloodshed begins.\n\nBut not all approve the truce's end. Gennosuke of Kouga and Oboro of Iga were to be married in hopes of ensuring lasting peace. However, unlike typical arranged marriages, they were already deeply in love. As preparations for the war ensue, Gennosuke questions his loyalties while Oboro refuses to fight. Fueled by their reawakened feud, will the two clans be consumed by hatred, or have their destinies changed by genuine love?\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/177216l.jpg	7.45	7779	3319	1128	Finished	f	2003-02-03 16:00:00-08	2004-06-14 17:00:00-07	34	5	2025-02-27 18:13:34.956882-08	2025-02-27 18:13:34.956882-08
222	Le Chevalier D'Eon	Le Chevalier D'Eon	シュヴァリエ	A mysterious cult is sacrificing beautiful young women to a demonic force that has promised them the kingdom of France in return for the blood of their victims. Only one man can save Paris from chaos and terror: the Chevalier d'Eon!\n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/3/286577l.jpg	7.05	617	8134	7958	Finished	f	2005-01-25 16:00:00-08	2008-11-25 16:00:00-08	45	8	2025-02-27 18:13:35.050325-08	2025-02-27 18:13:35.050325-08
223	Café Kichijouji de	Café Kichijoji de	Café吉祥寺で	"Irasshai!" Welcome to the most unruly cafe in Kichijouji and its charming staff of five who have absolutely nothing in common. When tempers rise, so do mop handles, giant boulders and repair bills. Meet Jun, a mild mannered high school student with a sharp tongue and superhuman strength. Tarou, a clean freak with a deadly aim in the art of mopping. Maki, a sloppy, lazy woman chaser. Minagawa, a talented pastry chef equally skilled in the arts of voodoo, and the impulsive, cheerful, though desperately unfortunate Tokumi. A feast of comedy based on the popular Japanese radio drama.\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/1/750l.jpg	7.22	782	5830	10213	Finished	f	2001-04-30 17:00:00-07	2003-03-31 16:00:00-08	14	3	2025-02-27 18:13:35.124694-08	2025-02-27 18:13:35.124694-08
237	Dear Myself	Dear Myself	ディア・マイセルフ	One fateful morning, Hirofumi awakens to discover he has no memory of the previous two years. He has forgotten his classmates and everything he's learned at school. All he recalls is the car accident that caused his amnesia. When he finds a letter written to himself, he is shocked to discover that he has been romantically involved with the tragic and handsome Daigo! Can true love triumph over the loss of memory? And will Hirofumi be able to make Daigo smile again? (Source: DMP)	https://cdn.myanimelist.net/images/manga/5/843l.jpg	7.15	1492	6787	7695	Finished	f	1997-12-31 16:00:00-08	\N	3	1	2025-02-27 18:13:36.115546-08	2025-02-27 18:13:36.115546-08
224	Camera Camera Camera	Camera Camera Camera	カメラ・カメラ・カメラ	Akira Togawa is a normal teenager: he goes to an average high school, he plays video games, he's in love with his step-brother, he's harassed by lecherous photographers, picked on by mischievous little boys, insulted by possessive young women...you get the idea. When a scruffy photographer by the name of Kaoru Nakahara has a premonition of love (or so he says) and takes a campus photography job, he ends up meeting Akira and falls head over heels. Will Akira learn to love the persistent pervert, or will he cling to his beloved brother?\n\n(Source: Juné Manga)	https://cdn.myanimelist.net/images/manga/2/30593l.jpg	6.72	193	13399	25905	Finished	f	2001-12-31 16:00:00-08	\N	13	2	2025-02-27 18:13:35.20079-08	2025-02-27 18:13:35.20079-08
225	Chiisana Glass no Sora	Glass Sky	小さなガラスの空	Everyone thought Naoki was a little flamboyant, and he was used to getting teased for it. But when Yada glanced at him, he felt something he never had before! Ten deftly written short episodes explore the pathos, confusion, drama, passion and humor of coming out and finding one’s true self. Forbidden desire, hidden lust, jealousy and acceptance collide in this collection of wonderfully drawn, bittersweet short stories of teenage romance by author Yugi Yamada!\n\n(Source: Juné Manga)	https://cdn.myanimelist.net/images/manga/2/33041l.jpg	6.67	413	\N	18088	Finished	f	1999-12-31 16:00:00-08	\N	9	1	2025-02-27 18:13:35.272066-08	2025-02-27 18:13:35.272066-08
226	Mizu Nurumu	Spring Fever	水温む	Yusuke Onishi easily gets crushes on everybody and anybody, but never succeeds in love. That is, until the day he meets and falls in love with his new neighbor—a mature single parent. Yusuke has finally met his match. But his match just happens to be a guy! This is a classic oyaji-uke of an unexpected love between two people, one younger, one older.\n\n(Source: Deux)\n\nIncluded one-shots\nWildman Blues	https://cdn.myanimelist.net/images/manga/2/249350l.jpg	6.92	353	\N	21047	Finished	f	2000-09-30 17:00:00-07	2001-02-28 16:00:00-08	6	1	2025-02-27 18:13:35.373965-08	2025-02-27 18:13:35.373965-08
227	Taiyou no Shita de Warae	Laugh Under the Sun	太陽の下で笑え。	After seriously injuring an opponent in a boxing match-Sohei quits his dream of ever being a pro boxer. Ten years later, after a string of failed jobs and relationships, his friend Chika finally convinces him to get back into boxing. But where Sohei was once champ material, he is now 25 years old (over the hill in boxing years) and must play catch up with all the 18-year-olds at the gym. To make things worse, Chika’s been secretly in love with Sohei for years, and has about had it with waiting for Sohei to figure it out. With his upcoming pro test, his squabbles with the youngsters in the boxing club, and Chika’s increasingly bold advances, will Sohei finally find some direction and happiness in his life?\n\n(Source: Juné Manga)	https://cdn.myanimelist.net/images/manga/2/33042l.jpg	6.96	258	\N	23429	Finished	f	1998-12-31 16:00:00-08	\N	5	1	2025-02-27 18:13:35.430568-08	2025-02-27 18:13:35.430568-08
228	Silent Möbius	Silent Möbius	サイレントメビウス	In the 21st century, just when the human race needs new heroes, the Lucifer Hawks enter Earth's dimension. The members of the A.M.P., six young women with incredible powers, are set to defend the human race against these monstrous entities from another world.\n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/4/278215l.jpg	7.13	414	7076	11780	Finished	f	1990-12-31 16:00:00-08	2002-12-31 16:00:00-08	\N	12	2025-02-27 18:13:35.509492-08	2025-02-27 18:13:35.509492-08
229	Dragon Head	Dragon Head	ドラゴンヘッド	Three teenagers—Teru Aoki, Nobuo Takahashi, and Ako Seto—discover that they are the lone survivors of a gruesome train accident that proved fatal to their fellow classmates and teachers. In an attempt to make their way out of the dreadful wreckage, they band together to grapple with hunger, loneliness, and the overwhelming sense of loss. However, as something sinister lurks in the shadows, the trio must fight off their worst impulses and the temptation to succumb to madness in these cruel times of despair.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/196300l.jpg	7.16	9279	6588	698	Finished	f	1994-09-11 17:00:00-07	1999-12-12 16:00:00-08	89	10	2025-02-27 18:13:35.604975-08	2025-02-27 18:13:35.604975-08
230	Chou ni Naru Hi	The Day I Become a Butterfly	チョウになる日。	The Day I Became a Butterfly is a volume which contains six chapters, each a different story:\n\n1) The Day I Become a Butterfly\n2) You at the end (Hate ni Aru Kimi)\n3) The Lonely War\n4) Blue Cat Tunnel\n5) Tokyo Alien Ulala\n6) Planet Yours\n\n(Source: ActiveAnime)	https://cdn.myanimelist.net/images/manga/4/21393l.jpg	7.56	1876	2546	5569	Finished	f	2003-06-30 17:00:00-07	\N	6	1	2025-02-27 18:13:35.708654-08	2025-02-27 18:13:35.708654-08
233	Nakagami-ke no Ichizoku	Clan of the Nakagamis	仲神家の一族	Haruka Iijima and Tokio Nakagami are student and teacher... and star-crossed lovers! If their forbidden relationship weren't enough trouble, they also have to deal with the rest of Tokio's family, the strange and insane Nakagami Clan! Not only are the Nakagamis all devastatingly gorgeous and apparently ageless, they're all completely obsessed with Tokio- and that means nothing but trouble! Can Haruka and Tokio keep their love alive in the face of such utter weirdness?\n\n(Source: Juné Manga)	https://cdn.myanimelist.net/images/manga/3/31109l.jpg	6.87	326	\N	18673	Finished	f	2004-12-31 16:00:00-08	2006-12-31 16:00:00-08	4	1	2025-02-27 18:13:35.759019-08	2025-02-27 18:13:35.759019-08
234	Saigo no Door wo Shimero!	Close the Last Door	最後のドアを閉めろ！	Nagai is just your typical office guy...except that he’s had a secret crush on his coworker Saitou for ages. But with Saitou’s massive wedding just around the corner, Nagai realizes that it’s finally time to retire his illicit desire for the adorable young man. However, sly Honda has a few teasing tricks up his own sleeve...and once the beer starts flowing, there’s no telling where the night will end! Is this love triangle destined to tumble, or will it evolve into the most tantalizing tryst ever?\n\n(Source: Juné Manga)	https://cdn.myanimelist.net/images/manga/3/33045l.jpg	7.58	1273	\N	7714	Finished	f	2000-12-31 16:00:00-08	\N	15	2	2025-02-27 18:13:35.859794-08	2025-02-27 18:13:35.859794-08
235	Aiteru Door kara Shitsurei Shimasuyo	Open The Door Through Your Heart	開いてるドアから失礼しますよ	This time focusing on the two elder brothers of Kenzou Honda...\n\nShouichi Honda goes to the Asian imported product shop to collect the tax. There he happens to meet an importer, his younger brother, Junji who had run away from home. When Shouichi returns home, Junji is already there having a card game with their parents. They realize how their feelings have not changed since they made love only once 10 years ago.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/2/33046l.jpg	7.06	656	\N	13821	Finished	f	2002-12-31 16:00:00-08	\N	7	1	2025-02-27 18:13:35.999245-08	2025-02-27 18:13:35.999245-08
236	Kawaii Beast	Cute Beast	かわいいビースト	There’s a tall and mysterious (and scary!) guy named Onizuka in Kisaki’s class. He looks horrifying at first glance, but if you take a good look, he’s actually pretty handsome! And yet he acts like a big lumbering animal all the time. He’s practically a little baby! Now, Kisaki’s starting to feel like he wants to keep Onizuka’s hidden charms to himself… but why?! Don’t miss this love story between Kisaki and his cute beast!\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/2/759l.jpg	7.11	1042	\N	9242	Finished	f	2006-10-29 16:00:00-08	\N	6	1	2025-02-27 18:13:36.057352-08	2025-02-27 18:13:36.057352-08
238	Dear Myself: World's End	Dear Myself: World's End	DEAR MYSELF 2: WORLD'S END	It's been four years since Hirofumi and Daigo started living together. But because of his psychological scars, Daigo gradually starts inposing frightening restraints on Hirofumi! Caught in a cage of love and madness, what will Hirofumi's ultimate answer be? At last, the conclusion to the popular Dear Myself series! Also contains the short stories "Last Spring," depicting the alien Hirofumi from those two lost years; "Kiss on a Honeymoon," the aftermath for Ayane and Fumiya, and the now legendary chapters of "Papa's 18"!\n\n(Source: Digital Manga Publishing)	https://cdn.myanimelist.net/images/manga/1/152305l.jpg	6.97	652	9394	13272	Finished	f	1998-12-31 16:00:00-08	\N	7	1	2025-02-27 18:13:36.176133-08	2025-02-27 18:13:36.176133-08
239	Yabai Kimochi	Desire	ヤバイ気持ち	Tooru is a shy and quiet student who has developed a special crush on his close friend Ryouji, the most popular member of the high school swim team. In front of Ryouji, Tooru hides his feelings and acts as if he is just one of Ryouji's good friends, but in a moment out of the blue his world will be turned upside down as Ryouji will confess a secret desire for Tooru. Dazzled, Tooru can barely hide his excitement for Ryouji and quickly accepts his offer. As time passes, Tooru's happiness begins to fade knowing that his affair with Ryouji was just a fling based out of Ryouji's sexual curiosity.\n\nTooru, adamant about his feelings for Ryouji, confides in another one of his close friend, Kashiwazaki, about his dilemma. The two set off to devise a plan to test Ryouji's true intentions by faking a romantic relationship. Soon after, a frustrated and jealous Ryouji attempts to pry Tooru out of the arms of Kashiwazaki. Is it just as they planned? Yeah! That is of course until Tooru realizes Kashiwazaki wasn't really faking! How could he not have seen it coming?\n\nBoth Tooru and Ryouji have hidden their feelings from each other in the past, but now they have discovered that they were not the only ones. Will Tooru and Ryouji be reunited or will their true feelings for each other go unfulfilled?\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/2/159373l.jpg	7.18	1402	\N	8135	Finished	f	2001-08-31 17:00:00-07	\N	4	1	2025-02-27 18:13:36.212909-08	2025-02-27 18:13:36.212909-08
240	Sore wo Ittara Oshimaiyo	Don't Say Anymore Darling	それを言ったらおしまいよ	Kouhei is a doctor at the local university hospital who has lost touch with his high school friend Tadashi. While Kouhei grew up to become a successful young doctor, Tadashi became a jobless, poor-as-dirt, flaming gay writer. But one lonely night, at his wits end, Tadashi sends Kouhei a text message and receives a reply. Of course Tadashi has secretly harbored feelings for Kouhei for a long time. But when he finds out Kouhei is getting set-up for an arranged marriage...\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/3/30562l.jpg	6.85	288	\N	21593	Finished	f	2003-12-31 16:00:00-08	\N	5	1	2025-02-27 18:13:36.269977-08	2025-02-27 18:13:36.269977-08
241	Dousaibou Seibutsu.	Same Cell Organism	同細胞生物。	Nakagawa and Yokota are two boys very much in love with each other. Yokota is more open with his feelings, but Nakagawa is easily embarrassed of public displays of affection. Though they may be outwardly different, their feelings for each other are the same and their connection is such that they liken themselves to Dousaibou Seibutsu (Same-Cell Organisms). \n\n(Source: DMP) \n\nContains the Stories:\n1. Same Cell Organism\n2. I Love You\n3. Lullaby in My Hand\n4. The Letter in the Attic\n5. To Make Angel (Tenshi wo Tsukuru) (Prequel)\n6. To Make Angel (Tenshi wo Tsukuru) (Sequel)\n7. We Selfish Two\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/3/21621l.jpg	7.37	1719	4086	6046	Finished	f	2001-07-31 17:00:00-07	\N	7	1	2025-02-27 18:13:36.373314-08	2025-02-27 18:13:36.373314-08
242	Duetto	\N	デュエット	Every time Shinobu and Ei-ichi see each other on campus at the university they start fighting. But, it turns out they actually live together in an apartment, and when they’re there they act completely different. That is the relationship they keep a secret from the rest of the world… (Source: DMP)	https://cdn.myanimelist.net/images/manga/3/33239l.jpg	6.47	352	\N	20265	Finished	f	2004-11-11 16:00:00-08	\N	10	1	2025-02-27 18:13:36.409601-08	2025-02-27 18:13:36.409601-08
243	Kaiketsu Jouki Tanteidan	Steam Detectives	快傑蒸気探偵団	A Steampunk mystery from the creator of Silent Mobius! In this tale of a past (or future?) that never was, in the age of Steam, masked dandies, dastardly supervillains, and sentient machines stalk a Japanese Gotham by night. Are the sharp wits and quick reflexes of wunderkind detectives Narutaki and pretty nurse Ling Ling enough to thwart evil and unravel the mysteries of this strange world? All steamed up.... When Narutaki meets Ling Ling, a pretty nurse with a dark secret, he gains both a true-blu friend and two new assistants. He'll certainly need all the help he can get when he is forced to do battle with such nefarious villains as the Phantom Knight, the Machine Baron, and Dr. Guilty!\n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/1/133301l.jpg	6.67	170	14137	21242	Finished	f	1993-12-31 16:00:00-08	1999-12-31 16:00:00-08	52	8	2025-02-27 18:13:36.467891-08	2025-02-27 18:13:36.467891-08
244	Enchanter	Enchanter	機工魔術士－enchanter－	Fulcanelli is an "Enchanter," an ancient engineer/alchemist who is able to imbue the weapons and gadgets he constructs with magical powers. Transformed into a demonic being after his death, he is always accompanied by his demon lover Eukanaria. Due to circumstances still unknown, his is in need a new body. Until one can be found, Eukanaria must guard the pendant containing his soul from the many demonic forces that wish to obtain his great power for their own.\n\nIn the present day, Haruhiko Kanou is an ordinary boy good with machines and nursing a crush on his science teacher and neighbor Yuki Fujiwara. Little does he know he is Fulcanelli's perfect double and Eukanaria has tracked him down...\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/1/204027l.jpg	7.42	694	3642	7835	Finished	f	2002-08-25 17:00:00-07	2009-01-25 16:00:00-08	74	19	2025-02-27 18:13:36.551373-08	2025-02-27 18:13:36.551373-08
245	Fake Fur	Fake Fur	フェイクファー	“When I was a junior in high school, I always thought about kissing someone. 15-year-old boys always pretend like that, right? One Valentine’s Day, I received a letter with chocolate…from a guy! The whole class was thrown into an uproar.” A collection of sweet stories like this one, Fake Fur takes you on the rocky road of love. (Source: DMP)	https://cdn.myanimelist.net/images/manga/1/11238l.jpg	6.89	594	\N	13363	Finished	f	2003-12-31 16:00:00-08	\N	8	1	2025-02-27 18:13:36.656039-08	2025-02-27 18:13:36.656039-08
246	Princess Princess	Princess Princess	プリンセス・プリンセス	Why is Toru Kouno receiving such an overly warm welcome at his new all boy's school? He has yet to discover the secret system called "Hime (Princess)" in effect at the school. Boys who are chosen have to dress up as a girl in every school event! Little does Kouno know that he would be the chosen one...\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/1/186261l.jpg	7.54	3458	2666	2755	Finished	f	2002-07-31 17:00:00-07	2006-03-31 16:00:00-08	25	5	2025-02-27 18:13:36.714082-08	2025-02-27 18:13:36.714082-08
269	Mikan no Tsuki	Crescent Moon	未完の月	After Mahiru has a haunting recurring dream, she meets the Lunar Race, which consists of the vampire Nozomu, the werewolf Akira, the fox Misoka, and the tengu Mitsuru. They need her help to recover the "Drops of the Moon," the recently-pilfered source of their power.\n\nAs the battles to recover the Drops rage on, Mahiru tries to open up the dark, human-hating tengu Mitsuru, and form a bridge between humans and the Lunar Race.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/138527l.jpg	7.24	1292	5518	6790	Finished	f	1998-12-31 16:00:00-08	2000-12-31 16:00:00-08	25	6	2025-02-27 18:13:38.409575-08	2025-02-27 18:13:38.409575-08
247	Princess Princess Plus	Princess Princess Plus	プリンセス・プリンセス＋	The new school year is here! Fujimori Academy students Kiriya Matsuoka and Tomoe Izumi have been chosen as this year’s princesses, but it’s going to take a lot of hard work to bring them up to speed. Enter former princesses Kouno, Shihoudani and Yutaka for a bit of princess training! Although Matsuoka and Izumi seem willing and able to take over the job of dressing up as girls and cheering at school events, they’re not exactly what you’d call “friends.” In fact, they seem to be about as opposite as two people can get. This animosity spells trouble for a student body that depends on their princesses to give them a warm, glowy feeling all year long. Can President Sakamoto and the ex-princesses convince Matsuoka and Izumi to bond for the sake of the school? Or will it take more than a common experience to bring two very different people together?\n\n(Source: Dokidoki)	https://cdn.myanimelist.net/images/manga/2/30581l.jpg	7.18	526	6320	10317	Finished	f	2006-04-30 17:00:00-07	2006-12-31 16:00:00-08	6	1	2025-02-27 18:13:36.765989-08	2025-02-27 18:13:36.765989-08
248	Family Complex	Family Complex	ファミリー・コンプレックス	Meet the Sakamotos...a typical, upper middle class family of six with one peculiar quality-namely, they're all uncannily good-looking! That is, except for one member of the clan-14-year-old Akira. At that awkward stage where teenagers feel out-of-place in general, Akira believes he's average in the looks department, which simply doesn't measure up. How can he be around his family when he feels like he's being judged against them all the time? Will Akira's complex about being "different" cause him to turn away from the people who love him most?\n\n(Source: Digital Manga Publishing)	https://cdn.myanimelist.net/images/manga/1/30580l.jpg	7.36	2233	4206	5071	Finished	f	1998-12-31 16:00:00-08	1999-12-31 16:00:00-08	6	1	2025-02-27 18:13:36.814333-08	2025-02-27 18:13:36.814333-08
249	Kakumei no Hi	The Day of Revolution	革命の日	Meet Megumi! She's petite, adorable, and a total eye-catcher. In fact, she reminds almost everyone at school of the very elite (and very missing) boy student Kei Yoshikawa. Whispers and wild rumors begin to run riot from the hallways to the exclusive school rooftop...and the most powerful clique on campus has their sights set on sweet Megumi, too. Can her good friend Makoto shield her from a showdown and help her "skirt" the issue? Are some secrets just too big to keep?\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/1/252614l.jpg	7.37	3852	4087	2853	Finished	f	1998-12-31 16:00:00-08	\N	7	2	2025-02-27 18:13:36.888753-08	2025-02-27 18:13:36.888753-08
250	Flower of Life	Flower of Life	フラワー・オブ・ライフ	Forced to enroll in school one month late after recovering from a serious illness, Harutaro is doing his best to remain optimistic about the entire situation. The other students are working hard to make Haru feel welcome—especially his chubby, loveable pal, Shota; however, Kai Majima, President of the Manga Club and all-around hard case, seems to be the one person intent on making Harutaro's school life a living nightmare.\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/5/29557l.jpg	7.45	300	3303	13571	Finished	f	2004-04-30 17:00:00-07	2007-05-31 17:00:00-07	21	4	2025-02-27 18:13:36.976321-08	2025-02-27 18:13:36.976321-08
251	G-senjou no Neko	Il gatto sul G	G線上の猫	Atsushi Ikeda, a kindhearted college student, tends abandoned animals and brings them inside his home. When he spots an injured high school student with a violin lying at his doorstep, he does not think twice about taking him in for the night. The fierce young man, introducing himself as Riya Narukawa, has no idea why he was unconscious in front of Atsushi's door but worries no further, as he claims that memory lapses are a common occurrence.\n\nThe following day, when Riya gets a sudden headache while playing the violin for Atsushi, he professes that he ran away from home because his dead brother's spirit inside him has been forcing him to play the violin. Stunned by the sudden revelation, a concerned Atsushi discovers that Riya is a prodigious violinist and the only son of a famous musician. Worried that things are not matching up, he soon learns that Riya has a multiple personality disorder, causing him to invent a deceased younger brother whom he believes to be within his soul. Carrying the weight of other people's expectations for his talent, Riya tries to come to terms with the underlying problems behind his psychological complications, all while understanding what Atsushi means to him.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/186454l.jpg	7.47	1361	\N	6595	Finished	f	2002-04-30 17:00:00-07	2007-08-31 17:00:00-07	19	3	2025-02-27 18:13:37.040888-08	2025-02-27 18:13:37.040888-08
252	Gorgeous Carat Galaxy	\N	ゴージャス・カラットGALAXY	Florian and Noir take a trip to Florian's relative's castle to purchase some antique works of art. There, Florian reunites with a childhood acquaintance, Eleonora, an unhappy and somewhat confused girl. Eleonara decides that she wants to keep Florian all to her self and takes him away to an underground cave holding him captive. Noir must now rescue Florian, but with murderous intents following him everywhere and a convoluted dungeon with multiple hidden trapdoors, will Noir succeed and be able to leave with Florian? (Source: DMP)	https://cdn.myanimelist.net/images/manga/3/11215l.jpg	7.17	487	6430	16125	Finished	f	2003-12-31 16:00:00-08	\N	7	1	2025-02-27 18:13:37.150284-08	2025-02-27 18:13:37.150284-08
253	Tenchi Muyou! Sasami-chan À la Carte	Tenchi Muyo! Sasami Stories	天地無用! 砂沙美ちゃんあらかると!	Who's the most popular of all the Tenchi girls? That's an easy question to answer. It's sweet li'l Sasami, of course! She's the cutest and best loved and, without a doubt, the most accomplished cook of the bunch. Whether she's thwarting evil space invaders or simply negotiating peace among her bickering housemates, Sasami always has a big smile on her face.\n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/4/146481l.jpg	7.21	208	5937	21851	Finished	f	2005-03-28 16:00:00-08	\N	3	1	2025-02-27 18:13:37.241661-08	2025-02-27 18:13:37.241661-08
254	Harem de Hitori	Alone in My King's Harem	ハレムでひとり	1. Harem de Hitori (Alone in My King's Harem)\n2. Yoru no Circus\n3. Yoru no Minasoko\n4. Canaria no Bouken\n5. Michiru Hada\n6. Urumu Hada	https://cdn.myanimelist.net/images/manga/2/201062l.jpg	6.97	1367	\N	7734	Finished	f	2001-04-13 17:00:00-07	2004-11-29 16:00:00-08	6	1	2025-02-27 18:13:37.282165-08	2025-02-27 18:13:37.282165-08
255	Hero Heel: Eiyuu to Akkan	Hero Heel	HERO・HEEL 英雄と悪漢	Minami is a young actor who has been cast as the main character of a superhero TV program. Although he takes the job half-heartedly, thinking of it as a mere children's show, he's soon taken by the talent of his costar, Sawada. One day, Minami stumbles upon Sawada kissing a man! Deeply confused, he's unable to hide his growing attraction for him... A hero's love is always filled with trials!\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/1/193140l.jpg	7.48	1255	\N	8505	Finished	f	2004-12-31 16:00:00-08	2006-12-31 16:00:00-08	14	3	2025-02-27 18:13:37.351575-08	2025-02-27 18:13:37.351575-08
256	Hoshigarimasen! Katsumade wa	After I Win	ほしがりません！勝つまでは	When nights grow lonely at the dorm, boys turn to naughty stuff. While pleasuring oneself is commonplace in a house full of teenage boys, Kasumi is nevertheless shocked when he catches his roommate Hiyori engrossed in self-indulgence. What’s more shocking is that Hiyori challenges Kasumi to stay and watch, that is, stay if Kasumi feels something for the older boy. Will he stay or go? Which option is more rewarding for Kasumi?\n\n(Source: Juné Manga)	https://cdn.myanimelist.net/images/manga/3/31115l.jpg	7.30	1717	\N	6747	Finished	f	2005-12-31 16:00:00-08	\N	6	1	2025-02-27 18:13:37.450163-08	2025-02-27 18:13:37.450163-08
257	Hybrid Child	Hybrid Child	Hybrid Child	Commonly mistaken as a doll, the Hybrid Child is a toy that can adapt human abilities—from reading books to conveying emotions. Their capability relies on the degree of affection their owner provides them. Nurture them with the best affection and the model will flourish.\n\nTogether for 10 years, the slothful Kotarou Izumi believes that Hazuki—a Hybrid Child whom he owns—will be in his life for eternity. But everything comes crashing down when the artificial human suddenly collapses.\n\nHybrid Child manifests the struggles of the Hybrid Children and their owners through three brief narratives.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/129067l.jpg	7.78	4823	1404	2091	Finished	f	2003-06-27 17:00:00-07	2004-08-27 17:00:00-07	5	1	2025-02-27 18:13:37.534521-08	2025-02-27 18:13:37.534521-08
258	Ikebukuro West Gate Park	Ikebukuro West Gate Park	池袋ウエストゲートパーク	Based on the phenomenally popular live action Japanese television series Ikebukuro West Gate Park is a very hip and urban drama that takes place in Tokyo's trendy district of Ikebukuro. The story focuses around the 21 year old Makoto, a cool and level headed member of the G-boys gang. Makoto, talented with diffusing tense situations and keeping his friends out of harm's way possibly stumbles into more than he can handle. Is Makoto really in over his head? His new girlfriend's just been found murdered and a turf war is escalating between two rival gangs.\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/3/235433l.jpg	6.95	184	9721	13766	Finished	f	2001-06-30 17:00:00-07	2004-11-24 16:00:00-08	36	4	2025-02-27 18:13:37.588732-08	2025-02-27 18:13:37.588732-08
259	Jazz	Jazz	JAZZ	Can a doctor and his patient ever find romance? Wait patiently, because this is one checkup you won't want to miss! Narusawa and Naoki have way-overstepped the bounds of their doctor-patient relationship. Naoki is instantly attracted to Narusawa, and will stop at nothing to be together with him. One glance into Naoki's despaired eyes and Narusawa caves instantly for Naoki's advances. Will this relationship go beyond a simple fling?\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/2/142093l.jpg	7.22	700	\N	12619	Finished	f	2002-12-31 16:00:00-08	2005-12-31 16:00:00-08	20	4	2025-02-27 18:13:37.669295-08	2025-02-27 18:13:37.669295-08
260	Kashinfuu	Ka Shin Fuu	花信風	The Kourenji Family, a wealthy Japanese empire, is looking for an heir to its massive family. The two candidates, Karou and Ryuugo, are fighting to succeed as the next heir. But as they two pit their strength against each other, Kaoru starts to show another side of himself. It seems he might be more interested in winning Ryuugo than the family fortune.\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/3/6066l.jpg	6.89	607	\N	14078	Finished	f	2006-07-11 17:00:00-07	\N	4	1	2025-02-27 18:13:37.723605-08	2025-02-27 18:13:37.723605-08
261	Kanjou Kairo	Manic Love	感情回路	During the summer of his second year in high school, Maki Sonoda found love for the first time in the arms of his cram school teacher, Haruji Shirai. Blinded by the illusions of his first love, Maki can think only of getting to know Haruji more. But, things become complicated when Maki realizes that Haruji is really in love with high school teacher Mr. Mizuguchi. Three men find themselves intertwined in this tantalizing love triangle full of emotion. (Source: Juné)	https://cdn.myanimelist.net/images/manga/3/11239l.jpg	7.01	369	\N	17259	Finished	f	2005-12-26 16:00:00-08	\N	6	1	2025-02-27 18:13:37.80291-08	2025-02-27 18:13:37.80291-08
262	Kare wa Hanazono de Yume wo Miru	Garden Dreams	彼は花園で夢を見る	In a castle in a far-off western land, there once lived a baron with empty eyes, whose melancholy ways belied a love of beauty and song. A wondrous garden surrounded the baron's home—a place of quiet splendor that served to remind him of his painful, untended memories. Could the songs of two bards bring dreams of a happier tomorrow? Or would they bring more loss than the baron might possibly bear?\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/2/198333l.jpg	7.01	181	8843	25210	Finished	f	1999-09-24 17:00:00-07	\N	4	1	2025-02-27 18:13:37.857602-08	2025-02-27 18:13:37.857602-08
263	Keijijou na Bokura	Our Everlasting	形而上なぼくら	For beach bum Horyu, it’s more than the surf that’s up. He has just confessed his undying love to the timid and quiet Shouin. Though Shouin feels the same, he is reluctant to return Horyu’s affections. Unknown to Horyu, Shouin already had his heart broken and is – as the saying goes – once bitten, twice shy. It looks like Horyu will wipe out on this one, unless he can convince Shouin that he won’t ever go through the same heartache twice.\n\n(Source: Juné Manga)	https://cdn.myanimelist.net/images/manga/2/31099l.jpg	7.34	764	\N	12280	Finished	f	2000-02-29 16:00:00-08	2001-02-28 16:00:00-08	13	2	2025-02-27 18:13:37.918946-08	2025-02-27 18:13:37.918946-08
264	Can't Win With You!	Can't Win With You!	きみには勝てない！	Shuuiku Academy is an elite all-boys school, home to a dormitory full of aspiring young students. But when the dorm’s lights go out, the exited cheers of handsome young men fill the hallways! Watch as love and ambition bloom in this wildly popular boy’s dormitory tale. (Source: DMP)	https://cdn.myanimelist.net/images/manga/4/21392l.jpg	6.87	466	\N	16373	Finished	f	2002-12-31 16:00:00-08	\N	16	3	2025-02-27 18:13:38.016434-08	2025-02-27 18:13:38.016434-08
265	Kimi no Ai wa Mienikui	Invisible Love	君の愛は見えにくい	This collection of 7 short stories by the master of romance explores love that is not easily seen. (Source: M-U) \n\nA prequel from the manga "Kimi to Iru Asu",  it tells the story before Senou and Inori start dating	https://cdn.myanimelist.net/images/manga/3/5905l.jpg	7.09	971	\N	10328	Finished	f	2004-12-31 16:00:00-08	\N	8	1	2025-02-27 18:13:38.089036-08	2025-02-27 18:13:38.089036-08
266	Star	\N	君の名はスター	Hoshimi Sudou is known as a lady-killer at the office. But Sodou leads a double life - lady-killer office man by day, awkward yet charming singer in an amateur band at night. His co-worker Hirokawa stumbles upon Sodou late one night on the street and is taken by his true face. At work Hirokawa finds himself becoming more and more attracted to Soudou and sets out to seduce him. (Source: DMP)	https://cdn.myanimelist.net/images/manga/4/168484l.jpg	6.84	219	\N	25906	Finished	f	2004-08-20 17:00:00-07	\N	5	1	2025-02-27 18:13:38.150778-08	2025-02-27 18:13:38.150778-08
267	Hellsing	Hellsing	ヘルシング	For centuries, many secret organizations have taken part in exterminating various types of dangerous monsters. One of them is the England-based Hellsing, run by its cunning leader, Sir Integra Fairbrook Wingates Hellsing. Her greatest hunter, and trump card, is Alucard, an unbeatable vampire genetically modified by her father. Despite him being one of "them," he swore to be her protector and servant.\n\nA new crisis begins and with the help of Seras Victoria, his recently turned vampire partner, Alucard has to uncover the truth behind the mysterious vampire attacks. Not every human is bound to be his ally in this battle, and he will not hesitate to kill anyone who stands in his way.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/267321l.jpg	8.28	45194	330	148	Finished	f	1997-04-29 17:00:00-07	2008-09-29 17:00:00-07	92	10	2025-02-27 18:13:38.24219-08	2025-02-27 18:13:38.24219-08
268	Crazy Love Story	Crazy Love Story	크레이지 러브스토리	Jin Sung Moo does his best to hide his inner feelings; Shin Hae Jung dances to the beat of her own drum; and Jimmy is an out-of-this-world guy with a revved-up motorcycle and style that is second to none.\n\nSome say it's an extreme kind of love. Some say it's just crazy. Some say it's a crazy love story.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/152306l.jpg	6.63	179	14656	23607	Finished	f	2003-12-31 16:00:00-08	\N	44	5	2025-02-27 18:13:38.342524-08	2025-02-27 18:13:38.342524-08
270	Culdcept	\N	Culdcept	Najaran is a young woman who just happens to be an apprentice Cepter. Cepters have the power to summon creatures from magical cards. Once, these cards were collected in a book called the "Culdcept." During an ancient battle, the book was destroyed—its cards scattered far and wide. Najaran's master gives her a dangerous mission—she must obtain information about the Black Cepters and their nefarious plans. If the Black Cepters rebuild the Culdcept, the arcane book of ages past will grant them unspeakable God-like powers!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/180998l.jpg	6.90	347	10489	17597	Finished	f	1999-07-25 17:00:00-07	2007-07-25 17:00:00-07	64	6	2025-02-27 18:13:38.493045-08	2025-02-27 18:13:38.493045-08
271	Dennou Shoujo☆Mink	Mink	電脳少女☆Mink	Minku Shiraishi is a 14-year-old middle school student obsessed with Illiya, the lead singer of a band called Jagunna. Along with her friends, fellow Illiya fan Mahoko Toriumi and tech-savvy Kanoka Moriyama, she enters the local music store to pick up Illiya's latest CD—but the CD they picked up is not Illiya's music but "Wanna-Be", a mysterious CD-ROM with its copyright date listed as 2099. Curious, Kanoka installs it into her computer and learns that the software can create virtual characters based off of actual people.\n\nThe girls then create a character based off of Minku and her dreams of being a star, dubbing it "Cyber Idol Mink." But when the character comes out of the computer and merges with Minku, the girls realize that they've made a mistake—after Cyber Idol Mink is sighted live on TV, all of Japan starts looking for her! Worse still, the mascot of the Wanna-Be program, Om, comes out of the computer and warns the trio that they are in danger of being "deleted" for using software from the future.\n\nWith the unexpected craze and Om's warning, Minku resolves not to continue using Wanna-Be—but when she learns that a new friend involved with stardom is in serious trouble, Minku decides to debut as Cyber Idol Mink to help them out and pave her way into fame.\n\n[Written by MAL Rewrite]\n\n\nIncluded one-shot:\nVolume 6: Yamaneko-za wa Ittousei (The Wildcat Constellation)	https://cdn.myanimelist.net/images/manga/3/171558l.jpg	6.63	874	14658	9108	Finished	f	1999-08-02 17:00:00-07	2002-07-16 17:00:00-07	28	6	2025-02-27 18:13:38.582655-08	2025-02-27 18:13:38.582655-08
272	D'v	Deus Vitae	D'v	In the year 2068, the Brain Computer, created by humans to be the core of a machine-driven Earth, itself creates Leave, an android that far surpasses the abilities of humans. With mankind now an unnecessary aspect of the Earth ecosystem, Leave, along with her 'father' Fenrir (the human scientist who raised her), destroys humanity and in its stead creates the four 'Mothers' who in turn create an android race modeled on Leave known as the Selenoid.\n\nThey divide the world into four parts, each ruled by a Mother, and then further sub-divide the android population into hierarchical levels with the strong at the top and the weak at the bottom. A virtually perfect society...\n\nAnd it would have remained perfect if some of the surviving humans hadn't formed a revolutionary group together with some of the lower caste Selenoid with the explicit purpose of overthrowing Leave and delivering the Earth back into the hands of the humans.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/5/837l.jpg	5.64	333	20201	19303	Finished	f	1999-06-25 17:00:00-07	2002-02-25 16:00:00-08	20	3	2025-02-27 18:13:38.65057-08	2025-02-27 18:13:38.65057-08
273	Deja-vu	Deja-vu: Spring, Summer, Fall, Winter	데자부	A collection of four oneshots (Spring, Summer, Fall and Winter). Every story is about two lovers who gets confronted with a cruel stroke of fate.\n\nBesides the four main stories, this manwha has two more oneshots: Utility, a story about sexual abuse and suicide viewed by a child; and The Sea, about a couple that discover more about themselves during a trip to the sea.	https://cdn.myanimelist.net/images/manga/4/113211l.jpg	7.04	251	8323	19879	Finished	f	2003-12-31 16:00:00-08	\N	6	1	2025-02-27 18:13:38.725485-08	2025-02-27 18:13:38.725485-08
274	Ai: Hikari to Mizu no Daphne	Daphne in the Brilliant Blue	アイ〜光と水のダフネ〜	Dahpne in the Brilliant Blue take place in a near future in which the remaining population lives in underwater cities, with waterways as streets. Years ago, while conducting underwater experiments, all contact with the surface was cut off. With the remaining human population now living underwater, The Deep Sea 9 Cities Association represent the last hope of mankind. Ai Mayuzumi is the daughter of the head of the research lab, and is an expert water jet bike driver. When the terrorist group Error, attacks the city, Ai becomes involved with the counter-terrorist group Stelnas, comprised of an all-female team, and led by a girl named Kei, and asks to join them. The group initially resists her efforts to join, but a surprising "gift" that Ai possesses, along with the way she handles herself during a kidnapping attempt, eventually sways the opinion of the members of Stelnas.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/89127l.jpg	6.25	232	18703	20907	Finished	f	2004-06-30 17:00:00-07	\N	6	1	2025-02-27 18:13:38.834733-08	2025-02-27 18:13:38.834733-08
275	Daten no Tsuki	Fallen Moon	堕天の月	A young man, Rukis, has left Eden and wanders the desert until he collapses and awakens in a strange mansion. There he meets the master of the house who has rescued him. Rukis reveals the true reason for why he was thrown out of Eden and learns that the master of the house may share a similar past. As the two open up to each other, Rukis and the master begin to develop a steamy relationship. (Source: BLU Manga)	https://cdn.myanimelist.net/images/manga/3/5197l.jpg	6.34	701	18053	11983	Finished	f	2004-04-04 17:00:00-07	\N	6	1	2025-02-27 18:13:38.953281-08	2025-02-27 18:13:38.953281-08
276	The End	Dead End	THE END ジ・エンド	Shirou's ordinary life as a poor construction worker gets turned upside down when he comes across a naked girl, Lucy, who's fallen out of the sky! Her strange and unique personality entices him and he introduces her to his apartment buddies.\nBut after leaving for just a few minutes, he returns to the apartment to find Lucy gone, all his friends slaughtered and an ogre-like stranger standing amidst the carnage.\n\nThe big man suddenly pulls Shirou out of the apartment building just before it explodes! Shirou gets pushed down into the sewage system of the city and is saved by a mysterious man...\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/139055l.jpg	6.50	641	16533	8284	Finished	f	2001-02-23 16:00:00-08	2002-09-24 17:00:00-07	20	4	2025-02-27 18:13:38.995482-08	2025-02-27 18:13:38.995482-08
277	Mawang Ilgi	Demon Diary	마왕일기	Gods and demons wage a neverending battle with the mortal realm as their battlefield. As with most longstanding feuds, the reasons are no longer important--hatred is a way of life. But it is foretold that one would arise who could restore harmony between gods and demons. Enter Raenef...heir to a set of demon royalty, he is hardly courtly material. The demon king assigns Eclipse to be his tutor, to mold Raenef into proper demonic shape. The two begin a journey of discovery and are soon joined by a human knight and a god-blessed priest.\n\n(Source: Tokyopop)\n\nIncluded one-shots:\nVolume 1: Crystal Heart, Tera	https://cdn.myanimelist.net/images/manga/3/264807l.jpg	7.42	4164	3643	2933	Finished	f	1998-12-31 16:00:00-08	2001-12-31 16:00:00-08	26	7	2025-02-27 18:13:39.083397-08	2025-02-27 18:13:39.083397-08
278	Majeh	King of Hell	魔帝 -마제-	Majeh was a great swordsman in life but in death he is merely an envoy to the next world for the King of Hell. It is later discovered that he is a legendary swordsman who was placed in a magical realm called the Moorim where the fiercest warriors stayed.\n\nWhen a disaster occurred in hell where the most wicked demons escaped into the world of Mortals, the King of Hell sends Majeh out to capture these escape demons...\n\n(Source: Wikipedia)	https://cdn.myanimelist.net/images/manga/1/197257l.jpg	7.62	3237	2205	2225	Finished	f	2000-12-31 16:00:00-08	2014-12-31 16:00:00-08	414	55	2025-02-27 18:13:39.223049-08	2025-02-27 18:13:39.223049-08
280	Shiritsu Shouei Gakuen Danshi Koutoubu: Kurashina-sensei no Junan	Kurashina Sensei's Passion	私立翔瑛学園男子高等部 倉科先生の受難	Shoei Academy is a prestigious private school system for young boys from well-to-do families. Newly appointed teacher Mr. Reiji Kurashina soon finds himself to be the center of attention at Shoei Academy – the center of attention for young men who are just about to ripe, that is! What does cool and collected Kurashina-sensei do when he becomes the object of love!\n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/1/30533l.jpg	\N	\N	20433	32722	Finished	f	2003-12-31 16:00:00-08	2010-12-31 16:00:00-08	\N	5	2025-02-27 18:13:39.352873-08	2025-02-27 18:13:39.352873-08
281	La Esperança	La Esperança	エスペランサ	In a European school dorm, Georges Saphir is admired and loved by everyone. However, afraid of others doing him harm, he has never allowed anyone to get close. Why is it then that misfit Robert can effortlessly step over this line Georges has drawn, and see right through him? And will getting too close to Robert result in a tragedy that justifies his worst fears? \n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/2/251758l.jpg	7.18	826	6321	10538	Finished	f	2000-10-31 16:00:00-08	2005-12-31 16:00:00-08	26	7	2025-02-27 18:13:39.387079-08	2025-02-27 18:13:39.387079-08
282	La Vie en Rose	La Vie en Rose	ラ・ヴィ・アン・ローズ	1. Renai Shousetsuka\n2. Koukishin wa Neko wo Korosu\n3. Shuumatsu no Chikai Shuumatsu\n4. La Vie en Rose\n5. Baby Blue\n6. Sayonara Baby\n7. Baby Blue After	https://cdn.myanimelist.net/images/manga/1/4926l.jpg	6.62	430	\N	17431	Finished	f	2004-01-16 16:00:00-08	2005-01-24 16:00:00-08	7	1	2025-02-27 18:13:39.43839-08	2025-02-27 18:13:39.43839-08
283	The Big O	\N	Theビッグオー	The official comic adaptation of Bandai's Cartoon Network hit, a stylish "manga meets film noir" story which goes BEYOND the plot of the TV series! \n\nParadigm City is the city of amnesia—40 years ago, SOMETHING happened that wiped out the memories of the residents, forcing them to recreate their culture from scattered fragments. \n\nIn this world only 40 years old, Roger Smith is a negotiator—a go-between for police, citizens and criminals in high-risk diplomatic situations. But something else survives from the forgotten past. They are the MegaDeuses—giant robots created by the city's former inhabitants, or perhaps by the forgetful citizens themselves. When crime and madness strike, Roger Smith brings the guilty to justice with the giant robot called THE BIG O. \n\n(Source: Viz)	https://cdn.myanimelist.net/images/manga/3/220469l.jpg	7.03	482	8445	10628	Finished	f	1999-06-25 17:00:00-07	2001-09-25 17:00:00-07	21	6	2025-02-27 18:13:39.493819-08	2025-02-27 18:13:39.493819-08
284	Little Butterfly	Little Butterfly	リトル・バタフライ	Kojima seeks to befriend the class outcast, and soon learns of Nakahara's troubled family life - of his uncaring, abusive father and mentally unstable mother. As Kojima yearns to somehow comfort Nakahara, he gradually becomes aware that his feelings for the other boy arise from more than mere sympathy. When Nakahara declares his own romantic feelings for Kojima, their relationship becomes one of sexual exploration as they face their first steps into adulthood together. \n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/1/284505l.jpg	8.04	3861	\N	2798	Finished	f	2001-05-31 17:00:00-07	2003-06-30 17:00:00-07	15	3	2025-02-27 18:13:39.530476-08	2025-02-27 18:13:39.530476-08
285	Love Recipe	Love Recipe	愛在旋轉	Tomonori Ozawa has just landed a job at a large publishing firm. The only catch is, he is the new editor of a Boy’s Love magazine?! On top of that, he is stuck with dealing with the artist Sakurako Kakyoin, a male yaoi artist who is notorious for missing his deadlines. To become a full fledged editor, Tomonori-kun has to start from the bottom – checking drafts, editing scripts and lettering. Now if only Kakyoin-sensei would stop sexually harassing him, he could actually get some work done! \n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/2/5529l.jpg	7.23	518	\N	13334	Finished	f	2004-12-31 16:00:00-08	\N	10	2	2025-02-27 18:13:39.604474-08	2025-02-27 18:13:39.604474-08
286	Tarinai Jikan	Not Enough Time	足りない時間	Shoko Hidaka's breakthrough comic is a collection of eye-opening love stories. Yousuke suddenly shows up on the door step of his old high school buddy Tanigawa after years of no contact. While the two had a budding relationship back in school, things fell apart and they decided to part ways and search for their true love. However, it might be that their relationship in the golden days of high school was what they have been looking for all along.\n\n(Source: Juné)	https://cdn.myanimelist.net/images/manga/3/282190l.jpg	6.98	855	\N	11285	Finished	f	2004-12-31 16:00:00-08	\N	6	1	2025-02-27 18:13:39.677881-08	2025-02-27 18:13:39.677881-08
287	Devil May Cry 3	Devil May Cry 3	デビル メイ クライ 3	It's been 2000 years since the rebellion lead by the Dark Knight Sparda, a demon who turned to the side of good. The gateway to the Underworld has been sealed and humans are now safe from an invasion of the demon world.\n\nDante, Sparda's son, makes a living by eradicating demons. His first job is to find and bring back a girl named Alice. But what awaits him when he storms the inn where Alice is being held? And who is this man walking around town who has the same face as Dante?\n\nTwin brothers born of the Dark Knight Sparda and the human woman he loved are now grown men, but each walks a very different path in life. What is Dante's twin, Vergil's, goal? The violent story of two fated brothers continues...\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/5/112447l.jpg	7.08	2834	7785	3802	Finished	f	2005-02-09 16:00:00-08	2005-07-22 17:00:00-07	9	2	2025-02-27 18:13:39.740201-08	2025-02-27 18:13:39.740201-08
288	Othello	Othello	othello	1. Othello\n2. Snow White in Summer\n3. Yowa no Kawori (Night's Fragrance)\n4. Haruka no Fuchi (Night's Abyss)	https://cdn.myanimelist.net/images/manga/3/152307l.jpg	7.00	1186	\N	8155	Finished	f	2001-12-31 16:00:00-08	\N	4	1	2025-02-27 18:13:39.802459-08	2025-02-27 18:13:39.802459-08
289	Agmaui Sinbu	\N	악마의 신부	Jeong-Hwan receive a letter from his sister Ji-Yeong, it says: "Please rescue me, here is the devil!"\n\nHis sister goes to an all-girl school, in order to rescue her, he must disguise himself as a female student. In this school there are all students canditates to become "the bride of devil."\n\n(Source: MU)\n\nIncluded one-shot:\nThe Evergreen Tree	https://cdn.myanimelist.net/images/manga/3/144069l.jpg	5.54	352	20276	17797	Finished	f	1999-12-31 16:00:00-08	2000-12-31 16:00:00-08	18	1	2025-02-27 18:13:39.855416-08	2025-02-27 18:13:39.855416-08
290	Netsujou	Passion	熱情	Hikaru is a second year high school student who is in love to  with his teacher, Shima to the point of obsession... so much that he forces himself on him one day after school. While he doesn't feel the same way about Hikaru, Shima nonetheless proposes that Hikaru atone for his sins by pretending that the two of them are lovers until he graduates. And thus, the two are swept up in a whirlwind of passion and drama until the end of Hikaru's high school career draws close.\n\nIncludes three unnumbered side stories.	https://cdn.myanimelist.net/images/manga/3/275460l.jpg	7.15	483	\N	16110	Finished	f	2002-08-31 17:00:00-07	2006-11-24 16:00:00-08	14	4	2025-02-27 18:13:39.934248-08	2025-02-27 18:13:39.934248-08
291	Picnic	PICNIC	ピクニック	Relationships are tough, but relationships between friends can be even tougher. That’s what Koreeda discovers when Noda – one of his college buddies – offers to become “friends with benefits.” Until recently, Koreeda had a serious girlfriend. But now he’s on the rebound and looking for something different, something real. Despite Noda’s bold proposition, he seems to pull away every time Koreeda tries to get close. Maybe all they need is some time alone – a vacation… a picnic, even.\n\n(Source: Juné Manga)	https://cdn.myanimelist.net/images/manga/1/33047l.jpg	7.07	411	\N	19143	Finished	f	2003-12-31 16:00:00-08	\N	8	1	2025-02-27 18:13:39.984587-08	2025-02-27 18:13:39.984587-08
292	Prince Charming	\N	プリンスチャーミング	Professor Asahina isn't a very good teacher. Rumor has it that he spends his nights at love hotels with a different partner every night and he has been known to come to class drunk on occasion. When one of his students, Yuasa, finds a film of him having sex with an unknown lady in a love hotel, things get a little sticky. Yuasa promises to help Professor Asahina hunt down the tape and keep his secret safe, but for a price. Yuasa is known to associate with men and has had his eyes on Professor Asahina for a while.\n\n(Source: Juné)	https://cdn.myanimelist.net/images/manga/1/157035l.jpg	6.87	326	\N	20569	Finished	f	2003-12-31 16:00:00-08	2005-12-31 16:00:00-08	15	3	2025-02-27 18:13:40.089435-08	2025-02-27 18:13:40.089435-08
293	Rakka Sokudo	Freefall Romance	落下速度	Reni and Youichi were nothing more than drinking buddies. But when a night of imbibing goes a little too far, they find themselves drinking buddies with “benefits!” What begins as a drunken lark soon becomes a passionate affair. But Renji and Youichi aren’t really gay… or are they? \n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/2/311849l.jpg	7.18	851	\N	11781	Finished	f	2004-04-21 17:00:00-07	\N	6	1	2025-02-27 18:13:40.155371-08	2025-02-27 18:13:40.155371-08
294	Seven	\N	セブン　SEVEN	Nana has no memory of his childhood earlier than age 12 when a store owner took him in and named him Nana, meaning no-name in Japanese. Mitsuha is on a quest to find a missing childhood friend. The two meet when Mitsuha ends up crashing at Nana’s place at the insistence of a mutual friend. At first Nana loathes the very existence of Mitsuha. However, he gradually warms up to his sincerity and kindness and finds happiness in awakening beside him. \n\n(Source: DMP)	https://cdn.myanimelist.net/images/manga/1/73515l.jpg	7.02	548	8629	15401	Finished	f	2004-06-30 17:00:00-07	\N	4	1	2025-02-27 18:13:40.216258-08	2025-02-27 18:13:40.216258-08
295	Angel/Dust Neo	\N	ANGEL/DUST neo	Little Akido has no idea that an innocent prayer at a shrine would turn his simple existence upside down. Suddenly a bevy of cute gals comes into his life—some claiming to be Emulates that want to "make a contract" with him!\n\n(Source: ADV)	https://cdn.myanimelist.net/images/manga/3/179774l.jpg	6.15	928	19243	9802	Finished	f	2002-07-09 17:00:00-07	2003-05-09 17:00:00-07	9	1	2025-02-27 18:13:40.271744-08	2025-02-27 18:13:40.271744-08
296	Anne Freaks	Anne Freaks	アンネ フリークス	While trying to bury the body of his mother deep in the woods, high school student Yuri is approached by a strange girl who offers to help him. That is... if he promises to be her "parent killing assistant." Meet Anne Freaks, a bright, attractive teenage girl normal in every way - except that she's on a mission to kill her father, the leader of the dangerous extremist cult: the Kakusei Group. (Source: ADV)	https://cdn.myanimelist.net/images/manga/5/26068l.jpg	6.63	3224	14659	3029	Finished	f	2000-08-31 17:00:00-07	2002-09-30 17:00:00-07	24	4	2025-02-27 18:13:40.33361-08	2025-02-27 18:13:40.33361-08
297	Diabolo	Diabolo	Diabolo-悪魔-	Protagonists Ren and Rai fell prey to the Diabolo in an attempt to save the soul of Ren's cousin, 7-year-old Mio...although they failed in their attempt, they were 'rewarded' with powers they would each gladly trade for the life of the young girl.\n\nJust who—or what—is the Diabolo? What enticements does he offer the kids at school? And, if they accept his 'bargains,' what foul fate awaits them on their 18th birthdays?\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/155713l.jpg	6.68	694	13958	11624	Finished	f	2000-12-31 16:00:00-08	2002-12-31 16:00:00-08	16	3	2025-02-27 18:13:40.391331-08	2025-02-27 18:13:40.391331-08
298	DOLL: IC in a Doll	DOLL	DOLL	These haunting tales of human-like androids, called Dolls, range from romantic to tragic, from comic to ironic, and everything in between. In these stories, dolls have an uncanny way of working themselves into the lives of their masters: A woman develops an unusual closeness to doll that will affect her human family from beyond the grave...A man wants to make his doll into the perfect human lover, but discovers that humans are not perfect...A father buys his son a doll to help him get over the death of his mother. Doll provides a firsthand glimpse into the psychology of the human-doll relationship and examines the question of what it means to be truly human.	https://cdn.myanimelist.net/images/manga/2/11704l.jpg	7.66	594	1932	8399	Finished	f	1999-12-31 16:00:00-08	2001-12-31 16:00:00-08	33	6	2025-02-27 18:13:40.446801-08	2025-02-27 18:13:40.446801-08
299	Cat Shit One	Apocalypse Meow	Cat Shit One	Inside the jungles of Vietnam, a courageous Special Ops. Unit is fighting the most infamous war of decades past—the Vietnam War. This bold account follows the brave exploits of Sergeant "Perky" Perkins and his unit...of rabbits! Join Rats, Perky and Botaski as they fight against the cats of the Viet Cong. From the Tet Offensive to the My Canh bombing, watch these commando-style bunnies through an anthropomorphic lens as events unfold and violence erupts.\n\nOn-human cast of characters notwithstanding, this compelling and painstakingly-researched work places an emphasis on factualism in order to accurately portray the events of the Vietnam War. With a fresh perspective on one of history's greatest calamities, Apocalypse Meow is a daring new take on a conflict that won't soon be forgotten...especially after these young rabbits are done!\n\n(Source: Manga Sketchbook)	https://cdn.myanimelist.net/images/manga/1/142165l.jpg	7.03	905	8446	7225	Finished	f	1996-11-30 16:00:00-08	2001-11-30 16:00:00-08	18	3	2025-02-27 18:13:40.504124-08	2025-02-27 18:13:40.504124-08
300	Hands Off!: Don't Call Us Angels	Hands Off!: Don't Call Us Angels	俺たちを天使と呼ぶな	Kiba is a sensitive who can see the future whenever he touches someone. But there's one person who's future always disturbs him: Udou. Unable to leave things alone, Kiba finds himself embroiled in Udou's issues, which deal mostly with girls, and, in this particular case, his childhood friend Haruhi. How Udou deals with his problems and how Kiba decides to judge him become the means to whether or not they can save anyone, much less themselves. (Source: M-U)	https://cdn.myanimelist.net/images/manga/2/278571l.jpg	6.69	134	13818	25567	Finished	f	2000-12-31 16:00:00-08	\N	8	2	2025-02-27 18:13:40.546608-08	2025-02-27 18:13:40.546608-08
301	Dragon Hunter	Dragon Hunter	용잡이	Welcome to Kaya, a world where dragons shape people's lives. Some people, hunters, make a living by slaying them. Others, shamans, control them with incantations. Seur-Chong is a hunter with the Dragon's Curse, a condition which gives him incredible strength and stamina, but is slowly killing him. A mercenary, he cares only for money. But as he becomes enmeshed in the intrigue surrounding those who hire the hunters, he finds himself fighting for a cause more noble than anything he'd ever imagined. Of course if he's lucky, he just might come away with a profit and a cure to his curse, as well... \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/4/9803l.jpg	6.65	194	14470	21879	Finished	f	1999-12-31 16:00:00-08	\N	\N	39	2025-02-27 18:13:40.583388-08	2025-02-27 18:13:40.583388-08
302	Tuxedo Gin	Tuxedo Gin	タキシード銀	High school student Ginji Kusanagi is about to make his dreams come true. He's made his professional boxing debut and is ready to go on the first date with the girl of his dreams, Minako. However, the unthinkable has happened. Ginji is in an accident, and his spirit is seperated from his body, effectively killing him before his time. A (sort of) angel tells him that he can be reincarnated as an animal and return to his body after he's lived out its lifespan. He chooses to be reincarnated as a penguin, Minako's favorite animal. Now Ginji lives with Minako as Gin the penguin and just tries to make it along as a penguin while waiting to be returned to his body.\n\n(Source: ANN)	https://cdn.myanimelist.net/images/manga/3/130629l.jpg	7.41	682	3752	10003	Finished	f	1997-03-18 16:00:00-08	2000-01-18 16:00:00-08	136	15	2025-02-27 18:13:40.659742-08	2025-02-27 18:13:40.659742-08
303	Dragon Kishidan	Dragon Knights	ドラゴン騎士団	Meet Rune, Rath and Thats—three warriors with dragon blood running through their veins. They've sworn allegiance to the Dragon Lord Lykouleon, and whenever evil shows up in the kingdom, it's up to the three Dragon Knights to save the day. The mighty trio are on their way home for rest and feasting when an incompetent witch and a demon rudely interrupt them. It's no fun fighting bad guys on an empty stomach! Oh well, it's all in a day's work when you're the most famous warriors in the land...\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/180630l.jpg	7.18	789	6322	9548	Finished	f	1989-12-31 16:00:00-08	2007-04-27 17:00:00-07	\N	26	2025-02-27 18:13:40.729228-08	2025-02-27 18:13:40.729228-08
304	Urusei Yatsura	Lum*Urusei Yatsura	うる星やつら	What would you do if a tiger skin bikini-clad alien followed you to school every day? Poor Ataru's life has never returned to normal since volatile extraterrestrial princess Lum fell for him. Now an excruciatingly wealthy and genteel rival, Mendo, adds to Ataru's torment. Not to mention an unending stream of extraordinary classroom visitors and educational materials including incompetent cherry blossom spirits, a legendary nightmare-eating tapir, and a fourth-dimensional camera that breaches alternate realities.  \n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/2/263150l.jpg	7.73	4061	1612	1507	Finished	f	1978-08-29 17:00:00-07	1987-01-20 16:00:00-08	366	34	2025-02-27 18:13:40.8469-08	2025-02-27 18:13:40.8469-08
305	Dragon Voice	Dragon Voice	ドラゴン ボイス	14-year-old Rin Amami is a gifted dancer who has been forced to give up his dream of becoming a singer like his mom because of his deep, frog-like voice. A chance encounter with the idol singing group Beatmen, however, gives him the opportunity to bring his old dream to life.\n\nDespite its oddness, his voice possesses a certain charisma: a captivating power, recognized by some as the legendary "Dragon Voice." Rin's destiny becomes intertwined with the Beatmen, Shino, Goh, Toshi, and Yuhgo, as the smalltime idol agency RedShoes attempts to take them to the top!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/186238l.jpg	7.33	443	4467	14217	Finished	f	2001-01-16 16:00:00-08	2003-01-21 16:00:00-08	96	11	2025-02-27 18:13:40.935355-08	2025-02-27 18:13:40.935355-08
306	Mugen Densetsu Takamagahara	Dream Saga	夢幻伝説 タカマガハラ	Yuuki Wakasa may be short-tempered when it comes to other people, especially her troublemaking younger brothers, but she is otherwise a normal fifth-grade student at Kamishiro Elementary School. One day, a small red bean known as a magatama falls from the dark sky and into her hands. Though tempted to throw it away out of fear, she decides to keep the stone after recalling that it is a bad omen to do such an act, and so she confronts a vision of a strange woman in a magical mirror known as the Shinjyukyou later that night.\n\nThe woman warns Yuuki that her world is in danger and explains that recent occurrences of strange, dark weather came forth due to the disappearance of Amaterasu, the sun goddess. Chosen as the "Horizon Girl," Yuuki must now travel to the dream world with her new magatama and find the four other magatama bearers—the Amatsukami. Will Yuuki and the Amatsukami be able to save Amaterasu before the sun in both the spiritual world and their own disappears forever?\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/180638l.jpg	7.06	1136	8092	8237	Finished	f	1996-12-27 16:00:00-08	1999-04-29 17:00:00-07	27	5	2025-02-27 18:13:40.952573-08	2025-02-27 18:13:40.952573-08
307	Gakuen Tokukei Duklyon	Duklyon: CLAMP School Defenders	学園特警デュカリオン	Kentaro and Takeshi are two freshmen who are periodically called upon to transform themselves into monster-battling superheroes, complete with capes and armor... but there's much more than meets the eye... \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/260106l.jpg	6.45	1337	17103	7583	Finished	f	1991-12-31 16:00:00-08	1992-12-31 16:00:00-08	13	2	2025-02-27 18:13:41.016776-08	2025-02-27 18:13:41.016776-08
308	Eden no Hana	Flower of Eden	エデンの花	A schoolgirl who was adopted by a family experiences hardships at school and home. Her foster family treats her as Reika, their daughter who had died a couple years ago. Suddenly, her real blood-related brother appears before her, who has been searching for her for years. Now her life is turned upside down. Will she learn to trust other people again? (Source: MU)	https://cdn.myanimelist.net/images/manga/3/40434l.jpg	7.37	1476	4088	5731	Finished	f	1999-12-31 16:00:00-08	2003-12-31 16:00:00-08	42	12	2025-02-27 18:13:41.092739-08	2025-02-27 18:13:41.092739-08
309	Ghost!	Eerie Queerie!	ゴースト！	Mitsuo Shiozu is a lonely high school student who happens to be psychic. Spirits 'use' his body and mind to communicate with the dead and to help the living. These ghostly apparitions use Mitsuo in order to put right things that were left undone in life, or to tie up ends that were left loose before they left the land of the living.\n\nIn the process, Mitsuo often finds that these 'visitations' change his own life in ways he could not predict. (Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/178258l.jpg	7.01	1574	8844	7116	Finished	f	1998-12-31 16:00:00-08	2003-12-31 16:00:00-08	20	4	2025-02-27 18:13:41.146602-08	2025-02-27 18:13:41.146602-08
311	Eternity	Eternity	이터너티	In the year 184, three leaders (Yoobe, Kwanoo, and Jangbe) rose up against the oppressive Chinese government and were all killed. Now, a 17-year-old shaman by the name of Aram Ko is in search of the reincarnations of the three men. Back in the year 184, Kwanoo had saved a man's life and, in return, that man ensured that every one of Kwanoo's female descendents became a Shaman so that they could serve Kwanoo when he is reincarnated.\n\n(Souce: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/152314l.jpg	6.32	130	18222	27105	Finished	f	1998-12-31 16:00:00-08	\N	34	5	2025-02-27 18:13:41.328124-08	2025-02-27 18:13:41.328124-08
312	Evil's Return	Evil's Return	천지인	Yumi, a seemingly average high school girl, is destined to become the wife of and child bearer for Evil. As soon as her first menstrual episodes begin, all sorts of villainous cretins show up in the hopes of providing the seed for wickedness itself. In response, the forces of Good, a Buddhist priest, the Catholic church, and their attendant holy warriors rush to provide protection for the now-pregnable Yumi. But she reaches out to another warrior, a young punk freshman heartthrob who literally beats off the female population of the school with a stick. But when he sees Yumi in a vision, this cool-as-ice thug melts... and the adventure begins... \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/166999l.jpg	5.83	588	20009	13853	Finished	f	2000-12-31 16:00:00-08	2001-12-31 16:00:00-08	14	4	2025-02-27 18:13:41.400337-08	2025-02-27 18:13:41.400337-08
314	Fake	Fake	FAKE	Half-Japanese Randy "Ryo" Maclean is assigned as a new detective to the 27th precinct at the New York City Police Department. His boss pairs him with Dee Laytner, a good-looking veteran prone to impulsiveness. Much to Ryo's confusion, Dee takes an immediate interest in his new partner.\n\nIn their first case together, Ryo and Dee must take care of Bikky—a young boy whose father was killed due to his involvement in a shady drug trafficking business. Bikky denies having any knowledge about his father's actions prior to his murder. Even so, it is up to Ryo and Dee to protect the boy from those wanting to get rid of him and preserve any evidence he might be holding back.\n\nAs time goes on and the detective duo works increasingly more together, the distance between them gradually shortens. But could Ryo ever reciprocate Dee's feelings?\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/161939l.jpg	7.88	3629	\N	3122	Finished	f	1992-12-31 16:00:00-08	2000-05-05 17:00:00-07	20	7	2025-02-27 18:13:41.510584-08	2025-02-27 18:13:41.510584-08
315	Fever	Fever	FEVƎR	This series is not about romance exactly but does contain the element for it. This series mainly focuses on overcoming the main characters' hardships. Each characters have a different hardship. There is really nothing more to mention about the plot.\n\nIt starts with a school girl who has trouble with her surroundings. It all started when her classmate was bullied and eventually committed suicide. Being a part of the group that bullied the girl, she feels extremely guilty. Her life becomes meaningless and she wants to end her life.\n\n(Source: JanimeS)	https://cdn.myanimelist.net/images/manga/1/152318l.jpg	6.77	160	12542	23673	Finished	f	2002-12-31 16:00:00-08	\N	19	4	2025-02-27 18:13:41.58601-08	2025-02-27 18:13:41.58601-08
316	Tenshi no Kiss	Forbidden Dance	天使のキス	When a young girl loses her confidence to dance, she fears she'll never set foot on the stage again. But then she falls in love with an all-guy avant-garde dance troupe and their leader...and everything changes. Soon, her primary goal in life is to join the troupe and snag the guy. So what if she's missing a Y-chromosome? She's got spunk, skill, and passion--and, in the end, she hopes that love will conquer all. (Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/304018l.jpg	7.30	892	4825	9875	Finished	f	1996-12-31 16:00:00-08	1997-12-31 16:00:00-08	16	4	2025-02-27 18:13:41.625504-08	2025-02-27 18:13:41.625504-08
317	Metamo☆Kiss	Metamo Kiss	メタモ☆キス	Kohamaru comes from a peculiar family—each member can switch bodies with his or her soul mate! His parents can switch bodies, and his aunt, oddly enough, can switch with her cat! Now it's Kohamaru's turn...\nWhen Kohamaru literally runs into Nanao, the girl of his dreams, they switch bodies. True love, right? Well, unfortunately, she's in love with someone else. And if that weren't bad enough, the "someone else" turns out to be Kohamaru's twin brother Konatsu...who can reverse their transformation with his own kiss!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/275338l.jpg	7.10	782	7420	10603	Finished	f	2003-12-31 16:00:00-08	2004-12-31 16:00:00-08	18	3	2025-02-27 18:13:41.676104-08	2025-02-27 18:13:41.676104-08
318	Futari Ecchi	Manga Sutra	ふたりエッチ	An excellent and very educational series. About a newlywed couple who are virgins and their comedic ups and downs in learning how to have sex. Not really a hentai, though there are scenes which can be called hentai. Tastefully rendered taboo themes. A funny "how to" guide for sex illiterate and experts. \n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/3/50533l.jpg	7.25	4894	5400	1325	Publishing	t	1996-12-31 16:00:00-08	\N	\N	\N	2025-02-27 18:13:41.730352-08	2025-02-27 18:13:41.730352-08
319	Gaccha Gacha	Gatcha Gacha	ガッチャガチャ	Yuri and Motoko are friends. Yuri has a crush on Yabe, but Yabe's decided the only girl he will ever seriously date is Motoko. But she doesn't want to have anything to do with him. Or is she secretly harboring a crush on him, too?\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/180609l.jpg	7.15	473	6777	14033	Finished	f	2001-11-27 16:00:00-08	2007-12-27 16:00:00-08	41	8	2025-02-27 18:13:41.82215-08	2025-02-27 18:13:41.82215-08
320	Gakuen Alice	Gakuen Alice	学園アリス	Mikan Sakura and Hotaru Imai are inseparable best friends, even if it seems like the latter does not reciprocate the same sentiment. Mikan naively believes that her aloof best friend would always be by her side until Hotaru decides to depart for Tokyo to attend Alice Academy. The school is home to gifted children who possess unique abilities known as Alices. Heartbroken and feeling abandoned, Mikan runs away from home in pursuit of her friend, hoping that she too can enroll in the prestigious institution.\n\nAs Mikan gets accepted as a student at Alice Academy and reunites with her friend, she quickly learns that the academy is not all fun and games. The school itself is divided into a hierarchy system based on the strength of their Alice, behavior, and academic performance, as well as classifying each student under a specific Alice subgroup for a more personalized education. When she finds herself in the lowest rank, Mikan faces bullying from her classmates who all believe that she does not belong. Natsume Hyuuga, one of the academy's highest-ranking students, is especially vitriolic towards Mikan for seemingly no reason.\n\nThe students begin to discover that the special academy has hidden secrets—many of which are a lot darker than one might think. As they unravel these mysteries, Mikan and her friends find themselves entangled in something far bigger than they could imagine.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/269701l.jpg	8.32	21226	287	415	Finished	f	2002-09-04 17:00:00-07	2013-06-19 17:00:00-07	183	31	2025-02-27 18:13:41.854781-08	2025-02-27 18:13:41.854781-08
321	Gate Keepers	Gate Keepers	ゲートキーパーズ	After attacked by an alien, saved by a girl, and discovers he has extraordinary powers, Shun Ukiya has had a hell of first day of school. Realizing what this new power is all about soon becomes one of the less important things that threaten Earth. \n\n(Source: ANN)	https://cdn.myanimelist.net/images/manga/2/35659l.jpg	6.21	210	18957	20646	Finished	f	1999-11-30 16:00:00-08	2001-10-30 16:00:00-08	14	2	2025-02-27 18:13:41.93625-08	2025-02-27 18:13:41.93625-08
322	Genjuu no Seiza	Genju no Seiza	幻獣の星座	Kamishina Fuuto would like to think he's a normal boy, but he is the reincarnation of the High Priest of Darashaal, a tiny Asian country that has just celebrated the inauguration of...its new high priest. Clearly, only one of them is the true priest, and unfortunately for Fuuto, it is he. As the celestial guardians come to dispose of him they discover that he is not, as their leader Naga says, a fake. Fuuto just wants to be normal and live a normal life, but he is constantly drawn into trouble as he has an extremely keen spiritual sense and the ability to soothe ghosts. \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/126579l.jpg	7.57	543	2465	9425	Finished	f	2000-09-30 17:00:00-07	2007-08-27 17:00:00-07	70	14	2025-02-27 18:13:42.005966-08	2025-02-27 18:13:42.005966-08
323	Galaxy Girl, Panda Boy	Galaxy Girl, Panda Boy	銀河ガールパンダボーイ	A collection of three stand-alone stories. "Galaxy Girl, Panda Boy" is the story of Mani, an adolescent girl growing up in an isolated new age community. Mani is convinced that there is something very odd about her family and the other members of the community. She might be right. "The Laidback Person I Will Never Forget" is a short piece in which a young woman named Yukari begins to doubt her relationship with Takafumi, her slacker / surfer boyfriend. She loves him but she's beginning to think that he might be a bit too laid back for his own good and that their relationship might not have much of a future. "Club Hurricane" (split into four sections and comprising by far the largest portion of the volume) is the tale of Andrew and Rose - twins who find themselves sent off to an odd, remote boarding school in the country as a result of their parents' divorce. Once there, the siblings have to deal with isolation, rejection, their eccentric new schoolmates and their reliance on one another. (Source: ANN)	https://cdn.myanimelist.net/images/manga/5/1562l.jpg	\N	\N	20434	36261	Finished	f	2001-12-31 16:00:00-08	\N	6	1	2025-02-27 18:13:42.091115-08	2025-02-27 18:13:42.091115-08
324	Girl Queen	Little Queen	소녀왕	Class rivals June and Lucia vie for the honor of being named the Queen of Light, entrusted with protecting the people from the King of Darkness. June is an attractive girl whose feisty, hot temper and general laziness may prevent her from receiving the crown...Lucia has a more regal quality and a strong desire to match, but she is always overshadowed by June. Will petty jealousies, love triangles, and one cute boy interfere with the Queen's royal duty?!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/189817l.jpg	7.21	795	5938	9268	Finished	f	2001-12-31 16:00:00-08	2005-12-31 16:00:00-08	35	8	2025-02-27 18:13:42.122697-08	2025-02-27 18:13:42.122697-08
325	Girls Bravo	Girls Bravo	GIRLS・ブラボー	Yukinari Sasaki is an average high school boy who has female-phobia...and an allergic reaction when girls touch him. One day, he falls through his tub to a bath to an alien planet called "Siren" where the population is 90% female. There he meets the sweet Miharu, whom he can touch without breaking into a rash! When the pair returns to earth, they're joined by a wacky collection of friends and enemies who make every day one of laughter, life lessons, and fan service!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/54717l.jpg	6.60	2238	15164	3765	Finished	f	2000-10-25 17:00:00-07	2005-03-25 16:00:00-08	70	10	2025-02-27 18:13:42.182568-08	2025-02-27 18:13:42.182568-08
326	Ueki no Housoku	The Law of Ueki	うえきの法則	Ueki no Housoku tells the story of the Battle of the Supernatural Powers, a tournament to decide who will be the next King of the Celestial World. Each candidate (100 in total) is required to choose a junior high school student to act as their fighter. Each student is given a unique power—the power to change one thing into something else. The winning King of the Celestial World Candidate will become King of the Celestial World and the winning student will receive the Blank Talent, a talent that can be anything they choose.	https://cdn.myanimelist.net/images/manga/3/160943l.jpg	7.59	4158	2338	2031	Finished	f	2001-07-22 17:00:00-07	2004-10-19 17:00:00-07	154	16	2025-02-27 18:13:42.266868-08	2025-02-27 18:13:42.266868-08
327	Ueki no Housoku Plus	The Law of Ueki Plus	うえきの法則プラス	Two years after the battle for the Heavenly World, Kousuke Ueki and his friends are finally able to have their long-awaited reunion. However, things take a strange turn when everyone starts forgetting about the people who matter the most to them. Even Ueki's friends are not excluded, as they completely forget about their comrades and the supposed reunion of Team Ueki. \n\nAfter he encounters U-lu, a mysterious sheep-like dog that can speak, Ueki discovers that everyone's memories were stolen from them and are now stored in U-lu's body. In order to get them back, he has to travel to the world where U-lu is from, an unknown territory where 75% of the population are power users. As the only person with his memory intact, Ueki is determined to do whatever it takes to restore the lost memories, even if it means fighting a dangerous battle without his precious friends.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/266595l.jpg	7.24	2373	5519	4728	Finished	f	2004-12-31 16:00:00-08	2006-12-31 16:00:00-08	46	5	2025-02-27 18:13:42.31639-08	2025-02-27 18:13:42.31639-08
328	Grenadier	Grenadier	グレネーダー	Rushuna is a blonde and very beautiful Senshi (gun expert) that travels through the world with one purpose. This is to make the world a peaceful place by instead of fighting with weapons, taking away the people's will to fight by giving them a smile. Although she doesn't want to fight, she is forced too and shows amazing gun skills. In this journey she meets Yajiro, a Mercenary that uses a sword to fight and joins her on her journey.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/180652l.jpg	6.96	768	9601	8355	Finished	f	2002-04-25 17:00:00-07	2005-03-25 16:00:00-08	36	7	2025-02-27 18:13:42.393836-08	2025-02-27 18:13:42.393836-08
329	Gokkun! Pucho	Pixie Pop: Gokkun Pucho	ゴックン! ぷーちょ	Cheerful 12-year-old Mayu Kousaka is excited for her first day of middle school until she learns that she has to sit next to Shinya Amamiya in class. Haunted by his rejection of her feelings toward him, she spends that night binging soda at her mother's cafe. Despite her efforts to get over him, she sheds a tear that drops into her cup, changing the soda into a seven-colored drink.\n\nAfter chugging the drink, Mayu suddenly meets a self-proclaimed "drink fairy" named Pucho, who rages at her for drinking what was supposed to be for herself. Due to Pucho's drink, Mayu now transforms whenever she drinks something—which often results in disastrous effects! Both Mayu and Pucho are now endlessly distressed until Pucho sees that Mayu may still have feelings for Shinya.\n\nTo make Pucho's seven-colored pixie pop, a human tear needs to be mixed with seven-colored drops that are gained from feelings of love. The two girls take this as an opportunity for Mayu to try again and win over Shinya; but with Shinya being difficult and Mayu's unpredictable transformations, their quest will not be easy.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/313800l.jpg	7.40	2335	3773	4600	Finished	f	2004-03-02 16:00:00-08	2005-06-02 17:00:00-07	15	3	2025-02-27 18:13:42.480424-08	2025-02-27 18:13:42.480424-08
330	Good Luck	Good Luck	Good Luck	Shi-Hyun is a girl who has nothing but bad luck - at least, that's what everyone believes. In some ways, Shi-Hyun herself believes this and tries to stay away from the people she loves the most. As a result, she has developed an outer shell, making her look tough and indifferent even with the constantly bullying. But when she transfers to a different high school, a fresh start brings unfamiliar characters - and new challenges - into her life.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/152319l.jpg	6.87	957	11032	8847	Finished	f	2001-12-31 16:00:00-08	2002-12-31 16:00:00-08	25	5	2025-02-27 18:13:42.573911-08	2025-02-27 18:13:42.573911-08
332	Gravitation	Gravitation	グラビテーション	Shuichi Shindou is determined to take his band Bad Luck to the top of the Japanese pop charts. With his drive, talent, and satiny singing voice, he just might stand a chance. But Fate throws a wrench into his well-oiled machine in the form of a handsome stranger named Yuki, a romance writer with an attitude. Yuki is Shuichi's biggest critic, but as the two young artists gravitate towards each other, friendship, and perhaps something more, is sure to blossom.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/112343l.jpg	7.56	7507	2547	1415	Finished	f	1995-12-31 16:00:00-08	2001-12-31 16:00:00-08	54	12	2025-02-27 18:13:42.621833-08	2025-02-27 18:13:42.621833-08
333	Gravitation EX	Gravitation EX	グラビテーションEX	In order to heal the wounds in Eiri Yuki's heart, he and his vocalist lover, Shuichi, travel to New York to visit the grave of Yuki's first love and tormentor, Yuki Kitagawa. They discover that the first Yuki has left behind a young son, Riku, and so the odd couple take the boy back with them to Japan. When Shuuichi receives a kiss from nutty rival band leader, Ryuuichi, Yuki flies into a jealous rage, and he and Riku disappear, leaving Shuuichi to search for them in vain.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/180139l.jpg	7.34	1509	4387	5966	Finished	f	2004-12-31 16:00:00-08	2010-12-31 16:00:00-08	25	2	2025-02-27 18:13:42.706907-08	2025-02-27 18:13:42.706907-08
334	Gravitation: The Novel	Gravitation: The Novel	グラビテーション・ザ・ノベル	Energetic teenager Shuichi Shindo is the lead singer and songwriter for the smash-hit pop band, Bad Luck. He's recently moved in with his older boyfriend, Eiri Yuki, the handsome, sophisticated, and uber-famous romance novelist. Nothing goes smoothly for Shuichi, however. Yuki is inexplicably cold and cruel toward him, more so than usual; due to a rash of publicity appearances on comedy sketch shows, he can't get anyone to take his band seriously; and he's suddenly entered, totally unprepared, into a nationally televised concert with Bad Luck's rival band, Ask.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/287922l.jpg	7.28	642	5086	11984	Finished	f	1999-12-31 16:00:00-08	\N	8	1	2025-02-27 18:13:42.809966-08	2025-02-27 18:13:42.809966-08
364	Hibiki no Mahou	Hibiki's Magic	ヒビキのマホウ	Some of our most cherished manga characters are blessed with magical powers...others have an extraordinary combination superhuman strength and cunning intellect. But Hibiki? Her only real skill seems to be making a pot of delicious tea... Or is it?! This heartwarming fantasy story will have you believing in the power of Hibiki's magic!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/173205l.jpg	7.65	991	2007	6339	Finished	f	2004-06-25 17:00:00-07	2016-03-25 17:00:00-07	35	6	2025-02-27 18:13:45.33146-08	2025-02-27 18:13:45.33146-08
335	Gravitation: Voice of Temptation	Gravitation: Voice of Temptation	小説　グラビテーション　～voice the temptation～	During a break on his premiere tour for the smash-hit pop band Bad Luck, lead singer Shuichi Shindo comes home to spend some quality time with his boyfriend, Eiri Yuki, the famous romance novelist. However, he finds their apartment empty and the only thing waiting for him is a mysterious, alarming note. Has something horrible happened to his lover? Does it have any connection to that gorgeous lady who's been stalking the writer for the past few weeks?\n\nBased on the popular manga and anime, Gravitation: Voice of Temptation is a highly charged, hilarious story about two lovers drawn together despite the overwhelming odds.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/287921l.jpg	7.30	538	4817	13673	Finished	f	2001-12-31 16:00:00-08	\N	4	1	2025-02-27 18:13:42.874761-08	2025-02-27 18:13:42.874761-08
336	GTO	GTO: Great Teacher Onizuka	GTO	22-year-old Eikichi Onizuka: pervert, former gang member... and teacher?\n\nGreat Teacher Onizuka follows the incredible, though often ridiculous, antics of the titular teacher as he attempts to outwit and win over the cunning Class 3-4 that is determined to have him removed from the school. However, other obstacles present themselves throughout—including the frustrated, balding vice principal, Hiroshi Uchiyamada; old enemies from his biker days; and his own idiotic teaching methods. But Eikichi fights it all whilst trying to help his students, romance fellow teacher Azusa Fuyutsuki, and earn his self-proclaimed title.\n\n[Written by MAL Rewrite]\n\nAlso contains the gaiden "GTO: Great Toroko Oppai♡" (Tomoko's Big Adventures).	https://cdn.myanimelist.net/images/manga/2/172982l.jpg	8.87	69003	25	57	Finished	f	1996-12-10 16:00:00-08	2002-01-29 16:00:00-08	208	25	2025-02-27 18:13:42.93415-08	2025-02-27 18:13:42.93415-08
337	Blue Inferior	Blue Inferior	ブルー・インフェリア	It is a world where environmental pollution has spiraled out of control. Most of the land is contaminated desert, and there are only a few pockets along the shore where people can live. Those inhabiting these oases are suspicious of strangers, and know nothing about the outside world save for stories of vicious "sub-humans." One day, a young girl named Marine washes up on the shore of one of the inhabited lands. She has no memory of where she came from. She is found by a young boy named Kazuya, who loves the sea and has a natural curiosity about the outside world. The two of them start to become friends... but then rumors start spreading that Marine might be a sub-human, and she is locked up. Now Kazuya must help her escape, and uncover the mystery of who she is and where she came from. \n\n(Source: ADV)	https://cdn.myanimelist.net/images/manga/1/77263l.jpg	\N	\N	20435	35440	Finished	f	1993-12-31 16:00:00-08	2000-12-31 16:00:00-08	24	4	2025-02-27 18:13:43.045566-08	2025-02-27 18:13:43.045566-08
338	Chrno Crusade	Chrno Crusade	クロノクルセイド	America in the Roaring 20s. On the surface, it's a positive, peaceful time after the violence of the Great War. But lurking in the shadows is a dark element ready to snatch that peace away. Sister Rosette Christopher, an exorcist working as a part of the Magdala Order, has a duty to fight the demons which appear and cause destruction. But along with her companion Chrno, she usually ends up causing more destruction than the demons themselves! On one particular mission, they meet a young girl with a beautiful voice named Azmaria, who is being targeted by her own stepfather. As Rosette and Chrno work to save her, more is revealed about the relationship between them. There is more to these two than meets the eye.\n\n(Source: ADV)	https://cdn.myanimelist.net/images/manga/2/178875l.jpg	8.11	13531	564	648	Finished	f	1998-12-08 16:00:00-08	2004-05-07 17:00:00-07	59	8	2025-02-27 18:13:43.080805-08	2025-02-27 18:13:43.080805-08
339	Sakigake!! Cromartie Koukou	Cromartie High School	魁!! クロマティ高校	Welcome to Cromartie High—a melting pot of underachievers and overzealous bullies, where the fist rules and the student body has the combined I.Q. of a rusty nail. After a whole lot of bad judgment and a little bad luck, Takashi Kamiyama is now attending this academy of dunces. Here, his only homework will be defending himself against the foul-mouthed robots, semi-intelligent apes and masked villains that roam the halls of Cromartie High School!\n\n(Source: ADV)	https://cdn.myanimelist.net/images/manga/3/265952l.jpg	8.10	3898	581	1450	Finished	f	2000-07-18 17:00:00-07	2006-05-16 17:00:00-07	335	17	2025-02-27 18:13:43.21837-08	2025-02-27 18:13:43.21837-08
340	Darkside Blues	Darkside Blues	ダークサイド・ブルース	In the near future, almost the entire world lies in the iron grip of a huge conglomerate, the Persona Century Corporation. One day, a mysterious good-looking man appears in Shinjuku, one of the few places not dominated by Persona Century. Shinjuku is a dangerous and lawless place, teeming with rebels and terrorists. The stranger's name is Dark Side - and with the help of a small band of rebels, he will attempt to break Persona's stranglehold on the world. \n\n(Source: ADV)	https://cdn.myanimelist.net/images/manga/3/269173l.jpg	6.55	173	15807	19699	Finished	f	1987-12-31 16:00:00-08	\N	\N	2	2025-02-27 18:13:43.278877-08	2025-02-27 18:13:43.278877-08
341	Desert Coral	Desert Coral	デザート・コーラル	Naoto Saki is a typical young boy. He gets average grades in school, and nothing about him really stands out. His favorite thing to do is sleep - which doesn't exactly endear him to his teachers when he dozes off in class. Whenever he falls asleep, Naoto dreams of the same fantasy world. Then one day, Naoto gets magically summoned into the very world he had once only seen in dreams! All at once, he's caught up in a battle between the powerful beings called Elphis, and a group of human-like beings called the Sand Dusts. For Naoto, this desert world of Orgos is no longer a dream-he can feel pain here, and possibly even die. He decides he'd rather not risk his life, and would like nothing more than to return home. But the pretty sorceress who summoned him in the first place has other plans for him.\n\n(Source: ADV)	https://cdn.myanimelist.net/images/manga/3/105689l.jpg	6.69	568	13819	11327	Finished	f	2002-02-27 16:00:00-08	2004-02-27 16:00:00-08	25	5	2025-02-27 18:13:43.339502-08	2025-02-27 18:13:43.339502-08
342	Kidou Senshi Gundam Gaiden: The Blue Destiny	Mobile Suit Gundam Sidestory: The Blue Destiny	機動戦士ガンダム外伝―THE BLUE DESTINY	Robotic armed freedom fighters fight for Earth's future in this intergalactic tale of the pursuit of freedom. After Earth's overpopulation sends humans offworld to live in space stations, they are abused by the controlling power -- the Earth Federation government. Colonists form the Zeon Dukedom to resolve their disputes and wage the One Year War for independence. For over 20 years, the world of Gundam has reigned over all other mecha anime and manga series. Mobile Suit Gundam: Blue Destiny continues the Gundam legacy with the adventures of Federal Forces second lieutenant Yu Kajima and his special unit of mobile suits. \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/268899l.jpg	6.87	559	11033	14776	Finished	f	1996-09-30 17:00:00-07	1997-02-28 16:00:00-08	6	1	2025-02-27 18:13:43.444281-08	2025-02-27 18:13:43.444281-08
343	Dragon Eye	Dragon Eye	龍眼－ドラゴンアイ－	Ten years ago, a terrible virus swept the globe. It turned its victims into bloodthirsty monsters called Dracules, and the only cure is death. Now, with humankind on the brink of extinction, only the elite warriors of the Vius Squad stand between chaos and civilization. New recruit Leila Mikami is one of the squad's most promising young warriors, but she has another agenda: Her parents were killed by a Dracule, and she's determined to take revenge. To do this, she has to find the Dragon Eye - a magic weapon that will make her the most powerful warrior in the world.\n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/2/176196l.jpg	7.59	830	2333	7788	Finished	f	2005-05-25 17:00:00-07	2007-11-25 16:00:00-08	31	9	2025-02-27 18:13:43.497947-08	2025-02-27 18:13:43.497947-08
344	ES: Eternal Sabbath	ES: Eternal Sabbath	エス -Eternal Sabbath-	Ryousuke Akiba calls himself ES, a code name taken from a mysterious scientific experiment. Ryousuke will live to be at least two centuries old and possesses strange mental powers: He can enter people's minds, discover their darkest secrets, even rearrange their memories so that complete strangers will treat him like family. Ryousuke acts not out of malice but for survival-wandering Tokyo for reasons known only to him. No one recognizes him for what he is...until Dr. Mine Kujyou, a determined researcher, meets someone who challenges everything she knows about science-ES, possessor of the Eternal Sabbath gene. But is he the only one?\n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/2/174740l.jpg	7.81	5499	1283	1338	Finished	f	2001-08-22 17:00:00-07	2004-10-06 17:00:00-07	83	8	2025-02-27 18:13:43.555454-08	2025-02-27 18:13:43.555454-08
345	Kidou Senshi Gundam SEED: X Astray	Mobile Suit Gundam SEED X Astray	機動戦士ガンダムSEED Ｘ Astray	After having finished a job at Research Colony Mendel, a mysterious mobile suit approaches the colony--likely with hostile intent. When Lowe Gear intercepts in the Red Frame, the pilot opens fire... and thus begins another exciting adventure set in the popular Gundam Seed universe! Mobile Suit Gundam SEED X Astray continues where Gundam Seed Astray R left off!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/5/184670l.jpg	7.02	434	8630	15866	Finished	f	2003-09-25 17:00:00-07	2004-07-25 17:00:00-07	11	2	2025-02-27 18:13:43.64495-08	2025-02-27 18:13:43.64495-08
346	Free Collars Kingdom	Free Collars Kingdom	フリーカラーズキングダム	Cyan is a teenage cat (in cat years!), and when his beloved young master falls ill, the parents abandon Cyan in the basement of a luxurious apartment building. Now Cyan finds himself smack-dab in the middle of the biggest feline territorial battle in Japan.\n\nWhile waiting for his owner to return and reclaim him, Cyan has to brave the attacks of vampy Siam and the beautiful killer Kline. He also must try to fit in with the group of oddball strays who reside in the basement, a cat gang named the Free Collars!\n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/1/862l.jpg	6.74	497	13125	15573	Finished	f	2001-12-31 16:00:00-08	2002-12-31 16:00:00-08	18	3	2025-02-27 18:13:43.698796-08	2025-02-27 18:13:43.698796-08
347	Gachagacha	Gacha Gacha	ガチャガチャ	Part.1: "Capsule" Arc (Volumes 1-5)\nLately, Kouhei can't get his friend Kurara out of his mind. Even though he has known her since elementary school, all of a sudden, ever since she came back from summer vacation, he has been crushing on her...hard.\n\nBut something is different about Kurara—she's acting very oddly. Sometimes she seems wholesome, pure, and innocent, and at other times she is extremely forward and unabashed. Kouhei soon learns that Kurara has multiple personalities—and decides to help her keep her secret from their classmates. But Kouhei finds himself struggling between helping Kurara as a friend and trying to win her heart... which is a challenge, since she has many! (Source: Del Rey)\n\nPart.2: "Secret" Arc (The Next Revolution; Volumes 6-16)\nHatsushiba Akira, an awkward high school senior boy, has a strong crush on classmate Sakuraba Yurika. But when he gets close to her, he always says or does something stupid. One day, at the suggestion of his best friend Kikuchi, Akira enters the GachaGacha machine to play a game, but the machine malfunctions. That night, he sneezes while going to bed, and when he wakes up, he looks like the female avatar he saw in the GachaGacha machine. He soon learns that sneezing will change him back and forth from his normal self to a female form. As a girl, Akira-chan is able to get close to Sakuraba and to become her friend.\n\nIncluded one-shot:\nVolume 13: Miniature	https://cdn.myanimelist.net/images/manga/1/143255l.jpg	7.18	3132	6323	3363	Finished	f	2002-08-06 17:00:00-07	2007-10-19 17:00:00-07	97	16	2025-02-27 18:13:43.815182-08	2025-02-27 18:13:43.815182-08
348	Genshiken	Genshiken	げんしけん	It's the spring of freshman year, and Kanji Sasahara is in a quandary. Should he fulfill his long-cherished dream of joining an otaku club? Saki Kasukabe also faces a dilemma. Can she ever turn her boyfriend, anime fanboy Kousaka, into a normal guy? Kanji triumphs where Saki fails, when both Kanji and Kousaka sign up for Genshiken: The Society for the Study of Modern Visual Culture.\n\nUndeterred, Saki chases Kousaka through the various activities of the club, from costume-playing and comic conventions to video gaming and collecting anime figures—learning more than she ever wanted to about the humorous world of the Japanese fan...\n\n(Source: Del Rey Manga)	https://cdn.myanimelist.net/images/manga/3/161681l.jpg	8.21	13465	415	434	Finished	f	2002-04-24 17:00:00-07	2016-08-24 17:00:00-07	127	21	2025-02-27 18:13:43.918797-08	2025-02-27 18:13:43.918797-08
349	Shin Kidou Senki Gundam Wing	Mobile Suit Gundam Wing	新機動戦記ガンダムＷ〈ウイング〉	After a generation of warfare, the Gundam boys finally secured a peace between Earth and the colonies by helping to defeat the Oz and White Fang armies. Now, out of the rubble, the surviving soldiers are re-emerging and clustering together into new factions. Heero Yuy has become a vigilante pacifist, tracking down weapons stashes and destroying them, while Relena, former Queen of the Earth Sphere, tries to maintain the peace politically. But an unmanned weapons factory has been discovered somewhere near Mars, and now the boys are going to have to dust off their mechs for one more battle to save the tenuous peace. \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/301296l.jpg	6.77	1179	12543	8436	Finished	f	1995-04-14 17:00:00-07	1996-04-14 17:00:00-07	12	3	2025-02-27 18:13:44.009639-08	2025-02-27 18:13:44.009639-08
350	Gokuraku Seishun Hockey Club	My Heavenly Hockey Club	極楽　青春ホッケー部	Hana Suzuki loves only two things in life: eating and sleeping. So when handsome classmate Izumi Oda asks Hana–his major crush–to join the school hockey club, persuading her proves to be a difficult task. True, the Grand Hockey Club is full of boys–and all the boys are super-cute–but given a choice, Hana prefers a sizzling steak to a hot date. Then Izumi mentions the field trips to fancy resorts. Now Hana can’t wait for the first away game, with its promise of delicious food and luxurious linens. Of course there’s also the getting up early, working hard, and playing well with others. How will Hana survive?\n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/1/241814l.jpg	7.54	2299	2696	3472	Finished	f	2004-12-31 16:00:00-08	2009-12-31 16:00:00-08	54	14	2025-02-27 18:13:44.100007-08	2025-02-27 18:13:44.100007-08
351	Kidou Senshi Gundam SEED	Mobile Suit Gundam SEED	機動戦士ガンダムSEED　	Year 71, Cosmic Era. After the terrible battle of Yakin Due, an uneasy peace rests between the Earth Alliance and the Zaft Empire. But even as Cagalli and Athrun visit Chairman Durandal to cement the tentative cease-fire, Zaft terrorists plot with Neo Roanoke to drag both sides into all-out war. The plan: storm Zaft territory and steal several Gundam Mobile Suits. But that's only the beginning. They're also scheming to engineer a catastrophic event, one designed to drive the Earth down a bloody path. Now the crew of the Minerva must prevent disaster, as everything and everyone-including the love between Athrun and Cagalli-is thrown in mortal danger.\n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/1/306872l.jpg	6.73	976	13256	9532	Finished	f	2002-10-25 17:00:00-07	2004-10-25 17:00:00-07	25	5	2025-02-27 18:13:44.137287-08	2025-02-27 18:13:44.137287-08
352	Kidou Senshi Gundam: École du Ciel	Mobile Suit Gundam: École du Ciel	機動戦士ガンダム École du Ciel -天空の学-	Daughter of a brilliant professor, Asuna is a below-average student at Ecole du Ciel, where teachers and other students constantly belittle her. However, with the world spiraling toward war, Asuna's headed for a crash course in danger and love, as everyone prepares for combat...\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/149934l.jpg	7.38	509	3982	10638	On Hiatus	f	2001-12-17 16:00:00-08	2011-02-25 16:00:00-08	68	12	2025-02-27 18:13:44.236267-08	2025-02-27 18:13:44.236267-08
353	Kidou Senshi Gundam Senki: Lost War Chronicles	Mobile Suit Gundam: Lost War Chronicles	機動戦士ガンダム戦記 Lost War Chronicles	The One Year War between the Earth Federation and the Principality of Zeon has begun—and the newest Mobile Suits are tested for battle!\n\nCaptain Matt Healy leads his team into dangerous territory as the leader of a Special Forces Experimental Unit. Ken Bederstadt is a Foreign Legion Lieutenant working in alliance with Zeon. These two heroes are trying to keep everyone alive... for tomorrow!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/152342l.jpg	6.96	406	9533	17362	Finished	f	2002-05-24 17:00:00-07	2004-01-25 16:00:00-08	10	2	2025-02-27 18:13:44.308291-08	2025-02-27 18:13:44.308291-08
354	Happy Mania	Happy Mania	ハッピー・マニア	Shigeta, a young woman of 24, spends her days working at Tanaka Books and fretting over her love-life or, more accurately, the lack thereof. The thing is, though, the biggest obstacle between Shigeta and a satisfying relationship seems to be Shigeta herself. When it comes to men, the poor girl has exceedingly poor judgement, exacerbated by her even poorer self-esteem.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/4/263715l.jpg	6.80	265	12175	11919	Finished	f	1995-12-31 16:00:00-08	2000-12-31 16:00:00-08	62	11	2025-02-27 18:13:44.385735-08	2025-02-27 18:13:44.385735-08
355	Harlem Beat	Harlem Beat	Harlem Beat	Some athletes dream of the bling-bling, others dream of the women. But real hoop dreams reflect the desire to be the best. The dream of being able to take the rock, drive the lane, and take it to the hole. That's Nate Torres, branded as the team benchwarmer, just trying to get that shot at high school fame and glory. When he blows his chance to try and make his high school team, he takes his dream to the only place he has left ... the streets.\n\nAway from the spotlight and glory of organized basketball, Nate Torres discovers himself on a back alley half-court.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/183416l.jpg	7.52	468	2804	11000	Finished	f	1994-07-26 17:00:00-07	2000-01-18 16:00:00-08	247	29	2025-02-27 18:13:44.475954-08	2025-02-27 18:13:44.475954-08
356	Hatenkou Yuugi	Dazzle	破天荒遊戯	A young girl named Rahzel is booted out of her house one day by her father with the instructions to 'see the world.' And so her journey begins, However, she won't be doing it alone...for she befriends a stoic young man named Alzeid seeking revenge for his father's murder.\n\nAlzeid and Rahzel are like oil and water...but even still, they feel strangely drawn to one another. This could be either the result of an underlying attraction—or their shared powers with magic. And so, the two reluctant allies travel from town to town, using their powers to help the helpless, while discovering their own respective places in the world.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/172703l.jpg	7.91	1656	953	3144	Finished	f	1999-11-17 16:00:00-08	2022-06-30 17:00:00-07	195	24	2025-02-27 18:13:44.540564-08	2025-02-27 18:13:44.540564-08
357	Wolf's Rain	Wolf's Rain	WOLF'S RAIN	Humans thought the wolves died off two centuries ago in this bleak post-apocalyptic wasteland. But some survivors lurk among the humans by mentally cloaking their animal bodies. One white wolf, Kiba, scours the land for the scent of the Lunar Flower that will lead them all to Paradise...but will it lead them to a deadly false legend?\n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/2/181408l.jpg	7.14	6885	6898	1428	Finished	f	2003-02-25 16:00:00-08	2004-01-25 16:00:00-08	11	2	2025-02-27 18:13:44.752949-08	2025-02-27 18:13:44.752949-08
358	Haunted House	Haunted House	ホーンテッドハウス	From the creator of Doll and Beautiful People comes a biting black comedy that shows us nothing is scarier than family. Haunted House follows the misadventures of Sabato, a hapless young teen trying to find himself, which is made all but impossible by his flamboyant family (who look like the Addams Family by way of Tim Burton). Scaring away every girl he brings home, Sabato's family seem to revel in his misery, but could there be more to their torment than meets the eye? Rest assured, Mihara-sensei keeps you guessing and giggling every step of the way.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/102063l.jpg	6.82	591	11758	14760	Finished	f	1998-07-31 17:00:00-07	2001-12-31 16:00:00-08	8	1	2025-02-27 18:13:44.87814-08	2025-02-27 18:13:44.87814-08
359	Kijuushin Seiki Zoids	Zoids: Chaotic Century	機獣新世紀ZOIDS	Van is the son of the greatest Zoid pilot in town, but he isn't living up to his father's reputation. He's lucky if he can even get a Zoid to move, but while being chased by a rampaging scorpion-like Zoid, Van finds himself in some old ruins.\n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/4/209555l.jpg	7.05	209	8139	19711	Finished	f	1999-04-14 17:00:00-07	2001-09-14 17:00:00-07	\N	5	2025-02-27 18:13:44.925218-08	2025-02-27 18:13:44.925218-08
360	Heat Guy J	Heat Guy J	ヒートガイジェイ	Daisuke Aurora works with the special division of peacekeepers in the city of Jewde, one of the largest cities on the planet. He and his android partner, Heat Guy J, team up to make sure that anything illegal stays off the streets and out of circulation.\n\nHowever, their presence doesn't sit too well with the local mob leader—a ruthless, unbalanced, well-armed son of the late Don, who is out to prove that he is not too young to take over the family business. In the city that never sleeps, will Daisuke and Heat Guy J end up sleeping with the fishes?\n\n(Source: TokyoPop)	https://cdn.myanimelist.net/images/manga/3/164806l.jpg	6.23	216	18823	20693	Finished	f	2002-08-25 17:00:00-07	2003-02-25 16:00:00-08	5	1	2025-02-27 18:13:44.997583-08	2025-02-27 18:13:44.997583-08
361	Heaven Above Heaven	Heaven Above Heaven	천외천	Seventeen years ago, nine Grand Masters of the Martial Arts raced to a remote mountaintop, determined to prevent a terrible prophecy. It had been foretold that on this very night, in this inhospitable place, a child would be born.\n\nA baby girl, who in time would become the catalyst for an Apocalypse, the likes of which had not been visited upon the earth in a thousand years. In order to avoid this prophecy, the child must be destroyed. But just as the noble warriors were about to fulfill their mission...they hesitated. Now, seventeen years later, a young street fighter arrives in a bustling city. He has a knack for trouble, a lust for the ladies and a wicked fighting technique.\n\nWhen he is caught peeping on the daughter of a local dojo master, a brief scuffle ends with him being taken in as a student by the wise master. All the while, a mysterious "cursed" young boy, who is not what he appears to be, is manipulating events from the shadows.\n\nAre his intentions evil? Is he in some way connected to the ancient prophecy? And what part will our young street fighter play in all of these unfolding events? These are the questions that will be answered in this epic tale.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/3/152325l.jpg	\N	\N	20436	45110	Finished	f	2004-12-31 16:00:00-08	\N	\N	6	2025-02-27 18:13:45.067871-08	2025-02-27 18:13:45.067871-08
362	Heaven!!	Heaven!!	HEAVEN!!	Rinne is a girl who can see and exorcise ghosts (usually with a paper fan). When the school punk saves her from getting hit by a truck, but ends up in a coma himself, she, and his disembodied spirit must defend his prone body from being possessed by this, that and the other local spirits. Unfortunately, she fails in her task, and an ancient playboy takes over the punk's body, leaving him to inhabit a pink stuffed monkey. Hilarity ensues.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/144089l.jpg	7.31	1181	4704	7347	Finished	f	2003-04-11 17:00:00-07	2004-05-12 17:00:00-07	13	3	2025-02-27 18:13:45.178696-08	2025-02-27 18:13:45.178696-08
363	Zoids Shinseiki/Zero	ZOIDS New Century	ゾイド新世紀／ゼロ	Based on the ZOIDS: New Century anime features Bit and his team of pilots and ZOIDS. In this volume, Bit and Team Blitz battle Team Backdraft — a team that will break every rule and try any dirty trick to win the league championship.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/4/58755l.jpg	\N	\N	20437	30137	Finished	f	2001-01-31 16:00:00-08	2001-07-31 17:00:00-07	4	\N	2025-02-27 18:13:45.264867-08	2025-02-27 18:13:45.264867-08
365	Honey Mustard	Honey Mustard	허니 머스타드	Ara, a pretty high school student, finally gets the chance to cozy up to the guy of her dreams, but she blows it and ends up kissing the wrong boy under fairly compromised circumstances. Hilarious complications, mistaken identities, and misinterpreted signals ensue, and Ara soon finds herself being backed into an arranged marriage she at first wants no part of...\n\nBut, as we all know, love has a way of blooming in the unlikeliest of places...and, of course, love eventually conquers all!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/152219l.jpg	6.92	283	10243	19390	Finished	f	2002-12-31 16:00:00-08	2003-12-31 16:00:00-08	23	4	2025-02-27 18:13:45.392483-08	2025-02-27 18:13:45.392483-08
366	Hoshi no Koe	Voices of a Distant Star	ほしのこえ	To what distance would you go for your one true love? In the midst of an alien invasion, Mikako joins the resistance, leaving behind the one young man she loves. As she goes deeper into space, Mikako's only connection with her boyfriend is through cell-phone text messages. The war rages on and years pass, but Mikako barely ages in the timelessness of space while Noboru grows old. How can the love of two people, torn apart by war, survive?\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/130253l.jpg	7.81	10182	1313	787	Finished	f	2004-02-24 16:00:00-08	2004-12-24 16:00:00-08	10	1	2025-02-27 18:13:45.452982-08	2025-02-27 18:13:45.452982-08
367	Hyper Police	Hyper Police	はいぱーぽりす	It is the year 22 H.C. (Holy Century). Shinjuku is populated by monsters and goblins. Humans are endangered and the town is rife with crime. Natsuki Sasahara is a rookie at the Police Company and a newbie bounty hunter. Scouted by her superior, Batanen Fujioka the werewolf, she is half-human, half-catbeast with magical powers, and is slowly getting the hang of the business...\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/180631l.jpg	7.21	378	5939	13824	Finished	f	1993-02-08 16:00:00-08	2004-01-29 16:00:00-08	97	10	2025-02-27 18:13:45.544896-08	2025-02-27 18:13:45.544896-08
368	Cyber Planet 1999: HYPER☆Rune	Hyper Rune	サイバー・プラネット1999HYPER☆ルン	Rune Ayanokouji lives a life less ordinary with her mad scientist grandfather. When mysterious humanoid robots suddenly pop up all around town, she discovers an alien plot to take over the world. Rune teams up with her friends to fight the invasion ... but when the fate of the world is on the line, who can you trust?\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/1105l.jpg	\N	\N	20438	30261	Finished	f	1995-12-31 16:00:00-08	\N	\N	4	2025-02-27 18:13:45.661228-08	2025-02-27 18:13:45.661228-08
369	I Wish...	I Wish...	I WISH...	Story about a young woman who after her family dies goes to a magician to wish them back. She ends up becoming his assistant until she makes a wish he can grant. How will she deal with his other customers? And what about the most prized possession that is the cost of having the wish granted?\n\n(Source: Korean-Manwha)	https://cdn.myanimelist.net/images/manga/1/261786l.jpg	7.62	665	2206	10033	Finished	f	1999-12-31 16:00:00-08	\N	50	7	2025-02-27 18:13:45.762474-08	2025-02-27 18:13:45.762474-08
370	I.N.V.U.	I.N.V.U.	I.N.V.U.	One morning, 16-year-old Sey's world is turned upside down when her mother announces she's moving to Italy to finish her novel. She's made arrangements for Sey to live with her friend, Meja, and Meja's creepy daughter, Terry 27 not exactly Sey's ideal living situation, but she has no other choice. Sey has a killer crush on a teacher named Mr. Cho, and she's beyond shocked when she learns that Terry knows him well ... VERY well.\n\nAnd so begins I.N.V.U. (I Envy You) - a hip, moving, topsy-turvy look at the lives and loves, trials and travails of 4 teenage girls.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/247887l.jpg	6.89	674	10656	10997	On Hiatus	f	1999-12-31 16:00:00-08	2007-12-31 16:00:00-08	\N	5	2025-02-27 18:13:45.869567-08	2025-02-27 18:13:45.869567-08
371	Ichigo Mashimaro	Strawberry Marshmallow	苺ましまろ	"Cute girls doing cute things in cute ways."\n\nEveryday things make up the fabric of life whether its making friends, going to school, trying to make money, or celebrating a holiday. Ichigo Mashimaro is a heartwarming series that follows the daily lives of Itoh Chika, her sister Nobue, and her friends Miu, Matsuri, and Ana.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/4/156517l.jpg	7.89	2026	1030	2693	Publishing	t	2002-02-14 16:00:00-08	\N	\N	\N	2025-02-27 18:13:45.933249-08	2025-02-27 18:13:45.933249-08
372	Ikkitousen	Battle Vixens	一騎当千	Sealed in ancient jewels are the spirits of the heroes who tried and failed to unite China in the Three Kingdoms era. These jewels have been scattered throughout Japan, and have the power to draw out the full potential of those who inherit them. However, those owners, known as Toushi, are possessed with an insatiable appetite for battle. Hakufu Sonsaku is one such Toushi. Living in the country, Hakufu's desire to beat something to a pulp goes unfulfilled until her mother tells her to go to Tokyo, where she starts training with other Toushi and sets foot on the path to her destiny.\n\n(Source: TokyoPop)	https://cdn.myanimelist.net/images/manga/1/180440l.jpg	6.79	2522	12290	2591	Finished	f	2000-04-25 17:00:00-07	2015-08-25 17:00:00-07	187	24	2025-02-27 18:13:45.99456-08	2025-02-27 18:13:45.99456-08
373	Meteor Methuselah	Immortal Rain	メテオ・メトセラ	Rain Jewlitt, known as the Methuselah, is a spaced-out, immortal, 624-year-old man dressed in priest's clothes. He's got eternal youth and a large price on his head... put there by those questing after the secret of his immortality.\n\nMachika Balfaltin is a tomboyish, energetic 14-year-old girl who, upon the death of her grandfather, sets out to kill Methuselah, the one bounty her assassin grandfather, Zol the Grim Reaper, couldn't kill. Instead, however, Machika ends up being saved by Rain again and again from other aspiring bounty hunters attacking them both.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/198155l.jpg	8.19	6093	446	973	Finished	f	1998-08-25 17:00:00-07	2011-05-24 17:00:00-07	61	11	2025-02-27 18:13:46.09292-08	2025-02-27 18:13:46.09292-08
374	In Dream World	In Dream World	인드림월드	Nightmares are bad enough when asleep, but In Dream World, nightmares are real, physical monsters!\n\nDrake, Hanee and Kyle fight these Nightmares with not only weapons, but "In Dream Cards". These cards have different elemental powers, and those who wield the cards are masters of their elements. Hanee and her friends must battle their way through the land of Nightmares to find their way home.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/4/7247l.jpg	6.47	214	16824	23338	Finished	f	2002-12-31 16:00:00-08	2003-12-31 16:00:00-08	25	3	2025-02-27 18:13:46.22155-08	2025-02-27 18:13:46.22155-08
375	Initial D	Initial D	頭文字D	There is said to be a legendary "Ghost of Akina" that holds the fastest time to descend the Akina Pass. No one has ever come close to beating the record, nor has the mysterious driver of the white Toyota AE86 ever revealed themselves. Nowadays, the same AE86 can be seen every morning driving up and down the pass, making trips to a hotel residing at the top of the mountain.\n\nUnlike his classmates and coworkers, Takumi Fujiwara did not like cars. Any conversation about them would remind him of his early morning routine of delivering tofu for his father. He did not see the appeal in street racing and knew nothing about its rules or its culture. However, when tagging along to a nighttime meetup, the appearance of a rival racing team at the Akina Pass compels Takumi to hop behind the wheel of his father's AE86 and race them down the familiar mountain.\n\nThis spur-of-the-moment decision marks the beginning of Takumi's high-octane journey, shifting from his daily deliveries to becoming the greatest drift racer ever. Along the way, he slowly finds and kindles his love for street racing as he comes face-to-face with a plethora of opponents, each ready to take on the renowned Ghost of Akina.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/186990l.jpg	8.24	10189	379	603	Finished	f	1995-06-25 17:00:00-07	2013-07-28 17:00:00-07	724	48	2025-02-27 18:13:46.310521-08	2025-02-27 18:13:46.310521-08
376	Innocent W	Innocent W	イノセントW	Someone has assembled a group of high school girls—rumored to be witches—and dropped them off in the woods. Among them is Makoto, a male 'witch' who has mysterious powers. The plot centers around people who have a grudge against the witches and who try to kill them in the woods. The story also focuses on the witches who are struggling to survive.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/180642l.jpg	6.83	270	11596	19934	Finished	f	2003-11-28 16:00:00-08	2006-06-29 17:00:00-07	24	3	2025-02-27 18:13:46.414419-08	2025-02-27 18:13:46.414419-08
377	Island	Island	아일랜드	Miho, a woman of beauty, intelligence and temper, comes to Cheju Island to teach school and is immediately flung into a world of terror and the supernatural. A demon attacks her and she is saved by the chance appearance of a mystery man with seemingly only one mission... demon killing.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/270452l.jpg	7.05	1198	8140	6582	Finished	f	1996-12-31 16:00:00-08	2000-12-31 16:00:00-08	46	7	2025-02-27 18:13:46.488212-08	2025-02-27 18:13:46.488212-08
378	Les Bijoux	Les Bijoux	레비쥬	Welcome to a world divided into 12 Mines, each of them its own land, dominated by a rigid social class structure in which the 'Habit' exists to rule and the 'Spar' exist to serve. Their future dim and seemingly set in stone, the Spar find hope in an unlikely hero: the androgynous child born of a dwarf and hunchback who is prophesied to overthrow the tyrannical rulers!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/191944l.jpg	6.70	529	13636	14520	Finished	f	1998-12-31 16:00:00-08	1999-12-31 16:00:00-08	32	5	2025-02-27 18:13:46.528997-08	2025-02-27 18:13:46.528997-08
379	Jiraishin	Ice Blade	地雷震	Kyoya Ida is a hard-nosed detective from the Shinjuku Police precient. He is known in the force as an unreasonable type who would use lethal force to solve cases, making him unpopular with the enlisted and high-ranking officers in the National Police Agency. Despite this fact, there are some in the force that admire Ida for his bravery and cleverness in using lethal force to solve criminal cases whenever legal means are met in a dead end.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/1/263862l.jpg	7.73	2490	1596	1834	Finished	f	1992-09-24 17:00:00-07	1999-11-24 16:00:00-08	72	19	2025-02-27 18:13:46.56017-08	2025-02-27 18:13:46.56017-08
380	Judas	Judas	JUDAS	Salvation may be at hand, but now is the time for prayer...\n\nJudas, cursed for his sins, is the spirit of Death—he is without form, and has enslaved young Eve to carry out the most heinous of acts. Together in spirit and body, they must slay 666 people, so that Judas can regain his humanity!\n\n(Source: Tokyopop)\n\nIncluded one-shot:\nVolume 5: Endless Pain	https://cdn.myanimelist.net/images/manga/2/178192l.jpg	6.86	424	11188	11356	Finished	f	2004-05-25 17:00:00-07	2005-12-25 16:00:00-08	20	5	2025-02-27 18:13:46.603776-08	2025-02-27 18:13:46.603776-08
381	Junai Tokkou Taichou!	Love Attack	純愛特攻隊長！	Chiemi Yusa's high school record is far from perfect. She's already been suspended twice for fighting, and she's not even half-way through her first year! In danger of getting expelled for starting yet another brawl, her teacher approaches her with an unexpected offer: get her classmate Akifumi "Deranged Devil" Hirata, the nastiest fighter in the whole school, to clean up his act, and her record will officially be cleared. Reluctantly she accepts and immediately goes on the attack. But as she's waiting for him to retaliate, she discovers that he has more in store for her than just a fight!\n\nIn Junai Tokkou Taichou!, you'll find a rollicking brawl of a good time as the roughest guy and girl in school get themselves into trouble—and find themselves in love.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/204996l.jpg	7.72	4483	1661	1593	Finished	f	2004-09-12 17:00:00-07	2009-07-12 17:00:00-07	25	13	2025-02-27 18:13:46.675838-08	2025-02-27 18:13:46.675838-08
382	Juu Ou Sei	Jyu-Oh-Sei	獣王星	Twin Brothers Thor and Rai, the sons of murder parents are sent to prison star Kimera. What was waiting for them is a planet where meat eating plants rules and society is in four different colony based on skin color. Will the boys survive in these harsh conditions!? \n\n(Source: MU)\n\nIncludes a two-part short called "Death Game".	https://cdn.myanimelist.net/images/manga/5/72293l.jpg	7.37	339	4089	10957	Finished	f	1992-12-31 16:00:00-08	2002-12-31 16:00:00-08	16	5	2025-02-27 18:13:46.710323-08	2025-02-27 18:13:46.710323-08
383	Kamen Tantei	Kamen Tantei	仮面探偵	A pair of young aspiring mystery writers have weird incidents happen around them that need solving. Luckily for them, the Masked Detective inexplicably always shows up to help.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/180641l.jpg	6.84	133	11414	26865	Finished	f	1998-12-31 16:00:00-08	1999-12-31 16:00:00-08	19	4	2025-02-27 18:13:46.760813-08	2025-02-27 18:13:46.760813-08
384	Kami-Kaze	Kami-Kaze	神・風	Imprisoned for a thousand years, eighty-eight fabled beasts seek resurrection from their world so that they can unleash their wrath upon present-day Japan. And a band of young warriors would love nothing more than to let loose these beasts so that they can feast upon the human world. The only thing preventing civilization's annihilation is the Girl of Water, who is lost in the human world—without any memory of who she is! As the elemental warriors continue their search for her, they cross paths with another of their kind: Ishigami, the Man of Earth. However, Ishigami is one who wants to stop the dreaded resurrection...\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/180645l.jpg	6.81	1038	11975	7990	Finished	f	1997-03-24 16:00:00-08	2003-02-24 16:00:00-08	59	7	2025-02-27 18:13:46.811767-08	2025-02-27 18:13:46.811767-08
385	Kamiyadori	Kamiyadori	カミヤドリ	Girard and ViVi are special government agents known as "Right Arms" whose job is to seek and destroy people who have become "infected." In this world, a weird virus that turns people into monsters has run rampant and the only way humanity can survive is to keep tight control on those who are infected. If the virus' symptoms appear, the person must be disposed of. It's a tough world where women and children must sometimes be killed to prevent the spread of the virus.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/56049l.jpg	6.75	858	12881	7532	Finished	f	2003-07-25 17:00:00-07	2006-01-25 16:00:00-08	29	5	2025-02-27 18:13:46.854494-08	2025-02-27 18:13:46.854494-08
386	Kimi no Unaji ni Kanpai!	Kanpai!	キミのうなじに乾杯!	What with humans killing, exorcising, and otherwise getting rid of them all the time, monsters and demons have become endangered species. Someone has to look out for them, and that's what Yamada Shintarou is training to do- he's going to become a monster guardian. Armed with a two-by-four and a talking rabbit, he goes out to fight the demon hunters, hoping to defeat enough of them to get his monster guardian license. It is while he is doing this that he meets Nao, a normal (if unusually pretty) high school girl, and instantly falls in love... with her neck. Now Yamada has a new mission in life: to protect Nao, and keep anyone- monster, ghost, demon hunter, or otherwise- from getting in the way of his view of her nape.\n\n(Source: ANN)	https://cdn.myanimelist.net/images/manga/3/11216l.jpg	6.71	551	13598	14721	Finished	f	1999-12-31 16:00:00-08	2000-12-31 16:00:00-08	12	2	2025-02-27 18:13:46.938338-08	2025-02-27 18:13:46.938338-08
451	Missing: Kamikakushi no Monogatari	Missing: Kamikakushi no Monogatari	Missing 神隠しの物語	Kyoichi Utsume, a.k.a. "His Majesty, Lord of Darkness," is a dark and compelling mystery, so much so that his fellow Literature Club members would rather discuss him than books! When "His Majesty" vanishes in front of their very eyes, his friends are left with several unanswered questions: what is the source of Kyoichi's long-standing obsession with the "other side"? And just who is Ayame, the eerily ghostlike girl Kyoichi brought to school as his girlfriend the day before he disappeared? \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/4367l.jpg	\N	\N	20442	26208	Finished	f	2002-12-31 16:00:00-08	\N	12	3	2025-02-27 18:13:50.996673-08	2025-02-27 18:13:50.996673-08
387	Karin	Chibi Vampire	かりん	Unlike her family, Karin Maaka is a vampire who walks outside during the day and sleeps during the night. Nobody from her town knows of her true identity—and she plans to keep it that way, as it could jeopardize her "normal" life if someone were to find out.\n\nKenta Usui witnesses Karin bite someone on the day he transfers into her class as a new student. Thinking that something provocative is happening, Kenta tries talking to Karin, only to bring about a series of misunderstandings. After Karin begins avoiding Kenta, he becomes determined to set things straight between them. However, the moment he gets close to her, she has a massive nosebleed!\n\nThis is Karin's true secret—rather than sucking it out of humans, she periodically produces excessive amounts of blood, leading to nosebleeds if she does not release it. Unfortunately, her blood seems to react strangely to Kenta. Armed with knowledge of Karin's truth, will Kenta be able to keep her secret?\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/181516l.jpg	7.72	18291	1634	526	Finished	f	2003-04-08 17:00:00-07	2008-02-08 16:00:00-08	63	14	2025-02-27 18:13:46.993029-08	2025-02-27 18:13:46.993029-08
388	Karin Zouketsuki	Chibi Vampire: The Novel	かりん 増血記	Karin Maaka can bite a throat like a proper vampire, but where others of her kind need hot red blood, she has too much of it! Every month, she's compelled to inject blood into her victims the way a snake injects venom. And her handsome classmate Kenta Usui makes her feel like she's is going to spurt blood like a geyser. Talk about embarrassing! When Karin's latest victim turns out to be as rich as he is good looking, it causes hilarious chaos at her school. Will she ever live in peace?\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/86977l.jpg	7.42	655	3600	9638	Finished	f	2003-12-09 16:00:00-08	2007-05-09 17:00:00-07	60	9	2025-02-27 18:13:47.089865-08	2025-02-27 18:13:47.089865-08
389	Kedamono Damono	\N	けだものだもの	Your typical romance story between a girl (Konatsu Narumiya) and a guy... except that this guy changes into a pervy girl! He can only change into a girl during the night. Konatsu is the manager of the boys' basketball team, has a crush on the team captain. Unfortunately, the team captain is a complete jerk. When Konatsu confides in another team member, Haruki, about her troubles, their relationship grows closer. The only problem: Haruki is a nice ordinary boy by day, but a pervy girl by night!\n\n(Source: MU)\n\nIncluded one-shot:\nVolume 2: Shounen Ningyo	https://cdn.myanimelist.net/images/manga/2/202951l.jpg	6.79	678	12315	9803	Finished	f	2003-08-06 17:00:00-07	2006-12-31 16:00:00-08	\N	3	2025-02-27 18:13:47.171421-08	2025-02-27 18:13:47.171421-08
390	Keroro Gunsou	Sgt. Frog	ケロロ軍曹	Sergeant Keroro is the Captain of the Space Invasion Forces Special Advance Team of the 58th Planet of the Gamma Storm Cloud System, sent to the planet Pokopen (aka Earth) to collect intelligence for his planet's invasion force. He is also a frog. After his ship crash-lands in the planet earth, he takes shelter in the Hinata household, but the two kids, Fuyuki and Natsume, find him and take away his alien weapons. When his people discover that the Pokopenians are aware of him, Keroro is abandoned - left to fend for himself in this hostile world. But he's not alone - four other pre-invasion agents were are also lurking on Earth. \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/4/152242l.jpg	7.65	3302	1989	2843	Publishing	t	1999-11-28 16:00:00-08	\N	\N	\N	2025-02-27 18:13:47.25011-08	2025-02-27 18:13:47.25011-08
391	K2♥: Kill Me Kiss Me	Kill♥Me Kiss Me	K2♥-Kill me Kiss me-	When Tae Yeon Im finds out that the idol star that she's adored for ages is currently attending the same school as her identical cousin, Jung-Woo Im, she convinces her cuz to exploit their similitude and switch places, she will dress as him, attend his school and try to get close to her lover boy. And he will dress as her, attend her school and revel in its sea of babes. Or maybe he just likes wearing a skirt? The plan seems flawless until Tae learns of a bully named Ga-Wun Kim who likes to beat up on poor Jung-Woo. Meanwhile, Jung-Woo finds that being a woman might not be as thrilling as it seems.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/152554l.jpg	6.85	2703	11368	4063	Finished	f	1999-12-31 16:00:00-08	2001-12-31 16:00:00-08	34	5	2025-02-27 18:13:47.335627-08	2025-02-27 18:13:47.335627-08
392	Kimi wa Pet	Tramps Like Us	きみはペット	Fed-up with a life of being under-appreciated and disrespected, Sumire Iwaya decides to change things when she picks up a young boy off the street and brings him into her house. Despite being total opposites, the two seem to complement one another as they try to carve out an ordinary life for themselves.\n\n(Source: TokyoPop)	https://cdn.myanimelist.net/images/manga/3/165611l.jpg	7.94	8452	883	855	Finished	f	2000-05-07 17:00:00-07	2005-10-24 17:00:00-07	82	14	2025-02-27 18:13:47.376345-08	2025-02-27 18:13:47.376345-08
393	Kindaichi Shounen no Jikenbo: File Series	The Kindaichi Case Files	金田一少年の事件簿	Kindaichi (frequently with best-bud, Miyuki) travels to various places where a murder has taken place, typically involving ghosts, curses, myths and folklore of significant events from the distant past, and solves the mystery using ingenious deductions of curious clues and his cool magic.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/84823l.jpg	8.08	2215	617	3082	Finished	f	1992-10-13 17:00:00-07	1997-10-21 17:00:00-07	219	27	2025-02-27 18:13:47.452557-08	2025-02-27 18:13:47.452557-08
394	King of Bandit Jing	Jing: King of Bandits - Twilight Tales	KING OF BANDIT JING	It is said that all that glitters—even the stars—can be stolen away in the blink of an eye by the King of Bandits. Heeded by all, this warning has spread around the world, yet nobody knows who the elusive thief truly is.\n\nJing, an inconspicuous vagabond, and Kir, his winged friend with a foul mouth, are not only on the hunt for rare gems and ancient relics, but also anything that catches the eye and pleases the heart. At first glance, most may overlook the filthy boy in his ragged coat with the bird on his shoulder. But when their cherished possessions are taken away, Jing will also steal their attention, opening their eyes to the true intent of the figure they once blindly thought to fear.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/295652l.jpg	7.51	1024	2898	7021	On Hiatus	f	1998-12-31 16:00:00-08	2005-05-25 17:00:00-07	35	7	2025-02-27 18:13:47.553895-08	2025-02-27 18:13:47.553895-08
395	Ibara no Ou	King of Thorn	いばらの王	Two twins, separated by fatal illness and a selective cure. Kasumi and her sister, Shizuku, were infected with the Medusa virus, which slowly turns the victim to stone. There is no cure, but of the two only Kasumi is selected to go into a sort of cryogenically frozen state along with 159 others until a cure is found. At some point in the undetermined future, Kasumi awakens to find herself and others who were in suspended animation in an unfamiliar world with violent monsters. Resolving to unlock the mysteries of her current situation and the fate of her twin sister, Kasumi struggles to survive in a treacherous world.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/180829l.jpg	7.48	7641	3132	1156	Finished	f	2002-09-11 17:00:00-07	2005-09-11 17:00:00-07	37	6	2025-02-27 18:13:47.652493-08	2025-02-27 18:13:47.652493-08
452	Fushigi no Kuni no Miyuki-chan	Miyuki-chan in Wonderland	不思議の国の美幸ちゃん	In CLAMP's take on the Alice in Wonderland saga, Miyuki finds herself in a world which seems to be populated solely by a series of scantily-clad women interested exclusively in exploring her charms. Needless to say, hi-jinks and misunderstandings ensue as our young heroine attempts to escape their clutches and return to her regular life.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/161931l.jpg	5.99	3287	19743	3640	Finished	f	1993-03-09 16:00:00-08	1995-06-09 17:00:00-07	7	1	2025-02-27 18:13:51.12252-08	2025-02-27 18:13:51.12252-08
396	Kingdom Hearts	Kingdom Hearts	キングダムハーツ	Sora is a young energetic boy looking forward to exploring the world with his friends, Riku and Kairi. The threesome is working hard on completing a raft that will allow them to leave their island but one day a mysterious force causes Sora to gain a special weapon known as the Keyblade. He fights some weird monsters and gets transported to a strange town. Meanwhile, Donald and Goofy leave their castle to search for the king and the chosen one who holds the "key" to saving the world. Sora is attacked again by creatures known as Heartless but is helped out by an old man named Cid and a warrior named Leon. He eventually meets up with Donald and Goofy and they join forces to go search for his friends and the King.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/197189l.jpg	7.33	12543	4468	800	Finished	f	2003-09-30 17:00:00-07	2005-01-30 16:00:00-08	43	4	2025-02-27 18:13:47.719764-08	2025-02-27 18:13:47.719764-08
397	Kingdom Hearts: Chain of Memories	Kingdom Hearts: Chain of Memories	キングダムハーツ チェインオブメモリーズ	The door to Kingdom Hearts was sealed, dealing a blow to the heartless and restoring the worlds to normal, but Riku and King Mickey were trapped inside! Now Sora, Donald, and Goofy's search for their friends leads them to the mysterious Castle Oblivion, where a hooded figure tells them, "Ahead lies something you need, but to claim it, you must lose something dear." What could be more dear than their very memories themselves? And what do the shadowy members of Organization XIII want with them?\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/112415l.jpg	7.43	7278	3519	1588	Finished	f	2005-03-11 16:00:00-08	2006-03-10 16:00:00-08	13	2	2025-02-27 18:13:47.772521-08	2025-02-27 18:13:47.772521-08
398	Kingdom Hearts II	Kingdom Hearts II	キングダムハーツⅡ	In the quiet little hamlet of Twilight Town, there lives a boy named Roxas. He and his friends Hayner, Pence and Olette are trying to enjoy their final days of summer vacation, when strange things begin to happen. First the group is falsely accused of stealing photos from all over town. Then they are attacked by bizarre, white creatures. But the oddest occurrences are the recurring dreams Roxas has of a boy named Sora, and the presence of a girl named Naminé, who has a mysterious secret to share with Roxas.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/153894l.jpg	7.78	6016	1406	1509	Finished	f	2006-05-11 17:00:00-07	2015-08-11 17:00:00-07	69	10	2025-02-27 18:13:47.827775-08	2025-02-27 18:13:47.827775-08
399	Kino no Tabi: The Beautiful World	Kino no Tabi: The Beautiful World	キノの旅 -the Beautiful World-	Destination is a state of mind. A tale of one girl and her bike and the road ahead. Kino wanders around the world on the back of Hermes, her unusual, anthropomorphic motorcycle, only staying in each country for three days. During their adventures, they find happiness, sadness, pain, decadence, violence, beauty, and wisdom. But through it all, they never lose their sense of freedom. They discover that because of the world's imperfections, it is actually a thing of beauty. "The world is not beautiful, therefore it is."\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/4/1146l.jpg	8.58	3264	109	980	Publishing	t	2000-03-09 16:00:00-08	\N	\N	\N	2025-02-27 18:13:47.874049-08	2025-02-27 18:13:47.874049-08
400	Kilala☆Princess	Kilala Princess	Disney's きらら☆プリンセス	Meet Kilala, an ordinary girl who loves all the Disney Princesses. When she awakens a sleeping prince named Rei, she magically gains the power of the princesses! Rei is searching for the missing princess of his world, and has a magical tiara that will lead him to her. But before Kilala can help him find the missing princess and restore peace to his world, Kilala's best friend, Erica, is kidnapped by mysterious men! So, with the help of the magical tiara and Rei, Kilala sets off on a quest to find her!	https://cdn.myanimelist.net/images/manga/3/190870l.jpg	7.22	1180	5848	7792	Finished	f	2004-12-31 16:00:00-08	2006-12-31 16:00:00-08	23	5	2025-02-27 18:13:47.94162-08	2025-02-27 18:13:47.94162-08
401	Kiseijuu	Parasyte	寄生獣	"Parasites" are tennis ball sized creatures, whose numbers and origins are unknown. They invade and take over the human mind in order to survive. Shinichi Izumi is a 16-year-old high school student who lives with his parents in a quiet neighborhood. One night, a Parasite invades Shinichi's body in an attempt to take control of it. However, it fails to complete the takeover process and ultimately ends up inhabiting only his right arm. \n\nThus, both Shinichi and the Parasite—who calls himself Migi—retain their individual minds. Now in a peculiar "human and alien" relationship, Migi proposes that they cooperate to survive. Shinichi has no choice but to agree, and he must now cling to his morality as he and Migi face off against other bloodthirsty Parasites.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/188928l.jpg	8.37	50144	242	137	Finished	f	1989-11-21 16:00:00-08	1995-12-22 16:00:00-08	64	10	2025-02-27 18:13:47.97302-08	2025-02-27 18:13:47.97302-08
402	Kowarehajimeta Tenshi Tachi	Broken Angels	壊れはじめた天使たち	Fujiwara Sunao is a rather unusual young lady. Not only does she prefer to wear her hair short and dress like a boy, but she also possesses the power to control water! One might think Fujiwara would be an odd fit at her school, but strangely, she's not. Between the destructive and demented school president, the kooky and somewhat stalker-like school nurse, and the obsessed underclassman who wants to be her apprentice, Fujiwara may be the sanest person at the school--which is a big help considering she may be asked to save it! \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/271317l.jpg	6.74	358	13064	17243	Finished	f	1998-12-31 16:00:00-08	\N	22	5	2025-02-27 18:13:48.053604-08	2025-02-27 18:13:48.053604-08
403	Kakutou Komusume Juline	Kung-Fu Girl Juline	格闘小娘 JULINE	In a faraway village, in a magical land, live Juline, Bakuya, and Seika, daughters of the top three martial-arts schools. Join them on a quest to uncover the mystery of the Black Pearl, a new clan shrouded in shadows. Juline and the other clan leaders face a new threat in the form of the Black Pearl Guardians. Who are these mysterious warriors, and what is their link to the princesses' past? (Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/167712l.jpg	6.40	248	17559	20983	Finished	f	1996-12-31 16:00:00-08	1997-12-31 16:00:00-08	20	5	2025-02-27 18:13:48.091731-08	2025-02-27 18:13:48.091731-08
405	Hitsuji no Uta	Lament of the Lamb	羊のうた	The members of the Takashiro family share a terrible curse: only human blood can quench their thirst. Sent away after the death of his mother, Kuzuna Takashiro remained blissfully unaware of his 'condition.' When Kazuna's teenage hormones begin to rage, his uncontrollable bloodlust suddenly rears its head...\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/173240l.jpg	7.12	3173	7125	2112	Finished	f	1995-11-24 16:00:00-08	2002-09-29 17:00:00-07	47	7	2025-02-27 18:13:48.121967-08	2025-02-27 18:13:48.121967-08
406	Cossette no Shouzou	Le Portrait de Petit Cossette	コゼットの肖像	Eiri Kurahashi is an art school student, with a job at a local antique store. It's there that he develops a strange obsession. He finds himself entranced by a portrait of a Victorian-era girl named Cossette. It's a portrait with a strange history--everyone who has owned it has been murdered in a bizarre fashion. But the story runs much deeper than that. Cossette was savagely murdered by her lover, who also happens to be the artist who painted the portrait. When the new owner of the portrait nearly kills himself, Eiri decides to get involved. And that's when Cossette begins speaking to him...\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/251870l.jpg	6.91	1941	10290	4135	Finished	f	2003-12-31 16:00:00-08	\N	9	2	2025-02-27 18:13:48.166491-08	2025-02-27 18:13:48.166491-08
407	Life	Life	ライフ	Ayumu Shiiba has always struggled when it comes to her grades but decides to study even harder so that she can go to Nishidate High School with her best friend, Yuuko Shinozuka. When the results of the entrance exams came out, it turns out that Ayumu herself passed, but unfortunately, Shinozuka did not. Consequently, Shinozuka reveals everything she had felt about Ayumu—nothing but resentment.\n\nDepressed that her closest friend has now deserted her, Ayumu finds a way to make her temporarily forget the loneliness: self-injury. As a result, she chooses to be alone and quickly becomes an outcast at her new school, refusing to socialize with anyone. Yet when her classmate Manami Anzai suddenly befriends her, Ayumu's world seems to brighten—but little does she know that something more horrible would start coming her way.\n\nLife is the story of a certain girl's isolation, a tale filled with despair and persecution enough to bring any person to the brink of insanity. However, only the strongest will find the light at the end of the tunnel, no matter how impossible the odds may seem.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/127497l.jpg	7.97	6149	819	1043	Finished	f	2002-04-12 17:00:00-07	2009-02-12 16:00:00-08	80	20	2025-02-27 18:13:48.237926-08	2025-02-27 18:13:48.237926-08
408	Kidou Senshi Gundam SEED Destiny	Mobile Suit Gundam SEED Destiny	機動戦士ガンダム SEED Destiny	C.E. 71: After the terrible battle of Yakin Due, an uneasy peace rests between the Earth Alliance and the Zaft Empire. But even as Cagalli and Athrun visit Chairman Durandal to cement the tentative cease-fire, Zaft terrorists plot with Neo Roanoke to drag both sides into all-out war. The plan: storm Zaft territory and steal several Gundam Mobile Suits. But that’s only the beginning. They’re also scheming to engineer a catastrophic event, one designed to drive the Earth down a bloody path. Now the crew of the Minerva must prevent disaster, as everything and everyone–including the love between Athrun and Cagalli–is thrown in mortal danger.\n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/3/300562l.jpg	6.82	424	11759	15846	Finished	f	2004-11-25 16:00:00-08	2006-04-25 17:00:00-07	17	4	2025-02-27 18:13:48.300425-08	2025-02-27 18:13:48.300425-08
409	Guruguru Pon-chan	Guru Guru Pon-chan	ぐるぐるポンちゃん	Ponta is a Labrador retriever puppy, the Koizumi family's pet. She's full of energy and usually up to some kind of mischief. But when Grandpa Koizumi, an amateur inventor, creates the Guruguru Bone, Ponta's curiosity causes trouble. She nibbles the bone... and turns into a human girl!\n\nSurprised but undaunted, Ponta ventures out of the house and meets Mirai Iwaki, the most popular boy at school. When Mirai saves her from a speeding car, Ponta changes back into her puppy self. Yet much has changed for Ponta during her short adventure as a human. Her heart races and her face flushes when she thinks of Mirai now. She's in love! Using the power of the Guruguru Bone, Ponta switches back and forth from dog to girl... but can she win Mirai's affections?\n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/3/286565l.jpg	7.03	1073	8447	8609	Finished	f	1996-12-31 16:00:00-08	1999-12-31 16:00:00-08	37	9	2025-02-27 18:13:48.371499-08	2025-02-27 18:13:48.371499-08
410	Kagetora	Kagetora	カゲトラ	The young ninja Kagetora has been given a great honor—to serve a renowned family of skilled martial artists. But on arrival, he's handed a challenging assignment: teach the heir to the dynasty, the charming but clumsy Yuki, the deft moves of self-defense and combat.\n\nAnd yet, Yuki's inability to master the martial arts is not what makes this job so difficult for Kagetora. No, it's Yuki herself. Someday she will inherit her family dojo, and for a ninja like Kagetora, to fall in love with his master is a betrayal of his duty, the ultimate dishonor, and strictly forbidden. Can Kagetora help Yuki overcome her ungainly nature . . . or will he be overcome by his growing feelings?\n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/5/199436l.jpg	7.47	2153	3152	4589	Finished	f	2001-11-19 16:00:00-08	2006-09-19 17:00:00-07	56	11	2025-02-27 18:13:48.452503-08	2025-02-27 18:13:48.452503-08
411	Kitchen no Ohimesama	Kitchen Princess	キッチンのお姫さま	Najika Kazami is a girl who is passionate about food, whether it comes to eating or cooking. She treasures the place she calls home, an orphanage in Hokkaido called Lavender House, as well as its owner, Hagio. But as much as Hagio and the fellow orphans love her, Najika decides to leave the orphanage to attend a special academy in Tokyo, hoping to achieve her dreams of being a pastry chef.\n\nHowever, Najika has another reason for leaving for the academy. She hopes to find the boy she calls the "Flan Prince"—a boy who touched her heart with a cup of flan seven years ago. Now 13 years old, Najika finds that the spoon that he left behind with the flan shares its emblem with the school she has been accepted to—the prestigious Seika Academy.\n\nWith high hopes, Najika enters her school's beautiful campus and becomes a first-year student in Seika's junior high division. While unpopular with her fellow classmates due to her love of eating, she seems to find support from two boys who recognize her culinary talents—the popular brothers Daichi and Sora Kitazawa. Will Najika be able to find her place in the academy with her cooking, and perhaps also reunite with her Flan Prince?\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/5/112513l.jpg	7.90	12741	985	770	Finished	f	2004-08-02 17:00:00-07	2008-09-02 17:00:00-07	53	10	2025-02-27 18:13:48.516948-08	2025-02-27 18:13:48.516948-08
412	Koibumi Biyori	A Perfect Day for Love Letters	恋文日和	Every letter the mailman delivers brings a new chance at love. With wit, humor, and mystery George Asakura leads us through a series of brief tales of affection, rejection, miscommunication, and connection that are sure to charm the romantic inside you.\n\n(Source: Del Rey)\n\nIncluded one-shot:\nVolume 2: Natsu no Awa	https://cdn.myanimelist.net/images/manga/1/187563l.jpg	7.11	272	7285	19352	Finished	f	1999-12-31 16:00:00-08	2003-12-31 16:00:00-08	12	3	2025-02-27 18:13:48.600677-08	2025-02-27 18:13:48.600677-08
413	Love Roma	Love Roma	ラブロマ	Negishi, a self-proclaimed normal high school girl, is suddenly confessed to by a boy whom she has never met before. Introducing himself as a long time admirer that had finally found the resolve to confess his feelings, Hoshino declares that everything will work out between the two as long as he remains unabashedly honest with her. After denying Hoshino's sudden request for a date, Negishi, bewildered but intrigued with Hoshino's candidness, agrees to walk home with him.\n\nThus begins the romantic comedy Love Roma, which follows the progressing relationship between Hoshino, who says whatever is on his mind with absolutely no reserve, and Negishi, playing the straight man to the boy's comic persistence of his feelings toward her.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/138067l.jpg	7.51	1990	2899	3942	Finished	f	2001-12-31 16:00:00-08	2004-12-31 16:00:00-08	32	5	2025-02-27 18:13:48.670518-08	2025-02-27 18:13:48.670518-08
422	Yamato Nadeshiko Shichihenge♥	The Wallflower: Yamatonadeshiko Shichihenge	ヤマトナデシコ七変化♥	It's a gorgeous, spacious mansion, and four handsome, fifteen-year-old friends are allowed to live in it for free! There's only one condition—that within three years the guys must transform the owner's wallflower niece into a lady befitting the palace in which they all live! How hard can it be?\n\nEnter Sunako Nakahara, the agoraphobic, horror-movie-loving, pockmark-faced, frizzy-haired, fashion-illiterate recluse who tends to break into explosive nosebleeds whenever she sees anyone attractive. This project is going to take more than our four heroes ever expected: it needs a miracle!\n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/2/173084l.jpg	7.95	11118	862	679	Finished	f	2000-03-12 16:00:00-08	2015-01-12 16:00:00-08	148	36	2025-02-27 18:13:49.147934-08	2025-02-27 18:13:49.147934-08
414	Mamotte! Lollipop	Mamotte! Lollipop	まもって! ロリポップ	Nina Yamada wishes to fall in love with a cute boy who will protect her no matter what. In the midst of complaining to her friends, two attractive boys fall out of the sky right in front of her. They introduce themselves as Zero and Ichii—two candidates who are taking a magical exam to become professional wizards. As part of the test, the duo is tasked with finding the "Crystal Pearl" and protecting it for six months from the other applicants. After the examination period, the pair that possess the pearl will automatically become full-fledged wizards.\n\nWhen the two discover that Nina had accidentally mistaken it for candy and swallowed it, the boys have no choice but to act as her full-time bodyguards for the rest of the exam until an antidote to remove the pearl can be created. Safeguarding a human from their crazy wizard candidate foes is a lot more challenging and exhausting than Zero and Ichii realize. Will they be able to pass the exam while protecting Nina's life?\n\n[Written by MAL Rewrite]\n\nIncluded one-shots:\nVolume 1: Medical Magical\nVolume 2: Kaitou Papillon	https://cdn.myanimelist.net/images/manga/2/11448l.jpg	7.27	2952	5225	3556	Finished	f	2002-10-31 16:00:00-08	2005-07-31 17:00:00-07	32	7	2025-02-27 18:13:48.744785-08	2025-02-27 18:13:48.744785-08
416	Sidooh	\N	SIDOOH―士道―	During the political upheavals and social strife at the end of the Tokugawa Shogunate in Japan (1855), two parent-less brothers — Yukimura Shoutarou and Yukimura Gentarou — struggle to survive in these turbulent times. The brothers' only possession is their deceased father's sword and they cling onto the wisdom of their mother's final words as they seek to embark on the Path of the Warrior: Sidooh.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/1/263863l.jpg	7.54	2799	2697	1498	Finished	f	2005-01-05 16:00:00-08	2010-10-27 17:00:00-07	267	25	2025-02-27 18:13:48.780909-08	2025-02-27 18:13:48.780909-08
417	Modotte! Mamotte! Lollipop	\N	もどって！ まもって！ ロリポップ	Nina, Zero, and Ichii are back! This time for the Advanced Magic test! The object of the test is-yet again-a crystal drop that looks like candy! When Nina accidentally swallows it (again!), it's up to Zero and Ichii to protect her until it comes out. The only trouble is, all the past participants are back, and only little fragments of the crystal drop will come out of Nina at a time! (Source: Baka Updates)\n\nOther Stories in the series.\nVol 1: Milcute Vs Lollipop\nVol 4: Sidestory\nVol 6: Minus 0	https://cdn.myanimelist.net/images/manga/3/1318l.jpg	7.43	1195	3548	8227	Finished	f	2005-12-31 16:00:00-08	2007-12-31 16:00:00-08	22	6	2025-02-27 18:13:48.812674-08	2025-02-27 18:13:48.812674-08
418	Mushishi	Mushishi	蟲師	Mushi: the most basic forms of life in the world. They exist without any goals or purposes aside from simply "being." They are beyond the shackles of the words good and evil. Mushi can exist in countless forms and are capable of mimicking things from the natural world such as plants, diseases, and even phenomena like rainbows.\n\nThis is, however, just a vague definition of these entities that inhabit the vibrant world, as to even call them a form of life would be an oversimplification. Detailed information on mushi is scarce because the majority of humans are unaware of their existence. So what are mushi and why do they exist? This is the question that a Mushishi, Ginko, ponders constantly. Mushishi are those who research mushi in hopes of understanding their place in the world's hierarchy of life.\n\nGinko relentlessly chases rumors of occurrences that could be tied to mushi, all for the sake of finding an answer. It could, after all, lead to the meaning of life itself.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/159514l.jpg	8.70	20707	61	179	Finished	f	1999-10-07 17:00:00-07	2008-08-24 17:00:00-07	50	10	2025-02-27 18:13:48.845423-08	2025-02-27 18:13:48.845423-08
419	Nodame Cantabile	Nodame Cantabile	のだめカンタービレ	Shinichi Chiaki, the perfectionist son of a famous pianist, is in his fourth year at Momogaoka College of Music, hoping to achieve his secret dream of being a conductor. His admiration for his father led him to pursue a career in music. As much as he wants to return to Europe, his phobia of flying traps him in Japan where he now lives.\n\nOne night, he passes out, and ends up being taken in by Megumi "Nodame" Noda. Upon first glance, Nodame is a talented pianist, but she is also slobbish and eccentric. What's even worse is that she is his neighbor and he ends up forced to work with her. Though it sounds like a recipe for disaster, Chiaki is drawn to this girl who makes him remember the love for music he once held. Just what does the future hold for this musical duo?\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/153962l.jpg	8.40	9798	219	668	Finished	f	2001-07-09 17:00:00-07	2010-08-24 17:00:00-07	150	25	2025-02-27 18:13:48.932008-08	2025-02-27 18:13:48.932008-08
420	Othello.	Othello	オセロ。	Yaya Higuchi is a fan of visual kei musicians and gothic lolita fashion. As a child, her dream was to grow up and become a great singer. However, she now hides her passion six days a week, afraid that she will be ridiculed by her peers or her overly strict father. Only on Sundays can she freely express herself among like-minded teens in Harajuku.\n\nEven without disclosing her secret hobbies, Yaya is treated poorly by Seri and Moe, two mean girls who she calls friends. As hard as she tries to remain optimistic, Yaya is painfully aware that no one at school speaks to her besides her bullies and an almost offensively straightforward male classmate named Moriyama.\n\nWhen a fierce, no-nonsense girl named Nana starts taking care of Yaya's troubles—paying back Seri and Moe for their cruel pranks and kicking down predatory men who approach Yaya in the street—it seems too good to be true. Moriyama encounters Nana more than once, and as he sees Yaya in class every day, he gradually begins to suspect that these two vastly different girls are the same person!\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/250803l.jpg	7.55	3687	2640	2891	Finished	f	2001-08-07 17:00:00-07	2004-09-12 17:00:00-07	28	7	2025-02-27 18:13:49.018768-08	2025-02-27 18:13:49.018768-08
421	Pastel	Pastel	ぱすてる	Poor Mugi Tadano... The sixteen-year-old is heartbroken after his girlfriend moves away. To ease his troubled state, Mugi takes a summer job at his friend Kazuki's beach-side snack bar/hotel on a tropical island. It seems like the perfect plan-until Kazuki sets Mugi up on a date with Yuu, who's supposed to be, well, a little less than perfect. When Yuu arrives, however, she's not the monster that either of the boys had imagined. In fact, Yuu is about the cutest person that Mugi has ever seen. But after Mugi accidentally walks in on Yuu in the bath, the girl is steamed. When trying to apologize the next day, he discovers that Yuu has left the shores of paradise. Mugi vows to search high and low for the beautiful Yuu, but will he ever see her again?\n\n(Source: Del Rey)\n\nIncluded one-shots:\nVolume 11: Candy Girl ni Hanataba wo.\nVolume 13: Apricot Girl\nVolume 24: Happy Ice Cream\nVolume 34: Otoko wa Sore wo Gaman Dekinai!!\nVolume 42: Weapon!!!	https://cdn.myanimelist.net/images/manga/1/188952l.jpg	7.47	5191	3153	1394	Finished	f	2002-07-09 17:00:00-07	2017-01-19 16:00:00-08	219	44	2025-02-27 18:13:49.063393-08	2025-02-27 18:13:49.063393-08
432	Y十M: Yagyuu Ninpouchou	The Yagyu Ninja Scrolls: Revenge of the Hori Clan	Y十M 〜柳生忍法帖〜	Vow of Vengeance. Seventeenth-century Japan: A rebellion in the Aizu teritory has been brutally crushed, leaving twenty one brave warriors dead and most of the nuns of the local convent slaughtered. Now the surviving nuns have sworn to seek revenge. They turn to the greatest swordsman of the land to train them so they can kill the ones who slew the men and the other nuns.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/3/157496l.jpg	7.22	823	5832	8411	Finished	f	2005-10-31 16:00:00-08	2007-06-30 17:00:00-07	100	11	2025-02-27 18:13:49.817753-08	2025-02-27 18:13:49.817753-08
423	Pichi Pichi Pitch: Mermaid Melody	Mermaid Melody Pichi Pichi Pitch	ぴちぴちピッチ―マーメイドメロディー	Lucia is the new girl at school. She and her sister run a public bath that's all the rage. When Lucia meets a terrific-looking surfer boy, there's just one little problem: Lucia is a mermaid-not just any mermaid, but a princess on an important mission to save the seven seas from an evil force bent on taking control of the marine world. Such a responsibility doesn't leave much time for romance. But Lucia vows to protect her world and win the heart of handsome Kaito. \n\n(Source: Del Rey)\n\nIncluded one-shots:\nVolume 7: Moonlight Goddess Diana, Get Nude, Cherry Blossom	https://cdn.myanimelist.net/images/manga/3/7128l.jpg	6.94	4749	9898	2171	Finished	f	2002-08-31 17:00:00-07	2005-03-31 16:00:00-08	35	7	2025-02-27 18:13:49.199181-08	2025-02-27 18:13:49.199181-08
424	Kaibutsu Oujo	Princess Resurrection	怪物王女	Werewolves, demons, monsters, vampires. All these ferocious creatures are afraid of the same thing: the beautiful Princess Hime, an awesome warrior who fights off the forces off evil with a chainsaw and a smile. Not only does she look great in a tiara, she has magical powers that allow her to raise the dead. She's a girl on a mission, and with the help of her undead servant and a supercute robot, there's no creature of darkness she can't take down!\n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/1/163097l.jpg	7.46	5733	3237	1331	Finished	f	2005-06-24 17:00:00-07	2013-02-25 16:00:00-08	87	20	2025-02-27 18:13:49.262181-08	2025-02-27 18:13:49.262181-08
425	Psycho Busters	Psycho Busters	サイコバスターズ	Out of the blue, a beautiful girl asks Kakeru to run away with her. It turns out that the girl is on the run from a shadowy government organization intent on using her psychic abilities for its own nefarious ends. But why does she need Kakeru’s help? Could it be that he has secret powers, too?\n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/3/3362l.jpg	7.36	3517	4207	2626	Finished	f	2006-02-19 16:00:00-08	2008-09-19 17:00:00-07	32	7	2025-02-27 18:13:49.363556-08	2025-02-27 18:13:49.363556-08
426	Pumpkin Scissors	Pumpkin Scissors	パンプキン シザーズ	Three years ago, an abrupt ceasefire ended a long and devastating conflict between the Republic of Frost and the Empire, bringing about peace and sending both nations on the arduous journey of recovery. In the battle-scarred Empire, sickness and starvation ravage the lands, and many former soldiers turn to crime, adding to a common man's misery. To combat this, the Empire has established Imperial Army State Section III, known as Pumpkin Scissors—a platoon dedicated to war relief and reconstruction.\n\nAlthough the young and energetic Second Lieutenant Alice L. Malvin honorably leads Pumpkin Scissors, the unit is seen as nothing more than a shameless propaganda tool used only to placate the masses. As Alice strives to further her unit's cause and win the favor of the populace, she decides to recruit Randal Oland, a mysterious and kind veteran with a grim past.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/55387l.jpg	7.66	1238	1933	4163	Publishing	t	2001-12-31 16:00:00-08	\N	\N	\N	2025-02-27 18:13:49.479997-08	2025-02-27 18:13:49.479997-08
427	Qko-chan	Q.ko-chan the Earth Invader Girl	QコちゃんTHE地球侵略少女	In the near-future on planet Earth, a world gone mad where never-ending war is a fact of life, Kirio is the coolest kid at school. Up in the sky, a giant robot is fighting a fleet of gunships, but the brilliant and distant Kirio is far from fazed—until the battling 'bot makes an unexpected landing in Kirio's front yard and rings the bell. But the worst threat for Kirio could be what stands on the other side of the door: an alien invader robot with the face of an adorable girl! \n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/2/723l.jpg	6.37	935	17846	7202	Finished	f	2002-12-31 16:00:00-08	2003-12-31 16:00:00-08	19	2	2025-02-27 18:13:49.518645-08	2025-02-27 18:13:49.518645-08
428	Shiki Tsukai	Shiki Tsukai	四季使い	On the day he turns fourteen, Akira discovers his destiny: He’s a shiki tsukai, a warrior with the magical power to control the seasons. He also meets the beautiful Koyomi, another warrior, who is sworn to protect him. For there are evil forces intent on destroying Akira–and the entire universe! \n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/3/53445l.jpg	6.90	292	10490	13302	Finished	f	2005-07-25 17:00:00-07	2011-09-25 17:00:00-07	\N	13	2025-02-27 18:13:49.552803-08	2025-02-27 18:13:49.552803-08
429	Sugar Sugar Rune	Sugar Sugar Rune	シュガシュガルーン	The queen of the Magical World is selected through a competition in which two young witches travel to the Human World to gather the hearts of boys who fall in love with them. This time, best friends Chocolat Meilleure and Vanilla Mieux, the daughters of the previous queen candidates, enroll in a human school in order to commence the challenge. Aided by their familiar spirits and mentor Rockin Robin, the young witches learn to adjust to human life as each aims to become the next queen.\n\nChocolat, who is popular with boys in the Magical World, finds that her strategies do not work well for capturing human hearts. In contrast, Vanilla's quiet and shy personality seems to make her the center of attraction. To make matters more complicated, a mysterious boy by the name of Pierre Tempête de Neige seems to be after Chocolat's heart. The two witches' friendship is put to the test as the competition intensifies.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/263709l.jpg	7.60	5452	2320	1753	Finished	f	2003-08-01 17:00:00-07	2007-04-02 17:00:00-07	46	8	2025-02-27 18:13:49.591284-08	2025-02-27 18:13:49.591284-08
430	Suzuka	Suzuka	涼風	Easygoing and energetic Yamato Akitsuki is ready to start his high school life in Tokyo. Having been invited by his aunt to stay rent-free at her housing complex, he unhesitatingly accepts her offer. But unbeknownst to him, the boarding house is actually an all-girls dormitory.\n\nUpon visiting his new school, Yamato catches sight of a girl training for the high jump. Amazed by her athletic ability and beauty, he yearns to learn more about her. To his fortune, this girl, Suzuka Asahina, lives right next door to him—but all of their encounters thus far has given Suzuka a bad impression of him. In spite of the constant misunderstandings, Yamato still joins the track team with the intent of impressing her and soon discovers he has the potential to become a top hundred-meter sprinter. With friendship, and possibly love on the line, Yamato trains his heart out in order to win over the girl he loves.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/184775l.jpg	7.85	24633	1149	342	Finished	f	2004-02-17 16:00:00-08	2007-09-18 17:00:00-07	171	18	2025-02-27 18:13:49.680501-08	2025-02-27 18:13:49.680501-08
431	Densha Otoko: Bijo to Junjou Otaku Seinen no Net-Hatsu Love Story	Train Man: A Shojo Manga	電車男―美女と純情ヲタク青年のネット発ラブストーリー	Geeky fanboy Ikumi Saiki has a dream that someday, somehow, he'll finally get a girlfriend. Then one day, on the train home, he rescues a beautiful girl from a troublesome drunk. Now the girl sees the hero inside the otaku—and it appears that Ikumi will finally find romance! But though Ikumi found the courage to save her, will he ever be brave enough to win her heart? Desparate, Ikumi posts an urgent plea on an Internet message board: "Help me with the girl of my dreams!" Ikumi's story ignites the whole online world. Everyone is ready to help Ikumi prove that even an otaku can find true love!\n\n(Source: Del Rey)	https://cdn.myanimelist.net/images/manga/3/167594l.jpg	7.44	363	3439	15894	Finished	f	2005-06-12 17:00:00-07	\N	5	1	2025-02-27 18:13:49.786239-08	2025-02-27 18:13:49.786239-08
433	Lights Out	Lights Out	어쩐지 좋은 일이 생길 것 같은 저녁	All Gun wanted to do was turn over a new leaf. A problem child since birth, Gun thought transferring to Northern Art High School and moving into the Lucky Residence would offer him a fresh start--a chance to begin again, away from his punch-drunk past.\n\nHe really should have known better. Whether it's having his attempts at romance with the lovely Seung-Ah thwarted time and time again by the lusty Ji-Ae, putting up with deliveryman Sung-Rae's dreams of heavy metal stardom, or dealing with Northern Art's gangs, Gun is going to have a very hard time shaking off his past. However, it's something he must do if he's to look towards the future, and Gun's future is a bright one indeed.\n\nFor on the hard asphalt surface of a bike track, Gun will finally lose his apathy and find himself. On the back of a motorcycle, Gun's life finally has purpose, and it's a purpose that will not be fulfilled, at least in Gun's eyes, until he's taken the checkered flag in the Korean Grand Prix.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/1/4999l.jpg	\N	\N	20439	28166	Finished	f	1991-12-31 16:00:00-08	\N	\N	9	2025-02-27 18:13:49.85438-08	2025-02-27 18:13:49.85438-08
434	Liling-Po	Liling-Po	リリン-ポ	Liling-Po, a master thief, has finally been captured by the government. But in order to be set free, Liling-Po must do one thing: Retrieve these eight magical, yet mysterious treasures that had been recently stolen from the government. So now, he must go on a journey with two other officials, Mei-Toku and Bu-cho, and find the Eight Great Treasures.\n\n(Source: ANN)	https://cdn.myanimelist.net/images/manga/2/11011l.jpg	6.52	134	16247	27722	Finished	f	1995-12-31 16:00:00-08	1998-12-31 16:00:00-08	51	9	2025-02-27 18:13:49.898748-08	2025-02-27 18:13:49.898748-08
435	Love or Money	Love or Money	콩깍지	Yenni is a feisty and cute 15-year-old girl who is so obsessed with money that she runs a profitable loan sharking business at her school! Her wealthy grandmother is shocked at Yenni's behavior, and decides to change the financial arrangements for the money she's leaving to her granddaughter in her will: Yenni will only inherit her grandmother's hefty fortune if she ceases the loan-sharking business ... and if she marries an honest man!\nIf she fails, her grandmother's fortune will be given to her friend's grandson, so the pressure is on for Yenni to give up her usurious ways...\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/12894l.jpg	\N	\N	20438	30998	Finished	f	2003-12-31 16:00:00-08	\N	\N	5	2025-02-27 18:13:49.952321-08	2025-02-27 18:13:49.952321-08
436	Uzumaki	Uzumaki: Spiral into Horror	うずまき	In the town of Kurouzu-cho, Kirie Goshima lives a fairly normal life with her family. As she walks to the train station one day to meet her boyfriend, Shuuichi Saito, she sees his father staring at a snail shell in an alley. Thinking nothing of it, she mentions the incident to Shuuichi, who says that his father has been acting weird lately. Shuuichi reveals his rising desire to leave the town with Kirie, saying that the town is infected with spirals.\n\nBut his father's obsession with the shape soon proves deadly, beginning a chain of horrific and unexplainable events that causes the residents of Kurouzu-cho to spiral into madness.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/185972l.jpg	8.16	135321	486	32	Finished	f	1998-01-11 16:00:00-08	1999-08-29 17:00:00-07	19	3	2025-02-27 18:13:49.968531-08	2025-02-27 18:13:49.968531-08
437	Dream Gold: Knights in the Dark City	Dream Gold	ドリムゴード〜Knights in the Dark City〜	In a world where technology and magic fuel the dream for riches, the Knights of the Dark City are sent out to find the hidden treasures that the world craves. Kurorat Jio Clocks, the clever rat of Higurashi Street, will join the Knights in their frantic hunt for wealth, and for the ultimate prize - Dream Gold. All who search for treasure search for Dream Gold, but this quest will yield one winner...\n\n(Source: ADV)	https://cdn.myanimelist.net/images/manga/2/121189l.jpg	\N	\N	20441	35143	Finished	f	2002-11-29 16:00:00-08	2005-08-29 17:00:00-07	30	5	2025-02-27 18:13:50.030891-08	2025-02-27 18:13:50.030891-08
438	Lupin III	Lupin the 3rd	ルパン三世	International man of mystery and master thief extraordinaire, Lupin III comes from a long line of high stakes bandits, all committed to stealing from the rich and giving to themselves. Fortunately, Lupin tends to avoid robbing society's virtuous and, instead, targets some pretty shady characters.\n\nOf course, he partners with some pretty shady characters as well: Daisuke Jigen is an ex-mafia hitman who carries himself with a somber demeanor, his trademark black fedora tilted forward to hide his eyes. Goemon Ishikawa is a cipher-like swordsman with samurai-ish overtones who mysteriously fades in and out of Lupin's exploits. Fujiko Mine is the object of Lupin's affections, but, since she is a thief herself, the duo's romance more than occasionally clashes with their competition for big scores.\n\nThe global police force, Interpol, and in particular the tenacious Inspector Zenigata, long to capture Lupin and his gang. Zenigata's relationship with the eponymous master thief is a complicated one, characterized by mutual respect laced with utter disdain. The two have even worked together when it's served both their interests, but they understand that when the crisis ends, they must resume their former wariness and animosity toward each other.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/4/261098l.jpg	7.31	1205	4705	4295	Finished	f	1967-07-06 17:00:00-07	1972-03-31 16:00:00-08	109	14	2025-02-27 18:13:50.104888-08	2025-02-27 18:13:50.104888-08
439	Magical x Miracle	Magical x Miracle	Magical×Miracle	Merleawe has left her hometown and moved to the capital city of Viegald to attend wizard school. On her way to her first day of school, she bumps into a man who kidnaps her and takes her to the castle, where she is charged with an awesome task—impersonating the kingdom's master wizard! Fearing war would break out if it was known the master wizard, Slythfarn, was missing, Slythfarn's inner circle has decided someone must pretend to be him. Merleawe tells them that she will take the job!\n\nBut not only does she lack the ability to cast more than simple magic, she also has no idea who the master wizard was! Unraveling the twisted threads of Sylthfarn's disappearance and keeping up the appearances of both master wizard and first year wizard student makes Merleawe's every day challenging, magical and amazing!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/172711l.jpg	7.71	1640	1673	5759	Finished	f	2002-03-27 16:00:00-08	2006-01-27 16:00:00-08	46	6	2025-02-27 18:13:50.202117-08	2025-02-27 18:13:50.202117-08
440	Mahoutsukai ni Taisetsu na Koto	Someday's Dreamers	魔法遣いに大切なこと	Yume innocently uses her magic to help the people she encounters—soccer players, the wrongly incarcerated, or two young lovers wanting to see the moon on a cloudy night. And you can bet that Yume's magic leads to new adventures—and a few mishaps!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/175873l.jpg	7.02	1345	8631	6500	Finished	f	2002-05-08 17:00:00-07	2003-01-08 16:00:00-08	9	2	2025-02-27 18:13:50.267678-08	2025-02-27 18:13:50.267678-08
450	Missile Happy!	Missile Happy!	ミサイル ハッピー！	Mikako, our over-zealous heroine, has a sister-complex so strong she won't let just any man wed her sister. On an undercover investigation to learn more about the newest bachelor, she ends up moving in with him! Plus the guy is a highschool kid just like her! Mikako's relationship with him starts to grow. What'll happen between Mikako and him?!\n\n(Source: Tokyopop)\n\nVolume 4 contains the one-shot "Smiling Revolution", the mangaka's debut story.	https://cdn.myanimelist.net/images/manga/1/270466l.jpg	7.34	1186	4368	7853	Finished	f	1999-12-31 16:00:00-08	\N	20	5	2025-02-27 18:13:50.954056-08	2025-02-27 18:13:50.954056-08
441	Mai-HiME	My-HiME	舞-HiME	Yuuichi Tate is overjoyed: He gets to go to a brand new high school. Of course, then he just happens to find out the school he choose is under frequent attack by strange creatures called ''Orphans'', and the school set up a special task force of female members called ''HiME''s, using various elements as their powers, to battle these invaders. That's not all, though. Each member of the HiME task force has their own, unique ''Key'', another person whom, upon being discovered, can team up with the HiME to create a ''Child'', a combative unit specifically needed to effectively battle these Orphans. And with Yuuichi's luck, he just happens to find out he's not just the ''Key'' for one of the HiMEs, but for two... Two highly competitive, rival schoolgirls. And that's only the start of the trouble. \n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/178058l.jpg	6.83	3566	11597	3065	Finished	f	2004-11-10 16:00:00-08	2005-07-06 17:00:00-07	44	5	2025-02-27 18:13:50.333853-08	2025-02-27 18:13:50.333853-08
442	Tekkon Kinkreet	Tekkonkinkreet: Black & White	鉄コン筋クリート	Orphaned on the mean streets of Treasure Town, lost boys Black and White must mug, steal and fight to survive. Around them moves a world of corruption and loneliness, small-time crooks and neurotic police officers, and a band of sadistic yakuza who have plans for their once-fair city. Can they rise above their environment? Surreal manga influenced by European comics.	https://cdn.myanimelist.net/images/manga/2/151420l.jpg	8.02	4538	724	1253	Finished	f	1992-12-31 16:00:00-08	1993-12-31 16:00:00-08	33	3	2025-02-27 18:13:50.426174-08	2025-02-27 18:13:50.426174-08
443	Mars	Mars	MARS	Timid 16-year-old Kira Asou prefers to be alone drawing than stand out. At a park, she is approached by her schoolmate Rei Kashino—notorious for being a womanizer—who asks for directions. Distrustful of Rei's intentions, Kira quickly chalks a map for him and runs away. Little does she know that Rei finds one of her sketches on the back of the map and becomes captivated by her artistic skills.\n\nMuch to Kira's chagrin, Rei immediately recognizes her at school, but she ignores his attempts at striking up a conversation. However, Rei's sincere praise about her drawing leads Kira to see the violent rebel in a better light. After watching him kiss a statue of the god Mars, Kira feels so moved that she instantly requests him to model for her.\n\nAs Kira and Rei's chance encounter begins to develop into a flourishing relationship, what is to become of these two polar personalities?\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/191262l.jpg	8.31	15803	301	508	Finished	f	1996-01-12 16:00:00-08	2000-11-12 16:00:00-08	59	15	2025-02-27 18:13:50.458747-08	2025-02-27 18:13:50.458747-08
444	Bad Company	\N	BAD COMPANY	Before Eikichi Onizuka became a legend, before Onibaku, before he became GTO, he was just a normal junior high school delinquent. Getting into fights with his seniors, trying to pick up girls and just hanging out with his friends. Bad Company is a compilation of many short stories, linked together with the characters of Eikichi, Ryuji and their school buds. Such stories involve the origins of Eikichi`s bike, which we see frequently in GTO, the first meeting with the Midnight Angel and many other.	https://cdn.myanimelist.net/images/manga/3/18566l.jpg	7.47	7778	3154	1302	Finished	f	1996-06-11 17:00:00-07	1996-07-16 17:00:00-07	10	1	2025-02-27 18:13:50.507358-08	2025-02-27 18:13:50.507358-08
445	Shonan Junai Gumi!	GTO: The Early Years	湘南純愛組！	Eikichi Onizuka and Ryuuji Danma are members of infamous biker gang, Oni Baku. When not out riding around, they can be found in school, trying to pick up young women. This is the story of the young Onizuka, who would later become the greatest teacher in Japan.\n\n(Source: ANN)	https://cdn.myanimelist.net/images/manga/2/216051l.jpg	8.23	7729	394	841	Finished	f	1990-09-25 17:00:00-07	1996-09-17 17:00:00-07	267	31	2025-02-27 18:13:50.572597-08	2025-02-27 18:13:50.572597-08
446	Aa! Megami-sama!	Oh! My Goddess	ああっ女神さまっ	Alone in his dorm room one Saturday night (a frequent occurrence, to be honest), young Keiichi Morisato accidentally dials a wrong number that will literally change his life. You see, he inadvertently reaches the Goddess Technical Help Line, and a goddess is dispatched to grant him one wish.\n\nThe lovely young Belldandy informs him that he may have one wish - a wish for virtually anything in the world. In disbelief, Keiichi opts for a wish he believes will confound the system (and will prove that Belldandy has no particular wish-granting power): he wishes that Belldandy would stay with him always.\n\nThe power of this wish almost rips the fabric of time and space but it is ultimately granted. But of course such a wish has unforseen consequences, including the fact that Keiichi lives in a guys-only dorm. When his roommates return to find him with a woman on the premises, he is immediately tossed out on to the street. But the wish also has other unexpected side effects - such as when Keiichi and Belldandy are in peril of being separated, a motorcycle is suddenly repaired so that they can travel together.\n\n(Source: Dark Horse)	https://cdn.myanimelist.net/images/manga/1/283558l.jpg	7.58	7222	2425	1081	Finished	f	1988-08-24 17:00:00-07	2014-04-24 17:00:00-07	308	48	2025-02-27 18:13:50.689942-08	2025-02-27 18:13:50.689942-08
447	Oretama	\N	オレたま	After a night of drunken revelry, 19-year-old Kouta Satou decides to relieve himself near a seemingly secluded temple. Meanwhile, an angel is attempting to seal the queen of the underworld into a holy ball with his bow. Unfortunately, he misfires, trapping her instead inside of Kouta's unwitting balls. The angel departs, leaving Kouta a dire warning: if he fails to resist ejaculating before the end of the month, the queen will be released and mark the end of the world.\n\nFor the lustful Kouta, such a commitment is easier said than done; on top of using any means necessary to resist temptation, he must also guard himself from advances made by Elyse, a lesser devil who would resort to drastic measures to free her queen. In Oretama, the fate of the entire world rests upon the improbability of one man's chastity.\n\n[Written by MAL Rewrite]\n\nNote: There are five specials: Extra Ball 1-3 and Special Ball 1 &amp; 2 are coupled with the tankoubon releases.	https://cdn.myanimelist.net/images/manga/2/53187l.jpg	7.30	17366	4827	552	Finished	f	2006-11-02 16:00:00-08	2010-04-01 17:00:00-07	41	6	2025-02-27 18:13:50.772373-08	2025-02-27 18:13:50.772373-08
448	Tenshi Kinryouku	Angel Sanctuary	天使禁猟区	The angel Alexiel loved God, but she rebelled against Heaven when she saw how disgracefully the other angels were behaving. She was finally captured, and as punishment sent to Earth to live an endless series of tragic lives. She now inhabits the body of Setsuna Mudo, a troubled teen in love with his sister Sara. Setsuna's misery mirrors the chaos among the angels, and their combined passions threaten to destroy both Heaven and Earth.	https://cdn.myanimelist.net/images/manga/1/262086l.jpg	7.89	10239	1025	710	Finished	f	1994-07-04 17:00:00-07	2000-10-19 17:00:00-07	120	20	2025-02-27 18:13:50.834968-08	2025-02-27 18:13:50.834968-08
449	Miracle☆Girls	Miracle Girls	ミラクル☆ガールズ	Meet Toni and Mika-identical twins as different as day and night. Toni is a star athlete, out-going, and popular. Mika is shy, quiet, and academic. Although they look like ordinary junior high school students, when they unite, these twins produce Miracle Powers. Telepathy, teleportation, and magic are all used to help the girls get through the day. Nobody knew about Toni and Mika's powers until a nosey classmate discovered their secret. Can the twins keep their powers a secret or will they be exposed to the world?\n\n(Source: Tokyopop)\n\nIncluded one-shot:\nVolume 1: Sukoshi dake Mystery	https://cdn.myanimelist.net/images/manga/1/161113l.jpg	6.91	604	10286	12099	Finished	f	1990-10-02 17:00:00-07	1994-02-02 16:00:00-08	39	9	2025-02-27 18:13:50.88847-08	2025-02-27 18:13:50.88847-08
454	Shin Kidou Senki Gundam Wing: Dual Story - G-Unit	Mobile Suit Gundam: The Last Outpost	新機動戦記ガンダムW デュアルストーリー G-UNIT	AC 195. Earth and its surrounding colonies were fighting the bloodiest war mankind had ever known. But on the remote asteroid colony MO-V, life carried on as normal. It wasn't long, however, before OZ agents came to enlist the colony in the battle for independence from Earth rule. Now the once neutral colony not only finds itself lending resources to OZ, but they are under attack by a mysterious group who call themselves the Stardust Knights. When Odel Bernett, the colony's top pilot, is shot down in combat, his younger brother, Odin, must don the experimental new MS, the G-Unit, and fight to defend his home.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/301297l.jpg	6.93	423	10054	16087	Finished	f	1997-03-31 16:00:00-08	1998-02-13 16:00:00-08	13	3	2025-02-27 18:13:51.210345-08	2025-02-27 18:13:51.210345-08
455	Model	Model	MODEL 모델	Jae is a Korean student who came to Europe to study art. Things aren't going her way, but she's determined to make it. One night, her friend Melissa brings a drunk guy to her apartment and asks if he can stay there for the night. Jae doesn't like it, but agrees. That night she has a dream that the drunk guy drinks her blood...which, of course, turns out NOT to be a dream.\n\nJae is surprisingly unafraid of the vampire, Michael, and starts to paint his portrait. The two strike an unusual deal: if Jae allows the vampire to feed on her, he will pose for her. His beauty and alluring preternatural energy could be exactly what Jae needs to finally succeed as a painter.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/173620l.jpg	7.31	2928	4706	3422	Finished	f	2000-05-31 17:00:00-07	2002-09-30 17:00:00-07	10	7	2025-02-27 18:13:51.249589-08	2025-02-27 18:13:51.249589-08
456	Monochrome Factor	Monochrome Factor	モノクローム・ファクター	Akira Nikaidou is a typical slacker high school student who thinks he has a normal life until a mysterious man called Shirogane appears and tells him to meet him at the school that night. He is skeptical but goes anyway...and gets attacked by a shadow monster! Shirogane convinces him that the balance between the human world and the shadow world has been distorted, and that Akira must become a shin, a creature of the shadow world, in order to help restore the balance.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/205068l.jpg	7.55	2197	2641	3540	Finished	f	2003-12-31 16:00:00-08	2011-06-14 17:00:00-07	65	11	2025-02-27 18:13:51.339788-08	2025-02-27 18:13:51.339788-08
457	Tsukiyomi	Tsukuyomi: Moon Phase	月詠MOON PHASE	When you come from a family of exorcists and mediums, you're expected to have certain powers. But despite having a psychic lineage, Kouhei Midou can't predict the future, nor can he see dead people. He's powerless in every sense of the word. However, he does think fast on his feet, and with a little help from his psychic cousin Seiji, he's an amazing crime solver.\n\nThe mystery he wants to solve more than anything is his mother's tragic disappearance. But it isn't easy... especially in this world, where nothing is as it seems. Cats talk, blood-sucking vampires roam the earth, and monsters eat guys like Kouhei for breakfast. Can Kouhei survive this chaos long enough to find the mother that he's lost?!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/179263l.jpg	7.16	848	6589	6261	Finished	f	1999-07-25 17:00:00-07	2009-01-25 16:00:00-08	109	16	2025-02-27 18:13:51.398337-08	2025-02-27 18:13:51.398337-08
458	Mouryo Kiden	Moryo Kiden	魍魎姫伝	Two families, both alike in dignity...and in their hunger for revenge!\nWhen Akaya of the nymphs and Kai of the ogres met, it was love at first sight. Little did these star-crossed lovers know that by their blood, they are born enemies!\n\nThey say true love can overcome any obstacle... but can it overcome the wrath of ancient gods and death itself?\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/39947l.jpg	6.13	216	19299	23307	Finished	f	1993-12-31 16:00:00-08	\N	17	3	2025-02-27 18:13:51.498383-08	2025-02-27 18:13:51.498383-08
459	Mugen Spiral	Mugen Spiral	夢幻スパイラル	Yayoi, a spunky high school girl, has inherited spiritual powers from her mother, and she uses these powers to protect people. During a fight with the devil Ura, Yayoi's power turns the devil into a black kitten. Now, even though Ura doesn't hide his desire to "eat" Yayoi's power when he gets the chance, they develop an interesting relationship: the two begin living together, and Yayoi takes her new feline "friend" on her adventures.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/269920l.jpg	7.33	3289	4531	2943	Finished	f	2004-01-19 16:00:00-08	2004-10-25 17:00:00-07	12	2	2025-02-27 18:13:51.569974-08	2025-02-27 18:13:51.569974-08
460	Boku to Kanojo no XXX	Your & My Secret	僕と彼女の×××	Two teens see how the other half lives!\n\nThe girl: cute but obnoxious, pretty but violent, petite but rude.\nThe guy: shy and slender and secretly in love with the girl.\n\nWhen her mad scientist grandfather accidentally switches their bodies—it's freaky Friday, Saturday, Sunday, and every day! Akira Uehara is mortified when his best buddy starts hitting on "him," and is embarrassed to look at "himself" in the mirror in her underwear! He can't wait to get back to being a boy. But Nanako Momoi has other ideas—she is starting to enjoy life in Akira's body!\n\n(Source: ADV)	https://cdn.myanimelist.net/images/manga/1/58073l.jpg	6.93	3390	10055	2532	Finished	f	2001-01-31 16:00:00-08	2011-08-11 17:00:00-07	69	8	2025-02-27 18:13:51.649217-08	2025-02-27 18:13:51.649217-08
461	Neck and Neck	Neck and Neck	막상막하	Dabin Choi is the daughter of Seoul's most powerful crime boss, and daddy's little girl has the hots for Eugene, the son of one of her father's "friends."\n\nThere's just one problem: Eugene isn't into Dabin. In fact, he thinks of her more like a little sister. (The kiss of death!) To make matters worse, Dabin's new classmate is none other than the son of her father's long-time rival. Soon, everyone at school begins playing power games that would make their fathers proud!\n\n(Source: TokyoPop)	https://cdn.myanimelist.net/images/manga/1/264961l.jpg	7.32	483	4612	14102	Finished	f	2001-12-31 16:00:00-08	2004-12-31 16:00:00-08	40	8	2025-02-27 18:13:51.720704-08	2025-02-27 18:13:51.720704-08
462	Shin Petshop of Horrors	Pet Shop of Horrors: Tokyo	新 Petshop of Horrors	Count D has opened his petshop again, this time in Tokyo's Shinjuku!\n\nFor those who haven't read Petshop of Horrors, Count D's Petshop is a place where one can find animals from the most ordinary housepets to savage predators to mystical beasts that should belong only in legends. Customers often find that their new pets change their lives more than they expect, fulfilling their dreams, or realizing their nightmares.\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/2/117839l.jpg	7.88	2220	1049	3094	Finished	f	2004-04-21 17:00:00-07	2012-11-14 16:00:00-08	45	12	2025-02-27 18:13:51.773011-08	2025-02-27 18:13:51.773011-08
463	NHK ni Youkoso!	Welcome to the N.H.K.	NHKにようこそ!	Tatsuhiro Satou is a 22-year-old hikikomori who dropped out of college and is now entering his fourth year of unemployment. He consumes hallucinatory drugs to escape reality, leading him to come up with various conspiracy theories. One such theory concerns the existence of a secret organization called the Nihon Hikikomori Kyoukai (NHK), which is supposedly responsible for Tatsuhiro's shut-in nature and the increasing number of hikikomori people across Japan.\n\nOn a quest to fight back against NHK, Tatsuhiro swears to leave behind his socially inept self. However, Tatsuhiro soon realizes that socializing may be too far-fetched a dream for him, as he struggles to get through even the most basic interactions with others. With the help of the mysterious Misaki Nakahara, who claims she can cure him of his current lifestyle, will he be able to turn his life around?\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/172691l.jpg	8.12	25449	547	284	Finished	f	2003-12-25 16:00:00-08	2007-04-25 17:00:00-07	40	8	2025-02-27 18:13:51.8567-08	2025-02-27 18:13:51.8567-08
464	Nishi no Yoki Majo	The Good Witch of the West	西の善き魔女	Firiel is a 15-year-old girl who lives with her father, the astronomer Professor Dee, and their servants, the Holys. When she is invited to a fancy ball at a count's castle, she discovers that her past is more complicated then she had thought. A necklace given to her by her father proves that she is of royal blood—and a candidate to be the next Queen!\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/3/140421l.jpg	7.39	404	3882	11850	Finished	f	2003-12-28 16:00:00-08	2007-05-29 17:00:00-07	39	7	2025-02-27 18:13:51.933074-08	2025-02-27 18:13:51.933074-08
465	NOiSE	NOiSE	NOiSE	The Bible has its Genesis.\nThe Matrix has The Second Renaissance.\nBLAME! has NOiSE.\n\nThrough the eyes of police force member Susono Musubi, this one-volume prequel gives readers a glimpse of the world before the Netsphere went haywire. Witness the events that threw the technologically advanced society into chaos: the cancerous growth of the Megastructure, the birth of the parasitic lifeforms called Silicon Creatures, and the development of the ruthless killing machines known as the Safeguards.\n\nAlso included in the compilation is Tsutomu Nihei's debut work BLAME which served as the prototype of the acclaimed 10-volume series, BLAME!.	https://cdn.myanimelist.net/images/manga/1/177551l.jpg	7.18	11377	6324	823	Finished	f	1999-12-31 16:00:00-08	2000-12-31 16:00:00-08	8	1	2025-02-27 18:13:52.073157-08	2025-02-27 18:13:52.073157-08
466	Aishiau Koto Shika Dekinai	Nothing But Loving You	愛しあう事しかできない	Nanako, an up and coming model, falls in love with another model named Etsushi...who, alas, turns out to be gay. Meanwhile, Nanako also discovers that another young actor is deeply in love with her and she is unable to choose between him and Etsushi. Her indecision leads her to a state of depression until the two men come together to encourage her and help her make decisions about her future.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/114675l.jpg	6.22	168	18905	27978	Finished	f	1993-12-31 16:00:00-08	\N	6	1	2025-02-27 18:13:52.140232-08	2025-02-27 18:13:52.140232-08
467	Sono Te Wo Dokero	Hands Off!	その手をどけろ	Kotarou Oohira is a boy with the clueless touch--he has an unusual type of ESP that is transmitted via physical contact. When he accidentally gives his cousin Tatsuki the "gift", he comes to realize that there is much more to his powers than he ever imagined!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/178498l.jpg	7.36	778	4208	11340	Finished	f	1997-12-31 16:00:00-08	2000-12-31 16:00:00-08	28	8	2025-02-27 18:13:52.196437-08	2025-02-27 18:13:52.196437-08
468	One	One	ONE	High schooler Jenny You is living a dream. In the public eye, she is a delicate princess, a successful pop star, but in real life, she's a rebellious beauty ostracized by her female schoolmates.\n\nShe and her classmate, umpa Won (One), seem to have nothing in common on the surface. Eumpa is a quiet boy, ignorant of the pop culture that has enchanted most of his peers. Having spent his childhood as a depressed prodigy in the United States, he has now resolved to lead a normal life as a regular boy.\n\nHe likes a cute-but-average-looking girl, Young-ju Chae. Young-ju takes him to a pop concert, and Eumpa is exposed to Jenny's music for the first time. Meanwhile, umpa's resolution to live a normal life is challenged when his music teacher steals the young man's music and attempts to pass it off as his own...\n\nSo begins the story of One...\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/152416l.jpg	6.86	319	11189	17146	Finished	f	1997-12-31 16:00:00-08	2001-12-31 16:00:00-08	71	11	2025-02-27 18:13:52.231075-08	2025-02-27 18:13:52.231075-08
469	Oniichan to Issho	Me & My Brothers	お兄ちゃんと一緒	Sakura had lived with her grandma ever since her parents died in a car accident when she was three. When she turned fourteen, her grandma also passed away, leaving her alone. Just when she was about to give up hope having a family, out of nowhere, four guys claim to be her older step-brothers.\n\n(Source: Esthétique)\n\nIncluded one-shots:\nVolume 1: Parallel to the World\nVolume 2: Gakuchuu\nVolume 3: Mahou no Tsukaikata (How To Use Magic)\nVolume 4: Himitsu no Tobira no Kugurikata (How to go Through a Secret Door)\nVolume 6: Santa no Iru Machi\nVolume 7: Shirayukihime no Douwa (The long tale of Snow White.)\nVolume 9: Kimi to Boku no Uta	https://cdn.myanimelist.net/images/manga/2/166809l.jpg	7.58	1622	2408	4574	Finished	f	2003-03-16 16:00:00-08	2009-03-23 17:00:00-07	67	11	2025-02-27 18:13:52.292039-08	2025-02-27 18:13:52.292039-08
470	Otogizoushi	Otogi Zoshi	お伽草子	The time is 972 A.D. in Kyoto, the capital of ancient Japan. Kyoto is becoming a corrupt and run-down city; selfish samurai and onmyoji, who care only about gaining political power are everywhere. To make matters worse the city is suffering from famine and widespread disease. Unable to ignore the condition of the city any longer, the Imperial Court decides to send Minamoto no Raiko, a famous samurai well-known for his archery skills, to recover a legendary gem, the Magatama, said to hold mysterious power to save the world. However Raiko also falls ill to disease. Instead his youngest sister, Hikaru, decides secretely to make the journey in his place. Hikaru meets many people, and has many adventures while on her trip for the legendary gem.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/6557l.jpg	6.83	311	11598	18730	Finished	f	2004-06-29 17:00:00-07	2005-03-29 16:00:00-08	10	2	2025-02-27 18:13:52.325512-08	2025-02-27 18:13:52.325512-08
471	Otona ni Nuts	Instant Teen - Just Add Nuts	おとなにナッツ	Natsumi Kawashima, an energetic fifth-grader, is obsessed with her fantasy of being the ideal, sexy woman. Rejected at every advance by the cute guys that she fawns over, she finally gets a break when she picks up a package of mysterious pink nuts that are adults only.\n\nEating these nuts causes her to morph into a voluptuous adult, and she's offered modeling opportunities and suddenly becomes noticed by guys who wouldn't have given her the time of day before.\n\nBut, she's still a kid inside and is about to learn that things don't always work out exactly as you hope they will... (Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/4643l.jpg	6.50	1706	16534	6404	Finished	f	2000-12-31 16:00:00-08	2001-12-31 16:00:00-08	16	4	2025-02-27 18:13:52.451517-08	2025-02-27 18:13:52.451517-08
472	Ou Dorobou Jing	Jing: King of Bandits	王ドロボウJING	The title of king implies grandeur or, at the very least, delusions of it. For Jing, the King of Bandits, all he has to his name are fear-mongering rumors that have spread between the cracks of civilization. Despite his infamy, he, along with his partner in crime and incurable womanizer Kir, roams the recesses of the world. Those who witness the pair with anxious hearts and minds cower at the thought of becoming Jing's next target.\n\nBut with every grand heist, it is not just mere precious treasures Jing is seeking to pry from his unwitting victims. Their undivided attention is just as valuable, showing how they ruin themselves over their foolishly prized possessions. Jing knows there is no better way to make his demands than through awe-inspiring fear—fear of the King of Bandits.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/3/148389l.jpg	7.37	1718	4090	4938	Finished	f	1995-03-14 16:00:00-08	1998-04-14 17:00:00-07	39	7	2025-02-27 18:13:52.508981-08	2025-02-27 18:13:52.508981-08
473	Peace Maker Kurogane	Peacemaker Kurogane	PEACE MAKER 鐵	The sword-slashing sequel to Peace Maker is here! Three months have passed since the Ikedaya Incident that crushed the anti-shogunate rebellion—and propelled the Shinsengumi, Kyoto's now-official police, into history as Kyoto's premium peacekeeping force. But there is no rest for the peaceful: An unexpected threat to the Shinsengumi arises, and it's going to take more than mere swords to defeat this new terror on the horizon.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/183478l.jpg	7.73	1528	1597	4051	Publishing	t	2002-02-27 16:00:00-08	\N	\N	\N	2025-02-27 18:13:52.587488-08	2025-02-27 18:13:52.587488-08
474	Shinsengumi Imon Peace Maker	Peace Maker	新撰組異聞PEACE MAKER	When childhood innocence gives way to a blinding thirst for revenge, is it worth the price of one's humanity? Tetsunosuke and Tatsunosuke are the sons of a diplomat who sought to bring peace and prosperity to Japan during the early Meiji Restoration. But when their parents are murdered before their very eyes, Tetsu seeks to join the Shinsengumi, the unofficial police who are capable of the same brutality as his parents' murderers. Wading through a sea of espionage, deception and bloodshed, the young boy must choose: should he take a step on the path to becoming a demon... or give up his rage and transform into the ultimate Peacemaker?\n\n(Source: Tokyopop)\n\nIncluded one-shot:\nVolume 6: Wagamama Tenshi no Sodatekata.	https://cdn.myanimelist.net/images/manga/3/120697l.jpg	7.63	1362	2124	4635	Finished	f	1999-04-11 17:00:00-07	2001-08-10 17:00:00-07	30	6	2025-02-27 18:13:52.620501-08	2025-02-27 18:13:52.620501-08
475	Peach Girl	Peach Girl	ピーチガール	Momo Adachi struggles with insecurities about her tanned skin daily, which is only worsened by her high school peers. Moreover, the girl who Momo treats as her best friend, Sae Kashiwagi, is the most vicious of them all—spreading hateful lies and scheming evil plans to ensure Momo does not outshine her.\n\nUnfortunately for Momo, she is about to face a tremendously difficult battle when Sae realizes that the two most attractive guys in school have feelings for her. Can Momo keep her long-time crush, Kazuya "Touji" Toujigamori, by her side despite Sae's attempts to tear them apart?\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/1/181872l.jpg	7.29	7239	4907	1329	Finished	f	1997-09-12 17:00:00-07	2003-12-12 16:00:00-08	72	18	2025-02-27 18:13:52.653575-08	2025-02-27 18:13:52.653575-08
476	Peppermint	Peppermint	파티코믹스	For Haei, being able to go to school with her idol, Ijy, is a dream come true! Plus she gets to help him with rehearsing. But with the girls from his fan club, who make her life hell on earth. But then Eo, a kid in primary school, wants her to pretend to be his girlfriend, making it easier for him to get away from his groupies. Haei's life isn't done being complicated....\n\n(Source: MU)	https://cdn.myanimelist.net/images/manga/3/1324l.jpg	7.07	395	7924	17510	Finished	f	2000-12-31 16:00:00-08	2002-12-31 16:00:00-08	21	4	2025-02-27 18:13:52.720924-08	2025-02-27 18:13:52.720924-08
477	Phantom	Phantom	팬텀	K—an agile mech pilot in Neo Seoul police's high-speed mobile unit—specializes in chasing down and eradicating terrorists. His duty has always been to protect the citizens, and he's given little thought to the mega-corporations that run the city. But when an ordinary arrest explodes into a nightmarish battle, K is painfully forced to question his convictions. Stripped of all sense of right and wrong, K must make a terrible choice—either join his enemies, or lose all sense of justice!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/5/262256l.jpg	6.77	164	12544	22625	Finished	f	2003-12-31 16:00:00-08	2004-12-31 16:00:00-08	\N	5	2025-02-27 18:13:52.784722-08	2025-02-27 18:13:52.784722-08
478	PhD: Phantasy Degree	PhD: Phantasy Degree	마스터스쿨 올림프스	A young, spunky, fearless girl named Sang is searching for the Demon School Hades. She runs into a group of misfit monsters who are all ditching classes from the same school. Sang convinces them to take her to the school ... and, since only monsters are allowed in, she 'monsterizes' herself by letting one of the misfits - a vampire - bite her. Sound pretty cool? Then welcome to the world of PhD!\n\n(Source: TokyoPop)\n\nNote: There are currently 10 volumes published, and the series' original publisher, Daiwon C.I. lists it as ongoing, but no new volumes have been published since 2005.	https://cdn.myanimelist.net/images/manga/2/171568l.jpg	6.99	551	9175	12824	Finished	f	2001-06-18 17:00:00-07	2004-11-30 16:00:00-08	106	10	2025-02-27 18:13:52.831467-08	2025-02-27 18:13:52.831467-08
479	Planet Blood	Planet Blood	\N	After the 5th World War comes to an end, 46% of humans have been wiped off the face of the earth. Because of contamination, the survivors of this war colonize the moon and Mars with plans to move back to Earth after they purify the planet.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/676l.jpg	\N	\N	20443	34193	Finished	f	\N	\N	\N	10	2025-02-27 18:13:52.915831-08	2025-02-27 18:13:52.915831-08
480	Planet Ladder	Planet Ladder	プラネット・ラダー	Kaguya is a quiet orphan who has lived with a Japanese family since she was a little girl. Another boring high school day becomes the adventure of her life when she's mysteriously transported far, far away to a realm of strangers who call her "Princess." Now, Princess Kaguya must uncover both her true identity and the motives behind the battling warlords who want to claim her. The universe is a battlefield, and the key to peace may be in the hands of one very special girl.\n\n(Source: TokyoPop)	https://cdn.myanimelist.net/images/manga/3/155810l.jpg	6.83	520	11599	14704	Finished	f	1998-02-28 16:00:00-08	2003-04-30 17:00:00-07	\N	7	2025-02-27 18:13:52.985651-08	2025-02-27 18:13:52.985651-08
481	Planetes	Planetes	プラネテス ΠΛΑΝΗΤΕΣ	Haunted by a space flight accident that claimed the life of his beloved wife, Yuri finds himself six years later as part of a team of debris cleaners on a vessel called the Toy Box charged with clearing space junk from space flight paths. The team consists of Hachimaki, a hot shot debris-man with a sailor's affinity for the orbital ocean; Fee, a chain-smoking tomboy beauty with an abrasive edge; and Pops, a veteran orbital mechanic whose avuncular presence soothes the stress of the job.\n\n(Source: TokyoPop)	https://cdn.myanimelist.net/images/manga/3/170572l.jpg	8.24	18110	377	292	Finished	f	1999-01-13 16:00:00-08	2004-01-07 16:00:00-08	27	4	2025-02-27 18:13:53.039741-08	2025-02-27 18:13:53.039741-08
482	Platinum Garden	Platinum Garden	プラチナガーデン	When Kazura Enomoto’s grandfather dies, he leaves her to the son of a rich family, Mizuki Magahara, as payment for his debts. After she goes to live with him, Kazura learns that she’s not going to be working off the debts as a servant—she’s going to be Mizuki’s fiancée! Unless Kazura can repay her debt, she’s got no choice but to learn to live with her new lot in life. But no sooner has Kazura begun to adjust to living with Mizuki and going to his snotty rich school than the dark secret of the Magahara family comes to light. The head of the family has the unique power to bring back the souls of the dead—and right now the head of the family is Mizuki!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/1539l.jpg	7.33	721	4470	7626	Finished	f	2001-04-11 17:00:00-07	2006-06-15 17:00:00-07	68	15	2025-02-27 18:13:53.136464-08	2025-02-27 18:13:53.136464-08
483	Power!!	Girl Got Game	POWER!!	Sixteen-year-old Kyou Aizawa's relationship with her father has always revolved around basketball. He wanted to join the NBA, but suffered a knee injury that ended his dream; since then, he has tried to live vicariously through Kyou. When her father suddenly gets transferred to another part of the country, Kyou gets the opportunity to attend Seisyu Academy. She is excited because Seisyu is famous for its cute girls' uniforms. When she opens the box sent by the school, however, Kyou discovers an unflattering boys' uniform instead!\n\nAs it turns out, her father has faked paperwork and enrolled her as a male student so she can join the school basketball team, which is ranked fourth in Japan. As a sacrifice to carry on her father's legacy, Kyou begrudgingly cuts her hair and moves into the boys' dormitory. She meets her roommate and teammate Chiharu Eniwa but somehow manages to irritate him on the very first day. He is quick to taunt Kyou about her short stature and questions her dedication to the sport. Will Kyou be able to live in close quarters with someone so annoying and thrive on the basketball team, all while hiding her true gender from everyone?\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/144007l.jpg	7.69	8237	1808	1381	Finished	f	1999-08-10 17:00:00-07	2001-12-31 16:00:00-08	44	10	2025-02-27 18:13:53.22171-08	2025-02-27 18:13:53.22171-08
484	Girls Educational Charter	President Dad	소녀교육헌장	Ami Won's late mother always told her to grow up to be an exemplary woman. And the chance presents itself now that her dad has been elected President of Korea. Thus begins this klutzy girl's transformation into the girl her mother had always hoped she'd become. However, in the spotlight and imbued with a kind of social power she never expected, Ami is now beset on all sides by the jealous and dismayed. Her cousin Bi-Na leads this parade. Bi-Na considers herself naturally charismatic and infinitely more charming, so she feels she deserves the role as Korea's First Lady.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/180644l.jpg	6.74	262	13065	21102	Finished	f	2001-12-31 16:00:00-08	2003-12-31 16:00:00-08	43	7	2025-02-27 18:13:53.300699-08	2025-02-27 18:13:53.300699-08
485	Priceless	Priceless	봄봄	Lang-bee knows the value of money. After her mother runs a vitamin drug scam and goes on the lam, Lang-bee is alone to fend for herself. Lang-bee repays the people scammed by her mom with the money she makes working for her fellow students. When she pursues her love interest in Dan Won, the rich, emotional heir to a corporate empire. Lang-bee competes against Yuka Lee, her nemesis, in the chase for Dan Won. Who will he choose?\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/261781l.jpg	6.37	230	17847	23674	Finished	f	2001-12-31 16:00:00-08	\N	22	3	2025-02-27 18:13:53.421219-08	2025-02-27 18:13:53.421219-08
486	Priest	Priest	프리스트	In the frontier of the American West, a veil of evil threatens to engulf humanity. Servants of the fallen archangel Temozarela are paving the way for their dark lord's resurrection. One man stands in the way of the apocalypse: Ivan Isaacs, a fallen priest who sold his soul to the devil Belial for the power to fight evil. Armed with a wicked blade and silver bullets, Ivan will give the heretics a baptism of blood in his pilgrimage for humanity's redemption.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/558l.jpg	7.37	1612	4091	3189	Finished	f	1997-12-31 16:00:00-08	2006-12-31 16:00:00-08	160	16	2025-02-27 18:13:53.46167-08	2025-02-27 18:13:53.46167-08
489	Psychic Academy Oura Bansho	Psychic Academy	サイキックアカデミー煌羅万象	Zerodaimu Kyupura Pa Azalraku Vairu Rua Darogu (a.k.a. Zero) once stopped the evil demon lord with his incredible psychic ability, and in the process saved the world from destruction and earned the honorable and highly imaginative title "The Man Who Stopped the Evil Lord."\n\nNow, he has accepted a position as a teacher at Psychic Academy, a school for gifted psychokinetic youngsters who have demonstrated incredible raw powers and want to learn how to hone their abilities. Among the student body is young Ai Shiomi, Zero's little brother, a somewhat meek boy who, despite parental prodding and his fraternal reputation, feels that his limited skills hardly justify his presence at the prestigious academy.\n\nHowever, everyone else is convinced that he, like his celebrated brother, is destined for greatness. A lot of pressure for a boy just entering adolescence!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/144285l.jpg	7.01	2304	8845	4762	Finished	f	1998-06-25 17:00:00-07	2003-01-24 16:00:00-08	38	11	2025-02-27 18:13:53.535985-08	2025-02-27 18:13:53.535985-08
491	Qwan	Qwan	怪・力・乱・神クワン	In the era of the Romance of the Three Kingdoms, the fall of the Han Dynasty in Ancient China, a strange boy Qwan and his winged companion Teikou are on a quest. In order to find his purpose and the truth of his existence, Qwan is told that he needs to find the holy text, the Essential Arts of Peace. During his journey, he sucks in the body of demons, apparently as his meals. Will this super-strong demon eater locate the texts and discover his destiny?\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/258219l.jpg	7.07	531	7925	10463	Finished	f	2002-09-04 17:00:00-07	2008-02-04 16:00:00-08	44	7	2025-02-27 18:13:53.622149-08	2025-02-27 18:13:53.622149-08
492	R.I.P.	R.I.P.	Ｒ・Ｉ・Ｐ	Transylvania Rose is a bored angel who descends to Earth to clean a few souls. When she witnesses a depressed undertaker slitting his wrists, Rose rips off one of her wings and gives it to the undertaker, trapping them both somewhere between heaven and hell -- and life and death! (Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/254481l.jpg	7.08	587	7712	12732	Finished	f	1999-04-15 17:00:00-07	2000-03-15 16:00:00-08	12	1	2025-02-27 18:13:53.754668-08	2025-02-27 18:13:53.754668-08
493	Ra-i	Ra-i	ライ	Al Foster is a private detective whose workaday life suddenly shakes up with the arrival of 13-year-old Rai Spencer, youngest son of the billionaire Spencer family, genius child prodigy, and unrepentant smart aleck. Rai has an unusual gift -- his telekinetic powers can knock out anyone who stands in his path. He also has a sister who sports a mean left hook. But what Rai desperately needs is someone to figure out who has been trying to kill him for the past month! (Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/265855l.jpg	6.47	143	16825	28167	Finished	f	1994-12-31 16:00:00-08	\N	4	1	2025-02-27 18:13:53.79676-08	2025-02-27 18:13:53.79676-08
495	Rakuen	Passion Fruit	楽園	A collection of four short stories. Story 3: Chihiro and Chiaki are twins with a special ability; Chihiro sees strange visions triggered by the things around him, but it's Chiaki who, without actually seeing them, knows what the visions mean. The trouble Chiaki has caused by blurting out the truth behind the visions has caused Chihiro to shut himself away to keep the visions from coming. But then, one day, his brother asks him to step outside...\n\n(Source: Storm in Heaven)	https://cdn.myanimelist.net/images/manga/2/39991l.jpg	7.01	781	8846	10436	Finished	f	2003-01-24 16:00:00-08	\N	6	1	2025-02-27 18:13:53.850221-08	2025-02-27 18:13:53.850221-08
496	Real Bout High School	Real Bout High School	リアルバウトハイスクール	In a school where martial arts are standard curriculum and disputes are settled by officially recognized duels, Ryouko takes on all comers. As the #1 fighter at Daimon High, Ryouko's battles to defend her position never end and "Finals" take on a whole new meaning.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/166934l.jpg	6.77	1151	12545	8287	Finished	f	1998-11-08 16:00:00-08	2003-03-07 16:00:00-08	46	6	2025-02-27 18:13:53.914088-08	2025-02-27 18:13:53.914088-08
497	Rebirth	Rebirth	ЯEBIRTH 리버스	Three hundred years ago the Dark Magician Deshwitat Lived Rudbich, a vampire, was sealed in limbo by the Light Magician Kalutika. Resurrected in the present day, Deshwitat has vowed to destroy Kalutika, and now, with the help of a team of spiritual warriors, seeks the means to use Light Magic to achieve his ends.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/3578l.jpg	7.35	907	4307	7471	Finished	f	1997-12-31 16:00:00-08	2009-12-31 16:00:00-08	107	26	2025-02-27 18:13:53.984432-08	2025-02-27 18:13:53.984432-08
499	Remote	.remote.	リモート	Kurumi Ayaki is a recently-retired police officer with a record of excellence on the force and the guts and guile to back it up. In order to earn some extra money for her upcoming wedding, she has to return to the force ... and is 'rewarded' with an assignment to an elite unit whose charge it is to solve those crimes that have been classified as unsolvable.\n\nPartnered with a mysterious young genius who is unable to feel emotions, or even to leave his room, she acts as his eyes and ears to piece together clues even as her own personal life falls apart around her.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/56465l.jpg	6.85	1105	11369	7178	Finished	f	2001-12-31 16:00:00-08	2003-12-31 16:00:00-08	100	10	2025-02-27 18:13:54.077989-08	2025-02-27 18:13:54.077989-08
500	RG Veda	RG Veda	聖伝 ‐RG VEDA‐	300 years ago, a powerful warlord rebelled against the Heavenly Emperor. After killing the Emperor, the warlord crowned himself as the new Emperor, starting a cruel reign. But there is a prophecy: Six Stars will one day assemble and overthrow his tyrannical rule ...\nNow, the ruler of the Yasha Clan has found Ashura, the last of the Ashura Clan, and together they set out to find the Six Stars and fulfill the prophecy.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/265984l.jpg	7.68	3910	1847	2083	Finished	f	1989-12-31 16:00:00-08	1995-12-31 16:00:00-08	16	10	2025-02-27 18:13:54.14435-08	2025-02-27 18:13:54.14435-08
501	Rizelmine	Rizelmine	りぜるまいん	The government has been conducting experiments to genetically engineer a human. Its first creation is a girl named Rizel, and the experiment is a success—sort of.\n\nWhile healthy and cheerful, 12-year-old Rizel also possesses the uncanny need for love to further her development. Saddened by this emptiness in her life, she sheds tears that can end up destroying a city block.\n\nSo what's a girl to do ... except get married! Enter Iwaki Tomonori, your average 15-year-old boy. His world is turned upside-down the day he arrives home to find that the government has just announced that he's a married man!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/147959l.jpg	6.42	884	17336	10713	Finished	f	2000-12-31 16:00:00-08	2001-12-31 16:00:00-08	7	1	2025-02-27 18:13:54.206259-08	2025-02-27 18:13:54.206259-08
502	Rose Hip Rose	Rose Hip Rose	Rose Hip Rose	Seventeen-year-old Kasumi Asakura may be many things—high school student, next-door neighbor, police assault squad ace—but she's not going to stand still and let anyone take a picture up her skirt, as Shohei Aiba learns firsthand when he tries it on the subway. When he attempts to find out more about this mystery girl, he gets caught up in her search for the serial killer nicknamed the Shepherd—who enjoys carving his initials into young women's mutilated bodies! Asakura's back for more in this action-packed shonen sequel to Rose Hip Zero!\n\n(Source: Tokyopop)\n\nIncluded one-shot:\nVolume 4: Rose Hip Rose (pilot)	https://cdn.myanimelist.net/images/manga/1/177185l.jpg	6.79	1207	12316	7596	Finished	f	2002-11-04 16:00:00-08	2006-06-13 17:00:00-07	22	4	2025-02-27 18:13:54.284746-08	2025-02-27 18:13:54.284746-08
503	Rose Hip Zero	Rose Hip Zero	ROSE HIP ZERO	Appearances can be deceiving. There is trouble in Tokyo as a mysterious terrorist organization called ALICE plots against the government. Just as the police are tasked to bring these men to justice, they are given a "secret weapon": a young girl with a mysterious past named Kasumi Asakura. She may look innocent, but she walks softly and carries a big gun.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/177217l.jpg	7.07	858	7926	8946	Finished	f	2005-04-19 17:00:00-07	2006-03-14 16:00:00-08	34	5	2025-02-27 18:13:54.343652-08	2025-02-27 18:13:54.343652-08
504	Rure	Rure	루어	Ha-Ru is the daughter of a family that rules a remote island--she is also the heiress to this secluded land, something that Ha-Ru's half sister, Mi-Ru, resents. When Mi-Ru becomes upset and runs away, Ha-Ru follows her--and magically they are ushered into a foreign desert! And in this land, it's survival of the fittest! (Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/41554l.jpg	7.29	271	4984	14714	Publishing	t	2002-12-31 16:00:00-08	\N	\N	\N	2025-02-27 18:13:54.398892-08	2025-02-27 18:13:54.398892-08
505	S to M no Sekai	The World Exists for Me	S と M の世界	To survive a fatal train wreck, Sekai Maihime is thrust back in time where she discovers she has hidden powers that are connected to a doll, 'S.' She is both aided and limited by 'S's' vague (but kind) guardian, Sovieul, who is the cause for Sekai's presence in 17th century France. Sovieul vows to protect Sekai, but offers little information as to why these strange events are happening.\n\nUnfortunately, they encounter Machiavello (also referred to as the Devil) who looks a lot like Sekai's childhood friend and love Midou. Machiavello covets the powers shared by Sekai and 'S' so he may obtain the power of the Devil R. Sekai only wants to find Midou and return to her time, but she's constantly hindered by her conflicting desires with 'S' and by Machiavello's attempts to obtain her body. To find Midou, Sekai must cooperate with 'S' and Sovieul to traverse through time while avoiding Machiavello. (Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/37113l.jpg	6.24	438	18766	14092	Finished	f	2002-11-15 16:00:00-08	2003-07-16 17:00:00-07	4	2	2025-02-27 18:13:54.450286-08	2025-02-27 18:13:54.450286-08
506	Saber Marionette J	Saber Marionette J	セイバーマリオネットJ	On a world with no women, the surviving men have reintroduced the female in the form of an android. Called Marionettes, they are built to serve men and are limited in their interactions with humans. That is until a poor boy named Otaru Mamiya encounters a Marionette named Lime. Lime is a Saber model with a special circuit that gives her emotions. When Otaru awakens two more Saber Marionettes, his life as an 'average' man quickly becomes as extraordinary as the lives of his eager, busty new friends.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/138531l.jpg	6.55	885	15865	10005	Finished	f	1996-09-08 17:00:00-07	1999-10-08 17:00:00-07	34	5	2025-02-27 18:13:54.522448-08	2025-02-27 18:13:54.522448-08
507	Sei♥Dragon Girl	St.♥ Dragon Girl	聖♥ドラゴンガール	Momoka Sendou (nicknamed "Dragon Girl") and Ryuga Kou are childhood friends. Momoka is a martial artist, and Ryuga is a Chinese magic master who banishes demons. In order to increase his power, Ryuga calls on the spirit of a dragon to possess him, but the spirit enters Momoka instead. Now the two must unite forces and fight demons together!\n\n(Source: VIZ Media)	https://cdn.myanimelist.net/images/manga/2/261038l.jpg	7.27	795	5226	8914	Finished	f	1998-12-31 16:00:00-08	2002-12-31 16:00:00-08	36	8	2025-02-27 18:13:54.641915-08	2025-02-27 18:13:54.641915-08
508	Kaitou Saint Tail	Saint Tail	怪盗セイント・テール	"Dear Lord, forgive me for the tricks up my sleeve..."\n\nIn the world of phantom thieves, one ponytail stands out from the rest—the uncapturable Saint Tail! She is not only known for using crazy magic tricks during and after her heists, but also for stealing back items that were wrongfully obtained. This infamous enemy of the law is the secret identity of Meimi Haneoka, a 14-year-old student attending Saint Paulia's Private School. With the help of her nun-in-training friend, Seira Mimori, Meimi assumes her alter ego during the night to help those in need.\n\nWhile her heists usually go through without a hitch, things begin to change when a certain boy starts showing up during her ventures—enter Daiki Asuka, who is known as "Asuka Jr." due to sharing his name with his father, a well-known local detective. Not only does he voice his resolve to be the one to capture Saint Tail, but he is also Meimi's classmate at school! After the young detective's first nocturnal encounter with the now-wary magician thief, a cat-and-mouse chase begins.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/171555l.jpg	7.36	1001	4209	7765	Finished	f	1994-09-02 17:00:00-07	1997-02-17 16:00:00-08	33	7	2025-02-27 18:13:54.74342-08	2025-02-27 18:13:54.74342-08
519	Seikai no Monshou	Seikai Trilogy	星界の紋章	After his home world is ruthlessly taken over by the Abh - a space-faring race that has conquered thousands of galaxies - a boy named Jinto begins an unforgettable journey that stretches the boundaries of the final frontier. With a beautiful princess at his side, he will attempt to unlock the secret behind the Abh domination and discover that all's fair in love and interplanetary war.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/5/1588l.jpg	7.24	427	5520	15716	Finished	f	1998-12-31 16:00:00-08	\N	25	3	2025-02-27 18:13:55.607958-08	2025-02-27 18:13:55.607958-08
509	Saiyuuki	Saiyuki	最遊記	Since its creation, Tougenkyou has been a place where both humans and youkai live in peace. However, following the breach of a taboo in an attempt to revive the villainous youkai Gyuumaou, the "Minus Wave" unleashes throughout the land. With this ghastly force at large, the youkai begin to lose their self-consciousness, causing them to devour the townspeople.\n\nTasked by the Three Aspects—the messengers of the heavens—to stop Gyuumaou's resurrection and restore peace, Sanzou Genjou rounds up three old comrades, none of which resemble the definition of ordinary. Being half-human, Gokuu Son, Hakkai Cho, and Gojou Sha are the only youkai with the power and spirituality to withstand the Minus Wave. Despite being skeptical about trusting them due to their mixed blood, Sanzou heads to the west with his companions to eradicate the growing threat.\n\n[Written by MAL Rewrite]	https://cdn.myanimelist.net/images/manga/2/181067l.jpg	7.99	6503	782	1091	Finished	f	1997-02-17 16:00:00-08	2002-01-17 16:00:00-08	56	9	2025-02-27 18:13:54.825393-08	2025-02-27 18:13:54.825393-08
510	Saiyuuki Reload	Saiyuki Reload	最遊記RELOAD	The fearsome foursome continue their journey west towards Shangri-La, encountering new challenges and new adventures along the way. Their legend precedes them, but not always in the way one might expect. The Minus Wave that apparently drove all the youkai in the land mad looks like it might have missed one, as Sanzou, Gojou, Hakkai and Gokuu meet a lone guardian and the band of children he cares for. Fear and misunderstanding run throughout this particular leg of the journey, including between the members of the Sanzou group!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/172702l.jpg	8.20	3188	440	2578	Finished	f	2002-03-27 16:00:00-08	2009-06-26 17:00:00-07	66	10	2025-02-27 18:13:54.914255-08	2025-02-27 18:13:54.914255-08
511	Sakura Taisen	Sakura Wars	サクラ大戦	The year is 1921, and this is a Tokyo where monstrous steam-powered robots crash a flower-viewing party only to be cut down samurai-style by a young girl in a kimono and traditional hakama pants.\n\nIt's eight years after the horrific Demon War, and Japan is a peaceful prosperous place. Meet Ensign Ogami Ichiro, who has just graduated from the Naval Academy. He's assigned to a base in Tokyo, but soon discovers that his headquarters is the Imperial Theater and his first mission is collecting tickets at the gate. He gamely goes about his menial jobs at the theater, surrounded by beautiful girls who seem to know a lot more about what's going on than he does, but he's about to be swept into a roiling world of robots, demons, and hot girls in uniform.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/301286l.jpg	6.88	799	10844	8692	Finished	f	2002-06-25 17:00:00-07	2008-12-25 16:00:00-08	29	9	2025-02-27 18:13:55.026176-08	2025-02-27 18:13:55.026176-08
512	Samurai Champloo	Samurai Champloo	サムライチャンプルー	Mugen is a rough-around-the-edges mercenary with a killer technique and nothing left to lose. Jin is a disciplined samurai who's as deadly as he is reserved. Fuu is a young waitress with a good heart and a resourcefulness that emerges when you least expect it. These three unlikely companions are about to begin a journey that will change all of their lives.\n\nIt's a dangerous quest for a mysterious samurai that will see our squabbling group of heroes get into and out of trouble more times than they can count (which admittedly, isn't very high). From the cynical gentility of the nobles to the backstabbing of the Japanese underworld, Mugen, Jin and Fuu will face threats from without and within as they hurl insults and throwing stars alike. Ancient Japan is about to get a lethal dose of street justice—Champloo style. And it will never be the same.\n\n(Source: TokyoPop)	https://cdn.myanimelist.net/images/manga/3/56743l.jpg	7.41	6285	3729	1446	Finished	f	2004-01-25 16:00:00-08	2004-09-24 17:00:00-07	10	2	2025-02-27 18:13:55.096516-08	2025-02-27 18:13:55.096516-08
513	Samurai Deeper Kyou	Samurai Deeper Kyo	SAMURAI DEEPER KYO	At the dawn of the 17th century, at the end of the era of civil wars, in a world of chaos, the epic Battle of Sekigahara was joined. One man emerged from the largest battle ever fought on Japanese soil; a terrible warrior of unspeakable power, he was nicknamed 'the unconquerable.'\n\nKyoshiro is a peaceful medicine peddler who harbors the soul of an assassin. He accompanies a young bounty hunter across Japan in search of a murderer and on a quest to discover the terrible secret of his own identity.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/157961l.jpg	7.67	11227	1915	740	Finished	f	1999-05-25 17:00:00-07	2006-05-09 17:00:00-07	308	38	2025-02-27 18:13:55.176384-08	2025-02-27 18:13:55.176384-08
514	Saver	Saver	세이버	Lena Ha is a beautiful and tough girl who is the captain of Kendo team. She meets Hye-Min Kang, the son of the president of a big company in Korea, and the two seem to feel love at first sight. But when Lena learns that she and Hye-Min are half-siblings, she runs away and falls into a strange body of water. When Lena comes to, she finds herself in a strange kingdom...and learns that she may be its only hope.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/150822l.jpg	7.92	2156	935	3123	Finished	f	2001-12-31 16:00:00-08	2009-12-31 16:00:00-08	55	17	2025-02-27 18:13:55.253879-08	2025-02-27 18:13:55.253879-08
516	Scrapped Princess	Scrapped Princess	スクラップド・プリンセス	Fifteen years ago, a set of twins—a girl and a boy—was born to the king of Linevan. Shortly after their birth, a prophecy foretold that when the girl turned 16, she would bring about the end of humanity. To avoid this terrible fate, the king ordered the princess disposed of... scrapped!\n\nShe miraculously survived and was raised away from the kingdom that would kill her. But now she has turned 15, and the king's guards have caught wind that she's still alive... and they set out to finish the job!\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/114613l.jpg	6.53	555	16101	12480	Finished	f	2001-12-31 16:00:00-08	2003-12-31 16:00:00-08	16	3	2025-02-27 18:13:55.377128-08	2025-02-27 18:13:55.377128-08
517	s.CRY.ed	Scryed	スクライド	22 years ago a mysterious seismic phenomenon rocked the Yokohama district, thrusting it miles into the sky and effectively separating it from the rest of Japan. In the following years, a fraction of the newborns in this fledgling world began to develop extraordinary powers, each unique to the personality of the possessor. These mutated humans became known as Alters and were responsible for turning the former Yokohama into a chaotic wasteland.\n\nNow, as the former metropolis continues to re-build itself, the Alters have fallen into two camps: those who have joined HOLY, a dogmatic organization that hopes to re-establish order and morality, and those who wish to lord over the comparatively weaker humans. Only Kazuma, a powerful Alter who's really only interested in looking out for himself and an orphan girl named Kanami, stands between them, suspicious of both sides and unaware that he may hold the key to harmonious co-existence.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/1/56325l.jpg	6.75	840	12882	9006	Finished	f	2001-05-30 17:00:00-07	2002-04-17 17:00:00-07	45	5	2025-02-27 18:13:55.503313-08	2025-02-27 18:13:55.503313-08
518	Secret Chaser	Secret Chaser	シークレットチェイサー	Follow the story of Tatsurou Shinozaki, a priest and private investigator who works to solve strange mysteries involving mystical influence. One day a woman comes to his church looking for the mysterious red penguin. She uses a post-hypnotic suggestion on him so that when the phrase "red penguin" is mentioned, he begins to hallucinate. As the journey to uncover the red penguin begins, secrets are uncovered about Tatsurou's past, including a shadowy society that may be linked to his suddenly unreliable memory.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/2/152333l.jpg	\N	\N	20444	35201	Finished	f	1997-12-31 16:00:00-08	1998-12-31 16:00:00-08	9	2	2025-02-27 18:13:55.554271-08	2025-02-27 18:13:55.554271-08
520	Sengoku Tsukiyo	Sengoku Nights	戦国月夜	Masayoshi Kurozuka is an ordinary high school boy...until the day he discovers that he is the reincarnation of an evil woman named Oni-hime, who sold her soul to the devil during Japan's warring period.\n\nMasayoshi must come to grips with his identity, all the while fighting off legions of ghosts—the remnants of men killed by Oni-hime. In order to free himself from this curse, Masayoshi must discover the truth behind Oni-hime's deal with the devil and clear her name in the eyes of the restless spirits seeking revenge.\n\n(Source: Tokyopop)	https://cdn.myanimelist.net/images/manga/3/155741l.jpg	6.70	271	13637	20458	Finished	f	1998-12-31 16:00:00-08	1999-12-31 16:00:00-08	10	2	2025-02-27 18:13:55.647869-08	2025-02-27 18:13:55.647869-08
\.


--
-- Data for Name: manga_genres; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.manga_genres (manga_id, genre_id) FROM stdin;
1	46
1	8
1	7
2	1
2	2
2	46
2	8
2	10
2	14
3	46
3	8
3	7
3	24
4	46
4	24
4	36
7	46
7	30
8	4
8	8
8	10
8	22
8	37
9	1
9	2
9	8
9	10
10	4
10	8
10	7
10	37
11	1
11	2
11	10
12	1
12	2
12	46
12	37
13	1
13	2
13	10
14	2
14	4
14	10
15	1
15	2
15	4
15	10
15	22
15	37
15	9
16	46
16	4
16	22
16	9
17	4
17	8
17	22
18	46
18	4
18	8
18	22
18	36
19	1
19	4
19	8
19	7
19	37
19	9
20	46
20	4
20	8
20	37
21	37
21	45
22	1
22	8
23	1
23	4
23	22
23	9
24	1
24	2
24	10
25	1
25	2
25	46
25	8
25	10
26	1
26	2
26	10
27	1
27	8
27	10
27	37
28	46
28	8
28	22
29	8
29	22
30	4
30	8
30	22
31	46
31	4
31	8
31	22
32	1
32	2
32	4
32	8
32	10
32	37
33	4
33	8
33	10
33	22
34	4
34	10
34	24
35	4
35	8
35	22
36	1
36	8
36	22
36	37
37	4
37	8
37	22
38	2
38	10
39	1
39	2
39	37
40	1
40	2
40	4
40	10
41	1
41	4
41	10
41	37
42	1
42	2
42	10
43	30
44	1
44	4
44	24
45	4
45	8
45	22
45	9
46	1
46	7
47	1
47	4
48	4
48	22
48	9
49	30
50	1
50	2
50	4
50	37
51	46
51	30
52	8
52	30
53	1
53	46
53	4
53	8
53	37
54	1
54	2
54	4
54	8
54	10
54	7
54	37
55	4
55	8
55	22
56	4
56	22
57	4
57	8
57	22
58	4
58	8
58	22
58	36
59	1
59	2
59	4
59	10
60	4
60	22
60	9
61	28
61	8
61	49
62	8
62	22
63	8
63	22
64	7
64	37
65	8
65	22
66	4
67	8
67	24
68	4
68	8
68	22
68	9
69	22
70	1
70	2
70	10
71	4
71	8
71	22
71	24
72	2
72	4
72	10
72	9
73	1
73	8
73	22
73	37
73	9
74	1
74	46
74	37
74	9
75	4
75	8
75	22
75	9
76	46
76	4
76	8
76	36
77	4
77	8
77	10
77	22
77	37
78	10
78	37
79	1
79	2
79	46
79	8
79	10
79	22
79	37
80	1
80	4
80	8
80	24
81	2
81	4
81	8
81	24
81	36
83	46
83	8
83	10
83	7
83	22
83	24
83	37
84	1
84	2
84	8
84	10
84	22
85	4
85	36
86	2
86	10
86	22
87	7
87	37
88	10
88	26
89	4
89	8
89	22
89	36
90	28
90	10
90	7
91	4
91	8
91	22
92	46
92	8
92	10
92	22
93	2
93	8
93	24
94	4
94	10
94	22
94	37
95	1
95	4
95	37
96	1
96	2
96	10
96	24
96	37
97	4
97	22
97	24
97	9
98	4
98	8
98	37
99	1
99	2
99	4
99	8
99	14
99	37
100	4
100	9
101	46
101	4
101	22
101	37
102	46
102	8
102	22
102	37
103	4
103	22
103	36
104	46
104	4
104	36
105	1
105	2
105	46
105	37
106	2
106	46
106	4
106	10
106	22
107	4
107	22
107	24
107	9
108	4
108	7
108	37
109	10
109	22
109	37
110	4
110	22
110	24
110	9
111	1
111	4
111	22
111	24
111	9
112	1
112	2
112	10
112	22
112	37
113	8
113	10
113	22
113	24
114	1
114	2
114	10
114	22
115	1
115	2
115	10
115	22
116	1
116	10
116	24
117	2
117	4
117	10
117	24
118	2
118	10
118	22
119	2
119	4
119	10
120	4
120	8
120	22
121	2
121	22
121	36
122	4
122	30
123	8
123	37
124	24
124	36
125	10
126	1
126	2
126	10
126	22
127	10
127	22
127	37
128	4
128	10
128	14
128	7
128	37
129	10
129	14
129	24
130	4
130	7
131	8
131	22
132	1
132	2
132	8
132	24
133	8
133	10
133	37
134	1
134	4
134	10
135	1
135	2
135	4
135	10
136	1
136	2
136	4
136	10
136	22
137	1
137	4
137	7
138	2
138	10
139	10
139	37
140	4
140	10
140	9
141	1
141	9
142	1
142	45
143	8
144	2
144	4
144	37
144	9
145	46
145	8
145	22
146	8
146	22
147	2
147	8
147	10
148	4
148	22
149	1
149	8
149	14
149	24
150	1
150	2
150	4
150	10
150	24
151	1
151	10
151	14
151	37
152	4
152	8
152	22
153	4
153	8
153	22
155	2
155	8
155	24
156	4
156	8
156	22
156	37
157	4
157	8
157	22
158	8
158	14
158	7
158	22
158	37
159	1
159	10
160	4
160	22
161	1
161	4
161	24
162	1
162	8
162	7
163	8
164	4
164	22
165	4
165	22
166	1
166	2
166	4
166	7
166	37
167	1
167	2
167	8
167	10
168	1
168	2
168	10
168	24
169	4
170	8
170	22
171	8
172	4
172	10
172	24
173	1
173	2
173	24
174	1
174	2
174	24
175	4
175	10
176	4
176	22
176	36
176	9
177	4
177	8
177	22
177	37
177	9
178	28
178	8
178	22
178	49
179	28
179	22
179	49
180	28
180	49
181	14
182	1
182	14
183	4
183	22
184	4
184	8
184	22
185	8
185	22
186	10
186	22
187	8
187	10
187	22
188	8
188	10
188	22
190	1
190	10
190	7
190	22
190	37
191	1
191	46
191	8
191	24
192	28
192	8
192	49
193	4
193	8
193	22
194	1
194	37
195	8
195	30
196	1
196	28
196	10
197	28
197	49
198	28
198	49
199	14
199	22
199	37
200	28
200	8
200	49
201	1
201	46
201	4
201	8
201	24
202	28
202	10
203	28
203	8
203	22
203	49
204	28
204	49
205	28
205	49
206	24
207	28
207	49
208	28
209	46
209	4
209	36
211	28
211	8
211	22
211	49
212	28
212	49
213	28
213	10
214	1
214	46
214	8
214	24
215	10
216	1
216	8
216	24
217	28
217	49
218	28
218	49
219	2
219	24
219	37
220	2
220	10
221	1
221	46
221	8
221	22
222	1
222	7
222	37
223	28
223	4
223	37
224	28
224	4
224	36
225	28
225	4
225	8
225	49
226	28
226	49
227	28
227	4
227	49
228	1
228	8
228	24
228	37
229	1
229	46
229	8
229	14
230	28
230	22
233	28
233	4
233	22
233	49
234	28
234	4
234	8
234	22
234	49
235	28
235	49
236	28
236	49
237	28
237	22
238	28
239	28
239	49
240	28
240	24
240	36
240	49
241	28
242	28
242	49
243	2
243	7
244	1
244	2
244	10
244	22
244	9
245	28
245	49
246	28
246	4
247	28
247	4
248	4
248	36
249	4
249	8
249	22
250	4
250	36
251	28
251	8
251	22
251	49
252	2
252	8
252	7
253	1
254	28
254	22
254	49
255	28
255	49
256	28
256	8
256	22
256	49
257	28
257	8
258	8
258	7
258	22
259	28
259	49
260	28
260	8
260	49
261	28
261	49
262	8
262	22
263	28
263	8
263	22
263	49
264	28
264	4
264	49
265	28
265	49
266	28
266	22
266	49
267	1
267	14
267	37
268	8
268	22
269	4
269	10
269	22
270	1
270	2
270	10
271	10
271	22
272	1
272	24
273	8
273	10
273	22
273	24
274	1
274	2
274	4
274	24
275	28
276	1
276	8
276	14
277	1
277	2
277	28
277	4
277	8
277	10
278	1
278	2
278	10
278	37
279	28
279	49
280	28
281	28
281	8
282	28
282	49
283	1
284	28
284	8
284	49
285	28
285	4
285	49
286	28
286	49
287	1
287	2
288	28
288	49
289	4
289	10
289	37
290	28
290	49
291	28
291	4
291	8
291	22
291	49
292	28
292	49
293	28
293	49
294	28
294	22
295	10
295	26
296	14
296	7
297	14
297	37
298	8
298	24
299	8
300	37
301	1
301	2
301	10
302	4
302	22
302	37
303	1
303	2
303	4
303	8
303	10
304	46
304	4
304	22
304	24
306	2
306	4
306	10
307	1
307	4
307	37
308	8
308	22
309	28
309	4
309	22
309	37
311	1
311	4
311	8
312	1
312	14
312	37
312	9
314	1
314	28
314	4
314	49
315	8
316	8
316	22
317	4
317	22
318	4
318	22
318	36
318	9
319	22
320	4
320	8
320	22
321	2
321	4
321	8
322	10
322	14
322	7
322	37
323	8
324	10
324	22
325	4
325	10
325	9
326	1
326	4
327	1
327	2
327	4
328	1
328	2
328	4
328	9
329	4
329	10
329	22
330	4
330	8
332	28
332	4
332	8
333	28
333	4
333	8
333	22
334	28
334	4
335	28
335	4
336	1
336	46
336	4
336	8
336	9
337	2
338	1
338	2
338	8
338	10
338	22
338	24
338	37
339	46
339	4
340	1
340	10
340	24
341	2
341	4
341	8
341	10
342	1
342	24
343	1
343	2
344	8
344	24
344	37
345	1
345	24
346	1
346	2
346	4
346	10
347	4
347	22
347	9
348	4
348	8
348	36
349	1
349	24
350	4
351	1
351	8
351	22
351	24
352	1
352	24
353	1
353	8
353	24
354	4
354	22
355	8
355	30
356	1
356	2
356	4
356	8
356	10
356	22
356	37
357	1
357	2
357	8
357	10
357	7
358	4
359	1
359	24
360	1
360	24
361	1
361	2
361	7
361	37
362	4
362	22
362	37
363	1
363	24
364	2
364	10
365	4
365	22
366	8
366	22
366	24
367	1
367	4
367	10
367	37
367	9
368	1
368	2
368	10
368	37
369	8
369	22
369	36
369	37
370	8
370	22
371	4
371	36
372	1
372	37
372	9
373	1
373	2
373	8
373	10
373	22
374	1
374	10
374	37
374	9
375	1
375	8
376	1
376	8
377	1
377	14
377	37
378	10
378	37
379	1
379	8
379	7
380	1
380	4
380	14
380	37
380	9
381	4
381	22
382	1
382	8
382	24
383	4
383	14
383	7
384	1
384	37
385	1
385	14
385	24
385	9
386	4
386	37
387	4
387	8
387	22
387	37
388	4
388	7
388	22
388	37
389	4
389	22
389	37
390	46
390	4
390	8
390	24
391	4
391	22
392	46
392	4
392	8
392	22
393	46
393	8
393	7
393	37
394	1
394	2
394	10
394	7
394	24
395	1
395	8
395	24
396	2
396	10
397	2
397	10
398	2
398	10
399	2
399	8
399	10
400	10
401	1
401	46
401	14
401	24
402	10
403	1
405	8
405	37
406	14
406	7
406	22
407	46
407	8
407	36
408	1
408	8
408	24
409	46
409	4
409	22
409	37
410	1
410	4
410	22
411	46
411	8
411	47
411	22
412	46
412	4
412	22
413	4
413	22
413	36
414	4
416	1
417	10
418	46
418	10
418	7
418	37
419	46
419	4
419	22
419	36
420	4
420	22
421	4
421	22
421	36
421	9
422	8
422	22
423	4
423	10
423	22
424	1
424	4
424	10
424	14
424	37
425	1
425	22
425	37
426	1
426	8
427	1
427	24
428	22
428	37
429	46
429	4
429	8
429	10
429	22
430	4
430	8
430	22
430	30
430	9
431	22
432	1
433	1
433	4
434	2
434	28
436	8
436	14
436	37
437	1
437	10
437	7
438	1
438	2
438	4
438	8
438	7
439	2
439	10
439	22
440	8
440	10
440	37
441	1
441	8
441	24
441	9
442	1
443	8
443	22
444	1
445	1
445	4
445	8
445	22
446	46
446	4
446	10
446	22
447	4
447	22
447	9
448	10
448	22
449	10
449	22
450	22
451	8
451	10
451	14
451	7
451	37
452	4
452	10
452	9
454	24
455	14
455	7
455	22
455	37
456	1
456	37
457	4
457	22
457	37
457	9
458	2
458	8
458	10
459	4
459	10
459	22
459	37
460	4
460	22
460	36
461	4
461	22
462	10
462	14
462	7
462	37
463	4
463	8
463	22
464	1
464	2
464	8
464	10
464	7
464	22
464	37
465	1
465	24
466	8
466	22
467	37
468	8
468	22
469	4
470	1
470	2
470	37
471	4
471	22
471	37
472	1
472	2
472	10
472	7
473	1
474	1
475	46
475	8
475	22
476	4
476	8
476	22
477	1
477	24
478	1
478	2
478	4
478	10
479	1
479	10
479	24
480	10
480	24
481	46
481	8
481	24
481	36
482	4
482	8
482	22
482	37
483	22
483	30
484	4
484	8
485	4
485	22
486	1
486	10
486	14
486	37
489	8
489	22
489	37
489	9
491	1
491	2
491	10
491	14
491	37
492	8
493	4
493	37
495	8
495	22
495	37
496	1
496	4
496	10
497	1
497	2
497	10
497	37
499	1
499	7
499	9
500	2
500	8
500	10
501	4
501	22
501	9
502	1
502	8
503	1
503	8
504	2
504	10
505	8
505	10
505	37
506	1
506	4
506	8
506	22
506	24
507	2
507	4
507	10
507	22
507	37
508	2
508	4
508	10
508	22
509	1
509	2
509	8
509	10
510	1
510	2
510	4
510	8
510	10
511	1
511	22
511	37
512	1
512	2
512	4
513	1
513	2
513	4
514	1
514	2
514	8
514	10
514	22
516	2
516	4
516	8
516	10
516	22
517	1
517	24
518	8
518	7
519	24
520	14
520	37
\.


--
-- Data for Name: user_ratings; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.user_ratings (user_id, manga_id, rating, review, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.users (user_id, username, email, password_hash, created_at) FROM stdin;
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- Name: genres genres_name_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_name_key UNIQUE (name);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genre_id);


--
-- Name: manga_genres manga_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.manga_genres
    ADD CONSTRAINT manga_genres_pkey PRIMARY KEY (manga_id, genre_id);


--
-- Name: manga manga_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.manga
    ADD CONSTRAINT manga_pkey PRIMARY KEY (manga_id);


--
-- Name: user_ratings user_ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_ratings
    ADD CONSTRAINT user_ratings_pkey PRIMARY KEY (user_id, manga_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: idx_manga_genres; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX idx_manga_genres ON public.manga_genres USING btree (manga_id, genre_id);


--
-- Name: idx_manga_popularity; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX idx_manga_popularity ON public.manga USING btree (popularity);


--
-- Name: idx_manga_score; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX idx_manga_score ON public.manga USING btree (score);


--
-- Name: idx_manga_title; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX idx_manga_title ON public.manga USING btree (title);


--
-- Name: idx_user_ratings; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX idx_user_ratings ON public.user_ratings USING btree (user_id, manga_id, rating);


--
-- Name: manga_genres manga_genres_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.manga_genres
    ADD CONSTRAINT manga_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(genre_id) ON DELETE CASCADE;


--
-- Name: manga_genres manga_genres_manga_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.manga_genres
    ADD CONSTRAINT manga_genres_manga_id_fkey FOREIGN KEY (manga_id) REFERENCES public.manga(manga_id) ON DELETE CASCADE;


--
-- Name: user_ratings user_ratings_manga_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_ratings
    ADD CONSTRAINT user_ratings_manga_id_fkey FOREIGN KEY (manga_id) REFERENCES public.manga(manga_id) ON DELETE CASCADE;


--
-- Name: user_ratings user_ratings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_ratings
    ADD CONSTRAINT user_ratings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

