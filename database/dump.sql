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
    "creditCardId" text NOT NULL,
    "orderedAt" timestamp with time zone DEFAULT now() NOT NULL
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
1	1	grove street
2	1	grove street
3	1	grove street
4	1	grove street
5	1	grove street
6	1	grove street
7	1	grove street
8	1	grove street
9	1	grove street
10	1	grove street
11	1	grove street
12	1	grove street
13	1	grove street
14	1	grove street
15	1	grove street
16	1	grove street
17	1	grove street
18	1	grove street
19	1	grove street
20	1	grove street
21	1	123 Apple St, Irvine, CA 91000
22	1	123 Test St, Irvine, CA 91000
23	1	123 Test St, Irvine, CA 92000
24	1	123 Apple St, Irvine, CA 92000
25	1	123 test Irvine
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
11
12
13
14
15
16
17
18
19
20
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
17	11	2	2.40
18	12	1	3.45
19	13	70	12.00
20	13	71	16.50
21	14	46	9.95
22	14	47	9.95
23	14	46	9.95
24	14	54	3.50
25	15	18	8
26	15	19	11
27	15	22	23
28	15	22	23
29	15	22	23
30	16	59	16.50
31	16	48	9.95
32	16	15	3
33	16	59	16.50
34	16	63	14.50
35	17	34	27
36	18	59	16.50
37	18	59	16.50
38	18	60	18.00
39	18	63	14.50
40	19	48	9.95
41	19	54	3.50
42	19	57	11.95
43	20	61	17.00
44	20	61	17.00
45	20	60	18.00
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories ("categoryId", name, "imageUrl") FROM stdin;
1	Asian	https://www.101corpuschristi.com/uploads/media/default/0001/23/fef92b31aa597167a112c932f2777db7941a79d3.jpeg
2	Fast Food	https://www.verdictfoodservice.com/wp-content/uploads/sites/31/2018/07/McDonaldsLunch_Dinner.jpg
3	Italian	https://www.lux-review.com/wp-content/uploads/2020/03/Pasta-1.jpg
4	Seafood	https://wallpapercave.com/wp/wp1912398.jpg
6	Vegan	https://crux.org.nz/assets/Uploads/Untitled-design-5-v2__ScaleWidthWzQwMF0.jpg
5	Mexican	https://communityimpact.com/wp-content/uploads/2019/05/LFH-2019-05-15-1.jpg
7	Coffee & Tea	https://static.wixstatic.com/media/861937_199818bd4e0a4ecab711c7cab4608778~mv2.jpg
8	Desserts	https://c1.wallpaperflare.com/preview/665/948/925/food-drink-food.jpg
\.


--
-- Data for Name: creditCard; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."creditCard" ("creditCardId", cvv, "billingAddress", "creditCardNumber", name) FROM stdin;
1	999	PO box 89888	5678	con
2	998	PO box 89888	5678	con
3	997	PO box 89888	5678	con
4	996	PO box 89888	5678	con
5	996	PO box 89888	5678	con
6	996	PO box 89888	5678	con
7	996	PO box 89888	5678	con
8	996	PO box 89888	5678	con
9	996	PO box 89888	5678	con
10	996	PO box 89888	5678	con
11	996	PO box 89888	5678	con
12	996	PO box 89888	5678	con
13	996	PO box 89888	5678	con
14	995	PO box 89888	5678	con
15	992	PO box 89888	5678	con
16	990	PO box 89888	5678	con
17	990	PO box 89888	5678	con
18	209	PO box 89888	5678	con
19	208	PO box 89888	5678	con
20	208	PO box 89888	5678	tia
21	208	PO box 89888	5678	real tia
22	111	PO box 12345	5678	tia kim
23	111	PO box 12345	5678	bose
24	123	123 Apple St, Irvine, CA 91000	1234 0000 0000 0000	Cinnamon Roll
25	123	123 Test St, Irvine, CA 91000	0000 0000 0000 0000	Test Kim
26	982	123 Test St, Irvine, CA 92000	0928 3728 4738 1234	Ti Kim
27	123	123 Apple St, Irvine, CA 92000	1247 8192 9012 1293	Tia Kim
28	123	123 test irvine 	1234 0000 0000 0000	Testing
\.


--
-- Data for Name: favoriteRestaurants; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."favoriteRestaurants" ("userId", "restaurantId") FROM stdin;
1	3
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
7	Burrito	72	7.75	Your choice of freshly grilled meat or sfritas wrapped in a warmed flour tortilla with rice, beans, or fajita veggies, and topped with guac, salsa, queso blanco, sour cream or cheese
7	Burrito Bowl	73	7.75	Your choice of freshly grilled meat or sofritas served in a delicious bowl with rice, beans, or fajita veggies, and topped with guac, salsa, queso blanco, sour cream or cheese
7	Salad	74	7.75	Served with our fresh supergreens lettuce blend made of Romaine, Baby Kale, and Baby Spinach. Add beans, queso blanco, salsa, guacamole, sour cream or cheese and top it off with our signature Chipotle-Honey Vinaigrette
7	Three Tacos	75	7.75	3 Tacos!
7	Keto Salad Bowl	76	10.15	Supergreens Lettuce Blend, Chicken, Tomatillo-Red Chili Salsa, Cheese  and Guacamole
7	Paleo Salad Bowl	77	10.15	Supergreens Lettuce Blend, Chicken, Fajita Veggies, Tomatillo-Green Chili Salsa and Guacamole
7	High Protein Bowl	78	12.00	White Rice, Chicken, Steak, Black Beans, Tomatillo-Red Chili Salsa, Cheese and Shredded Romaine Lettuce
7	Vegan Bowl	79	7.75	Brown Rice, Sofritas, Black Beans, Fresh Tomato Salsa, Roasted Chili-Corn Salsa and Shredded Romaine Lettuce
7	Vegetarian Bowl	80	7.75	Supergreens Lettuce Blend, Brown Rice, Black Beans, Fajita Veggies, Fresh Tomato Salsa and Guacamole
7	Mexican Coca-Cola	81	3.20	Mexican Coca-Cola
7	Blackberry Izze	82	3.00	Blackberry Izze
7	Bottled Water	83	2.60	Bottled Water
7	Pineapple Orange Banana Juice	84	3.00	Pineapple + Orange + Banana
7	Pressed Apple Juice	85	3.00	Pressed Apple Juice
8	Crispy Cauliflower	86	8.45	fresh cauliflower florets in panko breading choice of buffalo-style or orange dipping sauce
8	Kids Veggie Burger	87	8.95	House made veggie burger with lettuce, tomato, pickles and ketchup on a sesame bun
8	Pesto Zucchini Noodles	88	11.95	lightly seared zucchini noodles in basil pesto with arugula, parmesan, spicy italian sausage crumbles and roasted baby tomatoes
8	Far East Bowl	89	12.50	choice of grilled tempeh or crispy sesame chickin with  wild rice, broccolini, pickled vegetables, fresh herbs, and thai coconut curry sauce
8	Greek Mezze Salad	90	10.15	vg lettuce blend, tossed in our house vinaigrette with fresh herbs, marinated gigande beans, feta, roasted baby tomatoes, kalamata olives, cucumber, and 3-seed crunch
8	Catalina Taco Salad	91	11.95	achiote crumbles, lettuce mix, cabbage, tomato corn salsa, ranchero beans, jicama and avocado, tossed in catalina dressing
8	House Veggie Burger	92	12.00	wild rice mushroom burger, arugula, baby tomatoes, basil aioli, pickled onion on a whole grain sesame bun
8	Sweet Potato Fries	93	5.45	served with ketchup and chipotle aioli
8	The Caprese	94	8.20	layers of fresh tomato, farmers cheese, arugula, basil pesto, soft wheat roll
8	7 Layer Burrito	95	7.95	our play on a classic: layers of ranchero beans, wild rice, romaine lettuce, pico de gallo, mashed avocado, shredded cheddar cheese, chipotle cream, all wrapped in a warmed flour tortilla
8	La Colombe- Oat Milk Latte	96	4.75	oat milk latte
8	Oatmeal Cookie	97	2.75	Enriched flour, brown sugar, raisins, oats, natural vanilla flour, cinnamon
8	Carrot Cake	98	4.25	Fresh carrots, walnuts, VG cream cheese frosting
8	Chocolate Parfait	99	4.50	Layers of chocolate pudding and chocolate cookie crumbles, crema, and chocolate syrup
9	Vanilla Frappuccino	100	3.95	
9	Iced Coffee	101	2.95	
9	White Chocolate Mocha	102	4.45	
9	Cold Brew	103	4.50	
9	Iced Black Tea	104	2.75	
9	Iced Matcha Green Tea	105	3.25	
9	Iced Chai Tea Latte	106	3.75	
10	King Cream Donut	107	3.95	Soft Donut, Bavarian Cream, Powdered Sugar Contains: Egg, Milk, Soy, Wheat
10	Strawberry Croissant	108	4.31	Wheat flour, butter, sugar, milk powder, strawberries, choux cream, heavy cream, glaze, snow sugar Contains: Milk, Wheat
10	Almond Croissant	109	3.94	Wheat Flour, Almond Cream, Almond Contains: Almond, Coconut, Egg, Milk, Wheat
10	Honey & Garlic Baguette	110	3.11	Baguette, Garlic Cream, Honey Contains: Milk, Wheat
10	Fruit Bite (Blackberry & Kiwi)	111	2.39	Wheat Flour, Bavarian Cream, Blackberry, Kiwi Contains: Coconut, Milk, Wheat
10	Tiramisu Tart	112	3.35	Cream Cheese, chocolate Powder Contains: Egg, Milk, Wheat
10	Soft Cream Bread	113	5.94	 Coconut, Egg, Milk, Soy, Wheat 
11	Salt Ramen	114	7.99	Our signature ramen; silky tonkotsu broth enhanced with simple salt flavor.
11	Soy Sauce Ramen	115	8.99	Savory & complex flavor of soy sauce combined with silky tonkotsu broth with a hint of bonito dashi.
11	Miso Ramen	116	8.99	Robust miso paste and silky broth, with a hint of bonito dashi creates the gentle balance flavor.
11	Spicy Miso Ramen	117	9.99	Miso based ramen with a hint of spiciness gives a nice kick to the flavor.
11	Shiyake Ikura Gohan	118	8.49	Rice bowl topped with grilled salmon & salmon roe.
11	Chashu Gohan	119	8.49	Rice bowl topped with Cha-Shu (braised pork belly) with simmering stock.
11	Flavored Egg	120	0.99	Marinated soft boiled egg.
11	Takoyaki	121	12	Fried octopus balls dizzled with takoyaki sauce, Japanese mayo, topped with bonito flakes.
11	Gyoza	122	4.50	Pork & chicken pot stickers 5 pieces.
13	Blossom Platter	123	38	Our famous barbecue combination platter with jelly fish, pork hock, roast duck, B.B.Q. chicken, spicy beef shank, B.B.Q. pork and pickle vegetable.
13	Chinese Chicken Salad	124	10.95	Poach boneless & skinless chicken breast with fresh lettuce, rice noodle tossed in our sweet pickle & ginger sauce.
13	Guilin Shrimp Ball	125	15.95	A unique mixture of succulent shrimp paste, crumbly bread crispy cooked in perfect hue with Sam Woo plum sauce or sweet & sour sauce.
13	Deep Fried Stuffed Crab Claw (2)	126	12.95	Stuffed crab claw with shrimp paste, deep fried in light batter, served with sweet and sour sauce (option).
13	B.B.Q. Spareribs (4)	127	11.95	Barbecue honey-glazed back ribs, using our age-old technique, marinated in a well-guarded family B.B.Q. formula. You must try!
13	B.B.Q. Pork	128	9.95	Barbecue honey-glazed pork prepared in a secret flavoring using our ancient technique. You must try!
13	Fried Wonton (10)	129	7.95	Crispy and breakable noodle wrapper with shrimp paste, served with our fruity sweet & sour flavored sauce.
12	Cage Free Chicken Salad	131	7	Organic salad with chicken served with spicy miso dressing.
12	Crab Avocado Salad	132	8.50	Organic salad with crab and avocado served with creamy tomato dressing.
12	Giant Shrimp Ten Zaru	133	13	Shrimp tempura and asparagus in a roll with tempura batter on top.
12	Oyako Don 	134	8.50	Cage free chicken and egg cooked with special sauce served over organic brown rice, and includeds salad and miso soup.
12	Chicken Teriyaki Don	135	9	Cage free chicken with original teriyaki sauce
12	Crunchy Roll	136	5	Shrimp Tempura and asparagus along with various vegetables.
12	Wild Salmon Teriyaki	137	13	Grilled king salmon with original teriyaki sauce.
12	Prime Beef Steak 	138	15	Charbroiled prime rib eye with yuzu soy sauce.
14	Proscuitto Bruschetta	139	13	Crecenza cheese, grilled asparagus, truffle, grana padano
14	Italian Salad	140	15	Salami, provolone, pepperoncini, olive, campari tomato, red onion, cucumber, roasted pepper, oregano vinaigrette.
14	Crispy Pesto Chicken Sandwich	141	15	Fresh mozzarella, campari tomato, arugula, calabrian pesto aioli.
14	Famous Meatball Sandwich	142	15	Braised meatballs, marinara, scamorza cheese.
14	Chicken Parmesan	143	22	Crushed tomato, aged provolone, mozzarella, parmesan rigatoni.
14	Chicken Pesto	144	19	Gigli pasta, toasted pine nut, garlic, basil, crispy caper.
14	Strozzapreti	145	20	Chicken, roasted mushroom, spinach, toasted pine nut, parmesan cream.
14	Italian Grinder 	146	15	Rosemary ham, molinari salami, calabrese, fresh mozzarella, romaine, tomato, italian vinaigrette.
13	Fried Crab Puffs (8)	130	7.95	Crispy wheat wrapper stuffed with a tasty mixture of crab meat and cream cheese, served with plum sauce. Great starter!
15	AntiOxidant Salad	147	11.75	Lettuce blend, organic kale, cucumbers,  celery, mint, pickled onions, raw walnuts, grapes, mint vinaigrette.
15	Local Mixed Beet	148	11.75	Arugala, up lettuce blend, roasted tomatoes, organic carrot, jicama, preserved lemon vinaigrette.
15	Beets and Avocado	149	10	Organic red and white quinoa, beets, avocado, walnuts, pickled red onion, dates, hemp seeds, cabbage, coconut, miso lemongrass seasoning.
15	Chickpea and Sweet Potato Bowl	150	10	Organic lentils, cabbage, gogi berries, chia seeds, kale pesto, harissa sauce.
15	Curry Tofu and Vegetable Braise	151	10	Organic tofu slow cooked with organic carrots, organic apples and zucchini, in a green curry-coconut sauce, with ginger and garlic.
15	Caesar	152	15.50	Organic romaine lettuce, organic baby kale, organic tomatoes, garlic croutons, shaved asiago, caesar dressing
15	Cowgirl Cookie	153	2.75	Trail mix cookie! Made with organic sugar, organic flour, sunflower seeds, oats, dried cranberries, shredded coconut.
15	Chocolate Chunk Cookie	154	2.75	Made with organic earth balance, organic sugar, organic flour, bittersweet chocolate.
16	Pumpkin Pie Milk Tea	155	4.95	Pumpkin Topped with cheese foam and a sprinkle of nutmeg
16	Peach Me SweetTea	156	4.95	Peach & strawberry black tea with bits of both
16	Lychee Peachee	157	4.95	Peach black tea with diced lychee
16	Strawberry Ecsteasy	158	4.95	Strawberry black tea with black jelly
16	Sunset Peach	159	4.95	Peach, raspberry black tea with mango bits
16	Bootea Shaker	160	4.95	Mango, peach & pineapple tea with black jelly
16	Tootea Fruitea	161	4.95	Kiwi & pineapple black tea with diced jackfruit, lychee & longan
16	Jasmine Sunrise	162	5.95	Freshly squeezed orange juice with premium jasmine green iced tea
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders ("orderId", "cartId", "userId", "creditCardId", "orderedAt") FROM stdin;
6	11	1	13	2020-10-07 21:48:53.948748+00
7	11	1	14	2020-10-07 21:53:01.779037+00
8	11	1	15	2020-10-07 21:55:29.555576+00
9	11	1	16	2020-10-07 21:58:57.133735+00
10	11	1	17	2020-10-07 21:59:25.208094+00
11	11	1	18	2020-10-07 22:04:31.327508+00
12	11	1	19	2020-10-07 22:05:21.004184+00
13	12	1	20	2020-10-07 23:57:30.089243+00
14	13	1	21	2020-10-08 01:20:25.190776+00
15	14	1	22	2020-10-08 02:34:10.741586+00
16	15	1	23	2020-10-08 03:17:53.919305+00
17	16	1	24	2020-10-09 05:09:39.670251+00
18	17	1	25	2020-10-09 05:14:05.06845+00
19	18	1	26	2020-10-09 05:17:24.760906+00
20	19	1	27	2020-10-09 05:19:08.272191+00
21	20	1	28	2020-10-09 05:28:19.089588+00
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
Chipotle Mexican Grill	7	33.652126	-117.838115	4255 Campus Dr Ste A116, Irvine, CA 92612	5	https://i.insider.com/59c54032ba785e4a8e7a59f5?width=1100&format=jpeg&auto=webp	1.5	4.1
Veggie Grill	8	33.649728	-117.744836	732 Spectrum Center Dr, Irvine, CA 92618	6	https://cdn.vox-cdn.com/thumbor/sbhOTXRJki644945wjQVYRZbAig=/0x0:2000x1600/1200x0/filters:focal(0x0:2000x1600):no_upscale()/cdn.vox-cdn.com/uploads/chorus_asset/file/13055019/VeggieGrill_PChang_5196.jpg	1.5	4.3
Starbucks	9	33.65921	-117.748	14061 Jeffrey Rd, Irvine, CA 92620	7	https://i.pinimg.com/originals/ce/12/b8/ce12b8f50739dcaa3f0d61ff6b79e443.jpg	1.5	4.4
Paris Baguette	10	33.718496	-117.759125	4800 Irvine Blvd, Irvine, CA 92620	8	https://amazingsigns.com/wp-content/uploads/2017/07/523.jpg	1.5	4.6
Hokkaido Ramen Santouka	11	33.707023	-117.783469	El Camino Real, Irvine, CA 92604	1	https://uvillage.com/wp-content/uploads/2017/07/sakeikura-Combo-AJITAMA.jpg	3	4.6
Fukada	12	33.644371	-117.743044	8683 Irvine Center Dr, Irvine, CA 92618	1	https://s3-media0.fl.yelpcdn.com/bphoto/r0EcyFvjLgE1USJxsHcSxA/o.jpg	3	4.6
Sam Woo Seafood Restaurant	13	33.696262	-117.798458	15333 Culver Dr #720, Irvine, CA 92606	4	https://b.zmtcdn.com/data/reviews_photos/8bd/2aeb1bac7672a50896608fdc86fc98bd_1450942642.jpg?fit=around|750:500&crop=750:500;*,*	3	4.2
North Italia 	14	33.672127	-117.845028	2957 Michelson Dr, Irvine, CA 92612	3	https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/3276d233456403.56ab8e1d3b564.jpg	3	4.6
Urban Plates	15	33.729167	-117.789399	13380 Jamboree Rd, Irvine, CA 92602	6	https://urbanplates.com/wp-content/uploads/2017/10/Screen-Shot-2017-11-08-at-16.26.26.png	3	4.2
Tastea 	16	33.685395	-117.81045	3972 Barranca Pkwy K, Irvine, CA 92606	7	https://img.pagecloud.com/5DoaOSjW5ooaI0JK2hH_1VOr7nU=/432x0/filters:no_upscale()/tastea-2019/images/1-r353a.png	1.5	4.4
Ace Donut 	17	33.705553	-117.786928	14474 Culver Dr, Irvine, CA 92604	8	https://s3-media0.fl.yelpcdn.com/bphoto/WAJTplL7k6CjC8v9GnvBfA/o.jpg	1.5	4.0
SomiSomi 	18	33.651293	-117.745603	640 Spectrum Center Dr, Irvine, CA 92618	8	https://kirbiecravings.com/wp-content/uploads/2017/10/somi-somi-2ab.jpg	2.5	4.0
Slapfish 	19	33.650071	-117.838983	4249 Campus Dr Suite B148, Irvine, CA 92612	4	https://www.ocregister.com/wp-content/uploads/migration/npb/npbzc3-b88424176z.120150602115508000g40a2ql1.10.jpg?w=620	3	4.0
Tacos and Co  	20	33.669118	-117.765128	6616 Irvine Center Dr, Irvine, CA 92618	5	https://media-cdn.tripadvisor.com/media/photo-s/0c/60/36/10/excellent-chicken-tostada.jpg	3	4.4
The Kickin Crab	21	33.688816	-117.832866	2740 Alton Pkwy, Irvine, CA 92606	4	https://i.pinimg.com/originals/0c/25/0c/0c250cb7af0217e8efc8121fd9440a3f.jpg	3	4.4
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

SELECT pg_catalog.setval('public."address_addressId_seq"', 25, true);


--
-- Name: cartItems_cartItemId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."cartItems_cartItemId_seq"', 45, true);


--
-- Name: cart_cartId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."cart_cartId_seq"', 20, true);


--
-- Name: categories_categoryId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."categories_categoryId_seq"', 8, true);


--
-- Name: creditCard_creditCardId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."creditCard_creditCardId_seq"', 28, true);


--
-- Name: menuItems_menuItemId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."menuItems_menuItemId_seq"', 162, true);


--
-- Name: orders_cartId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."orders_cartId_seq"', 1, false);


--
-- Name: orders_orderId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."orders_orderId_seq"', 21, true);


--
-- Name: restaurants_restaurantId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."restaurants_restaurantId_seq"', 21, true);


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

