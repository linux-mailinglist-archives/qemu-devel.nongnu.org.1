Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7738F707047
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLF4-00023b-0H; Wed, 17 May 2023 13:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLER-000054-Fi
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEN-0004Ku-Nx
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qoLXEPjxyhKVbWnopTIL/PIeJORoRYWKQVvdTCXP6xU=;
 b=WI1vwqAGgRtsION+iB6ovcDIDxt8zIEpiR5uUw/heGzcyZmzu6v9xHFg/5zv0HFi+mUgWP
 7uCFD870W0opavOUKjzGN2Mvzex0EIUaJDM/Q4ZHfnIIJhitfiEPPuv+cbZCSYh1Pmyyf8
 0D/p50ce3+DUrRbLrmX/NPLDRJdmo1Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-T6w6aIZ8PdCOOwaRjbdKVg-1; Wed, 17 May 2023 13:46:27 -0400
X-MC-Unique: T6w6aIZ8PdCOOwaRjbdKVg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f42ceb4a4fso4346535e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345584; x=1686937584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qoLXEPjxyhKVbWnopTIL/PIeJORoRYWKQVvdTCXP6xU=;
 b=VIY4lWc+eCaZ512AxURYqzqf//0/bkaZq/qiRjeSZxNTwgmdEV0/h7qCUM7pGWIPZz
 3cIsOH9SKhBeXo7nO2Xof7vSFgINDog2Pl2gs7W5NF5ubVvOYaZ1+R6EvJGWQ9nEiX1w
 z7DuJQ66YpSENOT1nDZ0I1fQfeunpN/LkmFNu4UTyNht+jVbkdceTsP/u5Al0Yd8jdZu
 MxIQG0Bt8itRJfATUGo2d6QQuu4skVYvI3PsCWJhWb/+UfrGjR/aV0yPy4Wt72UZNCWH
 v7s5dPchVd3BX/0zw6ObORaeRgYo/XDUC6JsuMS+XuNmrBGpY/8uMGWW4yI+KcykMDTG
 q1jA==
X-Gm-Message-State: AC+VfDzcdKUKbX0Vn8kB9mTN0TCMZBA8pSjx3HDopu6VndRgJ8H7PY4m
 7gO3L+YADK9ps6sCQMQ77flrvPBx2+QAHFnkuK4+qZXFLGxLf5AcvsC/m0zO3U87awSkwXzDVVs
 JCJrUj3e5roD4CzmHY5fo1ZlFbipmIxyRJjQZPTc2oXnaewq0KLs7ftCxpf4eQkRp5HAiNR8p+L
 Q=
X-Received: by 2002:a05:600c:3655:b0:3f4:2cc7:aac5 with SMTP id
 y21-20020a05600c365500b003f42cc7aac5mr19615494wmq.9.1684345584341; 
 Wed, 17 May 2023 10:46:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4iNmIB+acFtq2E/j15sjhuM5D1BNxlnGKp82JvzYPikiCMMy0uHomAiVYusvJO16hYOm5SwA==
X-Received: by 2002:a05:600c:3655:b0:3f4:2cc7:aac5 with SMTP id
 y21-20020a05600c365500b003f42cc7aac5mr19615484wmq.9.1684345583912; 
 Wed, 17 May 2023 10:46:23 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 k20-20020a7bc414000000b003f18b942338sm2892765wmi.3.2023.05.17.10.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 37/68] tests: Use configure-provided pyvenv for tests
Date: Wed, 17 May 2023 19:44:49 +0200
Message-Id: <20230517174520.887405-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: John Snow <jsnow@redhat.com>

This patch changes how the avocado tests are provided, ever so
slightly. Instead of creating a new testing venv, use the
configure-provided 'pyvenv' instead, and install optional packages into
that.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-20-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml                         |  6 +++---
 docs/devel/acpi-bits.rst                           |  6 +++---
 docs/devel/testing.rst                             | 14 +++++++-------
 scripts/ci/org.centos/stream/8/x86_64/test-avocado |  4 ++--
 scripts/device-crash-test                          |  2 +-
 tests/Makefile.include                             | 10 +++++-----
 tests/requirements.txt                             |  7 +++++--
 7 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index bb3650a51c09..307cba1aab6d 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -103,7 +103,7 @@ crash-test-debian:
   script:
     - cd build
     - make NINJA=":" check-venv
-    - tests/venv/bin/python3 scripts/device-crash-test -q --tcg-only ./qemu-system-i386
+    - pyvenv/bin/python3 scripts/device-crash-test -q --tcg-only ./qemu-system-i386
 
 build-system-fedora:
   extends:
@@ -146,8 +146,8 @@ crash-test-fedora:
   script:
     - cd build
     - make NINJA=":" check-venv
-    - tests/venv/bin/python3 scripts/device-crash-test -q ./qemu-system-ppc
-    - tests/venv/bin/python3 scripts/device-crash-test -q ./qemu-system-riscv32
+    - pyvenv/bin/python3 scripts/device-crash-test -q ./qemu-system-ppc
+    - pyvenv/bin/python3 scripts/device-crash-test -q ./qemu-system-riscv32
 
 build-system-centos:
   extends:
diff --git a/docs/devel/acpi-bits.rst b/docs/devel/acpi-bits.rst
index 22e2580200cd..9677b0098f4b 100644
--- a/docs/devel/acpi-bits.rst
+++ b/docs/devel/acpi-bits.rst
@@ -61,19 +61,19 @@ Under ``tests/avocado/`` as the root we have:
    ::
 
      $ make check-venv (needed only the first time to create the venv)
-     $ ./tests/venv/bin/avocado run -t acpi tests/avocado
+     $ ./pyvenv/bin/avocado run -t acpi tests/avocado
 
    The above will run all acpi avocado tests including this one.
    In order to run the individual tests, perform the following:
    ::
 
-     $ ./tests/venv/bin/avocado run tests/avocado/acpi-bits.py --tap -
+     $ ./pyvenv/bin/avocado run tests/avocado/acpi-bits.py --tap -
 
    The above will produce output in tap format. You can omit "--tap -" in the
    end and it will produce output like the following:
    ::
 
-      $ ./tests/venv/bin/avocado run tests/avocado/acpi-bits.py
+      $ ./pyvenv/bin/avocado run tests/avocado/acpi-bits.py
       Fetching asset from tests/avocado/acpi-bits.py:AcpiBitsTest.test_acpi_smbios_bits
       JOB ID     : eab225724da7b64c012c65705dc2fa14ab1defef
       JOB LOG    : /home/anisinha/avocado/job-results/job-2022-10-10T17.58-eab2257/job.log
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 4071e727107a..50664d9eb9d5 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -882,9 +882,9 @@ You can run the avocado tests simply by executing:
 
   make check-avocado
 
-This involves the automatic creation of Python virtual environment
-within the build tree (at ``tests/venv``) which will have all the
-right dependencies, and will save tests results also within the
+This involves the automatic installation, from PyPI, of all the
+necessary avocado-framework dependencies into the QEMU venv within the
+build tree (at ``./pyvenv``). Test results are also saved within the
 build tree (at ``tests/results``).
 
 Note: the build environment must be using a Python 3 stack, and have
@@ -941,7 +941,7 @@ may be invoked by running:
 
  .. code::
 
-  tests/venv/bin/avocado run $OPTION1 $OPTION2 tests/avocado/
+  pyvenv/bin/avocado run $OPTION1 $OPTION2 tests/avocado/
 
 Note that if ``make check-avocado`` was not executed before, it is
 possible to create the Python virtual environment with the dependencies
@@ -956,20 +956,20 @@ a test file. To run tests from a single file within the build tree, use:
 
  .. code::
 
-  tests/venv/bin/avocado run tests/avocado/$TESTFILE
+  pyvenv/bin/avocado run tests/avocado/$TESTFILE
 
 To run a single test within a test file, use:
 
  .. code::
 
-  tests/venv/bin/avocado run tests/avocado/$TESTFILE:$TESTCLASS.$TESTNAME
+  pyvenv/bin/avocado run tests/avocado/$TESTFILE:$TESTCLASS.$TESTNAME
 
 Valid test names are visible in the output from any previous execution
 of Avocado or ``make check-avocado``, and can also be queried using:
 
  .. code::
 
-  tests/venv/bin/avocado list tests/avocado
+  pyvenv/bin/avocado list tests/avocado
 
 Manual Installation
 ~~~~~~~~~~~~~~~~~~~
diff --git a/scripts/ci/org.centos/stream/8/x86_64/test-avocado b/scripts/ci/org.centos/stream/8/x86_64/test-avocado
index d2c0e5fb4cc8..7bb5b317b64d 100755
--- a/scripts/ci/org.centos/stream/8/x86_64/test-avocado
+++ b/scripts/ci/org.centos/stream/8/x86_64/test-avocado
@@ -4,7 +4,7 @@
 # KVM and x86_64, or tests that are generic enough to be valid for all
 # targets. Such a test list can be generated with:
 #
-# ./tests/venv/bin/avocado list --filter-by-tags-include-empty \
+# ./pyvenv/bin/avocado list --filter-by-tags-include-empty \
 #   --filter-by-tags-include-empty-key -t accel:kvm,arch:x86_64 \
 #   tests/avocado/
 #
@@ -22,7 +22,7 @@
 #   - tests/avocado/virtio_check_params.py:VirtioMaxSegSettingsCheck.test_machine_types
 #
 make get-vm-images
-./tests/venv/bin/avocado run \
+./pyvenv/bin/avocado run \
     --job-results-dir=tests/results/ \
     tests/avocado/boot_linux.py:BootLinuxX8664.test_pc_i440fx_kvm \
     tests/avocado/boot_linux.py:BootLinuxX8664.test_pc_q35_kvm \
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index b74d887331db..353aa575d7b7 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -43,7 +43,7 @@ except ModuleNotFoundError as exc:
     print(f"Module '{exc.name}' not found.")
     print("  Try 'make check-venv' from your build directory,")
     print("  and then one way to run this script is like so:")
-    print(f'  > $builddir/tests/venv/bin/python3 "{path}"')
+    print(f'  > $builddir/pyvenv/bin/python3 "{path}"')
     sys.exit(1)
 
 logger = logging.getLogger('device-crash-test')
diff --git a/tests/Makefile.include b/tests/Makefile.include
index a4de0ad5a252..5b838ec438b0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -89,7 +89,8 @@ distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
 # Build up our target list from the filtered list of ninja targets
 TARGETS=$(patsubst libqemu-%.fa, %, $(filter libqemu-%.fa, $(ninja-targets)))
 
-TESTS_VENV_DIR=$(BUILD_DIR)/tests/venv
+TESTS_VENV_DIR=$(BUILD_DIR)/pyvenv
+TESTS_VENV_TOKEN=$(BUILD_DIR)/pyvenv/tests.group
 TESTS_VENV_REQ=$(SRC_PATH)/tests/requirements.txt
 TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
 TESTS_PYTHON=$(TESTS_VENV_DIR)/bin/python3
@@ -111,8 +112,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
     $(TESTS_PYTHON) -m pip -q --disable-pip-version-check $1, \
     "VENVPIP","$1")
 
-$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
-	$(call quiet-command, $(PYTHON) -m venv $@, VENV, $@)
+$(TESTS_VENV_TOKEN): $(TESTS_VENV_REQ)
 	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
 	$(call quiet-venv-pip,install -r $(TESTS_VENV_REQ))
 	$(call quiet-command, touch $@)
@@ -121,7 +121,7 @@ $(TESTS_RESULTS_DIR):
 	$(call quiet-command, mkdir -p $@, \
             MKDIR, $@)
 
-check-venv: $(TESTS_VENV_DIR)
+check-venv: $(TESTS_VENV_TOKEN)
 
 FEDORA_31_ARCHES_TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGETS)))
 FEDORA_31_ARCHES_CANDIDATES=$(patsubst ppc64,ppc64le,$(FEDORA_31_ARCHES_TARGETS))
@@ -167,7 +167,7 @@ check:
 check-build: run-ninja
 
 check-clean:
-	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
+	rm -rf $(TESTS_RESULTS_DIR)
 
 clean: check-clean clean-tcg
 distclean: distclean-tcg
diff --git a/tests/requirements.txt b/tests/requirements.txt
index a6f73da6811a..0e008b9aec35 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,6 +1,9 @@
 # Add Python module requirements, one per line, to be installed
-# in the tests/venv Python virtual environment. For more info,
+# in the qemu build_dir/pyvenv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-# Note that qemu.git/python/ is always implicitly installed.
+#
+# Note that qemu.git/python/ is implicitly installed to this venv when
+# 'make check-venv' is run, and will persist until configure is run
+# again.
 avocado-framework==101.0
 pycdlib==1.11.0
-- 
2.40.1


