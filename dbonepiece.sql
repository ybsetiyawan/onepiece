PGDMP      :                |            db_onepiece    16.3    16.3 X               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                        0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            !           1262    33485    db_onepiece    DATABASE     �   CREATE DATABASE db_onepiece WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE db_onepiece;
                postgres    false            �            1259    33486    m_cabang    TABLE     �   CREATE TABLE public.m_cabang (
    id integer NOT NULL,
    kode character varying(10) NOT NULL,
    nama character varying(50) NOT NULL,
    alamat text,
    telp character varying(20)
);
    DROP TABLE public.m_cabang;
       public         heap    postgres    false            �            1259    33491    m_cabang_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_cabang_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.m_cabang_id_seq;
       public          postgres    false    215            "           0    0    m_cabang_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.m_cabang_id_seq OWNED BY public.m_cabang.id;
          public          postgres    false    216            �            1259    33492    m_item    TABLE       CREATE TABLE public.m_item (
    id integer NOT NULL,
    kode character varying(50) NOT NULL,
    nama character varying(100) NOT NULL,
    hpp numeric(12,2),
    hjl numeric(12,2),
    aktif boolean DEFAULT true,
    id_satuan integer,
    id_jenis_item integer
);
    DROP TABLE public.m_item;
       public         heap    postgres    false            �            1259    33496    m_item_cabang    TABLE     �   CREATE TABLE public.m_item_cabang (
    id integer NOT NULL,
    id_item integer,
    id_cabang integer,
    stok_awal integer,
    stok_akhir integer
);
 !   DROP TABLE public.m_item_cabang;
       public         heap    postgres    false            �            1259    33499    m_item_cabang_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_item_cabang_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.m_item_cabang_id_seq;
       public          postgres    false    218            #           0    0    m_item_cabang_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.m_item_cabang_id_seq OWNED BY public.m_item_cabang.id;
          public          postgres    false    219            �            1259    33500    m_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.m_item_id_seq;
       public          postgres    false    217            $           0    0    m_item_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.m_item_id_seq OWNED BY public.m_item.id;
          public          postgres    false    220            �            1259    33501    m_jenis_item    TABLE     g   CREATE TABLE public.m_jenis_item (
    id integer NOT NULL,
    nama character varying(50) NOT NULL
);
     DROP TABLE public.m_jenis_item;
       public         heap    postgres    false            �            1259    33504    m_jenis_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_jenis_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.m_jenis_item_id_seq;
       public          postgres    false    221            %           0    0    m_jenis_item_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.m_jenis_item_id_seq OWNED BY public.m_jenis_item.id;
          public          postgres    false    222            �            1259    33505    m_role    TABLE     �   CREATE TABLE public.m_role (
    id integer NOT NULL,
    kode character varying(10) NOT NULL,
    nama character varying NOT NULL
);
    DROP TABLE public.m_role;
       public         heap    postgres    false            �            1259    33510    m_role_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.m_role_id_seq;
       public          postgres    false    223            &           0    0    m_role_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.m_role_id_seq OWNED BY public.m_role.id;
          public          postgres    false    224            �            1259    33511    m_satuan    TABLE     c   CREATE TABLE public.m_satuan (
    id integer NOT NULL,
    nama character varying(20) NOT NULL
);
    DROP TABLE public.m_satuan;
       public         heap    postgres    false            �            1259    33514    m_satuan_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_satuan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.m_satuan_id_seq;
       public          postgres    false    225            '           0    0    m_satuan_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.m_satuan_id_seq OWNED BY public.m_satuan.id;
          public          postgres    false    226            �            1259    33515    m_user    TABLE     �   CREATE TABLE public.m_user (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    id_role integer,
    id_cabang integer,
    nama character varying(50)
);
    DROP TABLE public.m_user;
       public         heap    postgres    false            �            1259    33518    m_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.m_user_id_seq;
       public          postgres    false    227            (           0    0    m_user_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.m_user_id_seq OWNED BY public.m_user.id;
          public          postgres    false    228            �            1259    33519    stok_harian    TABLE     �   CREATE TABLE public.stok_harian (
    id integer NOT NULL,
    id_item_cabang integer,
    tanggal date,
    stok_awal integer,
    stok_akhir integer,
    perubahan_stok integer
);
    DROP TABLE public.stok_harian;
       public         heap    postgres    false            �            1259    33522    stok_harian_id_seq    SEQUENCE     �   CREATE SEQUENCE public.stok_harian_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.stok_harian_id_seq;
       public          postgres    false    229            )           0    0    stok_harian_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.stok_harian_id_seq OWNED BY public.stok_harian.id;
          public          postgres    false    230            �            1259    33523 
   t_trans_in    TABLE     �   CREATE TABLE public.t_trans_in (
    id integer NOT NULL,
    no_faktur character varying(50),
    tanggal date,
    keterangan text
);
    DROP TABLE public.t_trans_in;
       public         heap    postgres    false            �            1259    33528    t_trans_in_detail    TABLE     �   CREATE TABLE public.t_trans_in_detail (
    id integer NOT NULL,
    id_transaksi integer,
    id_item_cabang integer,
    qty integer,
    harga integer,
    subtotal integer
);
 %   DROP TABLE public.t_trans_in_detail;
       public         heap    postgres    false            �            1259    33531    t_transaksi_detail_id_seq    SEQUENCE     �   CREATE SEQUENCE public.t_transaksi_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.t_transaksi_detail_id_seq;
       public          postgres    false    232            *           0    0    t_transaksi_detail_id_seq    SEQUENCE OWNED BY     V   ALTER SEQUENCE public.t_transaksi_detail_id_seq OWNED BY public.t_trans_in_detail.id;
          public          postgres    false    233            �            1259    33532    t_transaksi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.t_transaksi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.t_transaksi_id_seq;
       public          postgres    false    231            +           0    0    t_transaksi_id_seq    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.t_transaksi_id_seq OWNED BY public.t_trans_in.id;
          public          postgres    false    234            G           2604    33533    m_cabang id    DEFAULT     j   ALTER TABLE ONLY public.m_cabang ALTER COLUMN id SET DEFAULT nextval('public.m_cabang_id_seq'::regclass);
 :   ALTER TABLE public.m_cabang ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215            H           2604    33534 	   m_item id    DEFAULT     f   ALTER TABLE ONLY public.m_item ALTER COLUMN id SET DEFAULT nextval('public.m_item_id_seq'::regclass);
 8   ALTER TABLE public.m_item ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    217            J           2604    33535    m_item_cabang id    DEFAULT     t   ALTER TABLE ONLY public.m_item_cabang ALTER COLUMN id SET DEFAULT nextval('public.m_item_cabang_id_seq'::regclass);
 ?   ALTER TABLE public.m_item_cabang ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218            K           2604    33536    m_jenis_item id    DEFAULT     r   ALTER TABLE ONLY public.m_jenis_item ALTER COLUMN id SET DEFAULT nextval('public.m_jenis_item_id_seq'::regclass);
 >   ALTER TABLE public.m_jenis_item ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221            L           2604    33537 	   m_role id    DEFAULT     f   ALTER TABLE ONLY public.m_role ALTER COLUMN id SET DEFAULT nextval('public.m_role_id_seq'::regclass);
 8   ALTER TABLE public.m_role ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223            M           2604    33538    m_satuan id    DEFAULT     j   ALTER TABLE ONLY public.m_satuan ALTER COLUMN id SET DEFAULT nextval('public.m_satuan_id_seq'::regclass);
 :   ALTER TABLE public.m_satuan ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225            N           2604    33539 	   m_user id    DEFAULT     f   ALTER TABLE ONLY public.m_user ALTER COLUMN id SET DEFAULT nextval('public.m_user_id_seq'::regclass);
 8   ALTER TABLE public.m_user ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227            O           2604    33540    stok_harian id    DEFAULT     p   ALTER TABLE ONLY public.stok_harian ALTER COLUMN id SET DEFAULT nextval('public.stok_harian_id_seq'::regclass);
 =   ALTER TABLE public.stok_harian ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229            P           2604    33541    t_trans_in id    DEFAULT     o   ALTER TABLE ONLY public.t_trans_in ALTER COLUMN id SET DEFAULT nextval('public.t_transaksi_id_seq'::regclass);
 <   ALTER TABLE public.t_trans_in ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    231            Q           2604    33542    t_trans_in_detail id    DEFAULT     }   ALTER TABLE ONLY public.t_trans_in_detail ALTER COLUMN id SET DEFAULT nextval('public.t_transaksi_detail_id_seq'::regclass);
 C   ALTER TABLE public.t_trans_in_detail ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    232                      0    33486    m_cabang 
   TABLE DATA           @   COPY public.m_cabang (id, kode, nama, alamat, telp) FROM stdin;
    public          postgres    false    215   d       
          0    33492    m_item 
   TABLE DATA           [   COPY public.m_item (id, kode, nama, hpp, hjl, aktif, id_satuan, id_jenis_item) FROM stdin;
    public          postgres    false    217   �d                 0    33496    m_item_cabang 
   TABLE DATA           V   COPY public.m_item_cabang (id, id_item, id_cabang, stok_awal, stok_akhir) FROM stdin;
    public          postgres    false    218   eh                 0    33501    m_jenis_item 
   TABLE DATA           0   COPY public.m_jenis_item (id, nama) FROM stdin;
    public          postgres    false    221   �h                 0    33505    m_role 
   TABLE DATA           0   COPY public.m_role (id, kode, nama) FROM stdin;
    public          postgres    false    223   	i                 0    33511    m_satuan 
   TABLE DATA           ,   COPY public.m_satuan (id, nama) FROM stdin;
    public          postgres    false    225   [i                 0    33515    m_user 
   TABLE DATA           R   COPY public.m_user (id, username, password, id_role, id_cabang, nama) FROM stdin;
    public          postgres    false    227   �i                 0    33519    stok_harian 
   TABLE DATA           i   COPY public.stok_harian (id, id_item_cabang, tanggal, stok_awal, stok_akhir, perubahan_stok) FROM stdin;
    public          postgres    false    229   j                 0    33523 
   t_trans_in 
   TABLE DATA           H   COPY public.t_trans_in (id, no_faktur, tanggal, keterangan) FROM stdin;
    public          postgres    false    231   `j                 0    33528    t_trans_in_detail 
   TABLE DATA           c   COPY public.t_trans_in_detail (id, id_transaksi, id_item_cabang, qty, harga, subtotal) FROM stdin;
    public          postgres    false    232   �j       ,           0    0    m_cabang_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.m_cabang_id_seq', 13, true);
          public          postgres    false    216            -           0    0    m_item_cabang_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.m_item_cabang_id_seq', 12, true);
          public          postgres    false    219            .           0    0    m_item_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.m_item_id_seq', 74, true);
          public          postgres    false    220            /           0    0    m_jenis_item_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.m_jenis_item_id_seq', 4, true);
          public          postgres    false    222            0           0    0    m_role_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.m_role_id_seq', 4, true);
          public          postgres    false    224            1           0    0    m_satuan_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.m_satuan_id_seq', 5, true);
          public          postgres    false    226            2           0    0    m_user_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.m_user_id_seq', 13, true);
          public          postgres    false    228            3           0    0    stok_harian_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.stok_harian_id_seq', 52, true);
          public          postgres    false    230            4           0    0    t_transaksi_detail_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.t_transaksi_detail_id_seq', 55, true);
          public          postgres    false    233            5           0    0    t_transaksi_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.t_transaksi_id_seq', 28, true);
          public          postgres    false    234            S           2606    33544    m_cabang m_cabang_kode_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.m_cabang
    ADD CONSTRAINT m_cabang_kode_key UNIQUE (kode);
 D   ALTER TABLE ONLY public.m_cabang DROP CONSTRAINT m_cabang_kode_key;
       public            postgres    false    215            U           2606    33546    m_cabang m_cabang_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.m_cabang
    ADD CONSTRAINT m_cabang_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.m_cabang DROP CONSTRAINT m_cabang_pkey;
       public            postgres    false    215            [           2606    33548     m_item_cabang m_item_cabang_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.m_item_cabang
    ADD CONSTRAINT m_item_cabang_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.m_item_cabang DROP CONSTRAINT m_item_cabang_pkey;
       public            postgres    false    218            W           2606    33550    m_item m_item_kode_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.m_item
    ADD CONSTRAINT m_item_kode_key UNIQUE (kode);
 @   ALTER TABLE ONLY public.m_item DROP CONSTRAINT m_item_kode_key;
       public            postgres    false    217            Y           2606    33552    m_item m_item_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.m_item
    ADD CONSTRAINT m_item_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.m_item DROP CONSTRAINT m_item_pkey;
       public            postgres    false    217            ]           2606    33554    m_jenis_item m_jenis_item_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.m_jenis_item
    ADD CONSTRAINT m_jenis_item_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.m_jenis_item DROP CONSTRAINT m_jenis_item_pkey;
       public            postgres    false    221            _           2606    33556    m_role m_role_kode_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.m_role
    ADD CONSTRAINT m_role_kode_key UNIQUE (kode);
 @   ALTER TABLE ONLY public.m_role DROP CONSTRAINT m_role_kode_key;
       public            postgres    false    223            a           2606    33558    m_role m_role_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.m_role
    ADD CONSTRAINT m_role_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.m_role DROP CONSTRAINT m_role_pkey;
       public            postgres    false    223            c           2606    33560    m_satuan m_satuan_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.m_satuan
    ADD CONSTRAINT m_satuan_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.m_satuan DROP CONSTRAINT m_satuan_pkey;
       public            postgres    false    225            e           2606    33562    m_user m_user_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_pkey;
       public            postgres    false    227            g           2606    33564    m_user m_user_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_username_key UNIQUE (username);
 D   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_username_key;
       public            postgres    false    227            i           2606    33566    stok_harian stok_harian_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.stok_harian
    ADD CONSTRAINT stok_harian_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.stok_harian DROP CONSTRAINT stok_harian_pkey;
       public            postgres    false    229            o           2606    33568 )   t_trans_in_detail t_transaksi_detail_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.t_trans_in_detail
    ADD CONSTRAINT t_transaksi_detail_pkey PRIMARY KEY (id);
 S   ALTER TABLE ONLY public.t_trans_in_detail DROP CONSTRAINT t_transaksi_detail_pkey;
       public            postgres    false    232            k           2606    33570 $   t_trans_in t_transaksi_no_faktur_key 
   CONSTRAINT     d   ALTER TABLE ONLY public.t_trans_in
    ADD CONSTRAINT t_transaksi_no_faktur_key UNIQUE (no_faktur);
 N   ALTER TABLE ONLY public.t_trans_in DROP CONSTRAINT t_transaksi_no_faktur_key;
       public            postgres    false    231            m           2606    33572    t_trans_in t_transaksi_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.t_trans_in
    ADD CONSTRAINT t_transaksi_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY public.t_trans_in DROP CONSTRAINT t_transaksi_pkey;
       public            postgres    false    231            r           2606    33573 *   m_item_cabang m_item_cabang_id_cabang_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_item_cabang
    ADD CONSTRAINT m_item_cabang_id_cabang_fkey FOREIGN KEY (id_cabang) REFERENCES public.m_cabang(id);
 T   ALTER TABLE ONLY public.m_item_cabang DROP CONSTRAINT m_item_cabang_id_cabang_fkey;
       public          postgres    false    215    218    4693            s           2606    33578 (   m_item_cabang m_item_cabang_id_item_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_item_cabang
    ADD CONSTRAINT m_item_cabang_id_item_fkey FOREIGN KEY (id_item) REFERENCES public.m_item(id);
 R   ALTER TABLE ONLY public.m_item_cabang DROP CONSTRAINT m_item_cabang_id_item_fkey;
       public          postgres    false    217    218    4697            p           2606    33583     m_item m_item_id_jenis_item_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_item
    ADD CONSTRAINT m_item_id_jenis_item_fkey FOREIGN KEY (id_jenis_item) REFERENCES public.m_jenis_item(id);
 J   ALTER TABLE ONLY public.m_item DROP CONSTRAINT m_item_id_jenis_item_fkey;
       public          postgres    false    4701    221    217            q           2606    33588    m_item m_item_id_satuan_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_item
    ADD CONSTRAINT m_item_id_satuan_fkey FOREIGN KEY (id_satuan) REFERENCES public.m_satuan(id);
 F   ALTER TABLE ONLY public.m_item DROP CONSTRAINT m_item_id_satuan_fkey;
       public          postgres    false    4707    217    225            t           2606    33593    m_user m_user_id_cabang_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_id_cabang_fkey FOREIGN KEY (id_cabang) REFERENCES public.m_cabang(id);
 F   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_id_cabang_fkey;
       public          postgres    false    215    227    4693            u           2606    33598    m_user m_user_id_role_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.m_role(id);
 D   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_id_role_fkey;
       public          postgres    false    223    227    4705            v           2606    33603 +   stok_harian stok_harian_id_item_cabang_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.stok_harian
    ADD CONSTRAINT stok_harian_id_item_cabang_fkey FOREIGN KEY (id_item_cabang) REFERENCES public.m_item_cabang(id);
 U   ALTER TABLE ONLY public.stok_harian DROP CONSTRAINT stok_harian_id_item_cabang_fkey;
       public          postgres    false    229    4699    218            w           2606    33608 8   t_trans_in_detail t_transaksi_detail_id_item_cabang_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.t_trans_in_detail
    ADD CONSTRAINT t_transaksi_detail_id_item_cabang_fkey FOREIGN KEY (id_item_cabang) REFERENCES public.m_item_cabang(id);
 b   ALTER TABLE ONLY public.t_trans_in_detail DROP CONSTRAINT t_transaksi_detail_id_item_cabang_fkey;
       public          postgres    false    232    218    4699            x           2606    33613 6   t_trans_in_detail t_transaksi_detail_id_transaksi_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.t_trans_in_detail
    ADD CONSTRAINT t_transaksi_detail_id_transaksi_fkey FOREIGN KEY (id_transaksi) REFERENCES public.t_trans_in(id);
 `   ALTER TABLE ONLY public.t_trans_in_detail DROP CONSTRAINT t_transaksi_detail_id_transaksi_fkey;
       public          postgres    false    231    4717    232               �   x�u�Q� �g8E`
,��jpA�����M]�'���G{e(�d�[��-t���CEqfm�7����ԥ����iiJ�1#�����-!�V:5�.`�#Ui�����7�Ƕė�4��g'Ce�|��]:#3{-��U6G��4����L�H�9��p�_	zMW      
     x����n�0F����t�osIMXHA@TU������s�^��U%��c��L8����޹�	׌�7ƈ`�?	'�$ 	Q���B(	Jʯ?��Z
�%�Z�<��AiP�v����Q}DP�w}�i�����>�6~��d-��Q����K�"�ܖV)�
`��փv��̓���hF*�����q{/�Ü�����L���1!� �.�C���ƃfMP��A��4ʃ<���͡N�>�˭閞.u�laM�c@9m�Q��Du�x$�6O�[@�d/1�z}&�Y<=;n$ S�$(��c��l�J�=�s1�%A�,%�kl;k�&9{=��R�K=7tn��?h�u��,����z��ri�g7�C�,�y�Yؖ�L�D��o�r�0-�ς>�x�Q(��w�5>�ǹ�NB�b�>>�������M¨�$P�~4ݘ�AB�ۺ�C��%�)IB�gz��P���J"J-T �[�M��T?�g�a(T��
�>b�R/���w �1~��Vm�T*��Nɼ�NU��0S0��+�+v����يT��!�4��X�W�tO
��<��a��Y+<�Q��^�7�T
n��H��\cU���FZ�{�.�6��Ȋ�j�^%K£�6����Sâa;�G�<Q���������k֌�a\W~�i83r�V�ݗW��0fvc��}r��deH3�L���j3�O7c�R��U�=�6ƌ�Ǉ2S��c��^|YH�����D�,d�>LY��4�de Ë��Eb���U�i�e��@��d���k r��P�����D/�-�+��[��_�V���~f�0�8�>�8",�8����^�c9痄'�'�����k��[�qj���x�S�r{����v:��Sg_�         J   x�=�Q�0B��0K����e�?�0� �M�;�/w�Iw�Z:��t��U<\Y��@3`tQ�}��G         :   x�3�ttvv��t�2�prq�s�2�p�vQpqq�2��	v����� ,"         B   x�3�LL��̃���%E�%�E\Ɯ�ũE�y�E��9
 6�	gnb^b:PJ+䧥e&�r��qqq rL�         &   x�3�p�2��v�2���	�2���q����� Y��         y   x�=�1�@D�����|w�z0�F��+�&6kl�+oD���{���s{CW�Q���ZF�w&�}(����:/x
��b�C^��F��/�_̢�َ5/]��LE���HL��b��Z��Y�$         6   x�3��4�4202�5��5��4�4�4�25 R���Hj�@JA�FHj�1z\\\ �4         =   x�32�40002�4202�5��5��	r�v��Tp�wrTp�2� +��+22�T���� ��'         +   x�35�42�4B# �25�|N#dyS!���� N�	g     