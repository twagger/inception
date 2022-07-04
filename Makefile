# COMMANDS
################################################################################
RM			= rm -f
RMRF		= rm -rf
CD			= cd
MKDIR		= mkdir
DOCKERIMG	= docker image
DCOMPOSE	= docker compose

# SOURCES
################################################################################
ENVFILE		= .env


# EXECUTABLES & LIBRARIES
################################################################################
NAME		= my_app

# DIRECTORIES
################################################################################
SRCS		= ./srcs

# FLAGS
################################################################################
FLAGENV		= --env-file
UP			= up -d
DOWN		= down
REMOVEIMGS	= --rmi all

# RULES
################################################################################
$(NAME):	
			$(CD) $(SRCS) && $(DCOMPOSE) $(FLAGENV) $(ENVFILE) $(UP)

all:		$(NAME)

clean:
			$(CD) $(SRCS) && $(DCOMPOSE) $(DOWN)

fclean:		
			$(CD) $(SRCS) && $(DCOMPOSE) $(DOWN) $(REMOVEIMGS)

re:			clean all

.PHONY:		all clean fclean re