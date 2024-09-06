PGDMP  0                    |            db_onepiece    16.3    16.3 ?    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
          public          postgres    false    215            �            1259    33411    m_item    TABLE       CREATE TABLE public.m_item (
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
       public         heap    postgres    false            �            1259    33469    m_item_cabang    TABLE     �   CREATE TABLE public.m_item_cabang (
    id integer NOT NULL,
    id_item integer,
    id_cabang integer,
    stok_awal integer,
    stok_akhir integer
);
 !   DROP TABLE public.m_item_cabang;
       public         heap    postgres    false            �            1259    33468    m_item_cabang_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_item_cabang_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.m_item_cabang_id_seq;
       public          postgres    false    228                        0    0    m_item_cabang_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.m_item_cabang_id_seq OWNED BY public.m_item_cabang.id;
          public          postgres    false    227            �            1259    33410    m_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.m_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.m_item_id_seq;
       public          postgres    false    226                       0    0    m_item_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.m_item_id_seq OWNED BY public.m_item.id;
          public          postgres    false    225            �            1259    33399    m_jenis_item    TABLE     g   CREATE TABLE public.m_jenis_item (
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
       public          postgres    false    224                       0    0    m_jenis_item_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.m_jenis_item_id_seq OWNED BY public.m_jenis_item.id;
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
       public          postgres    false    218                       0    0    m_role_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.m_role_id_seq OWNED BY public.m_role.id;
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
       public          postgres    false    222                       0    0    m_satuan_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.m_satuan_id_seq OWNED BY public.m_satuan.id;
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
       public          postgres    false    220                       0    0    m_user_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.m_user_id_seq OWNED BY public.m_user.id;
          public          postgres    false    219            8           2604    25204    m_cabang id    DEFAULT     j   ALTER TABLE ONLY public.m_cabang ALTER COLUMN id SET DEFAULT nextval('public.m_cabang_id_seq'::regclass);
 :   ALTER TABLE public.m_cabang ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    216    216            =           2604    33414 	   m_item id    DEFAULT     f   ALTER TABLE ONLY public.m_item ALTER COLUMN id SET DEFAULT nextval('public.m_item_id_seq'::regclass);
 8   ALTER TABLE public.m_item ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225    226            ?           2604    33472    m_item_cabang id    DEFAULT     t   ALTER TABLE ONLY public.m_item_cabang ALTER COLUMN id SET DEFAULT nextval('public.m_item_cabang_id_seq'::regclass);
 ?   ALTER TABLE public.m_item_cabang ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    228    228            <           2604    33402    m_jenis_item id    DEFAULT     r   ALTER TABLE ONLY public.m_jenis_item ALTER COLUMN id SET DEFAULT nextval('public.m_jenis_item_id_seq'::regclass);
 >   ALTER TABLE public.m_jenis_item ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    224    224            9           2604    25215 	   m_role id    DEFAULT     f   ALTER TABLE ONLY public.m_role ALTER COLUMN id SET DEFAULT nextval('public.m_role_id_seq'::regclass);
 8   ALTER TABLE public.m_role ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            ;           2604    33395    m_satuan id    DEFAULT     j   ALTER TABLE ONLY public.m_satuan ALTER COLUMN id SET DEFAULT nextval('public.m_satuan_id_seq'::regclass);
 :   ALTER TABLE public.m_satuan ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            :           2604    25226 	   m_user id    DEFAULT     f   ALTER TABLE ONLY public.m_user ALTER COLUMN id SET DEFAULT nextval('public.m_user_id_seq'::regclass);
 8   ALTER TABLE public.m_user ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220            �          0    25201    m_cabang 
   TABLE DATA           @   COPY public.m_cabang (id, kode, nama, alamat, telp) FROM stdin;
    public          postgres    false    216   �E       �          0    33411    m_item 
   TABLE DATA           [   COPY public.m_item (id, kode, nama, hpp, hjl, aktif, id_satuan, id_jenis_item) FROM stdin;
    public          postgres    false    226   �F       �          0    33469    m_item_cabang 
   TABLE DATA           V   COPY public.m_item_cabang (id, id_item, id_cabang, stok_awal, stok_akhir) FROM stdin;
    public          postgres    false    228   J       �          0    33399    m_jenis_item 
   TABLE DATA           0   COPY public.m_jenis_item (id, nama) FROM stdin;
    public          postgres    false    224   SJ       �          0    25212    m_role 
   TABLE DATA           0   COPY public.m_role (id, kode, nama) FROM stdin;
    public          postgres    false    218   �J       �          0    33392    m_satuan 
   TABLE DATA           ,   COPY public.m_satuan (id, nama) FROM stdin;
    public          postgres    false    222   �J       �          0    25223    m_user 
   TABLE DATA           R   COPY public.m_user (id, username, password, id_role, id_cabang, nama) FROM stdin;
    public          postgres    false    220   %K                  0    0    m_cabang_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.m_cabang_id_seq', 13, true);
          public          postgres    false    215                       0    0    m_item_cabang_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.m_item_cabang_id_seq', 9, true);
          public          postgres    false    227                       0    0    m_item_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.m_item_id_seq', 73, true);
          public          postgres    false    225            	           0    0    m_jenis_item_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.m_jenis_item_id_seq', 4, true);
          public          postgres    false    223            
           0    0    m_role_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.m_role_id_seq', 4, true);
          public          postgres    false    217                       0    0    m_satuan_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.m_satuan_id_seq', 5, true);
          public          postgres    false    221                       0    0    m_user_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.m_user_id_seq', 13, true);
          public          postgres    false    219            A           2606    25210    m_cabang m_cabang_kode_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.m_cabang
    ADD CONSTRAINT m_cabang_kode_key UNIQUE (kode);
 D   ALTER TABLE ONLY public.m_cabang DROP CONSTRAINT m_cabang_kode_key;
       public            postgres    false    216            C           2606    25208    m_cabang m_cabang_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.m_cabang
    ADD CONSTRAINT m_cabang_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.m_cabang DROP CONSTRAINT m_cabang_pkey;
       public            postgres    false    216            U           2606    33474     m_item_cabang m_item_cabang_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.m_item_cabang
    ADD CONSTRAINT m_item_cabang_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.m_item_cabang DROP CONSTRAINT m_item_cabang_pkey;
       public            postgres    false    228            Q           2606    33421    m_item m_item_kode_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.m_item
    ADD CONSTRAINT m_item_kode_key UNIQUE (kode);
 @   ALTER TABLE ONLY public.m_item DROP CONSTRAINT m_item_kode_key;
       public            postgres    false    226            S           2606    33419    m_item m_item_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.m_item
    ADD CONSTRAINT m_item_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.m_item DROP CONSTRAINT m_item_pkey;
       public            postgres    false    226            O           2606    33404    m_jenis_item m_jenis_item_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.m_jenis_item
    ADD CONSTRAINT m_jenis_item_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.m_jenis_item DROP CONSTRAINT m_jenis_item_pkey;
       public            postgres    false    224            E           2606    25221    m_role m_role_kode_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.m_role
    ADD CONSTRAINT m_role_kode_key UNIQUE (kode);
 @   ALTER TABLE ONLY public.m_role DROP CONSTRAINT m_role_kode_key;
       public            postgres    false    218            G           2606    25219    m_role m_role_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.m_role
    ADD CONSTRAINT m_role_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.m_role DROP CONSTRAINT m_role_pkey;
       public            postgres    false    218            M           2606    33397    m_satuan m_satuan_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.m_satuan
    ADD CONSTRAINT m_satuan_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.m_satuan DROP CONSTRAINT m_satuan_pkey;
       public            postgres    false    222            I           2606    25228    m_user m_user_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_pkey;
       public            postgres    false    220            K           2606    25230    m_user m_user_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_username_key UNIQUE (username);
 D   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_username_key;
       public            postgres    false    220            Z           2606    33480 *   m_item_cabang m_item_cabang_id_cabang_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_item_cabang
    ADD CONSTRAINT m_item_cabang_id_cabang_fkey FOREIGN KEY (id_cabang) REFERENCES public.m_cabang(id);
 T   ALTER TABLE ONLY public.m_item_cabang DROP CONSTRAINT m_item_cabang_id_cabang_fkey;
       public          postgres    false    228    4675    216            [           2606    33475 (   m_item_cabang m_item_cabang_id_item_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_item_cabang
    ADD CONSTRAINT m_item_cabang_id_item_fkey FOREIGN KEY (id_item) REFERENCES public.m_item(id);
 R   ALTER TABLE ONLY public.m_item_cabang DROP CONSTRAINT m_item_cabang_id_item_fkey;
       public          postgres    false    4691    226    228            X           2606    33427     m_item m_item_id_jenis_item_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_item
    ADD CONSTRAINT m_item_id_jenis_item_fkey FOREIGN KEY (id_jenis_item) REFERENCES public.m_jenis_item(id);
 J   ALTER TABLE ONLY public.m_item DROP CONSTRAINT m_item_id_jenis_item_fkey;
       public          postgres    false    4687    224    226            Y           2606    33422    m_item m_item_id_satuan_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_item
    ADD CONSTRAINT m_item_id_satuan_fkey FOREIGN KEY (id_satuan) REFERENCES public.m_satuan(id);
 F   ALTER TABLE ONLY public.m_item DROP CONSTRAINT m_item_id_satuan_fkey;
       public          postgres    false    226    4685    222            V           2606    25236    m_user m_user_id_cabang_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_id_cabang_fkey FOREIGN KEY (id_cabang) REFERENCES public.m_cabang(id);
 F   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_id_cabang_fkey;
       public          postgres    false    216    220    4675            W           2606    25231    m_user m_user_id_role_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.m_role(id);
 D   ALTER TABLE ONLY public.m_user DROP CONSTRAINT m_user_id_role_fkey;
       public          postgres    false    4679    218    220            �   �   x�u�Q� �g8E`
,��jpA�����M]�'���G{e(�d�[��-t���CEqfm�7����ԥ����iiJ�1#�����-!�V:5�.`�#Ui�����7�Ƕė�4��g'Ce�|��]:#3{-��U6G��4����L�H�9��p�_	zMW      �   o  x����n� F��S�]`����7ImŎ�J���Z>bӘ�W�|�9��d�c�Ҝ�4B�!��?�d� � q%����Q�"�Ji���AQX+}��Z�u\�0���5{��@��3o�vZ�[z?�b�Q�k���X�(��U˿ج���@����l?��S�]ZL��,��z⚿��@��0�T=�R�$�)����h3ޔ� � u�D�� ʴ��7�:e�륝߻a>�㾖-�)���c��#��C�j����jˬ�
I<Ō��#1)���~#�$����Lm'��UK*z��S�ς ��=v�P�ГR<�片k����:~��.\h-M'���2��f��r��s���~���(��M�M�����/��a�|Ȃ?Ҹ�Q(��]������GP���������_���`TK)�޻a,�@�պ����y�X�P�_��p�NX�>����%�fM�k����h�=�:��Ƹ�أ6	��@:6l���v�J�ө�'����<fF�x�CǮ���
G�#5��=upl�3^���iC;��hh6�ǨFB�1+Yk�Ʈ�di�jH5n%]�=�Q���Ưd#X�}o�%��4+l�+�����'�2Sn�������*3k֬�`����8���+��+�le��1%�9�vi�2�Yæc��Ƭ�S�`̺Hj��K����1�#����6�D���.2�_ND��@2;��,'#Y���)�@�PLM�"ol��2���f]���<
,�8ÖSx�J�B���^|3����%�b��y`���p�4�k�����U<<��<�x���D8��a�S;��|,/	1��'�n��#���r8�z�VM      �   =   x�3�4�4A.#N#(˘
�L��� �e
���̀2�9P���,�
�K�8'F��� ��       �   :   x�3�ttvv��t�2�prq�s�2�p�vQpqq�2��	v����� ,"      �   B   x�3�LL��̃���%E�%�E\Ɯ�ũE�y�E��9
 6�	gnb^b:PJ+䧥e&�r��qqq rL�      �   &   x�3�p�2��v�2���	�2���q����� Y��      �   y   x�=�1�@D�����|w�z0�F��+�&6kl�+oD���{���s{CW�Q���ZF�w&�}(����:/x
��b�C^��F��/�_̢�َ5/]��LE���HL��b��Z��Y�$     