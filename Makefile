PWD=$(shell pwd)
ROLE_NAME=lnc-challenge
ROLE_PATH=/$(ROLE_NAME)
TEST_VERSION=ansible --version
INSTALL_REQUIREMENTS=ansible-galaxy install -r requirements.yml
TEST_SYNTAX=ansible-playbook -vv -i local $(ROLE_PATH)/{deploy-{app,nginx},{update,rollback}-app}.yml --syntax-check
TEST_PLAYBOOK=ansible-playbook -vv -i local $(ROLE_PATH)/deploy.yml
TEST_CMD=$(TEST_VERSION); cd $(ROLE_PATH); $(INSTALL_REQUIREMENTS); $(TEST_SYNTAX); $(TEST_PLAYBOOK)
CONTAINER_ID=$(mktemp)

.PHONY: test
test:
	docker run --detach -e "ROLE_NAME=$(ROLE_NAME)" --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v $(PWD):$(ROLE_PATH) geerlingguy/docker-ubuntu1604-ansible:latest "/lib/systemd/systemd > $(CONTAINER_ID)"
	docker exec --tty "$(cat $(CONTAINER_ID))" env TERM=xterm "$(TEST_CMD)"
