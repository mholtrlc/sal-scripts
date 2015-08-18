USE_PKGBUILD=1
include /usr/local/share/luggage/luggage.make
PACKAGE_VERSION=0.6.0b1
TITLE=sal_scripts
PACKAGE_NAME=${TITLE}-${PACKAGE_VERSION}
REVERSE_DOMAIN=com.github.salopensource
PAYLOAD=\
	pack-yaml \
	pack-sal-submit

pack-yaml: l_usr_local
	@sudo find . -name "*.pyc" -exec rm -rf {} \;
	@sudo mkdir -p ${WORK_D}/usr/local/sal/yaml
	@sudo ${CP} -R yaml ${WORK_D}/usr/local/sal
	@sudo chown -R root:wheel ${WORK_D}/usr/local/sal/yaml
	@sudo chmod -R 755 ${WORK_D}/usr/local/sal/yaml
	@sudo ${INSTALL} -m 755 -g wheel -o root "salgurl.py" ${WORK_D}/usr/local/sal
	@sudo ${INSTALL} -m 755 -g wheel -o root "utils.py" ${WORK_D}/usr/local/sal

l_munki: l_usr_local
	@sudo mkdir -p ${WORK_D}/usr/local/munki/postflight.d
	@sudo chown root:wheel ${WORK_D}/usr/local/munki/postflight.d
	@sudo mkdir -p ${WORK_D}/usr/local/munki/preflight.d
	@sudo chown root:wheel ${WORK_D}/usr/local/munki/preflight.d

pack-sal-submit: l_munki
	@sudo ${INSTALL} -m 755 -g wheel -o root "sal-postflight" ${WORK_D}/usr/local/munki/postflight.d
	@sudo ${INSTALL} -m 755 -g wheel -o root "sal-preflight" ${WORK_D}/usr/local/munki/preflight.d
