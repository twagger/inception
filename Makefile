# COMMANDS
################################################################################
RM              := rm -f
RMRF			:= rm -rf
CD				:= cd
MKDIR			:= mkdir
DOCKER			:= docker
DOCKERIMG		:= docker image
DCOMPOSE		:= docker compose
REPLACE			:= sed -i
ECHO			:= echo
TOUCH			:= touch
CHMOD			:= chmod
AWK				:= awk
CAT				:= cat

# SOURCES
################################################################################
ENVFILE			:= .env
HOSTS			:= /etc/hosts
DCOMPOSEFILE	= docker-compose.yml

# EXECUTABLES & LIBRARIES
################################################################################
NAME			:= .done

# DIRECTORIES
################################################################################
SRCS			:= ./srcs
DATABIND		:= /home/twagner/data

# FLAGS
################################################################################
FLAGENV			:= --env-file
FLAGFILE		:= -f
UP				:= up -d
DOWN			:= down
REMOVEALL		:= --rmi all --remove-orphans -v

# DNS
################################################################################
ADDRESS			:= 127.0.0.1
DOMAINNAME		:= twagner.42.fr
HOST_UPDATED	= $(shell [ -e .host_updated ] && echo 1 || echo 0 )

# USER & GROUP
################################################################################
UID				:= $(shell id -u ${USER})
GID				:= $(shell id -g ${USER})

# RULES
################################################################################
$(NAME):		
				@touch $(NAME)

.PHONY:			all
all:			
				# Create bind folders only if they don't already exists
				$(MKDIR) -p $(DATABIND)
				$(MKDIR) -p $(DATABIND)/wordpress
				$(MKDIR) -p $(DATABIND)/db
				# Update /etc/hosts file to map 127.0.0.1 with dns
ifeq ($(HOST_UPDATED), 0)
				sudo $(CHMOD) 646 $(HOSTS)
				$(ECHO) "$(ADDRESS) $(DOMAINNAME)" >> $(HOSTS)
				$(TOUCH) .host_updated
endif
				# Update .env file
				$(REPLACE) "s|.*USER_ID.*|USER_ID=$(UID)|g" $(SRCS)/$(ENVFILE)
				$(REPLACE) "s|.*GROUP_ID.*|GROUP_ID=$(GID)|g" $(SRCS)/$(ENVFILE)
				# Build images and run containers
				$(CD) $(SRCS) && $(DCOMPOSE) -f $(DCOMPOSEFILE) $(FLAGENV) $(ENVFILE) $(UP)	

.PHONY:			clean
clean:
				# Clean all : stops containers and remove images + volumes
				$(CD) $(SRCS) && $(DCOMPOSE) $(DOWN) $(REMOVEALL)
				$(RM) .done

.PHONY:			fclean
fclean:			clean cleanbinds
				# Clean all : stops containers, remove images, volumes, network
				$(DOCKER) system prune --all --force --volumes
				$(DOCKER) network prune --force
				$(DOCKER) volume prune --force
				$(DOCKER) image prune --force

.PHONY:			cleanbinds
cleanbinds:		
				# Remove binded folders and data in them
				$(RMRF) $(DATABIND)

.PHONY:			cleanhosts
cleanhosts:		
				# Remove the additionnal line from /etc/hosts and restore rights
				sudo $(CHMOD) 646 $(HOSTS)
				$(AWK) '!/$(DOMAINNAME)/' $(HOSTS) > .tmp \
					&& $(CAT) .tmp > $(HOSTS) \
					&& $(RM) .tmp
				sudo $(CHMOD) 644 $(HOSTS)
				$(RM) .host_updated

.PHONY:			bonus
bonus:			DCOMPOSEFILE = docker-compose.bonus.yml
bonus:			all

.PHONY:			re
re:				fclean all