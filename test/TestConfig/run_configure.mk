##############################################################################
#  Copyright (c) 2016, 2019 IBM Corp. and others
#
#  This program and the accompanying materials are made available under
#  the terms of the Eclipse Public License 2.0 which accompanies this
#  distribution and is available at https://www.eclipse.org/legal/epl-2.0/
#  or the Apache License, Version 2.0 which accompanies this distribution and
#  is available at https://www.apache.org/licenses/LICENSE-2.0.
#
#  This Source Code may also be made available under the following
#  Secondary Licenses when the conditions for such availability set
#  forth in the Eclipse Public License, v. 2.0 are satisfied: GNU
#  General Public License, version 2 with the GNU Classpath
#  Exception [1] and GNU General Public License, version 2 with the
#  OpenJDK Assembly Exception [2].
#
#  [1] https://www.gnu.org/software/classpath/license.html
#  [2] http://openjdk.java.net/legal/assembly-exception.html
#
#  SPDX-License-Identifier: EPL-2.0 OR Apache-2.0 OR GPL-2.0 WITH Classpath-exception-2.0 OR LicenseRef-GPL-2.0 WITH Assembly-exception
##############################################################################

#
# If AUTO_DETECT is turned on, compile and execute envDetector in build_envInfo.xml.
# Otherwise, call makeGen.mk
#

.PHONY: testconfig

ifndef TEST_JDK_HOME
$(error Please provide TEST_JDK_HOME value.)
else
export TEST_JDK_HOME:=$(subst \,/,$(TEST_JDK_HOME))
endif

testconfig:
	ant -f ./TKGJ/build_tools.xml -DTEST_JDK_HOME=$(TEST_JDK_HOME)
ifneq ($(AUTO_DETECT), false)
	@echo "AUTO_DETECT is set to true"
	${TEST_JDK_HOME}/bin/java -cp ./TKGJ/TestKitGen.jar org.openj9.envInfo.EnvDetector JavaInfo
else
	@echo "AUTO_DETECT is set to false"
endif
	$(MAKE) -f makeGen.mk AUTO_DETECT=$(AUTO_DETECT)