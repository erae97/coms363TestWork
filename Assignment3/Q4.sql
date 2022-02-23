
SET @film_id = 20;
select @film_id;

CREATE TRIGGER delete_film
AFTER DELETE
   ON film FOR EACH ROW

	UPDATE film_id
	SET old.film_id = film_id;