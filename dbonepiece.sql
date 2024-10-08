PGDMP  9    8            	    |            db_onepiece    16.3    16.3 i    6           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            7           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            8           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            9           1262    34139    db_onepiece    DATABASE     �   CREATE DATABASE db_onepiece WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE db_onepiece;
                postgres    false            �            1259    34140    m_cabang    TABLE     �   CREATE TABLE public.m_cabang (
    id integer NOT NULL,
    kode character varying(10) NOT NULL,
    nama character varying(50) NOT NULL,
    alamat text,
    telp character varying(20)
);
    DROP TABLE public.m_cabang;
       public         heap    postgres    false            �            1259    34145    m_cabang_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_cabang_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.m_cabang_id_seq;
       public          postgres    false    215            :           0    0    m_cabang_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.m_cabang_id_seq OWNED BY public.m_cabang.id;
          public          postgres    false    216            �            1259    34146    m_item    TABLE       CREATE TABLE public.m_item (
    id integer NOT NULL,
    kode character varying(50) NOT NULL,
    nama character varying(100) NOT NULL,
    hpp numeric(12,0),
    hjl numeric(12,0),
    aktif boolean DEFAULT true,
    id_satuan integer,
    id_jenis_item integer
);
    DROP TABLE public.m_item;
       public         heap    postgres    false            �            1259    34150    m_item_cabang    TABLE     �   CREATE TABLE public.m_item_cabang (
    id integer NOT NULL,
    id_item integer,
    id_cabang integer,
    stok_awal integer,
    stok_akhir integer
);
 !   DROP TABLE public.m_item_cabang;
       public         heap    postgres    false            �            1259    34153    m_item_cabang_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_item_cabang_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.m_item_cabang_id_seq;
       public          postgres    false    218            ;           0    0    m_item_cabang_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.m_item_cabang_id_seq OWNED BY public.m_item_cabang.id;
          public          postgres    false    219            �            1259    34154    m_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.m_item_id_seq;
       public          postgres    false    217            <           0    0    m_item_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.m_item_id_seq OWNED BY public.m_item.id;
          public          postgres    false    220            �            1259    34155    m_jenis_item    TABLE     g   CREATE TABLE public.m_jenis_item (
    id integer NOT NULL,
    nama character varying(50) NOT NULL
);
     DROP TABLE public.m_jenis_item;
       public         heap    postgres    false            �            1259    34158    m_jenis_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_jenis_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.m_jenis_item_id_seq;
       public          postgres    false    221            =           0    0    m_jenis_item_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.m_jenis_item_id_seq OWNED BY public.m_jenis_item.id;
          public          postgres    false    222            �            1259    34159    m_role    TABLE     �   CREATE TABLE public.m_role (
    id integer NOT NULL,
    kode character varying(10) NOT NULL,
    nama character varying NOT NULL
);
    DROP TABLE public.m_role;
       public         heap    postgres    false            �            1259    34164    m_role_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.m_role_id_seq;
       public          postgres    false    223            >           0    0    m_role_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.m_role_id_seq OWNED BY public.m_role.id;
          public          postgres    false    224            �            1259    34165    m_satuan    TABLE     c   CREATE TABLE public.m_satuan (
    id integer NOT NULL,
    nama character varying(20) NOT NULL
);
    DROP TABLE public.m_satuan;
       public         heap    postgres    false            �            1259    34168    m_satuan_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_satuan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.m_satuan_id_seq;
       public          postgres    false    225            ?           0    0    m_satuan_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.m_satuan_id_seq OWNED BY public.m_satuan.id;
          public          postgres    false    226            �            1259    34169    m_user    TABLE     �   CREATE TABLE public.m_user (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    id_role integer,
    id_cabang integer,
    nama character varying(50)
);
    DROP TABLE public.m_user;
       public         heap    postgres    false            �            1259    34172    m_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.m_user_id_seq;
       public          postgres    false    227            @           0    0    m_user_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.m_user_id_seq OWNED BY public.m_user.id;
          public          postgres    false    228            �            1259    34173    stok_harian    TABLE       CREATE TABLE public.stok_harian (
    id integer NOT NULL,
    id_item_cabang integer,
    tanggal timestamp without time zone,
    stok_awal integer,
    stok_akhir integer,
    perubahan_stok integer,
    transtp character varying(10),
    transfrom character varying(20)
);
    DROP TABLE public.stok_harian;
       public         heap    postgres    false            �            1259    34176    stok_harian_id_seq    SEQUENCE     �   CREATE SEQUENCE public.stok_harian_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.stok_harian_id_seq;
       public          postgres    false    229            A           0    0    stok_harian_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.stok_harian_id_seq OWNED BY public.stok_harian.id;
          public          postgres    false    230            �            1259    50003 	   t_receipt    TABLE     �   CREATE TABLE public.t_receipt (
    id integer NOT NULL,
    docno character varying(50),
    tanggal date,
    keterangan text
);
    DROP TABLE public.t_receipt;
       public         heap    postgres    false            �            1259    50021    t_receipt_detail    TABLE     �   CREATE TABLE public.t_receipt_detail (
    id integer NOT NULL,
    id_transaksi integer,
    id_item_cabang integer,
    qty integer
);
 $   DROP TABLE public.t_receipt_detail;
       public         heap    postgres    false            �            1259    50020    t_receipt_detail_id_seq    SEQUENCE     �   CREATE SEQUENCE public.t_receipt_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.t_receipt_detail_id_seq;
       public          postgres    false    238            B           0    0    t_receipt_detail_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.t_receipt_detail_id_seq OWNED BY public.t_receipt_detail.id;
          public          postgres    false    237            �            1259    50002    t_receipt_id_seq    SEQUENCE     �   CREATE SEQUENCE public.t_receipt_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.t_receipt_id_seq;
       public          postgres    false    236            C           0    0    t_receipt_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.t_receipt_id_seq OWNED BY public.t_receipt.id;
          public          postgres    false    235            �            1259    34177 
   t_trans_in    TABLE     �   CREATE TABLE public.t_trans_in (
    id integer NOT NULL,
    no_faktur character varying(50),
    tanggal date,
    keterangan text
);
    DROP TABLE public.t_trans_in;
       public         heap    postgres    false            �            1259    34182    t_trans_in_detail    TABLE     �   CREATE TABLE public.t_trans_in_detail (
    id integer NOT NULL,
    id_transaksi integer,
    id_item_cabang integer,
    qty integer,
    harga integer,
    subtotal integer
);
 %   DROP TABLE public.t_trans_in_detail;
       public         heap    postgres    false            �            1259    34185    t_transaksi_detail_id_seq    SEQUENCE     �   CREATE SEQUENCE public.t_transaksi_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.t_transaksi_detail_id_seq;
       public          postgres    false    232            D           0    0    t_transaksi_detail_id_seq    SEQUENCE OWNED BY     V   ALTER SEQUENCE public.t_transaksi_detail_id_seq OWNED BY public.t_trans_in_detail.id;
          public          postgres    false    233            �            1259    34186    t_transaksi_id_seq    SEQUENCE     �   CREATE SEQUENCE public.t_transaksi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.t_transaksi_id_seq;
       public          postgres    false    231            E           0    0    t_transaksi_id_seq    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.t_transaksi_id_seq OWNED BY public.t_trans_in.id;
          public          postgres    false    234            Q           2604    34187    m_cabang id    DEFAULT     j   ALTER TABLE ONLY public.m_cabang ALTER COLUMN id SET DEFAULT nextval('public.m_cabang_id_seq'::regclass);
 :   ALTER TABLE public.m_cabang ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215            R           2604    34188 	   m_item id    DEFAULT     f   ALTER TABLE ONLY public.m_item ALTER COLUMN id SET DEFAULT nextval('public.m_item_id_seq'::regclass);
 8   ALTER TABLE public.m_item ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    217            T           2604    34189    m_item_cabang id    DEFAULT     t   ALTER TABLE ONLY public.m_item_cabang ALTER COLUMN id SET DEFAULT nextval('public.m_item_cabang_id_seq'::regclass);
 ?   ALTER TABLE public.m_item_cabang ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218            U           2604    34190    m_jenis_item id    DEFAULT     r   ALTER TABLE ONLY public.m_jenis_item ALTER COLUMN id SET DEFAULT nextval('public.m_jenis_item_id_seq'::regclass);
 >   ALTER TABLE public.m_jenis_item ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221            V           2604    34191 	   m_role id    DEFAULT     f   ALTER TABLE ONLY public.m_role ALTER COLUMN id SET DEFAULT nextval('public.m_role_id_seq'::regclass);
 8   ALTER TABLE public.m_role ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223            W           2604    34192    m_satuan id    DEFAULT     j   ALTER TABLE ONLY public.m_satuan ALTER COLUMN id SET DEFAULT nextval('public.m_satuan_id_seq'::regclass);
 :   ALTER TABLE public.m_satuan ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225            X           2604    34193 	   m_user id    DEFAULT     f   ALTER TABLE ONLY public.m_user ALTER COLUMN id SET DEFAULT nextval('public.m_user_id_seq'::regclass);
 8   ALTER TABLE public.m_user ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227            Y           2604    34194    stok_harian id    DEFAULT     p   ALTER TABLE ONLY public.stok_harian ALTER COLUMN id SET DEFAULT nextval('public.stok_harian_id_seq'::regclass);
 =   ALTER TABLE public.stok_harian ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229            \           2604    50006    t_receipt id    DEFAULT     l   ALTER TABLE ONLY public.t_receipt ALTER COLUMN id SET DEFAULT nextval('public.t_receipt_id_seq'::regclass);
 ;   ALTER TABLE public.t_receipt ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    236    235    236            ]           2604    50024    t_receipt_detail id    DEFAULT     z   ALTER TABLE ONLY public.t_receipt_detail ALTER COLUMN id SET DEFAULT nextval('public.t_receipt_detail_id_seq'::regclass);
 B   ALTER TABLE public.t_receipt_detail ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    237    238            Z           2604    34195    t_trans_in id    DEFAULT     o   ALTER TABLE ONLY public.t_trans_in ALTER COLUMN id SET DEFAULT nextval('public.t_transaksi_id_seq'::regclass);
 <   ALTER TABLE public.t_trans_in ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    231            [           2604    34196    t_trans_in_detail id    DEFAULT     }   ALTER TABLE ONLY public.t_trans_in_detail ALTER COLUMN id SET DEFAULT nextval('public.t_transaksi_detail_id_seq'::regclass);
 C   ALTER TABLE public.t_trans_in_detail ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    232                      0    34140    m_cabang 
   TABLE DATA           @   COPY public.m_cabang (id, kode, nama, alamat, telp) FROM stdin;
    public          postgres    false    215   �x                 0    34146    m_item 
   TABLE DATA           [   COPY public.m_item (id, kode, nama, hpp, hjl, aktif, id_satuan, id_jenis_item) FROM stdin;
    public          postgres    false    217   �y                 0    34150    m_item_cabang 
   TABLE DATA           V   COPY public.m_item_cabang (id, id_item, id_cabang, stok_awal, stok_akhir) FROM stdin;
    public          postgres    false    218   }       "          0    34155    m_jenis_item 
   TABLE DATA           0   COPY public.m_jenis_item (id, nama) FROM stdin;
    public          postgres    false    221   G}       $          0    34159    m_role 
   TABLE DATA           0   COPY public.m_role (id, kode, nama) FROM stdin;
    public          postgres    false    223   �}       &          0    34165    m_satuan 
   TABLE DATA           ,   COPY public.m_satuan (id, nama) FROM stdin;
    public          postgres    false    225   �}       (          0    34169    m_user 
   TABLE DATA           R   COPY public.m_user (id, username, password, id_role, id_cabang, nama) FROM stdin;
    public          postgres    false    227   ~       *          0    34173    stok_harian 
   TABLE DATA           }   COPY public.stok_harian (id, id_item_cabang, tanggal, stok_awal, stok_akhir, perubahan_stok, transtp, transfrom) FROM stdin;
    public          postgres    false    229   �~       1          0    50003 	   t_receipt 
   TABLE DATA           C   COPY public.t_receipt (id, docno, tanggal, keterangan) FROM stdin;
    public          postgres    false    236   &       3          0    50021    t_receipt_detail 
   TABLE DATA           Q   COPY public.t_receipt_detail (id, id_transaksi, id_item_cabang, qty) FROM stdin;
    public          postgres    false    238   d       ,          0    34177 
   t_trans_in 
   TABLE DATA           H   COPY public.t_trans_in (id, no_faktur, tanggal, keterangan) FROM stdin;
    public          postgres    false    231   �       -          0    34182    t_trans_in_detail 
   TABLE DATA           c   COPY public.t_trans_in_detail (id, id_transaksi, id_item_cabang, qty, harga, subtotal) FROM stdin;
    public          postgres    false    232   �       F           0    0    m_cabang_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.m_cabang_id_seq', 13, true);
          public          postgres    false    216            G           0    0    m_item_cabang_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.m_item_cabang_id_seq', 66, true);
          public          postgres    false    219            H           0    0    m_item_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.m_item_id_seq', 74, true);
          public          postgres    false    220            I           0    0    m_jenis_item_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.m_jenis_item_id_seq', 4, true);
          public          postgres    false    222            J           0    0    m_role_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.m_role_id_seq', 4, true);
          public          postgres    false    224            K           0    0    m_satuan_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.m_satuan_id_seq', 5, true);
          public          postgres    false    226            L           0    0    m_user_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.m_user_id_seq', 13, true);
          public          postgres    false    228            M           0    0    stok_harian_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.stok_harian_id_seq', 291, true);
          public          postgres    false    230            N           0    0    t_receipt_detail_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.t_receipt_detail_id_seq', 23, true);
          public          postgres    false    237            O           0    0    t_receipt_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.t_receipt_id_seq', 23, true);
          public          postgres    false    235            P           0    0    t_transaksi_detail_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.t_transaksi_detail_id_seq', 229, true);
          public          postgres    false    233            Q           0    0    t_transaksi_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.t_transaksi_id_seq', 191, true);
          public          postgres    false    234            _           2606    34198    m_cabang m_cabang_kode_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.m_cabang
    ADD CONSTRAINT m_cabang_kode_key UNIQUE (kode);
 D   ALTER TABLE ONLY public.m_cabang DROP CONSTRAINT m_cabang_kode_key;
       public            postgres    false    215            a           2606    34200    m_cabang m_cabang_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.m_cabang
    ADD CONSTRAINT m_cabang_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.m_cabang DROP CONSTRAINT m_cabang_pkey;
       public            postgres    false    215            g           2606    34202     m_item_cabang m_item_cabang_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.m_item_cabang
    ADD CONSTRAINT m_item_cabang_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.m_item_cabang DROP CONSTRAINT m_item_cabang_pkey;
       public            postgres    false    218            c           2606    34204    m_item m_item_kode_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.m_item
    ADD CONSTRAINT m_item_kode_key UNIQUE (kode);
 @   ALTER TABLE ONLY public.m_item DROP CONSTRAINT m_item_kode_key;
       public            postgres    false    217            e           2606    34206    m_item m_item_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.m_item
    ADD CONSTRAINT m_item_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.m_item DROP CONSTRAINT m_item_pkey;
       public            postgres    false    217            i           2606    34208    m_jenis_item m_jenis_item_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.m_jenis_item
    ADD CONSTRAINT m_jenis_item_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.m_jenis_item DROP CONSTRAINT m_jenis_item_pkey;
       public            postgres    false    221            k           2606    34210    m_role m_role_kode_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.m_role
    ADD CONSTRAINT m_role_kode_key UNIQUE (kode);
 @   ALTER TABLE ONLY public.m_role DROP CONSTRAINT m_role_kode_key;
       public            postgres    false    223            m           2606    34212    m_role m_role_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.m_role
    ADD CONSTRAINT m_role_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.m_role DROP CONSTRAINT m_role_pkey;
       public            postgres    false    223            o           2606    34214    m_satuan m_satuan_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.m_satuan
    ADD CONSTRAINT m_satuan_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.m_satuan DROP CONSTRAINT m_satuan_pkey;
       public            postgres    false    225            q           2606    34216    m_user m_user_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_pkey;
       public            postgres    false    227            s           2606    34218    m_user m_user_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_username_key UNIQUE (username);
 D   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_username_key;
       public            postgres    false    227            u           2606    34220    stok_harian stok_harian_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.stok_harian
    ADD CONSTRAINT stok_harian_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.stok_harian DROP CONSTRAINT stok_harian_pkey;
       public            postgres    false    229            �           2606    50026 &   t_receipt_detail t_receipt_detail_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.t_receipt_detail
    ADD CONSTRAINT t_receipt_detail_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.t_receipt_detail DROP CONSTRAINT t_receipt_detail_pkey;
       public            postgres    false    238            }           2606    50012    t_receipt t_receipt_docno_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.t_receipt
    ADD CONSTRAINT t_receipt_docno_key UNIQUE (docno);
 G   ALTER TABLE ONLY public.t_receipt DROP CONSTRAINT t_receipt_docno_key;
       public            postgres    false    236                       2606    50010    t_receipt t_receipt_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.t_receipt
    ADD CONSTRAINT t_receipt_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.t_receipt DROP CONSTRAINT t_receipt_pkey;
       public            postgres    false    236            {           2606    34222 )   t_trans_in_detail t_transaksi_detail_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.t_trans_in_detail
    ADD CONSTRAINT t_transaksi_detail_pkey PRIMARY KEY (id);
 S   ALTER TABLE ONLY public.t_trans_in_detail DROP CONSTRAINT t_transaksi_detail_pkey;
       public            postgres    false    232            w           2606    34224 $   t_trans_in t_transaksi_no_faktur_key 
   CONSTRAINT     d   ALTER TABLE ONLY public.t_trans_in
    ADD CONSTRAINT t_transaksi_no_faktur_key UNIQUE (no_faktur);
 N   ALTER TABLE ONLY public.t_trans_in DROP CONSTRAINT t_transaksi_no_faktur_key;
       public            postgres    false    231            y           2606    34226    t_trans_in t_transaksi_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.t_trans_in
    ADD CONSTRAINT t_transaksi_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY public.t_trans_in DROP CONSTRAINT t_transaksi_pkey;
       public            postgres    false    231            �           2606    34227 *   m_item_cabang m_item_cabang_id_cabang_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_item_cabang
    ADD CONSTRAINT m_item_cabang_id_cabang_fkey FOREIGN KEY (id_cabang) REFERENCES public.m_cabang(id);
 T   ALTER TABLE ONLY public.m_item_cabang DROP CONSTRAINT m_item_cabang_id_cabang_fkey;
       public          postgres    false    215    218    4705            �           2606    34232 (   m_item_cabang m_item_cabang_id_item_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_item_cabang
    ADD CONSTRAINT m_item_cabang_id_item_fkey FOREIGN KEY (id_item) REFERENCES public.m_item(id);
 R   ALTER TABLE ONLY public.m_item_cabang DROP CONSTRAINT m_item_cabang_id_item_fkey;
       public          postgres    false    4709    217    218            �           2606    34237     m_item m_item_id_jenis_item_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_item
    ADD CONSTRAINT m_item_id_jenis_item_fkey FOREIGN KEY (id_jenis_item) REFERENCES public.m_jenis_item(id);
 J   ALTER TABLE ONLY public.m_item DROP CONSTRAINT m_item_id_jenis_item_fkey;
       public          postgres    false    221    217    4713            �           2606    34242    m_item m_item_id_satuan_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_item
    ADD CONSTRAINT m_item_id_satuan_fkey FOREIGN KEY (id_satuan) REFERENCES public.m_satuan(id);
 F   ALTER TABLE ONLY public.m_item DROP CONSTRAINT m_item_id_satuan_fkey;
       public          postgres    false    217    225    4719            �           2606    34247    m_user m_user_id_cabang_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_id_cabang_fkey FOREIGN KEY (id_cabang) REFERENCES public.m_cabang(id);
 F   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_id_cabang_fkey;
       public          postgres    false    4705    227    215            �           2606    34252    m_user m_user_id_role_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.m_role(id);
 D   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_id_role_fkey;
       public          postgres    false    223    4717    227            �           2606    34257 +   stok_harian stok_harian_id_item_cabang_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.stok_harian
    ADD CONSTRAINT stok_harian_id_item_cabang_fkey FOREIGN KEY (id_item_cabang) REFERENCES public.m_item_cabang(id);
 U   ALTER TABLE ONLY public.stok_harian DROP CONSTRAINT stok_harian_id_item_cabang_fkey;
       public          postgres    false    229    218    4711            �           2606    50032 5   t_receipt_detail t_receipt_detail_id_item_cabang_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.t_receipt_detail
    ADD CONSTRAINT t_receipt_detail_id_item_cabang_fkey FOREIGN KEY (id_item_cabang) REFERENCES public.m_item_cabang(id);
 _   ALTER TABLE ONLY public.t_receipt_detail DROP CONSTRAINT t_receipt_detail_id_item_cabang_fkey;
       public          postgres    false    238    218    4711            �           2606    50027 3   t_receipt_detail t_receipt_detail_id_transaksi_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.t_receipt_detail
    ADD CONSTRAINT t_receipt_detail_id_transaksi_fkey FOREIGN KEY (id_transaksi) REFERENCES public.t_receipt(id);
 ]   ALTER TABLE ONLY public.t_receipt_detail DROP CONSTRAINT t_receipt_detail_id_transaksi_fkey;
       public          postgres    false    238    4735    236            �           2606    34262 8   t_trans_in_detail t_transaksi_detail_id_item_cabang_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.t_trans_in_detail
    ADD CONSTRAINT t_transaksi_detail_id_item_cabang_fkey FOREIGN KEY (id_item_cabang) REFERENCES public.m_item_cabang(id);
 b   ALTER TABLE ONLY public.t_trans_in_detail DROP CONSTRAINT t_transaksi_detail_id_item_cabang_fkey;
       public          postgres    false    4711    218    232            �           2606    34267 6   t_trans_in_detail t_transaksi_detail_id_transaksi_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.t_trans_in_detail
    ADD CONSTRAINT t_transaksi_detail_id_transaksi_fkey FOREIGN KEY (id_transaksi) REFERENCES public.t_trans_in(id);
 `   ALTER TABLE ONLY public.t_trans_in_detail DROP CONSTRAINT t_transaksi_detail_id_transaksi_fkey;
       public          postgres    false    231    232    4729               �   x�u�Q� �g8E`
,��jpA�����M]�'���G{e(�d�[��-t���CEqfm�7����ԥ����iiJ�1#�����-!�V:5�.`�#Ui�����7�Ƕė�4��g'Ce�|��]:#3{-��U6G��4����L�H�9��p�_	zMW         s  x�u�Kr� E�x���?h([���T�\�T�2z��\@	�Q��#x:��	����H�f����ᄟ�"��`c��]���Xϧ�,�W�+�ex>Ud�F]�~��0� ��2��?�e�m��[�����JS�}�Ϲ���K:�.7Q��d��F�g�,2�{�F���,�'���*z=]"�.DD�W%⅌711%�BED��TZ�~�#bT@xډ?m���]oݰ�t���w��>�G���p��Q��/�g65���R�@��߮�����bq�@$���Nx:%�<\�H�O͸��GPR@�T,~F�����D^R�K�tt��.Y�z'���d���~3b��|K?��n�BbҒ��t�c�5���{Ҵ�!&ِ�p����=�}�}�x#w�X{:��~��T'�N�G7�ʎa(����*gR" %I�~�w��i%�R?��P�HA��`�n-Չ�}f1�0���@���g�D�~��܄Eӵ�媈C�r�zn���	�z�T4+�p��̤�ð����4z��@NZ�`݁BZZ>��1��V8��ui��z�
�h���Q�����a�4�\��.3#M,6�2�B7	Y��y���a;�Jy�20�����9�K���1H�y�F��ji��\��n]�}��,��A��d>�Ұn�c�nld�m����u�"s�j�n�� _��e��-�:�e^�l ����1�m�C9���L�-)5Q�f��*������3Pl5�.�s�z�[�����  7�-������2x��װ����}Q��C�����cF��\��0�+}���2��$�����RO/C�®S��1�k��]n;(����N��A�            x�33�47�4�4�4����� �M      "   :   x�3�ttvv��t�2�prq�s�2�p�vQpqq�2��	v����� ,"      $   B   x�3�LL��̃���%E�%�E\Ɯ�ũE�y�E��9
 6�	gnb^b:PJ+䧥e&�r��qqq rL�      &   %   x�3�p�2��v�2���q�2�������� T.R      (   y   x�=�1�@D�����|w�z0�F��+�&6kl�+oD���{���s{CW�Q���ZF�w&�}(����:/x
��b�C^��F��/�_̢�َ5/]��LE���HL��b��Z��Y�$      *   u   x�m�1� ��>E/@eCk�!�UI���%,Q%��?=}�b!Q��Hs��h\=J�b6�A:㑭�w}��g�:M�Ϭ4x;��PMe�Θ��_N<�={���*e      1   .   x�32�40002�4202�54�50�442�22����p��qqq ���      3   !   x�32�42�43�44�22�"0ۀ+F��� EkO      ,   .   x�3�4�400�FF&���&��F�\���`	C4	�=... �	K      -   3   x�5��	  �w:�$A�����"~�s���Ȅ!��gvu��K~�GD�	W     