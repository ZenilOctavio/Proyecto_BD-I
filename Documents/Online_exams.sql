
-- Funcion para verificar que una respuesta se haga en el dia del examen o posterior
CREATE OR REPLACE FUNCTION ansDate_exaDate(_id_ int, _date_ TIMESTAMP)
RETURNS BOOLEAN
LANGUAGE plpgsql
as
$$
DECLARE
	countable integer;
BEGIN
	SELECT count(*) INTO countable FROM exams WHERE exam_id = _id_ AND _date_ <  exam_date;
	
	IF countable = 0 THEN
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;
END;
$$;


-- Table: public.subjects

-- DROP TABLE IF EXISTS public.subjects;

CREATE TABLE IF NOT EXISTS public.subjects
(
    subject_code character varying(15) COLLATE pg_catalog."default" NOT NULL,
    subject_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT subjects_pkey PRIMARY KEY (subject_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.subjects
    OWNER to postgres;



-- Table: public.type_question

-- DROP TABLE IF EXISTS public.type_question;

CREATE TABLE IF NOT EXISTS public.type_question
(
    type_question_code character varying(15) COLLATE pg_catalog."default" NOT NULL,
    type_question_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT type_question_pkey PRIMARY KEY (type_question_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.type_question
    OWNER to postgres;



-- Table: public.exams

-- DROP TABLE IF EXISTS public.exams;

CREATE TABLE IF NOT EXISTS public.exams
(
    exam_id integer NOT NULL,
    subject_code character varying(15) COLLATE pg_catalog."default" NOT NULL,
    exam_date timestamp without time zone NOT NULL,
    exam_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    exam_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    other_details character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT exams_pkey PRIMARY KEY (exam_id),
    CONSTRAINT subject_code FOREIGN KEY (subject_code)
        REFERENCES public.subjects (subject_code) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.exams
    OWNER to postgres;


-- Table: public.questions

-- DROP TABLE IF EXISTS public.questions;

CREATE TABLE IF NOT EXISTS public.questions
(
    question_id integer NOT NULL,
    type_question_code character varying(15) COLLATE pg_catalog."default" NOT NULL,
    question_text character varying(255) COLLATE pg_catalog."default" NOT NULL,
    other_details character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT questions_pkey PRIMARY KEY (question_id),
    CONSTRAINT type_question_code FOREIGN KEY (type_question_code)
        REFERENCES public.type_question (type_question_code) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.questions
    OWNER to postgres;


-- Table: public.student

-- DROP TABLE IF EXISTS public.student;

CREATE TABLE IF NOT EXISTS public.student
(
    student_id integer NOT NULL,
    first_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    middle_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    gender_mfu "char" NOT NULL,
    student_address character varying(255) COLLATE pg_catalog."default" NOT NULL,
    email_address character varying(255) COLLATE pg_catalog."default" NOT NULL,
    cell_mobile_phone character varying(255) COLLATE pg_catalog."default" NOT NULL,
    home_phone character varying(255) COLLATE pg_catalog."default" NOT NULL,
    other_details character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT student_pkey PRIMARY KEY (student_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.student
    OWNER to postgres;


-- Table: public.questions_in_exams

-- DROP TABLE IF EXISTS public.questions_in_exams;

CREATE TABLE IF NOT EXISTS public.questions_in_exams
(
    exam_id integer NOT NULL,
    question_id integer NOT NULL,
    CONSTRAINT pkey PRIMARY KEY (exam_id, question_id),
    CONSTRAINT exam_id FOREIGN KEY (exam_id)
        REFERENCES public.exams (exam_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT question_id FOREIGN KEY (question_id)
        REFERENCES public.questions (question_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.questions_in_exams
    OWNER to postgres;



-- Table: public.valid_answers

-- DROP TABLE IF EXISTS public.valid_answers;

CREATE TABLE IF NOT EXISTS public.valid_answers
(
    valid_answer_id integer NOT NULL,
    question_id integer NOT NULL,
    valid_answer_text character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT valid_answers_pkey PRIMARY KEY (valid_answer_id),
    CONSTRAINT question_id FOREIGN KEY (question_id)
        REFERENCES public.questions (question_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.valid_answers
    OWNER to postgres;



-- Table: public.student_answers

-- DROP TABLE IF EXISTS public.student_answers;

CREATE TABLE IF NOT EXISTS public.student_answers
(
    student_answer_id integer NOT NULL,
    exam_id integer NOT NULL,
    question_id integer NOT NULL,
    student_id integer NOT NULL,
    date_of_answer timestamp without time zone NOT NULL,
    comments character varying(255) COLLATE pg_catalog."default" NOT NULL,
    satisfactory boolean NOT NULL,
    student_answer_text character varying(255) COLLATE pg_catalog."default" NOT NULL,
    other_details character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT student_answers_pkey PRIMARY KEY (student_answer_id),
    CONSTRAINT exam_id FOREIGN KEY (exam_id)
        REFERENCES public.exams (exam_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT question_id FOREIGN KEY (question_id)
        REFERENCES public.questions (question_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT student_id FOREIGN KEY (student_id)
        REFERENCES public.student (student_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT "ansDate GTOREQ exaDate" CHECK (ansdate_exadate(exam_id, date_of_answer)) NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.student_answers
    OWNER to postgres;



-- Table: public.student_assesments

-- DROP TABLE IF EXISTS public.student_assesments;

CREATE TABLE IF NOT EXISTS public.student_assesments
(
    student_answer_id integer NOT NULL,
    valid_answer_id integer NOT NULL,
    student_answer_text character varying(255) COLLATE pg_catalog."default" NOT NULL,
    satisfactory boolean NOT NULL,
    assesment character varying(40) COLLATE pg_catalog."default" NOT NULL,
    other_details character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT student_assesments_pkey PRIMARY KEY (student_answer_id, valid_answer_id),
    CONSTRAINT student_answer_id FOREIGN KEY (student_answer_id)
        REFERENCES public.student_answers (student_answer_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT valid_answer_id FOREIGN KEY (valid_answer_id)
        REFERENCES public.valid_answers (valid_answer_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.student_assesments
    OWNER to postgres;