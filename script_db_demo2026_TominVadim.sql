--
-- PostgreSQL database dump
--


-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

-- Started on 2026-02-18 15:38:15

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 224 (class 1259 OID 16451)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16519)
-- Name: order_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_status (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.order_status OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16549)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    order_date date,
    delivery_date date,
    pickup_points_id integer,
    user_id integer,
    delivery_code integer,
    status_id integer
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16415)
-- Name: pickup_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pickup_points (
    id integer NOT NULL,
    index integer,
    city character varying(255),
    street character varying(255),
    building integer
);


ALTER TABLE public.pickup_points OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16457)
-- Name: producers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producers (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.producers OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16491)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    article character varying(255),
    name character varying(255),
    unit_id integer,
    price integer,
    provider_id integer,
    producer_id integer,
    category_id integer,
    discount integer,
    amount integer,
    description text,
    photo character varying(255)
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16576)
-- Name: products_in_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_in_orders (
    id integer NOT NULL,
    order_id integer,
    product_id integer,
    amount integer
);


ALTER TABLE public.products_in_orders OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16445)
-- Name: providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.providers (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.providers OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16423)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16439)
-- Name: units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.units (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.units OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16429)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    role_id integer,
    surname character varying(255),
    name character varying(255),
    father_name character varying(255),
    email character varying(255),
    password character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 5079 (class 0 OID 16451)
-- Dependencies: 224
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories VALUES (2, 'Мужская обувь');
INSERT INTO public.categories VALUES (1, 'Женская обувь');


--
-- TOC entry 5082 (class 0 OID 16519)
-- Dependencies: 227
-- Data for Name: order_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_status VALUES (2, 'Новый');
INSERT INTO public.order_status VALUES (1, 'Завершен');


--
-- TOC entry 5083 (class 0 OID 16549)
-- Dependencies: 228
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orders VALUES (1, '2025-02-27', '2025-04-20', 1, 4, 901, 1);
INSERT INTO public.orders VALUES (2, '2022-09-28', '2025-04-21', 11, 1, 902, 1);
INSERT INTO public.orders VALUES (3, '2025-03-21', '2025-04-22', 2, 2, 903, 1);
INSERT INTO public.orders VALUES (4, '2025-02-20', '2025-04-23', 11, 3, 904, 1);
INSERT INTO public.orders VALUES (5, '2025-03-17', '2025-04-24', 2, 4, 905, 1);
INSERT INTO public.orders VALUES (6, '2025-03-01', '2025-04-25', 15, 1, 906, 1);
INSERT INTO public.orders VALUES (7, '2025-02-28', '2025-04-26', 3, 2, 907, 1);
INSERT INTO public.orders VALUES (8, '2025-03-31', '2025-04-27', 19, 3, 908, 2);
INSERT INTO public.orders VALUES (9, '2025-04-02', '2025-04-28', 5, 4, 909, 2);
INSERT INTO public.orders VALUES (10, '2025-04-03', '2025-04-29', 19, 4, 910, 2);


--
-- TOC entry 5074 (class 0 OID 16415)
-- Dependencies: 219
-- Data for Name: pickup_points; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pickup_points VALUES (1, 420151, 'Лесной', 'Вишневая', 32);
INSERT INTO public.pickup_points VALUES (2, 125061, 'Лесной', 'Подгорная', 8);
INSERT INTO public.pickup_points VALUES (3, 630370, 'Лесной', 'Шоссейная', 24);
INSERT INTO public.pickup_points VALUES (4, 400562, 'Лесной', 'Зеленая', 32);
INSERT INTO public.pickup_points VALUES (5, 614510, 'Лесной', 'Маяковского', 47);
INSERT INTO public.pickup_points VALUES (6, 410542, 'Лесной', 'Светлая', 46);
INSERT INTO public.pickup_points VALUES (7, 620839, 'Лесной', 'Цветочная', 8);
INSERT INTO public.pickup_points VALUES (8, 443890, 'Лесной', 'Коммунистическая', 1);
INSERT INTO public.pickup_points VALUES (9, 603379, 'Лесной', 'Спортивная', 46);
INSERT INTO public.pickup_points VALUES (10, 603721, 'Лесной', 'Гоголя', 41);
INSERT INTO public.pickup_points VALUES (11, 410172, 'Лесной', 'Северная', 13);
INSERT INTO public.pickup_points VALUES (12, 614611, 'Лесной', 'Молодежная', 50);
INSERT INTO public.pickup_points VALUES (13, 454311, 'Лесной', 'Новая', 19);
INSERT INTO public.pickup_points VALUES (14, 660007, 'Лесной', 'Октябрьская', 19);
INSERT INTO public.pickup_points VALUES (15, 603036, 'Лесной', 'Садовая', 4);
INSERT INTO public.pickup_points VALUES (16, 394060, 'Лесной', 'Фрунзе', 43);
INSERT INTO public.pickup_points VALUES (17, 410661, 'Лесной', 'Школьная', 50);
INSERT INTO public.pickup_points VALUES (18, 625590, 'Лесной', 'Коммунистическая', 20);
INSERT INTO public.pickup_points VALUES (19, 625683, 'Лесной', '8 марта', NULL);
INSERT INTO public.pickup_points VALUES (20, 450983, 'Лесной', 'Комсомольская', 26);
INSERT INTO public.pickup_points VALUES (21, 394782, 'Лесной', 'Чехова', 3);
INSERT INTO public.pickup_points VALUES (22, 603002, 'Лесной', 'Дзержинского', 28);
INSERT INTO public.pickup_points VALUES (23, 450558, 'Лесной', 'Набережная', 30);
INSERT INTO public.pickup_points VALUES (24, 344288, 'Лесной', 'Чехова', 1);
INSERT INTO public.pickup_points VALUES (25, 614164, 'Лесной', 'Степная', 30);
INSERT INTO public.pickup_points VALUES (26, 394242, 'Лесной', 'Коммунистическая', 43);
INSERT INTO public.pickup_points VALUES (27, 660540, 'Лесной', 'Солнечная', 25);
INSERT INTO public.pickup_points VALUES (28, 125837, 'Лесной', 'Шоссейная', 40);
INSERT INTO public.pickup_points VALUES (29, 125703, 'Лесной', 'Партизанская', 49);
INSERT INTO public.pickup_points VALUES (30, 625283, 'Лесной', 'Победы', 46);
INSERT INTO public.pickup_points VALUES (31, 614753, 'Лесной', 'Полевая', 35);
INSERT INTO public.pickup_points VALUES (32, 426030, 'Лесной', 'Маяковского', 44);
INSERT INTO public.pickup_points VALUES (33, 450375, 'Лесной', 'Клубная', 44);
INSERT INTO public.pickup_points VALUES (34, 625560, 'Лесной', 'Некрасова', 12);
INSERT INTO public.pickup_points VALUES (35, 630201, 'Лесной', 'Комсомольская', 17);
INSERT INTO public.pickup_points VALUES (36, 190949, 'Лесной', 'Мичурина', 26);


--
-- TOC entry 5080 (class 0 OID 16457)
-- Dependencies: 225
-- Data for Name: producers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.producers VALUES (1, 'Kari');
INSERT INTO public.producers VALUES (2, 'Marco Tozzi');
INSERT INTO public.producers VALUES (3, 'Рос');
INSERT INTO public.producers VALUES (4, 'Rieker');
INSERT INTO public.producers VALUES (5, 'Alessio Nesca');
INSERT INTO public.producers VALUES (6, 'CROSBY');


--
-- TOC entry 5081 (class 0 OID 16491)
-- Dependencies: 226
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products VALUES (1, 'А112Т4', 'Ботинки', 1, 4990, 1, 1, 1, 3, 6, 'Женские Ботинки демисезонные kari', '1.jpg');
INSERT INTO public.products VALUES (2, 'F635R4', 'Ботинки', 1, 3244, 2, 2, 1, 2, 13, 'Ботинки Marco Tozzi женские демисезонные, размер 39, цвет бежевый', '2.jpg');
INSERT INTO public.products VALUES (3, 'H782T5', 'Туфли', 1, 4499, 1, 1, 2, 4, 5, 'Туфли kari мужские классика MYZ21AW-450A, размер 43, цвет: черный', '3.jpg');
INSERT INTO public.products VALUES (4, 'G783F5', 'Ботинки', 1, 5900, 1, 3, 2, 2, 8, 'Мужские ботинки 3-Обувь кожаные с натуральным мехом', '4.jpg');
INSERT INTO public.products VALUES (5, 'J384T6', 'Ботинки', 1, 3800, 2, 4, 2, 2, 16, 'B3430/14 Полуботинки мужские Rieker', '5.jpg');
INSERT INTO public.products VALUES (6, 'D572U8', 'Кросовки', 1, 4100, 2, 3, 2, 3, 6, '129615-4 К3совки мужские', '6.jpg');
INSERT INTO public.products VALUES (7, 'F572H7', 'Туфли', 1, 2700, 1, 2, 1, 2, 14, 'Туфли Marco Tozzi женские летние, размер 39, цвет черный', '7.jpg');
INSERT INTO public.products VALUES (8, 'D329H3', 'Полуботинки', 1, 1890, 2, 5, 1, 4, 4, 'Полуботинки Alessio Nesca женские 3-30797-47, размер 37, цвет: бордовый', '8.jpg');
INSERT INTO public.products VALUES (9, 'B320R5', 'Туфли', 1, 4300, 1, 4, 1, 2, 6, 'Туфли Rieker женские демисезонные, размер 41, цвет коричневый', '9.jpg');
INSERT INTO public.products VALUES (10, 'G432E4', 'Туфли', 1, 2800, 1, 1, 1, 3, 15, 'Туфли kari женские TR-YR-413017, размер 37, цвет: черный', '10.jpg');
INSERT INTO public.products VALUES (11, 'S213E3', 'Полуботинки', 1, 2156, 2, 6, 2, 3, 6, '407700/01-01 Полуботинки мужские CROSBY', NULL);
INSERT INTO public.products VALUES (12, 'E482R4', 'Полуботинки', 1, 1800, 1, 1, 1, 2, 14, 'Полуботинки kari женские MYZ20S-149, размер 41, цвет: черный', NULL);
INSERT INTO public.products VALUES (13, 'S634B5', 'Кеды', 1, 5500, 2, 6, 2, 3, 6, 'Кеды Caprice мужские демисезонные, размер 42, цвет черный', NULL);
INSERT INTO public.products VALUES (14, 'K345R4', 'Полуботинки', 1, 2100, 2, 6, 2, 2, 3, '407700/01-02 Полуботинки мужские CROSBY', NULL);
INSERT INTO public.products VALUES (15, 'O754F4', 'Туфли', 1, 5400, 2, 4, 1, 4, 18, 'Туфли женские демисезонные Rieker артикул 55073-68/37', NULL);
INSERT INTO public.products VALUES (16, 'G531F4', 'Ботинки', 1, 6600, 1, 1, 1, 2, 9, 'Ботинки женские зимние ROMER арт. 893167-01 Черный', NULL);
INSERT INTO public.products VALUES (17, 'J542F5', 'Тапочки', 1, 500, 1, 1, 2, 3, 12, 'Тапочки мужские Арт.70701-55-67син р.41', NULL);
INSERT INTO public.products VALUES (18, 'B431R5', 'Ботинки', 1, 2700, 2, 4, 2, 2, 5, 'Мужские кожаные ботинки/мужские ботинки', NULL);
INSERT INTO public.products VALUES (19, 'P764G4', 'Туфли', 1, 6800, 1, 6, 1, 3, 15, 'Туфли женские, ARGO, размер 38', NULL);
INSERT INTO public.products VALUES (20, 'C436G5', 'Ботинки', 1, 10200, 1, 5, 1, 2, 9, 'Ботинки женские, ARGO, размер 40', NULL);
INSERT INTO public.products VALUES (21, 'F427R5', 'Ботинки', 1, 11800, 2, 4, 1, 4, 11, 'Ботинки на молнии с декоративной пряжкой FRAU', NULL);
INSERT INTO public.products VALUES (22, 'N457T5', 'Полуботинки', 1, 4600, 1, 6, 1, 3, 13, 'Полуботинки Ботинки черные зимние, мех', NULL);
INSERT INTO public.products VALUES (23, 'D364R4', 'Туфли', 1, 12400, 1, 1, 1, 2, 5, 'Туфли Luiza Belly женские Kate-lazo черные из натуральной замши', NULL);
INSERT INTO public.products VALUES (24, 'S326R5', 'Тапочки', 1, 9900, 2, 6, 2, 3, 15, 'Мужские кожаные тапочки Профиль С.Дали ', NULL);
INSERT INTO public.products VALUES (25, 'L754R4', 'Полуботинки', 1, 1700, 1, 1, 1, 2, 7, 'Полуботинки kari женские WB2020SS-26, размер 38, цвет: черный', NULL);
INSERT INTO public.products VALUES (26, 'M542T5', 'Кросовки', 1, 2800, 2, 4, 2, 5, 3, 'Кросовки мужские TOFA', NULL);
INSERT INTO public.products VALUES (27, 'D268G5', 'Туфли', 1, 4399, 2, 4, 1, 3, 12, 'Туфли Rieker женские демисезонные, размер 36, цвет коричневый', NULL);
INSERT INTO public.products VALUES (28, 'T324F5', 'Сапоги', 1, 4699, 1, 6, 1, 2, 5, 'Сапоги замша Цвет: синий', NULL);
INSERT INTO public.products VALUES (29, 'K358H6', 'Тапочки', 1, 599, 1, 4, 2, 3, 2, 'Тапочки мужские син р.41', NULL);
INSERT INTO public.products VALUES (30, 'H535R5', 'Ботинки', 1, 2300, 2, 4, 1, 2, 7, 'Женские Ботинки демисезонные', NULL);


--
-- TOC entry 5084 (class 0 OID 16576)
-- Dependencies: 229
-- Data for Name: products_in_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products_in_orders VALUES (1, 1, 1, 2);
INSERT INTO public.products_in_orders VALUES (2, 2, 3, 1);
INSERT INTO public.products_in_orders VALUES (3, 3, 5, 10);
INSERT INTO public.products_in_orders VALUES (4, 4, 7, 5);
INSERT INTO public.products_in_orders VALUES (5, 5, 1, 2);
INSERT INTO public.products_in_orders VALUES (6, 6, 3, 1);
INSERT INTO public.products_in_orders VALUES (7, 7, 5, 10);
INSERT INTO public.products_in_orders VALUES (8, 8, 7, 5);
INSERT INTO public.products_in_orders VALUES (9, 9, 9, 5);
INSERT INTO public.products_in_orders VALUES (10, 10, 11, 5);
INSERT INTO public.products_in_orders VALUES (11, 1, 2, 2);
INSERT INTO public.products_in_orders VALUES (12, 2, 4, 1);
INSERT INTO public.products_in_orders VALUES (13, 3, 6, 10);
INSERT INTO public.products_in_orders VALUES (14, 4, 8, 4);
INSERT INTO public.products_in_orders VALUES (15, 5, 2, 2);
INSERT INTO public.products_in_orders VALUES (16, 6, 4, 1);
INSERT INTO public.products_in_orders VALUES (17, 7, 6, 10);
INSERT INTO public.products_in_orders VALUES (18, 8, 8, 4);
INSERT INTO public.products_in_orders VALUES (19, 9, 10, 1);
INSERT INTO public.products_in_orders VALUES (20, 10, 12, 5);


--
-- TOC entry 5078 (class 0 OID 16445)
-- Dependencies: 223
-- Data for Name: providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.providers VALUES (2, 'Обувь для вас');
INSERT INTO public.providers VALUES (1, 'Kari');


--
-- TOC entry 5075 (class 0 OID 16423)
-- Dependencies: 220
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles VALUES (1, 'Администратор');
INSERT INTO public.roles VALUES (2, 'Менеджер');
INSERT INTO public.roles VALUES (3, 'Авторизированный клиент');


--
-- TOC entry 5077 (class 0 OID 16439)
-- Dependencies: 222
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.units VALUES (1, 'шт.');


--
-- TOC entry 5076 (class 0 OID 16429)
-- Dependencies: 221
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 1, 'Никифорова', 'Весения', 'Николаевна', '94d5ous@gmail.com', 'uzWC67');
INSERT INTO public.users VALUES (2, 1, 'Сазонов', 'Руслан', 'Германович', 'uth4iz@mail.com', '2L6KZG');
INSERT INTO public.users VALUES (3, 1, 'Одинцов', 'Серафим', 'Артёмович', 'yzls62@outlook.com', 'JlFRCZ');
INSERT INTO public.users VALUES (4, 2, 'Степанов', 'Михаил', 'Артёмович', '1diph5e@tutanota.com', '8ntwUp');
INSERT INTO public.users VALUES (5, 2, 'Ворсин', 'Петр', 'Евгеньевич', 'tjde7c@yahoo.com', 'YOyhfR');
INSERT INTO public.users VALUES (6, 2, 'Старикова', 'Елена', 'Павловна', 'wpmrc3do@tutanota.com', 'RSbvHv');
INSERT INTO public.users VALUES (7, 3, 'Михайлюк', 'Анна', 'Вячеславовна', '5d4zbu@tutanota.com', 'rwVDh9');
INSERT INTO public.users VALUES (8, 3, 'Ситдикова', 'Елена', 'Анатольевна', 'ptec8ym@yahoo.com', 'LdNyos');
INSERT INTO public.users VALUES (9, 3, 'Ворсин', 'Петр', 'Евгеньевич', '1qz4kw@mail.com', 'gynQMT');
INSERT INTO public.users VALUES (10, 3, 'Старикова', 'Елена', 'Павловна', '4np6se@mail.com', 'AtnDjr');


--
-- TOC entry 4906 (class 2606 OID 16456)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4912 (class 2606 OID 16524)
-- Name: order_status order_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status
    ADD CONSTRAINT order_status_pkey PRIMARY KEY (id);


--
-- TOC entry 4914 (class 2606 OID 16575)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4896 (class 2606 OID 16422)
-- Name: pickup_points pickup_points_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT pickup_points_pkey PRIMARY KEY (id);


--
-- TOC entry 4908 (class 2606 OID 16462)
-- Name: producers producers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producers
    ADD CONSTRAINT producers_pkey PRIMARY KEY (id);


--
-- TOC entry 4916 (class 2606 OID 16581)
-- Name: products_in_orders products_in_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_in_orders
    ADD CONSTRAINT products_in_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4910 (class 2606 OID 16498)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 4904 (class 2606 OID 16450)
-- Name: providers providers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.providers
    ADD CONSTRAINT providers_pkey PRIMARY KEY (id);


--
-- TOC entry 4898 (class 2606 OID 16428)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4902 (class 2606 OID 16444)
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- TOC entry 4900 (class 2606 OID 16548)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4922 (class 2606 OID 16552)
-- Name: orders orders_pickup_points_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pickup_points_id_fkey FOREIGN KEY (pickup_points_id) REFERENCES public.pickup_points(id);


--
-- TOC entry 4923 (class 2606 OID 16557)
-- Name: orders orders_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.order_status(id);


--
-- TOC entry 4924 (class 2606 OID 16562)
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4918 (class 2606 OID 16514)
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- TOC entry 4925 (class 2606 OID 16587)
-- Name: products_in_orders products_in_orders_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_in_orders
    ADD CONSTRAINT products_in_orders_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- TOC entry 4926 (class 2606 OID 16582)
-- Name: products_in_orders products_in_orders_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_in_orders
    ADD CONSTRAINT products_in_orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 4919 (class 2606 OID 16509)
-- Name: products products_producer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_producer_id_fkey FOREIGN KEY (producer_id) REFERENCES public.producers(id);


--
-- TOC entry 4920 (class 2606 OID 16504)
-- Name: products products_provider_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_provider_id_fkey FOREIGN KEY (provider_id) REFERENCES public.providers(id);


--
-- TOC entry 4921 (class 2606 OID 16499)
-- Name: products products_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- TOC entry 4917 (class 2606 OID 16434)
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


-- Completed on 2026-02-18 15:38:15

--
-- PostgreSQL database dump complete
--



