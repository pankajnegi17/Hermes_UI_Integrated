PGDMP         %                x            GunungFirstPOCDB    11.6    11.6 %    K           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            L           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            M           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            N           1262    98901    GunungFirstPOCDB    DATABASE     �   CREATE DATABASE "GunungFirstPOCDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_India.1252' LC_CTYPE = 'English_India.1252';
 "   DROP DATABASE "GunungFirstPOCDB";
             postgres    false            �            1259    98902    bot_qna    TABLE     �   CREATE TABLE public.bot_qna (
    question text NOT NULL,
    utterances text[],
    dialogue text,
    dialogue_depth numeric,
    answer text[] NOT NULL
);
    DROP TABLE public.bot_qna;
       public         postgres    false            �            1259    98908    chat_data_s_no_seq    SEQUENCE     {   CREATE SEQUENCE public.chat_data_s_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.chat_data_s_no_seq;
       public       postgres    false            �            1259    98910 	   chat_data    TABLE       CREATE TABLE public.chat_data (
    conversation_id text,
    group_id text,
    "Message" jsonb,
    s_no numeric DEFAULT nextval('public.chat_data_s_no_seq'::regclass),
    creation_date text DEFAULT now(),
    server_timestamp timestamp(1) without time zone DEFAULT now()
);
    DROP TABLE public.chat_data;
       public         postgres    false    197            �            1259    98919    chat_logging_S_No_seq    SEQUENCE     �   CREATE SEQUENCE public."chat_logging_S_No_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."chat_logging_S_No_seq";
       public       postgres    false            �            1259    98921    chat_logging    TABLE     L  CREATE TABLE public.chat_logging (
    "Conversation_ID" text,
    "Group_ID" text,
    "From_Participant_ID" text,
    "Message" json,
    "Creation_Date" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "S_No" integer DEFAULT nextval('public."chat_logging_S_No_seq"'::regclass) NOT NULL,
    "To_Participant_ID" text
);
     DROP TABLE public.chat_logging;
       public         postgres    false    199            �            1259    98929    chat_logging_s_no_seq    SEQUENCE     ~   CREATE SEQUENCE public.chat_logging_s_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.chat_logging_s_no_seq;
       public       postgres    false            �            1259    98931 
   group_data    TABLE     �   CREATE TABLE public.group_data (
    group_id text NOT NULL,
    group_name text,
    group_participants text[],
    group_type text DEFAULT 'individual'::text
);
    DROP TABLE public.group_data;
       public         postgres    false            �            1259    98938 
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
       public         postgres    false            �            1259    98944    meetings    TABLE     �   CREATE TABLE public.meetings (
    "MeetingId" numeric,
    "Topic" text,
    "Agenda" text,
    "StartedOn" timestamp with time zone,
    "EndedOn" timestamp with time zone,
    "TranscriptJsonFilePath" text,
    "TranscriptSubtitleFilePath" text
);
    DROP TABLE public.meetings;
       public         postgres    false            �            1259    98950    participant_ParticipantId_seq    SEQUENCE     �   CREATE SEQUENCE public."participant_ParticipantId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public."participant_ParticipantId_seq";
       public       postgres    false            �            1259    98952    participants    TABLE     �   CREATE TABLE public.participants (
    "MeetingId" numeric,
    "ParticipantId" numeric DEFAULT nextval('public."participant_ParticipantId_seq"'::regclass),
    "ParticipantEmail" text,
    "ParticipantName" text
);
     DROP TABLE public.participants;
       public         postgres    false    205            �            1259    98959    recording_files    TABLE     �   CREATE TABLE public.recording_files (
    "MeetingId" numeric,
    "FileType" text,
    "RecordingType" text,
    "SrcObject" text,
    "FilePath" text
);
 #   DROP TABLE public.recording_files;
       public         postgres    false            �            1259    98965 	   reminders    TABLE     �   CREATE TABLE public.reminders (
    duration numeric NOT NULL,
    base_time text NOT NULL,
    notification_data json,
    subscribers text[],
    status text,
    reminder_id text NOT NULL
);
    DROP TABLE public.reminders;
       public         postgres    false            �            1259    98971    subscribers_data    TABLE     �   CREATE TABLE public.subscribers_data (
    subscriber text NOT NULL,
    email_id text NOT NULL,
    last_login timestamp with time zone,
    active boolean,
    first_name text
);
 $   DROP TABLE public.subscribers_data;
       public         postgres    false            ;          0    98902    bot_qna 
   TABLE DATA               Y   COPY public.bot_qna (question, utterances, dialogue, dialogue_depth, answer) FROM stdin;
    public       postgres    false    196   O*       =          0    98910 	   chat_data 
   TABLE DATA               p   COPY public.chat_data (conversation_id, group_id, "Message", s_no, creation_date, server_timestamp) FROM stdin;
    public       postgres    false    198   X,       ?          0    98921    chat_logging 
   TABLE DATA               �   COPY public.chat_logging ("Conversation_ID", "Group_ID", "From_Participant_ID", "Message", "Creation_Date", "S_No", "To_Participant_ID") FROM stdin;
    public       postgres    false    200   u,       A          0    98931 
   group_data 
   TABLE DATA               Z   COPY public.group_data (group_id, group_name, group_participants, group_type) FROM stdin;
    public       postgres    false    202   �,       B          0    98938 
   login_data 
   TABLE DATA               e   COPY public.login_data (fname, lname, username, password, user_type, designation, teams) FROM stdin;
    public       postgres    false    203   $0       C          0    98944    meetings 
   TABLE DATA               �   COPY public.meetings ("MeetingId", "Topic", "Agenda", "StartedOn", "EndedOn", "TranscriptJsonFilePath", "TranscriptSubtitleFilePath") FROM stdin;
    public       postgres    false    204   F1       E          0    98952    participants 
   TABLE DATA               k   COPY public.participants ("MeetingId", "ParticipantId", "ParticipantEmail", "ParticipantName") FROM stdin;
    public       postgres    false    206   c1       F          0    98959    recording_files 
   TABLE DATA               l   COPY public.recording_files ("MeetingId", "FileType", "RecordingType", "SrcObject", "FilePath") FROM stdin;
    public       postgres    false    207   �1       G          0    98965 	   reminders 
   TABLE DATA               m   COPY public.reminders (duration, base_time, notification_data, subscribers, status, reminder_id) FROM stdin;
    public       postgres    false    208   3       H          0    98971    subscribers_data 
   TABLE DATA               `   COPY public.subscribers_data (subscriber, email_id, last_login, active, first_name) FROM stdin;
    public       postgres    false    209   4       O           0    0    chat_data_s_no_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.chat_data_s_no_seq', 3122, true);
            public       postgres    false    197            P           0    0    chat_logging_S_No_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."chat_logging_S_No_seq"', 1055, true);
            public       postgres    false    199            Q           0    0    chat_logging_s_no_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.chat_logging_s_no_seq', 1, false);
            public       postgres    false    201            R           0    0    participant_ParticipantId_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public."participant_ParticipantId_seq"', 25, true);
            public       postgres    false    205            �
           2606    98978    chat_logging chat_logging_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.chat_logging
    ADD CONSTRAINT chat_logging_pkey PRIMARY KEY ("S_No");
 H   ALTER TABLE ONLY public.chat_logging DROP CONSTRAINT chat_logging_pkey;
       public         postgres    false    200            �
           2606    98980    group_data group_data_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.group_data
    ADD CONSTRAINT group_data_pkey PRIMARY KEY (group_id);
 D   ALTER TABLE ONLY public.group_data DROP CONSTRAINT group_data_pkey;
       public         postgres    false    202            �
           2606    98982    login_data login_data_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.login_data
    ADD CONSTRAINT login_data_pkey PRIMARY KEY (username);
 D   ALTER TABLE ONLY public.login_data DROP CONSTRAINT login_data_pkey;
       public         postgres    false    203            �
           2606    98984    reminders reminders_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.reminders
    ADD CONSTRAINT reminders_pkey PRIMARY KEY (reminder_id);
 B   ALTER TABLE ONLY public.reminders DROP CONSTRAINT reminders_pkey;
       public         postgres    false    208            �
           2606    98986 &   subscribers_data subscribers_data_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.subscribers_data
    ADD CONSTRAINT subscribers_data_pkey PRIMARY KEY (email_id);
 P   ALTER TABLE ONLY public.subscribers_data DROP CONSTRAINT subscribers_data_pkey;
       public         postgres    false    209            ;   �  x��SM��0='�b�9x��,��iY($m �P�e�LlY2�\�-��;���-��7�7�� 	�La����.`��Opte�	lB�Y&E�gI��UF&x�m��+Z�u^͖��E�%��v\ʕ�U����h��}sRݺrF��Z=�(l�U�o;\֕��m��㵧�K�E����d��P�,��.�IUp�ʀ�6�*��@(@�=u����3kxZy�;e��P+��緩xO:B�橀�{������e(.���x�V�H���,n�&qEo�t�	a��'�{}o��Brw�D������qهGy���P�y�J�f~�F91�!q{��w�gM������j�k_�k3�~x(�2���%��N����!�����Nk�8W�����	X�q�^#!�0�K@e�%<���4���,_wղ:��������؀"U�f��Xǖ�=}�!�Ѕ���f޻aC7�8᤾��֜υ,
�w�M�7�3���
���)���9���      =      x������ � �      ?      x������ � �      A   �  x���Mo#7����X�9\�[�m�zjz)zꅔ�d��E�/�����.�13zH�|))��,�l��+PR1��4/��>����o���˧{Z����V������+�w4,_�zy���>�f)��_��s�U"�` yBE�T[!d�]�x#z��^�����}6���mh����h:Wʀ��[G@�TN�ˆL����p6�I�MB�!7�%@�)2�ܬII�F��<�%�RoP��f2t
��O)�D���\�nM:e�h�4t��8(%V�,"�c�q ��t��6W��,^�F&`�|�>P�H΍�O����bX4N�6�:�� Z�Pj�kt�L~z]t	�g�u ӓU�Հ$�C��Y䞄�u_��ҝ��t����mQ�X����9���q'�:�R����`�s�3R�)�H�'��Xc�w.D�5���s�����[Lʖ�z�.�]�5� M�I����y�Iﲤ�.���1�Z�
k	Q��*�^�'k����m�����1հ��u����U.�n_�$�	���1(MAK�>B�@�v�:j�{���DB�i�cR����n�sկ�������@G�ޮ_h�����_l֫�����Y����H�}���΃��
~�h���&�ا���s9�4�_�>T����T���v��p>MvL<Q�ednغ��[[ԃl"�T(��B
^7�q�O��,��Ǣ6!V�.�Z�1v�Ƙj�CGzb�'[��U�CC�զ"��2��)u���T��K�g�mK��Ѷ�Jnd��^�G2��s�w�U�9�[�������l�S���選{n��G�����s�_0t')z��s���W��|:;��[@�m�I�Ĩ�;�X���-�(�n��+��d����6��      B     x�}Q�N�@<;_�/�7D���ܸ�Y�ْ���M���l^�S(���c��;��h`�G�t�w%ٚܪ���WT���u�T�����.�����;C���l��R<vo�_��.�렖�3Td���͎�G�%���k�K@E����M�,����9!��v!�_&3QW>qJ��C:�U��'}��������m�5Gp}YO���h������:�h8�E ����J���O9")��������6,f�Һ�ˎԬn���6$��XEQ��8��      C      x������ � �      E      x������ � �      F   �  x���9jA��}��K������|�0HP�8��AO��Ri�bD���z<?�^��߿�ܘ������Y*�$Ϛ �0I�Y��>gK�Y#�T�P���1��%�Y#�R5��ƀ���P���0��g�*e���tc,$K <�Ӎag����~F����s�R����
��I�R�⓹�0ѩ6��l��K �:�%��"q�pwQ���bc̅�z���������~�1,�߸�àV�N���N��Qt�э�ސ=&3ka@�Ύ����`(�g�2Dj�A-lLhop��0����Z��Ojaa${�Fqj�uC7���Y# S�Aݘ^�X���ޘ�}�T@g�1�Y��Lv卩^v�'�d�n��Edgc�:��љ��������J}�      G   �   x����j�0��9�A�#�ީ��l9![�ڞJ�}�����r�H����
�X0��5�P���yn�,,�]�֥�S+��0�<�|��V^��uk������|W5�c�Q��������%���4 d�m�:z�A;C���SB�)|(����}>:Ĭ�"t�u���Ж��\�Z�eT���)_gA����,ԇ�P�w�C��g�K��~��<      H      x������ � �     