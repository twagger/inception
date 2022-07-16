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
DCOMPOSEDEV	= docker-compose.yml


# EXECUTABLES & LIBRARIES
################################################################################
NAME		= my_app

# DIRECTORIES
################################################################################
SRCS		= ./srcs

# FLAGS
################################################################################
FLAGENV		= --env-file
FLAGFILE	= -f
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
			docker image prune -af

fclean:		
			$(CD) $(SRCS) && $(DCOMPOSE) $(DOWN) $(REMOVEIMGS)
			docker system prune --all --force --volumes

re:			fclean all

.PHONY:		all clean fclean re