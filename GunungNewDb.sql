PGDMP                     
    x            GunungNewDB    11.6    11.6 %    K           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            L           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            M           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            N           1262    90709    GunungNewDB    DATABASE     �   CREATE DATABASE "GunungNewDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_India.1252' LC_CTYPE = 'English_India.1252';
    DROP DATABASE "GunungNewDB";
             postgres    false            �            1259    90710    bot_qna    TABLE     �   CREATE TABLE public.bot_qna (
    question text NOT NULL,
    utterances text[],
    dialogue text,
    dialogue_depth numeric,
    answer text[] NOT NULL
);
    DROP TABLE public.bot_qna;
       public         postgres    false            �            1259    90716    chat_data_s_no_seq    SEQUENCE     {   CREATE SEQUENCE public.chat_data_s_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.chat_data_s_no_seq;
       public       postgres    false            �            1259    90718 	   chat_data    TABLE       CREATE TABLE public.chat_data (
    conversation_id text,
    group_id text,
    "Message" jsonb,
    s_no numeric DEFAULT nextval('public.chat_data_s_no_seq'::regclass),
    creation_date text DEFAULT now(),
    server_timestamp timestamp(1) without time zone DEFAULT now()
);
    DROP TABLE public.chat_data;
       public         postgres    false    197            �            1259    90727    chat_logging_S_No_seq    SEQUENCE     �   CREATE SEQUENCE public."chat_logging_S_No_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."chat_logging_S_No_seq";
       public       postgres    false            �            1259    90729    chat_logging    TABLE     L  CREATE TABLE public.chat_logging (
    "Conversation_ID" text,
    "Group_ID" text,
    "From_Participant_ID" text,
    "Message" json,
    "Creation_Date" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "S_No" integer DEFAULT nextval('public."chat_logging_S_No_seq"'::regclass) NOT NULL,
    "To_Participant_ID" text
);
     DROP TABLE public.chat_logging;
       public         postgres    false    199            �            1259    90737    chat_logging_s_no_seq    SEQUENCE     ~   CREATE SEQUENCE public.chat_logging_s_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.chat_logging_s_no_seq;
       public       postgres    false            �            1259    90739 
   group_data    TABLE     �   CREATE TABLE public.group_data (
    group_id text NOT NULL,
    group_name text,
    group_participants text[],
    group_type text DEFAULT 'individual'::text
);
    DROP TABLE public.group_data;
       public         postgres    false            �            1259    90746 
   login_data    TABLE     �   CREATE TABLE public.login_data (
    fname text,
    lname text,
    username text NOT NULL,
    password text,
    user_type text,
    designation text,
    teams text[]
);
    DROP TABLE public.login_data;
       public         postgres    false            �            1259    90752    meetings    TABLE     �   CREATE TABLE public.meetings (
    "MeetingId" numeric,
    "Topic" text,
    "Agenda" text,
    "StartedOn" timestamp with time zone,
    "EndedOn" timestamp with time zone,
    "TranscriptJsonFilePath" text,
    "TranscriptSubtitleFilePath" text
);
    DROP TABLE public.meetings;
       public         postgres    false            �            1259    90758    participant_ParticipantId_seq    SEQUENCE     �   CREATE SEQUENCE public."participant_ParticipantId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public."participant_ParticipantId_seq";
       public       postgres    false            �            1259    90760    participants    TABLE     �   CREATE TABLE public.participants (
    "MeetingId" numeric,
    "ParticipantId" numeric DEFAULT nextval('public."participant_ParticipantId_seq"'::regclass),
    "ParticipantEmail" text,
    "ParticipantName" text
);
     DROP TABLE public.participants;
       public         postgres    false    205            �            1259    90767    recording_files    TABLE     �   CREATE TABLE public.recording_files (
    "MeetingId" numeric,
    "FileType" text,
    "RecordingType" text,
    "SrcObject" text,
    "FilePath" text
);
 #   DROP TABLE public.recording_files;
       public         postgres    false            �            1259    90773 	   reminders    TABLE     �   CREATE TABLE public.reminders (
    duration numeric NOT NULL,
    base_time text NOT NULL,
    notification_data json,
    subscribers text[],
    status text,
    reminder_id text NOT NULL
);
    DROP TABLE public.reminders;
       public         postgres    false            �            1259    90779    subscribers_data    TABLE     �   CREATE TABLE public.subscribers_data (
    subscriber text NOT NULL,
    email_id text NOT NULL,
    last_login timestamp with time zone,
    active boolean,
    first_name text
);
 $   DROP TABLE public.subscribers_data;
       public         postgres    false            ;          0    90710    bot_qna 
   TABLE DATA               Y   COPY public.bot_qna (question, utterances, dialogue, dialogue_depth, answer) FROM stdin;
    public       postgres    false    196   ;*       =          0    90718 	   chat_data 
   TABLE DATA               p   COPY public.chat_data (conversation_id, group_id, "Message", s_no, creation_date, server_timestamp) FROM stdin;
    public       postgres    false    198   D,       ?          0    90729    chat_logging 
   TABLE DATA               �   COPY public.chat_logging ("Conversation_ID", "Group_ID", "From_Participant_ID", "Message", "Creation_Date", "S_No", "To_Participant_ID") FROM stdin;
    public       postgres    false    200   a,       A          0    90739 
   group_data 
   TABLE DATA               Z   COPY public.group_data (group_id, group_name, group_participants, group_type) FROM stdin;
    public       postgres    false    202   ~,       B          0    90746 
   login_data 
   TABLE DATA               e   COPY public.login_data (fname, lname, username, password, user_type, designation, teams) FROM stdin;
    public       postgres    false    203   �/       C          0    90752    meetings 
   TABLE DATA               �   COPY public.meetings ("MeetingId", "Topic", "Agenda", "StartedOn", "EndedOn", "TranscriptJsonFilePath", "TranscriptSubtitleFilePath") FROM stdin;
    public       postgres    false    204   �0       E          0    90760    participants 
   TABLE DATA               k   COPY public.participants ("MeetingId", "ParticipantId", "ParticipantEmail", "ParticipantName") FROM stdin;
    public       postgres    false    206   �0       F          0    90767    recording_files 
   TABLE DATA               l   COPY public.recording_files ("MeetingId", "FileType", "RecordingType", "SrcObject", "FilePath") FROM stdin;
    public       postgres    false    207   �0       G          0    90773 	   reminders 
   TABLE DATA               m   COPY public.reminders (duration, base_time, notification_data, subscribers, status, reminder_id) FROM stdin;
    public       postgres    false    208   m2       H          0    90779    subscribers_data 
   TABLE DATA               `   COPY public.subscribers_data (subscriber, email_id, last_login, active, first_name) FROM stdin;
    public       postgres    false    209   �2       O           0    0    chat_data_s_no_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.chat_data_s_no_seq', 2913, true);
            public       postgres    false    197            P           0    0    chat_logging_S_No_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."chat_logging_S_No_seq"', 1055, true);
            public       postgres    false    199            Q           0    0    chat_logging_s_no_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.chat_logging_s_no_seq', 1, false);
            public       postgres    false    201            R           0    0    participant_ParticipantId_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public."participant_ParticipantId_seq"', 25, true);
            public       postgres    false    205            �
           2606    90789    chat_logging chat_logging_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.chat_logging
    ADD CONSTRAINT chat_logging_pkey PRIMARY KEY ("S_No");
 H   ALTER TABLE ONLY public.chat_logging DROP CONSTRAINT chat_logging_pkey;
       public         postgres    false    200            �
           2606    90791    group_data group_data_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.group_data
    ADD CONSTRAINT group_data_pkey PRIMARY KEY (group_id);
 D   ALTER TABLE ONLY public.group_data DROP CONSTRAINT group_data_pkey;
       public         postgres    false    202            �
           2606    90793    login_data login_data_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.login_data
    ADD CONSTRAINT login_data_pkey PRIMARY KEY (username);
 D   ALTER TABLE ONLY public.login_data DROP CONSTRAINT login_data_pkey;
       public         postgres    false    203            �
           2606    90795    reminders reminders_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.reminders
    ADD CONSTRAINT reminders_pkey PRIMARY KEY (reminder_id);
 B   ALTER TABLE ONLY public.reminders DROP CONSTRAINT reminders_pkey;
       public         postgres    false    208            �
           2606    90797 &   subscribers_data subscribers_data_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.subscribers_data
    ADD CONSTRAINT subscribers_data_pkey PRIMARY KEY (email_id);
 P   ALTER TABLE ONLY public.subscribers_data DROP CONSTRAINT subscribers_data_pkey;
       public         postgres    false    209            ;   �  x��SM��0='�b�9x��,��iY($m �P�e�LlY2�\�-��;���-��7�7�� 	�La����.`��Opte�	lB�Y&E�gI��UF&x�m��+Z�u^͖��E�%��v\ʕ�U����h��}sRݺrF��Z=�(l�U�o;\֕��m��㵧�K�E����d��P�,��.�IUp�ʀ�6�*��@(@�=u����3kxZy�;e��P+��緩xO:B�橀�{������e(.���x�V�H���,n�&qEo�t�	a��'�{}o��Brw�D������qهGy���P�y�J�f~�F91�!q{��w�gM������j�k_�k3�~x(�2���%��N����!�����Nk�8W�����	X�q�^#!�0�K@e�%<���4���,_wղ:��������؀"U�f��Xǖ�=}�!�Ѕ���f޻aC7�8᤾��֜υ,
�w�M�7�3���
���)���9���      =      x������ � �      ?      x������ � �      A   �  x����n�J���S]��p��zwus7EW�pf8�[
l�@P��K�YԒkg#�����p%I��;�n3��h�C�q_��������������#?�r7ܔ���v�N����^v[��X}���T	�z�1):e�b�X\�U
�7��Ӗ�����al÷�=�f��r�#-��PK�m2lڼЂ�a3톿V0�	�O���$�
����(�
3��"��d鬪}�L!��|p1Zس���V�1�
r#�����C�ZD�S�4/���/�SU�)�ĩ�T��.%�9'bk��~�H�J��Uk�` tr�ب����������>����`zDuX���d-R�Q
^�Ŝ*�j���N�ؿ9�-$[ΔB�N�O�dr6�P�1�y��j&N(��8c�"Ћh�u�̜Zs���ߛN�%��c61!���]�َ5M�.IE��<l��$�j���g�F�s�8�ZO��=�c4��p��?��4|Ƙj
B���Dsb�X�������2�J�փ����UW-�X�+�� �:�5��� "��������;o�|2���Ļ-��y����4�N��&�����'F�+�����v��2V_�&�k�s��˹\{Z�N����4��5>�z@v'��כ��9�L;���Q��l1k�	�1�Q�U��;=��S>SdƒS�e͠� L�uY�Y���R�إs�1�,말�QluzV�	+�,�׼��%u)�d+�~\��?aU��      B   �   x�}�AN�0EדS�=ATJ� j�d3���{"ۭ!��8����?�����v|"cAz}ӓQd7+hB�$i[5<����j�ǯ�'MP�q��=yx�^O?��o�C'}:/,�X��q��='�U����=����sBf/���܅�e��2����[o&Y?8eM(2B�Gv)d<��yD-���6�*U��Uc���h�WT�E����Q��˹�[�f����c��'��)��ز      C      x������ � �      E      x������ � �      F   �  x���9jA��}��K������|�0HP�8��AO��Ri�bD���z<?�^��߿�ܘ������Y*�$Ϛ �0I�Y��>gK�Y#�T�P���1��%�Y#�R5��ƀ���P���0��g�*e���tc,$K <�Ӎag����~F����s�R����
��I�R�⓹�0ѩ6��l��K �:�%��"q�pwQ���bc̅�z���������~�1,�߸�àV�N���N��Qt�э�ސ=&3ka@�Ύ����`(�g�2Dj�A-lLhop��0����Z��Ojaa${�Fqj�uC7���Y# S�Aݘ^�X���ޘ�}�T@g�1�Y��Lv卩^v�'�d�n��Edgc�:��љ��������J}�      G      x������ � �      H   v  x��Ks�@ ���+��Adx�vDHD1ф��VY�C` a���ɵ�������U��h i۪���((fqY�9񫴙e�#͛�u�����9���V��ӑlX��$Cj<����K&IC(�o^�ol�M������Z��-��#z+�~��q�۳����?�����*{�G�4�1k��Vϊ�dX��ᲇ�$�@�*��mZҷ� @�,�@F�h���&��K�Azx��ڥ�U6s��e-�� a�]
(K�p�3��r�>��V&� �ѣCJ�?q��u����Fi<ټr/�����e�6
�1n<t��̝b��5��.�鿄�
���D��x���?���P�h�@�/D�N�	�ML�Ϧ��7�8��     