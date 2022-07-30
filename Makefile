# COMMANDS
################################################################################
RM              = rm -f
RMRF			= rm -rf
CD				= cd
MKDIR			= mkdir
DOCKER			= docker
DOCKERIMG		= docker image
DCOMPOSE		= docker compose
REPLACE			= sed -i
ECHO			= echo
TOUCH			= touch
CHMOD			= chmod

# SOURCES
################################################################################
ENVFILE			= .env
DCOMPOSEDEV		= docker-compose.yml
HOSTS			= /etc/hosts

# EXECUTABLES & LIBRARIES
################################################################################
NAME			= .done

# DIRECTORIES
################################################################################
SRCS			= ./srcs
DATABIND		= /home/twagner/data

# FLAGS
################################################################################
FLAGENV			= --env-file
FLAGFILE		= -f
UP				= up -d
DOWN			= down
REMOVEALL		= --rmi all --remove-orphans -v

# DNS
################################################################################
ADDRESS			= 34.173.196.190
LOCADDRESS		= 10.128.0.5 
HOST_UPDATED	= $(shell [ -e .host_updated ] && echo 1 || echo 0 )

# USER & GROUP
################################################################################
UID				= $(shell id -u ${USER})
GID				= $(shell id -g ${USER})

# RULES
################################################################################
$(NAME):		
				@touch $(NAME)

.PHONY:			all
all:			
				# Create bind folders only if they don't already exists
				sudo $(MKDIR) -p $(DATABIND)
				sudo $(MKDIR) -p $(DATABIND)/wordpress
				sudo $(MKDIR) -p $(DATABIND)/db
				# Update /etc/hosts file to map 127.0.0.1 with dns
ifeq ($(HOST_UPDATED), 0)
				sudo $(CHMOD) 777 $(HOSTS)
				sudo $(ECHO) "$(ADDRESS) twagner.42.fr" >> $(HOSTS)
				sudo $(TOUCH) .host_updated
endif
				# Update .env file
				sudo $(REPLACE) "s|.*USER_ID.*|USER_ID=$(UID)|g" \
					  $(SRCS)/$(ENVFILE)
				sudo $(REPLACE) "s|.*GROUP_ID.*|GROUP_ID=$(GID)|g" \
				      $(SRCS)/$(ENVFILE)
				# Build images and run containers
				$(CD) $(SRCS) && $(DCOMPOSE) $(FLAGENV) $(ENVFILE) $(UP)
				

.PHONY:			clean
clean:
				# Clean all : stops containers and remove images + volumes
				$(CD) $(SRCS) && $(DCOMPOSE) $(DOWN) $(REMOVEALL)
				$(RM) .done

.PHONY:			fclean
fclean:			clean
				# Clean all : stops containers, remove images, volumes, network
				$(DOCKER) system prune --all --force --volumes
				$(DOCKER) network prune --force
				$(DOCKER) volume prune --force
				$(DOCKER) image prune --force

.PHONY:			bindclean
bindclean:		
				# Remove binded folders and data in them
				sudo $(RMRF) $(DATABIND)

.PHONY:			re
re:				fclean all