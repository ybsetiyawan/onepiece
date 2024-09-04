PGDMP  -    '    
            |            db_onepiece    16.3    16.3 ,    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    25199    db_onepiece    DATABASE     �   CREATE DATABASE db_onepiece WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE db_onepiece;
                postgres    false            �            1259    25201    m_cabang    TABLE     �   CREATE TABLE public.m_cabang (
    id integer NOT NULL,
    kode character varying(10) NOT NULL,
    nama character varying(50) NOT NULL,
    alamat text,
    telp character varying(20)
);
    DROP TABLE public.m_cabang;
       public         heap    postgres    false            �            1259    25200    m_cabang_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_cabang_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.m_cabang_id_seq;
       public          postgres    false    216            �           0    0    m_cabang_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.m_cabang_id_seq OWNED BY public.m_cabang.id;
          public          postgres    false    215            �            1259    33399    m_jenis_item    TABLE     g   CREATE TABLE public.m_jenis_item (
    id integer NOT NULL,
    nama character varying(50) NOT NULL
);
     DROP TABLE public.m_jenis_item;
       public         heap    postgres    false            �            1259    33398    m_jenis_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_jenis_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.m_jenis_item_id_seq;
       public          postgres    false    224            �           0    0    m_jenis_item_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.m_jenis_item_id_seq OWNED BY public.m_jenis_item.id;
          public          postgres    false    223            �            1259    25212    m_role    TABLE     �   CREATE TABLE public.m_role (
    id integer NOT NULL,
    kode character varying(10) NOT NULL,
    nama character varying NOT NULL
);
    DROP TABLE public.m_role;
       public         heap    postgres    false            �            1259    25211    m_role_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.m_role_id_seq;
       public          postgres    false    218            �           0    0    m_role_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.m_role_id_seq OWNED BY public.m_role.id;
          public          postgres    false    217            �            1259    33392    m_satuan    TABLE     c   CREATE TABLE public.m_satuan (
    id integer NOT NULL,
    nama character varying(20) NOT NULL
);
    DROP TABLE public.m_satuan;
       public         heap    postgres    false            �            1259    33391    m_satuan_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_satuan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.m_satuan_id_seq;
       public          postgres    false    222            �           0    0    m_satuan_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.m_satuan_id_seq OWNED BY public.m_satuan.id;
          public          postgres    false    221            �            1259    25223    m_user    TABLE     �   CREATE TABLE public.m_user (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    id_role integer,
    id_cabang integer,
    nama character varying(50)
);
    DROP TABLE public.m_user;
       public         heap    postgres    false            �            1259    25222    m_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.m_user_id_seq;
       public          postgres    false    220            �           0    0    m_user_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.m_user_id_seq OWNED BY public.m_user.id;
          public          postgres    false    219            .           2604    25204    m_cabang id    DEFAULT     j   ALTER TABLE ONLY public.m_cabang ALTER COLUMN id SET DEFAULT nextval('public.m_cabang_id_seq'::regclass);
 :   ALTER TABLE public.m_cabang ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            2           2604    33402    m_jenis_item id    DEFAULT     r   ALTER TABLE ONLY public.m_jenis_item ALTER COLUMN id SET DEFAULT nextval('public.m_jenis_item_id_seq'::regclass);
 >   ALTER TABLE public.m_jenis_item ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    224    224            /           2604    25215 	   m_role id    DEFAULT     f   ALTER TABLE ONLY public.m_role ALTER COLUMN id SET DEFAULT nextval('public.m_role_id_seq'::regclass);
 8   ALTER TABLE public.m_role ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218            1           2604    33395    m_satuan id    DEFAULT     j   ALTER TABLE ONLY public.m_satuan ALTER COLUMN id SET DEFAULT nextval('public.m_satuan_id_seq'::regclass);
 :   ALTER TABLE public.m_satuan ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221    222            0           2604    25226 	   m_user id    DEFAULT     f   ALTER TABLE ONLY public.m_user ALTER COLUMN id SET DEFAULT nextval('public.m_user_id_seq'::regclass);
 8   ALTER TABLE public.m_user ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220            �          0    25201    m_cabang 
   TABLE DATA           @   COPY public.m_cabang (id, kode, nama, alamat, telp) FROM stdin;
    public          postgres    false    216   �.       �          0    33399    m_jenis_item 
   TABLE DATA           0   COPY public.m_jenis_item (id, nama) FROM stdin;
    public          postgres    false    224   ]/       �          0    25212    m_role 
   TABLE DATA           0   COPY public.m_role (id, kode, nama) FROM stdin;
    public          postgres    false    218   �/       �          0    33392    m_satuan 
   TABLE DATA           ,   COPY public.m_satuan (id, nama) FROM stdin;
    public          postgres    false    222   �/       �          0    25223    m_user 
   TABLE DATA           R   COPY public.m_user (id, username, password, id_role, id_cabang, nama) FROM stdin;
    public          postgres    false    220   !0       �           0    0    m_cabang_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.m_cabang_id_seq', 13, true);
          public          postgres    false    215            �           0    0    m_jenis_item_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.m_jenis_item_id_seq', 4, true);
          public          postgres    false    223            �           0    0    m_role_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.m_role_id_seq', 4, true);
          public          postgres    false    217            �           0    0    m_satuan_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.m_satuan_id_seq', 3, true);
          public          postgres    false    221            �           0    0    m_user_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.m_user_id_seq', 13, true);
          public          postgres    false    219            4           2606    25210    m_cabang m_cabang_kode_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.m_cabang
    ADD CONSTRAINT m_cabang_kode_key UNIQUE (kode);
 D   ALTER TABLE ONLY public.m_cabang DROP CONSTRAINT m_cabang_kode_key;
       public            postgres    false    216            6           2606    25208    m_cabang m_cabang_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.m_cabang
    ADD CONSTRAINT m_cabang_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.m_cabang DROP CONSTRAINT m_cabang_pkey;
       public            postgres    false    216            B           2606    33404    m_jenis_item m_jenis_item_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.m_jenis_item
    ADD CONSTRAINT m_jenis_item_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.m_jenis_item DROP CONSTRAINT m_jenis_item_pkey;
       public            postgres    false    224            8           2606    25221    m_role m_role_kode_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.m_role
    ADD CONSTRAINT m_role_kode_key UNIQUE (kode);
 @   ALTER TABLE ONLY public.m_role DROP CONSTRAINT m_role_kode_key;
       public            postgres    false    218            :           2606    25219    m_role m_role_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.m_role
    ADD CONSTRAINT m_role_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.m_role DROP CONSTRAINT m_role_pkey;
       public            postgres    false    218            @           2606    33397    m_satuan m_satuan_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.m_satuan
    ADD CONSTRAINT m_satuan_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.m_satuan DROP CONSTRAINT m_satuan_pkey;
       public            postgres    false    222            <           2606    25228    m_user m_user_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_pkey;
       public            postgres    false    220            >           2606    25230    m_user m_user_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_username_key UNIQUE (username);
 D   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_username_key;
       public            postgres    false    220            C           2606    25236    m_user m_user_id_cabang_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_id_cabang_fkey FOREIGN KEY (id_cabang) REFERENCES public.m_cabang(id);
 F   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_id_cabang_fkey;
       public          postgres    false    216    4662    220            D           2606    25231    m_user m_user_id_role_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.m_role(id);
 D   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_id_role_fkey;
       public          postgres    false    4666    220    218            �   �   x�u�Q� �g8E`
,��jpA�����M]�'���G{e(�d�[��-t���CEqfm�7����ԥ����iiJ�1#�����-!�V:5�.`�#Ui�����7�Ƕė�4��g'Ce�|��]:#3{-��U6G��4����L�H�9��p�_	zMW      �   :   x�3�ttvv��t�2�prq�s�2�p�vQpqq�2��	v����� ,"      �   B   x�3�LL��̃���%E�%�E\Ɯ�ũE�y�E��9
 6�	gnb^b:PJ+䧥e&�r��qqq rL�      �      x�3�p�2��v����� J�      �   y   x�5�1�@�z�)�&�]�����H���C����������?ЭG�zTƸ?���ǃ�$y%���|C�/�U�y̋{�`4�.��=���z	�5�W���5�}��LEn�\D$     