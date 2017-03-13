PWD=$(shell pwd)
ROLE_NAME=lnc-challenge
ROLE_PATH=/$(ROLE_NAME)
TEST_VERSION=ansible --version
INSTALL_REQUIREMENTS=ansible-galaxy install -r requirements.yml
TEST_SYNTAX=ansible-playbook -vv -i local $(ROLE_PATH)/{deploy-{app,nginx},{update,rollback}-app}.yml --syntax-check
TEST_PLAYBOOK=ansible-playbook -vv -i local $(ROLE_PATH)/deploy.yml # Since container needs, isn't working.
TEST_CMD=$(TEST_VERSION); cd $(ROLE_PATH); $(INSTALL_REQUIREMENTS); $(TEST_SYNTAX)

.PHONY: test
test:
	docker run -it --rm -e "ROLE_NAME=$(ROLE_NAME)" -v $(PWD):$(ROLE_PATH) williamyeh/ansible:ubuntu16.04 /bin/bash -c "$(TEST_CMD)"
