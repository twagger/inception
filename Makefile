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
DCOMPOSEDEV	= docker-compose.dev.yml


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

dev:		
			$(CD) $(SRCS) && $(DCOMPOSE) \
							 $(FLAGENV) $(ENVFILE) \
							 $(FLAGFILE) $(DCOMPOSEDEV) \
							 $(UP)

clean:
			$(CD) $(SRCS) && $(DCOMPOSE) $(DOWN)

fclean:		
			$(CD) $(SRCS) && $(DCOMPOSE) $(DOWN) $(REMOVEIMGS)
			docker image prune -af

re:			clean all

re-dev:		fclean dev 

.PHONY:		all clean fclean re