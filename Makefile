# COMMANDS
################################################################################
RM			= rm -f
RMRF		= rm -rf
CD			= cd
MKDIR		= mkdir
DOCKER		= docker
DOCKERIMG	= docker image
DCOMPOSE	= docker compose
REPLACE		= sed -i

# SOURCES
################################################################################
ENVFILE		= .env
DCOMPOSEDEV	= docker-compose.yml
HOSTS		= /etc/hosts


# EXECUTABLES & LIBRARIES
################################################################################
NAME		= my_app

# DIRECTORIES
################################################################################
SRCS		= ./srcs
DATABIND	= /home/twagner/data

# FLAGS
################################################################################
FLAGENV		= --env-file
FLAGFILE	= -f
UP			= up -d
DOWN		= down
REMOVEIMGS	= --rmi all --remove-orphans

# DNS
################################################################################
ADDRESS		= ec2-3-91-204-43.compute-1.amazonaws.com 

# RULES
################################################################################
$(NAME):	
			sudo $(MKDIR) $(DATABIND)
			sudo $(MKDIR) $(DATABIND)/wordpress
			sudo $(MKDIR) $(DATABIND)/db
			sudo $(REPLACE) "s|.*127.0.0.1.*|$(ADDRESS) twagner.42.fr|" $(HOSTS)
			$(CD) $(SRCS) && $(DCOMPOSE) $(FLAGENV) $(ENVFILE) $(UP)

all:		$(NAME)

clean:
			$(CD) $(SRCS) && $(DCOMPOSE) $(DOWN) $(REMOVEIMGS)

fclean:		clean	
			$(DOCKER) system prune --all --force --volumes
			$(DOCKER) network prune --force
			$(DOCKER) volume prune --force
			$(DOCKER) image prune --force
			sudo $(RMRF) $(DATABIND)

re:			fclean all

.PHONY:		all clean fclean re