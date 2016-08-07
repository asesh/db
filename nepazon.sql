DROP PROCEDURE IF EXISTS nepazon.register_user; # DROP this PROCEDURE

##########################################################################################
# Name: register_user
# Type: Stored PROCEDURE
# Desc: Register the specIFied user
##########################################################################################
delimiter //
CREATE PROCEDURE nepazon.register_user(IN email_address VARCHAR(45), IN user_password VARCHAR(45), IN first_name VARCHAR(45), IN last_name VARCHAR(45), IN date_of_birth VARCHAR(45))

BEGIN

	# Local variables
	DECLARE l_email_address VARCHAR(45);

	DECLARE l_user_id INT DEFAULT 0;

	# Check if this user already exists or not
	SELECT email_address FROM nepazon.users WHERE nepazon.users.email_address = email_address INTO l_email_address;

	#
	# Perform the validation of user Input before inserting them into the database
	#

	# Check the length of the username
	IF (len(email_address) <= 30) THEN # The length of email address is within the valid range
		IF (len(user_password) <= 30) THEN # The length of password is within the valid range
			IF (len(first_name) <= 30) THEN # The lenght of first name is within the valid range
				IF (len(last_name) <= 30) THEN # The length of the last name is with in the valid range
					INSERT INTO nepazon.users(email_address, first_name, last_name, password, date_of_birth) VALUES(email_address, first_name, last_name, user_password, date_of_birth);
				ELSE # Length of last name is invalid
					RETURN FALSE;
				END IF;
			ELSE # Length of first name is invalid
				RETURN FALSE;
			END IF;
		ELSE # Length of password is invalid
			RETURN FALSE;
		END IF;
	ELSE # Length of username is invalid
		RETURN FALSE;
	END IF;

END //
delimiter

##########################################################################################
# Name: register_product
# Type: Stored PROCEDURE
# Desc: Register a product
##########################################################################################
delimiter // 
CREATE PROCEDURE nepazon.register_product(IN product_name VARCHAR(45), IN product_description VARCHAR(45), IN product_price VARCHAR(45))

BEGIN

END //
delimiter

DROP PROCEDURE IF EXISTS nepazon.unregister_product;

##########################################################################################
# Name: unregister_product
# Type: Stored PROCEDURE
# Desc: Unregister a product
##########################################################################################
delimiter //
CREATE PROCEDURE nepazon.unregister_product(IN product_id INT)

BEGIN
	DECLARE retrieved_product_id INT DEFAULT 0;

	SELECT product_id FROM nepazon.products WHERE nepazon.products.product_id = product_id INTO retrieved_product_id;

	# Check if the retrieved product id is valid or not
	IF(retrieved_product_id = 0) THEN # The retrieved product id is not valid
		RETURN FALSE;
	END IF;

	DELETE FROM nepazon.products WHERE nepazon.products.product_id = product_id; # Delete product with the specified product id

END //
delimiter
call nepazon.unregister_product(12);
DROP PROCEDURE IF EXISTS nepazon.modify_product;

##########################################################################################
# Name: modify_product
# Type: Stored PROCEDURE
# Desc: Modify a registered product
##########################################################################################
delimiter //
CREATE PROCEDURE nepazon.modify_product(IN product_id INT, IN product_name VARCHAR(45), IN product_description VARCHAR(45), IN product_price VARCHAR(45))

BEGIN

	DECLARE l_product_id INT DEFAULT 0;

	# Update the specified product
	SELECT nepazon.products.product_id FROM nepazon.products WHERE nepazon.products.product_id = product_id INTO l_product_id;

END // 
delimiter

DROP PROCEDURE IF EXISTS nepazon.log_user_activity;

##########################################################################################
# Name: log_user_activity
# Type: Stored PROCEDURE
# Desc: Log user activity
##########################################################################################
delimiter //
CREATE PROCEDURE nepazon.log_user_activity(IN username VARCHAR(45), IN date_time DATETIME, IN log_type VARCHAR(45), IN log_activity VARCHAR(500))

BEGIN

	# Save this log INTO the database
	INSERT INTO nepazon.user_log(log_username, log_datetime, log_type, log_activity) VALUES(username, date_time, log_type, log_activity);

END //
delimiter

#CALL `nepazon`.`register_user`(<{username VARCHAR(45)}>);