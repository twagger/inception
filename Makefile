# COLORS
################################################################################
ifneq (,$(findstring xterm,${TERM}))
	RED          := $(shell tput -Txterm setaf 1)
	GREEN        := $(shell tput -Txterm setaf 2)
	YELLOW       := $(shell tput -Txterm setaf 3)
	BLUE         := $(shell tput -Txterm setaf 6)
	RESET		 := $(shell tput -Txterm sgr0)
else
	RED          := ""
	GREEN        := ""
	YELLOW       := ""
	BLUE         := ""
	RESET        := ""
endif

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
NAME			= my_app

# DIRECTORIES
################################################################################
SRCS			= ./srcs
DATABIND		= /home/twagner/data
BINDDIR_EXISTS	= $(shell [ -d .$(DATABIND) ] && echo 1 || echo 0 )

# FLAGS
################################################################################
FLAGENV			= --env-file
FLAGFILE		= -f
UP				= up -d
DOWN			= down
REMOVEIMGS		= --rmi all --remove-orphans

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
ifeq ($(HOST_UPDATED), 0)
				@printf "$(BLUE)Updating : $(RESET) $(YELLOW)[Hosts]$(RESET)" 
				@sudo $(CHMOD) 777 $(HOSTS)
				@sudo $(ECHO) "$(ADDRESS) twagner.42.fr" >> $(HOSTS)
				@sudo $(TOUCH) .host_updated
				@echo " : $(GREEN)OK !$(RESET)"
endif
ifeq ($(BINDDIR_EXISTS), 0)
				@printf "$(BLUE)Creating : $(RESET) $(YELLOW)[Bind dir]$(RESET)" 
				@sudo $(MKDIR) $(DATABIND)
				@sudo $(MKDIR) $(DATABIND)/wordpress
				@sudo $(MKDIR) $(DATABIND)/db
				@echo " : $(GREEN)OK !$(RESET)"
endif
				@printf "$(BLUE)Updating : $(RESET) $(YELLOW)[UID/GID]$(RESET)" 
				@sudo $(REPLACE) "s|.*USER_ID.*|USER_ID=$(UID)|g" \
					  $(SRCS)/$(ENVFILE)
				@sudo $(REPLACE) "s|.*GROUP_ID.*|GROUP_ID=$(GID)|g" \
				      $(SRCS)/$(ENVFILE)
				@echo "  : $(GREEN)OK !$(RESET)"

				@echo "$(BLUE)Starting : $(RESET) $(YELLOW)[Containers]$(RESET)" 
				$(CD) $(SRCS) && $(DCOMPOSE) $(FLAGENV) $(ENVFILE) $(UP)

all:			$(NAME)

clean:
				@echo "$(BLUE)Stopping : $(RESET) $(YELLOW)[Containers]$(RESET)" 
				$(CD) $(SRCS) && $(DCOMPOSE) $(DOWN) $(REMOVEIMGS)

fclean:			clean
				$(DOCKER) system prune --all --force --volumes
				$(DOCKER) network prune --force
				$(DOCKER) volume prune --force
				$(DOCKER) image prune --force
				@printf "$(BLUE)Removing : $(RESET) $(YELLOW)[Bind dir]$(RESET)" 
				@sudo $(RMRF) $(DATABIND)
				@echo " : $(GREEN)OK !$(RESET)"

re:				fclean all

.PHONY:			all clean fclean re