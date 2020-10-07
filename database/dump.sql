--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)

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

ALTER TABLE IF EXISTS ONLY public.restaurants DROP CONSTRAINT IF EXISTS restaurants_fk0;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_fk1;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_fk0;
ALTER TABLE IF EXISTS ONLY public."menuItems" DROP CONSTRAINT IF EXISTS "menuItems_fk0";
ALTER TABLE IF EXISTS ONLY public."favoriteRestaurants" DROP CONSTRAINT IF EXISTS "favoriteRestaurants_fk1";
ALTER TABLE IF EXISTS ONLY public."favoriteRestaurants" DROP CONSTRAINT IF EXISTS "favoriteRestaurants_fk0";
ALTER TABLE IF EXISTS ONLY public."cartItems" DROP CONSTRAINT IF EXISTS "cartItems_fk1";
ALTER TABLE IF EXISTS ONLY public."cartItems" DROP CONSTRAINT IF EXISTS "cartItems_fk0";
ALTER TABLE IF EXISTS ONLY public.address DROP CONSTRAINT IF EXISTS address_fk0;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pk;
ALTER TABLE IF EXISTS ONLY public.restaurants DROP CONSTRAINT IF EXISTS restaurants_pk;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_pk;
ALTER TABLE IF EXISTS ONLY public."menuItems" DROP CONSTRAINT IF EXISTS "menuItems_pk";
ALTER TABLE IF EXISTS ONLY public."creditCard" DROP CONSTRAINT IF EXISTS "creditCard_pkey";
ALTER TABLE IF EXISTS ONLY public.categories DROP CONSTRAINT IF EXISTS categories_pk;
ALTER TABLE IF EXISTS ONLY public.cart DROP CONSTRAINT IF EXISTS cart_pk;
ALTER TABLE IF EXISTS ONLY public."cartItems" DROP CONSTRAINT IF EXISTS "cartItems_pk";
ALTER TABLE IF EXISTS ONLY public.address DROP CONSTRAINT IF EXISTS address_pk;
ALTER TABLE IF EXISTS public.users ALTER COLUMN "userId" DROP DEFAULT;
ALTER TABLE IF EXISTS public.restaurants ALTER COLUMN "restaurantId" DROP DEFAULT;
ALTER TABLE IF EXISTS public.orders ALTER COLUMN "cartId" DROP DEFAULT;
ALTER TABLE IF EXISTS public.orders ALTER COLUMN "orderId" DROP DEFAULT;
ALTER TABLE IF EXISTS public."menuItems" ALTER COLUMN "menuItemId" DROP DEFAULT;
ALTER TABLE IF EXISTS public."creditCard" ALTER COLUMN "creditCardId" DROP DEFAULT;
ALTER TABLE IF EXISTS public.categories ALTER COLUMN "categoryId" DROP DEFAULT;
ALTER TABLE IF EXISTS public."cartItems" ALTER COLUMN "cartItemId" DROP DEFAULT;
ALTER TABLE IF EXISTS public.cart ALTER COLUMN "cartId" DROP DEFAULT;
ALTER TABLE IF EXISTS public.address ALTER COLUMN "addressId" DROP DEFAULT;
DROP SEQUENCE IF EXISTS public."users_userId_seq";
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public."restaurants_restaurantId_seq";
DROP TABLE IF EXISTS public.restaurants;
DROP SEQUENCE IF EXISTS public."orders_orderId_seq";
DROP SEQUENCE IF EXISTS public."orders_cartId_seq";
DROP TABLE IF EXISTS public.orders;
DROP SEQUENCE IF EXISTS public."menuItems_menuItemId_seq";
DROP TABLE IF EXISTS public."menuItems";
DROP TABLE IF EXISTS public."favoriteRestaurants";
DROP SEQUENCE IF EXISTS public."creditCard_creditCardId_seq";
DROP TABLE IF EXISTS public."creditCard";
DROP SEQUENCE IF EXISTS public."categories_categoryId_seq";
DROP TABLE IF EXISTS public.categories;
DROP SEQUENCE IF EXISTS public."cart_cartId_seq";
DROP SEQUENCE IF EXISTS public."cartItems_cartItemId_seq";
DROP TABLE IF EXISTS public."cartItems";
DROP TABLE IF EXISTS public.cart;
DROP SEQUENCE IF EXISTS public."address_addressId_seq";
DROP TABLE IF EXISTS public.address;
DROP EXTENSION IF EXISTS plpgsql;
DROP SCHEMA IF EXISTS public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.address (
    "addressId" integer NOT NULL,
    "userId" integer NOT NULL,
    address text NOT NULL
);


--
-- Name: address_addressId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."address_addressId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: address_addressId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."address_addressId_seq" OWNED BY public.address."addressId";


--
-- Name: cart; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart (
    "cartId" integer NOT NULL
);


--
-- Name: cartItems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."cartItems" (
    "cartItemId" integer NOT NULL,
    "cartId" integer NOT NULL,
    "menuItemId" integer NOT NULL,
    price numeric
);


--
-- Name: cartItems_cartItemId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."cartItems_cartItemId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cartItems_cartItemId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."cartItems_cartItemId_seq" OWNED BY public."cartItems"."cartItemId";


--
-- Name: cart_cartId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."cart_cartId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cart_cartId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."cart_cartId_seq" OWNED BY public.cart."cartId";


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    "categoryId" integer NOT NULL,
    name text NOT NULL,
    "imageUrl" text NOT NULL
);


--
-- Name: categories_categoryId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."categories_categoryId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_categoryId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."categories_categoryId_seq" OWNED BY public.categories."categoryId";


--
-- Name: creditCard; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."creditCard" (
    "creditCardId" integer NOT NULL,
    cvv integer NOT NULL,
    "billingAddress" text NOT NULL,
    "creditCardNumber" text NOT NULL,
    name text NOT NULL
);


--
-- Name: creditCard_creditCardId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."creditCard_creditCardId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: creditCard_creditCardId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."creditCard_creditCardId_seq" OWNED BY public."creditCard"."creditCardId";


--
-- Name: favoriteRestaurants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."favoriteRestaurants" (
    "userId" integer NOT NULL,
    "restaurantId" integer NOT NULL
);


--
-- Name: menuItems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."menuItems" (
    "restaurantId" integer NOT NULL,
    name text NOT NULL,
    "menuItemId" integer NOT NULL,
    price numeric NOT NULL,
    description text NOT NULL
);


--
-- Name: menuItems_menuItemId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."menuItems_menuItemId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: menuItems_menuItemId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."menuItems_menuItemId_seq" OWNED BY public."menuItems"."menuItemId";


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    "orderId" integer NOT NULL,
    "cartId" integer NOT NULL,
    "userId" integer NOT NULL,
    "creditCard" text NOT NULL,
    "orderedAt" timestamp with time zone NOT NULL
);


--
-- Name: orders_cartId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."orders_cartId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_cartId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."orders_cartId_seq" OWNED BY public.orders."cartId";


--
-- Name: orders_orderId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."orders_orderId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_orderId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."orders_orderId_seq" OWNED BY public.orders."orderId";


--
-- Name: restaurants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.restaurants (
    name text NOT NULL,
    "restaurantId" integer NOT NULL,
    lat numeric NOT NULL,
    lon numeric NOT NULL,
    address text NOT NULL,
    "categoryId" integer NOT NULL,
    image text NOT NULL,
    "deliveryFee" numeric NOT NULL,
    rating numeric NOT NULL
);


--
-- Name: restaurants_restaurantId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."restaurants_restaurantId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: restaurants_restaurantId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."restaurants_restaurantId_seq" OWNED BY public.restaurants."restaurantId";


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    "userId" integer NOT NULL
);


--
-- Name: users_userId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."users_userId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_userId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."users_userId_seq" OWNED BY public.users."userId";


--
-- Name: address addressId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.address ALTER COLUMN "addressId" SET DEFAULT nextval('public."address_addressId_seq"'::regclass);


--
-- Name: cart cartId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart ALTER COLUMN "cartId" SET DEFAULT nextval('public."cart_cartId_seq"'::regclass);


--
-- Name: cartItems cartItemId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."cartItems" ALTER COLUMN "cartItemId" SET DEFAULT nextval('public."cartItems_cartItemId_seq"'::regclass);


--
-- Name: categories categoryId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN "categoryId" SET DEFAULT nextval('public."categories_categoryId_seq"'::regclass);


--
-- Name: creditCard creditCardId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."creditCard" ALTER COLUMN "creditCardId" SET DEFAULT nextval('public."creditCard_creditCardId_seq"'::regclass);


--
-- Name: menuItems menuItemId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."menuItems" ALTER COLUMN "menuItemId" SET DEFAULT nextval('public."menuItems_menuItemId_seq"'::regclass);


--
-- Name: orders orderId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN "orderId" SET DEFAULT nextval('public."orders_orderId_seq"'::regclass);


--
-- Name: orders cartId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN "cartId" SET DEFAULT nextval('public."orders_cartId_seq"'::regclass);


--
-- Name: restaurants restaurantId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.restaurants ALTER COLUMN "restaurantId" SET DEFAULT nextval('public."restaurants_restaurantId_seq"'::regclass);


--
-- Name: users userId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN "userId" SET DEFAULT nextval('public."users_userId_seq"'::regclass);


--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.address ("addressId", "userId", address) FROM stdin;
\.


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart ("cartId") FROM stdin;
1
2
3
4
5
6
7
8
9
10
\.


--
-- Data for Name: cartItems; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."cartItems" ("cartItemId", "cartId", "menuItemId", price) FROM stdin;
1	4	9	1.65
2	5	10	1.85
3	6	10	1.85
4	7	16	18
5	8	4	1.60
6	9	4	1.60
7	9	9	1.65
8	9	10	1.85
9	9	2	2.40
10	9	55	3.50
11	9	21	20
12	9	50	9.95
13	9	50	9.95
14	10	59	16.50
15	10	59	16.50
16	10	60	18.00
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories ("categoryId", name, "imageUrl") FROM stdin;
1	Asian	https://www.101corpuschristi.com/uploads/media/default/0001/23/fef92b31aa597167a112c932f2777db7941a79d3.jpeg
2	Fast Food	https://www.verdictfoodservice.com/wp-content/uploads/sites/31/2018/07/McDonaldsLunch_Dinner.jpg
3	Italian	https://www.lux-review.com/wp-content/uploads/2020/03/Pasta-1.jpg
4	Seafood	https://wallpapercave.com/wp/wp1912398.jpg
\.


--
-- Data for Name: creditCard; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."creditCard" ("creditCardId", cvv, "billingAddress", "creditCardNumber", name) FROM stdin;
\.


--
-- Data for Name: favoriteRestaurants; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."favoriteRestaurants" ("userId", "restaurantId") FROM stdin;
\.


--
-- Data for Name: menuItems; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."menuItems" ("restaurantId", name, "menuItemId", price, description) FROM stdin;
4	DOUBLE-DOUBLE	1	3.45	
4	CHEESEBURGER	2	2.40	
4	HAMBURGER	3	2.10	
4	FRENCH FRIES	4	1.60	
4	DOUBLE-DOUBLE COMBO	5	6.70	
4	CHEESEBURGER COMBO	6	5.65	
4	HAMBURGER COMBO	7	5.35	
4	SMALL SOFT DRINK	8	1.50	
4	MEDIUM SOFT DRINK	9	1.65	
4	LARGE SOFT DRINK	10	1.85	
4	XL SOFT DRINK	11	2.05	
4	SHAKE	12	2.15	
4	COFFEE	13	1.35	
4	MILK	14	0.99	
3	Heavenly Biscuits	15	3	worth the wait
3	Home Smoked Salmon	16	18	served with our Chef’s dressing and toasts
3	Chilled Jumbo Shrimp	17	26	with cocktail and rémoulade sauces
3	Newport Beach Clam Chowder	18	8	served with bacon crumbles and croutons
3	Caesar Salad	19	11	grated Reggiano, rustic croutons, our signature Caesar dressing
3	Emerald Kale & Rotisserie Chicken Salad	20	18	with cashews and sesame miso vinaigrette
3	Chopped Vegetable Salad	21	20	avocado, beets, grapes, chopped egg, macadamia nuts, fresh herbs
3	Pan-seared Ahi Tuna	22	23	with almond sauce, and salad of mango, avocado, cucumber, sesame miso dressing
3	Cheeseburger	23	17	freshly ground chuck steak, served all the way on a toasted bun
3	Ding’s Crispy Chicken Sandwich	24	18	crispy buttermilk fried chicken, baby Swiss, spicy slaw
3	Rotisserie Chicken	25	24	herb roasted with pan juices
3	Mustard Barbecue Pork Ribs	26	28	fall-off-the-bone tender, with our house-made barbecue sauce
3	Rutherford Rib-eye	27	50	hand-selected and lightly seasoned, with house-made Worcestershire
3	‘The Duke’ Filet Mignon	28	39	usda prime center-cut tenderloin
3	Wild Rice with Champagne Vinaigrette and Almonds	29	5	
3	Coleslaw	30	5	
3	Broccoli with Reggiano	31	5	
3	Heirloom Cauliflower	32	5	
3	Pomme Purée	33	5	
5	Uni Pasta	34	27	Uni Cream Sauce, Dried Seaweed, Fish Roe, Chives
5	EMC Clam Chowder	35	9	Clams, Bacon, Potatoes, Celery, Onions, Light Creamy Broth
5	Grilled Oysters	36	10	Choice of Garlic Butter, Smoke Salt, Rockefeller, or Cajun Garlic
5	Fish Tacos	37	5.5	Fried or Pan Seared
5	Lobster Ravioli	38	21.5	Shrimp, Clam , Chardonnay Sauce
5	Blue Crab Lettuce Cups	39	15.5	Blue Crab, Tomatoes, Bacon, Avocado, Louie Sauce, Butter Lettuce
5	Truffle Sliders	40	16.5	Angus Beef, Mushrooms, Munster, Truffle Shaving Saunce, Shitake Aioli, Brioche Bun
6	Baconator	41	8.99	1/2 Double Beef , Bacon, Cheese
6	Big Bacon Classic	42	6.99	1/3 Beef , Bacon, Cheese
6	Grilled Chicken Sandwich	43	5.49	Grilled Chicken, Lettuce, Tomatoes, Onion
6	Southwest Avocado Chicken Salad	44	14.5	Lettuce, Avocado, Chicken, Tomatoes, Southwest Sauce
6	4 for $5	45	5	Chicken Sandwich, 10pc nuggets, french fries, and a drink
1	Pad Thai	46	9.95	Stir-fried rice noodles with our special seasoning, egg, green onions, bean sprouts, and sprinkled with ground peanuts. Gluten-free
1	Pad See Ewe	47	9.95	Soft wide rice noodles stir-fried with sweet black soy sauce, egg, broccoli, mushrooms, carrots, and baby corn. Sweet and savory.
1	Pad Kee Mow	48	9.95	Soft wide rice noodles stir-fried with garlic, Thai basil, sprouts, carrots, and onions. Served over lettuce. Savory, tangy, delicious!
1	Pineapple Fried Rice	49	10.95	Curry-seasoned fried rice with pineapple, onions, carrots, cashew nuts and raisins. Gluten-free
1	Thai Spice Fried Rice 	50	9.95	Our signature fried rice with a tangy and savory seasoning, Thai basil, bean sprouts, carrots, onions, and garlic
1	Chicken Yellow Curry	51	10.95	A classic favorite, tender chicken and potato cooked in yellow curry and Thai coconut milk. Served with rice. Gluten-free
1	Green Curry 	52	11.95	Tender beef, white meat chicken, or tofu with bell pepper, bamboo shoots, zucchini, peas and carrots in green curry and Thai coconut milk. Served with rice on the side. Gluten-free
1	Mango with Sweet Sticky Rice	53	4.95	Seasonal
1	Thai Iced Tea	54	3.50	Traditional Thai iced tea cold-brewed on site. Non-dairy creamer added to create a sweet delicious drink
1	Thai Iced Coffee	55	3.50	Iced dark cold-brewed coffee Thai-style with non-dairy creamer added
1	Thai Chicken Salad	56	12.95	Seasoned chicken breast with lettuce, cucumbers, broccoli, tomatoes, onions, carrots, and bell pepper topped with crunchy noodles, choice of dressing: Zesty Lemon, peanut sauce or honey ranch
1	Thai Beef Salad	57	11.95	Sliced tender beef with cucumbers, tomatoes, onions, carrots, celery, and tossed with our Thai citrus dressing. Beef is NOT gluten-free
1	Tom Ka Kai	58	6.25	Sliced chicken breast with mushrooms, celery, white onion, herbs and seasoning in a traditional Thai coconut milk broth
2	Margherita Pizza	59	16.50	Tomato sauce + house made mozzarella + basil
2	Pepperoni + Sausage Pizza	60	18.00	Ricotta + fresh mozzarella + tomato + garlic + basil
2	Fig + stracchino	61	17.00	Garlic + hot honey + arugula
2	Cheese Pizza	62	14.00	Cheese Pizza
2	Vegan Pizza	63	14.50	Chefs whim
2	Clam + squid ink linguine	64	24.00	Charred tomato + fennel soffritto + creme fraiche
2	Bucatini amatriciana	65	19.50	Guanciale + tomato + onion + chili + pecorino
2	Rigatoni Bolognese	66	20.00	Veal + pork + lemon ricotta + grana padano
2	Cucina burger	67	19.00	Taleggio + port wine onion + porcini aioli + brioche bun + parmesan fries
2	Olive oil cake	68	10.00	Seasonal fruit + pistachio whip
2	Chocolate panna cotta	69	9.00	Mascarpone crema + cacao nib
2	Cannellini bean hummus	70	12.00	Sicilian pesto + pistachio + market vegetable + baguette
2	Charred Octopus	71	16.50	Gigante bean + fennel + lemon yogurt + brown butter vinaigrette
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders ("orderId", "cartId", "userId", "creditCard", "orderedAt") FROM stdin;
\.


--
-- Data for Name: restaurants; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.restaurants (name, "restaurantId", lat, lon, address, "categoryId", image, "deliveryFee", rating) FROM stdin;
Thai Kitchen	1	33.681696	-117.805381	4250 Barranca Pkwy U, Irvine, CA 92604	1	https://s3-media0.fl.yelpcdn.com/bphoto/0WeCs_i9u8gda6wu0gRvJA/o.jpg	1.5	4.3
Cucina Enoteca	2	33.652052	-117.746196	532 Spectrum Center Dr, Irvine, CA 92618	3	https://s3-media0.fl.yelpcdn.com/bphoto/aIuIwCKEI89hWUHDFrCMZw/o.jpg	3.0	4.4
Gulfstream	3	33.6060070000	-117.8752780000	850 Avocado Ave, Newport Beach 92660	4	https://gulfstreamrestaurant.com/images/gallery/bartender.jpg	2	4.2
In-N-Out Burger	4	33.65019	-117.84073	4115 Campus Drive, 92612	2	https://www.in-n-out.com/Frontend-Assembly/Telerik.Sitefinity.Frontend/content/images/homepage/double-double.png?package=INNOUT	1.5	4.2
EMC Seafood	5	33.669445	-117.823059	Heritage Plaza, 14346 Culver Dr, Irvine, CA 92604	4	https://www.emcseafood.com/wp-content/uploads/2014/05/emc-seafood-pasta.jpg	2	4.4
Wendys 	6	33.652052	-117.823056	14386 Culver Dr, Irvine, CA 92604	2	https://dynl.mktgcdn.com/p/IqIuwfyfi12qOxK54MtSfQYHxfpxRFtNL8AMbSeNACk/1900x1068.jpg	1.5	4.0
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users ("userId") FROM stdin;
1
\.


--
-- Name: address_addressId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."address_addressId_seq"', 1, false);


--
-- Name: cartItems_cartItemId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."cartItems_cartItemId_seq"', 16, true);


--
-- Name: cart_cartId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."cart_cartId_seq"', 10, true);


--
-- Name: categories_categoryId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."categories_categoryId_seq"', 4, true);


--
-- Name: creditCard_creditCardId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."creditCard_creditCardId_seq"', 1, false);


--
-- Name: menuItems_menuItemId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."menuItems_menuItemId_seq"', 71, true);


--
-- Name: orders_cartId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."orders_cartId_seq"', 1, false);


--
-- Name: orders_orderId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."orders_orderId_seq"', 1, false);


--
-- Name: restaurants_restaurantId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."restaurants_restaurantId_seq"', 6, true);


--
-- Name: users_userId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."users_userId_seq"', 1, true);


--
-- Name: address address_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pk PRIMARY KEY ("addressId");


--
-- Name: cartItems cartItems_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."cartItems"
    ADD CONSTRAINT "cartItems_pk" PRIMARY KEY ("cartItemId");


--
-- Name: cart cart_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pk PRIMARY KEY ("cartId");


--
-- Name: categories categories_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pk PRIMARY KEY ("categoryId");


--
-- Name: creditCard creditCard_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."creditCard"
    ADD CONSTRAINT "creditCard_pkey" PRIMARY KEY ("creditCardId");


--
-- Name: menuItems menuItems_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."menuItems"
    ADD CONSTRAINT "menuItems_pk" PRIMARY KEY ("menuItemId");


--
-- Name: orders orders_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pk PRIMARY KEY ("orderId");


--
-- Name: restaurants restaurants_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT restaurants_pk PRIMARY KEY ("restaurantId");


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY ("userId");


--
-- Name: address address_fk0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_fk0 FOREIGN KEY ("userId") REFERENCES public.users("userId");


--
-- Name: cartItems cartItems_fk0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."cartItems"
    ADD CONSTRAINT "cartItems_fk0" FOREIGN KEY ("cartId") REFERENCES public.cart("cartId");


--
-- Name: cartItems cartItems_fk1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."cartItems"
    ADD CONSTRAINT "cartItems_fk1" FOREIGN KEY ("menuItemId") REFERENCES public."menuItems"("menuItemId");


--
-- Name: favoriteRestaurants favoriteRestaurants_fk0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."favoriteRestaurants"
    ADD CONSTRAINT "favoriteRestaurants_fk0" FOREIGN KEY ("userId") REFERENCES public.users("userId");


--
-- Name: favoriteRestaurants favoriteRestaurants_fk1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."favoriteRestaurants"
    ADD CONSTRAINT "favoriteRestaurants_fk1" FOREIGN KEY ("restaurantId") REFERENCES public.restaurants("restaurantId");


--
-- Name: menuItems menuItems_fk0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."menuItems"
    ADD CONSTRAINT "menuItems_fk0" FOREIGN KEY ("restaurantId") REFERENCES public.restaurants("restaurantId");


--
-- Name: orders orders_fk0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_fk0 FOREIGN KEY ("cartId") REFERENCES public.cart("cartId");


--
-- Name: orders orders_fk1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_fk1 FOREIGN KEY ("userId") REFERENCES public.users("userId");


--
-- Name: restaurants restaurants_fk0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT restaurants_fk0 FOREIGN KEY ("categoryId") REFERENCES public.categories("categoryId");


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

