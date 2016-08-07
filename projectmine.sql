##########################################################################################
# Name: 
# Desc: 
##########################################################################################
delimiter //
CREATE PROCEDURE project.register_user(IN username VARCHAR(45), IN password VARCHAR(45))

BEGIN

	# Local variables
	DECLARE user_name_exist BOOl DEFAULT FALSE; # Will hold a boolean value indicating if the specified username exists

	DECLARE retrieved_username VARCHAR(45); # Will hold 

	SELECT username FROM project.account WHERE username = project.account.username INTO retrieved_username;

	IF (retrieved_username IS NOT NULL) THEN
		RETURN FALSE;

	END IF;
END //
delimiter

delimiter //
CREATE PROCEDURE project.register_project(IN project_name VARCHAR(45))

BEGIN

	# Local variable
	DECLARE existing_project_name VARCHAR(45);  # Will hold the name of the project in the database if the specified project already exists

	SELECT project_name FROM project.project WHERE project.project.project_name = project_name INTO existing_project_name;

END //
delimiter