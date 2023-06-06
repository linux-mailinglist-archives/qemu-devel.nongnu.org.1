Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A4572462A
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:33:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xiq-0005HY-RX; Tue, 06 Jun 2023 10:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xim-0005AE-09
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xij-0001GI-6Q
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5elWgXnBAgSsq0WG5je9LQlvQACUGHo+A0AiWYgrn4=;
 b=XX08/u/vouBSvQAWLb2wstJBPXlrL0fj/wqPMQOfWBQz6CSM2UlFmpWkd7ICsK6aTKlA82
 QR+EHYVdsuKEk+9p72sNNW6TeYrsw08d6Z3ZEDVDWSpFoBNzmUw5KXEafTmfSExwckHTIS
 AURBaZQYuXeBww42WeiROcR+PuoUtac=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-nm9A853fMTCoCu0RQj_ksA-1; Tue, 06 Jun 2023 10:31:34 -0400
X-MC-Unique: nm9A853fMTCoCu0RQj_ksA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a355c9028so471402266b.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061893; x=1688653893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e5elWgXnBAgSsq0WG5je9LQlvQACUGHo+A0AiWYgrn4=;
 b=JWrDGDmpM9ZRg6GlZirbJzVr4v3CmkWHqzJtAtojAWKWKJ5CBl9pn+otZideiz/N1m
 FEfC7inmj7H3FjL9+TZvI9dRi5xNQDfZhqOL6HN5qRm5wzXYan/meSG4Z4iNZM/zJ4kd
 G0APiMR/lXSXnGt+CRCPO8Tdu/QWgyAEker8VRcBJDzUG5Yla9OhrNLnyVXk02813bZv
 rNd4SDveIkXiSGtkTwsGu8tY8Z2liJLBQBhmwf1YycSxeSrG1Tfr6R0EmjIXsRhE50lw
 PQtZsb97/2jKwafeT/MwP7mlDNuEdiNmyQdSzxsfoRQhpu1XnjUoGwDNAcGCb3zQlAJP
 xCCA==
X-Gm-Message-State: AC+VfDwZodWGTVHgClDLQMCA8sZEywClxk134IQ/cOYAgrQDnUFyXAWG
 EsoASykIXns7QbYBdXPk8H+T1XYxOtLB1MWD31Gabqhy4Wen50pq+7Bk1DMW+d1zTBy184WUms3
 aYN8I565pJV+JZnvxgM1rOgDzav1Ky/Tq1gV+TsLoDOxG7W/YAUlJD5DZxdAaSdMGjUG7T4GQKQ
 0=
X-Received: by 2002:a17:907:7282:b0:974:31:ed74 with SMTP id
 dt2-20020a170907728200b009740031ed74mr2496740ejc.65.1686061893075; 
 Tue, 06 Jun 2023 07:31:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4+/Ayd/q0ya1PcjrUXS7lMXJNu/AlLnw/bnsra/BZyFTdhmkfwaMM1+K4EDRLxzQPn14MztQ==
X-Received: by 2002:a17:907:7282:b0:974:31:ed74 with SMTP id
 dt2-20020a170907728200b009740031ed74mr2496721ejc.65.1686061892607; 
 Tue, 06 Jun 2023 07:31:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a170906118300b0096a6bf89259sm5665204eja.167.2023.06.06.07.31.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/21] tests: Use separate virtual environment for avocado
Date: Tue,  6 Jun 2023 16:31:05 +0200
Message-Id: <20230606143116.685644-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This reverts commits eea2d141179 ("Makefile: remove $(TESTS_PYTHON)",
2023-05-26) and 9c6692db550 ("tests: Use configure-provided pyvenv for
tests", 2023-05-18).

Right now, there is a conflict between wanting a ">=" constraint when
using a distro-provided package and wanting a "==" constraint when
installing Avocado from PyPI; this would provide the best of both worlds
in terms of resiliency for both distros that have required packages and
distros that don't.

The conflict is visible also for meson, where we would like to install
the latest 0.63.x version but also accept a distro 1.1.x version.
But it is worse for avocado, for two reasons:

1) we cannot use an "==" constraint to install avocado if the venv
includes a system avocado.  The distro will package plugins that have
"==" constraints on the version that is included in the distro, and, using
"pip install avocado==88.1" on a venv that includes system packages will
result in this error:

   ERROR: pip's dependency resolver does not currently take into account all the packages that are installed. This behaviour is the source of the following dependency conflicts.
   avocado-framework-plugin-varianter-yaml-to-mux 98.0 requires avocado-framework==98.0, but you have avocado-framework 88.1 which is incompatible.
   avocado-framework-plugin-result-html 98.0 requires avocado-framework==98.0, but you have avocado-framework 88.1 which is incompatible.
   make[1]: Leaving directory '/home/berrange/src/virt/qemu/build'

2) we cannot use ">=" either if the venv does _not_ include a system
avocado, because that would result in the installation of v101.0 which
is the one we've just reverted.

So the idea is to encode the dependencies as an (acceptable, locked)
tuple, like this hypothetical TOML that would be committed inside
python/ and used by mkvenv.py:

  [meson]
  meson = { minimum = "0.63.0", install = "0.63.3", canary = "meson" }

  [docs]
  # 6.0 drops support for Python 3.7
  sphinx = { minimum = "1.6", install = "<6.0", canary = "sphinx-build" }
  sphinx_rtd_theme = { minimum = "0.5" }

  [avocado]
  avocado-framework = { minimum = "88.1", install = "88.1", canary = "avocado" }

Once this is implemented, it would also be possible to install avocado in
pyvenv/ using "mkvenv.py ensure", thus using the distro package on Fedora
and CentOS Stream (the only distros where it's available).  But until
this is implemented, keep avocado in a separate venv.  There is still the
benefit of using a single python for meson custom_targets and for sphinx.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml                       |  6 +++---
 docs/devel/acpi-bits.rst                         |  6 +++---
 docs/devel/testing.rst                           | 14 +++++++-------
 .../ci/org.centos/stream/8/x86_64/test-avocado   |  4 ++--
 scripts/device-crash-test                        |  2 +-
 tests/Makefile.include                           | 16 +++++++++-------
 tests/requirements.txt                           |  7 ++-----
 tests/vm/Makefile.include                        |  2 +-
 8 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 0f1be14cb62..1922caf5363 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -103,7 +103,7 @@ crash-test-debian:
   script:
     - cd build
     - make NINJA=":" check-venv
-    - pyvenv/bin/python3 scripts/device-crash-test -q --tcg-only ./qemu-system-i386
+    - tests/venv/bin/python3 scripts/device-crash-test -q --tcg-only ./qemu-system-i386
 
 build-system-fedora:
   extends:
@@ -146,8 +146,8 @@ crash-test-fedora:
   script:
     - cd build
     - make NINJA=":" check-venv
-    - pyvenv/bin/python3 scripts/device-crash-test -q ./qemu-system-ppc
-    - pyvenv/bin/python3 scripts/device-crash-test -q ./qemu-system-riscv32
+    - tests/venv/bin/python3 scripts/device-crash-test -q ./qemu-system-ppc
+    - tests/venv/bin/python3 scripts/device-crash-test -q ./qemu-system-riscv32
 
 build-system-centos:
   extends:
diff --git a/docs/devel/acpi-bits.rst b/docs/devel/acpi-bits.rst
index 9677b0098f4..22e2580200c 100644
--- a/docs/devel/acpi-bits.rst
+++ b/docs/devel/acpi-bits.rst
@@ -61,19 +61,19 @@ Under ``tests/avocado/`` as the root we have:
    ::
 
      $ make check-venv (needed only the first time to create the venv)
-     $ ./pyvenv/bin/avocado run -t acpi tests/avocado
+     $ ./tests/venv/bin/avocado run -t acpi tests/avocado
 
    The above will run all acpi avocado tests including this one.
    In order to run the individual tests, perform the following:
    ::
 
-     $ ./pyvenv/bin/avocado run tests/avocado/acpi-bits.py --tap -
+     $ ./tests/venv/bin/avocado run tests/avocado/acpi-bits.py --tap -
 
    The above will produce output in tap format. You can omit "--tap -" in the
    end and it will produce output like the following:
    ::
 
-      $ ./pyvenv/bin/avocado run tests/avocado/acpi-bits.py
+      $ ./tests/venv/bin/avocado run tests/avocado/acpi-bits.py
       Fetching asset from tests/avocado/acpi-bits.py:AcpiBitsTest.test_acpi_smbios_bits
       JOB ID     : eab225724da7b64c012c65705dc2fa14ab1defef
       JOB LOG    : /home/anisinha/avocado/job-results/job-2022-10-10T17.58-eab2257/job.log
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 2cafec41782..203facb417b 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -888,9 +888,9 @@ You can run the avocado tests simply by executing:
 
   make check-avocado
 
-This involves the automatic installation, from PyPI, of all the
-necessary avocado-framework dependencies into the QEMU venv within the
-build tree (at ``./pyvenv``). Test results are also saved within the
+This involves the automatic creation of Python virtual environment
+within the build tree (at ``tests/venv``) which will have all the
+right dependencies, and will save tests results also within the
 build tree (at ``tests/results``).
 
 Note: the build environment must be using a Python 3 stack, and have
@@ -947,7 +947,7 @@ may be invoked by running:
 
  .. code::
 
-  pyvenv/bin/avocado run $OPTION1 $OPTION2 tests/avocado/
+  tests/venv/bin/avocado run $OPTION1 $OPTION2 tests/avocado/
 
 Note that if ``make check-avocado`` was not executed before, it is
 possible to create the Python virtual environment with the dependencies
@@ -962,20 +962,20 @@ a test file. To run tests from a single file within the build tree, use:
 
  .. code::
 
-  pyvenv/bin/avocado run tests/avocado/$TESTFILE
+  tests/venv/bin/avocado run tests/avocado/$TESTFILE
 
 To run a single test within a test file, use:
 
  .. code::
 
-  pyvenv/bin/avocado run tests/avocado/$TESTFILE:$TESTCLASS.$TESTNAME
+  tests/venv/bin/avocado run tests/avocado/$TESTFILE:$TESTCLASS.$TESTNAME
 
 Valid test names are visible in the output from any previous execution
 of Avocado or ``make check-avocado``, and can also be queried using:
 
  .. code::
 
-  pyvenv/bin/avocado list tests/avocado
+  tests/venv/bin/avocado list tests/avocado
 
 Manual Installation
 ~~~~~~~~~~~~~~~~~~~
diff --git a/scripts/ci/org.centos/stream/8/x86_64/test-avocado b/scripts/ci/org.centos/stream/8/x86_64/test-avocado
index 73e7a1a3126..e0443fc8ae8 100755
--- a/scripts/ci/org.centos/stream/8/x86_64/test-avocado
+++ b/scripts/ci/org.centos/stream/8/x86_64/test-avocado
@@ -4,7 +4,7 @@
 # KVM and x86_64, or tests that are generic enough to be valid for all
 # targets. Such a test list can be generated with:
 #
-# ./pyvenv/bin/avocado list --filter-by-tags-include-empty \
+# ./tests/venv/bin/avocado list --filter-by-tags-include-empty \
 #   --filter-by-tags-include-empty-key -t accel:kvm,arch:x86_64 \
 #   tests/avocado/
 #
@@ -22,7 +22,7 @@
 #   - tests/avocado/virtio_check_params.py:VirtioMaxSegSettingsCheck.test_machine_types
 #
 make get-vm-images
-./pyvenv/bin/avocado run \
+./tests/venv/bin/avocado run \
     --job-results-dir=tests/results/ \
     tests/avocado/boot_linux.py:BootLinuxX8664.test_pc_i440fx_kvm \
     tests/avocado/boot_linux.py:BootLinuxX8664.test_pc_q35_kvm \
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 353aa575d7b..b74d887331d 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -43,7 +43,7 @@ except ModuleNotFoundError as exc:
     print(f"Module '{exc.name}' not found.")
     print("  Try 'make check-venv' from your build directory,")
     print("  and then one way to run this script is like so:")
-    print(f'  > $builddir/pyvenv/bin/python3 "{path}"')
+    print(f'  > $builddir/tests/venv/bin/python3 "{path}"')
     sys.exit(1)
 
 logger = logging.getLogger('device-crash-test')
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8294a44816c..9422ddaece5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -89,9 +89,10 @@ distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
 # Build up our target list from the filtered list of ninja targets
 TARGETS=$(patsubst libqemu-%.fa, %, $(filter libqemu-%.fa, $(ninja-targets)))
 
-TESTS_VENV_TOKEN=$(BUILD_DIR)/pyvenv/tests.group
+TESTS_VENV_DIR=$(BUILD_DIR)/tests/venv
 TESTS_VENV_REQ=$(SRC_PATH)/tests/requirements.txt
 TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
+TESTS_PYTHON=$(TESTS_VENV_DIR)/bin/python3
 ifndef AVOCADO_TESTS
 	AVOCADO_TESTS=tests/avocado
 endif
@@ -107,10 +108,11 @@ else
 endif
 
 quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
-    $(PYTHON) -m pip -q --disable-pip-version-check $1, \
+    $(TESTS_PYTHON) -m pip -q --disable-pip-version-check $1, \
     "VENVPIP","$1")
 
-$(TESTS_VENV_TOKEN): $(TESTS_VENV_REQ)
+$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
+	$(call quiet-command, $(PYTHON) -m venv $@, VENV, $@)
 	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
 	$(call quiet-venv-pip,install -r $(TESTS_VENV_REQ))
 	$(call quiet-command, touch $@)
@@ -119,7 +121,7 @@ $(TESTS_RESULTS_DIR):
 	$(call quiet-command, mkdir -p $@, \
             MKDIR, $@)
 
-check-venv: $(TESTS_VENV_TOKEN)
+check-venv: $(TESTS_VENV_DIR)
 
 FEDORA_31_ARCHES_TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGETS)))
 FEDORA_31_ARCHES_CANDIDATES=$(patsubst ppc64,ppc64le,$(FEDORA_31_ARCHES_TARGETS))
@@ -129,7 +131,7 @@ FEDORA_31_DOWNLOAD=$(filter $(FEDORA_31_ARCHES),$(FEDORA_31_ARCHES_CANDIDATES))
 # download one specific Fedora 31 image
 get-vm-image-fedora-31-%: check-venv
 	$(call quiet-command, \
-             $(PYTHON) -m avocado vmimage get \
+             $(TESTS_PYTHON) -m avocado vmimage get \
              --distro=fedora --distro-version=31 --arch=$*, \
 	"AVOCADO", "Downloading avocado tests VM image for $*")
 
@@ -138,7 +140,7 @@ get-vm-images: check-venv $(patsubst %,get-vm-image-fedora-31-%, $(FEDORA_31_DOW
 
 check-avocado: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 	$(call quiet-command, \
-            $(PYTHON) -m avocado \
+            $(TESTS_PYTHON) -m avocado \
             --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
             $(if $(AVOCADO_TAGS),, --filter-by-tags-include-empty \
 			--filter-by-tags-include-empty-key) \
@@ -161,7 +163,7 @@ check:
 check-build: run-ninja
 
 check-clean:
-	rm -rf $(TESTS_RESULTS_DIR)
+	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
 
 clean: check-clean clean-tcg
 distclean: distclean-tcg
diff --git a/tests/requirements.txt b/tests/requirements.txt
index 07e713ef5ac..0ba561b6bdf 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,9 +1,6 @@
 # Add Python module requirements, one per line, to be installed
-# in the qemu build_dir/pyvenv Python virtual environment. For more info,
+# in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-#
-# Note that qemu.git/python/ is implicitly installed to this venv when
-# 'make check-venv' is run, and will persist until configure is run
-# again.
+# Note that qemu.git/python/ is always implicitly installed.
 avocado-framework==88.1
 pycdlib==1.11.0
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index f0f5d32fb0f..c2a8ca1c175 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -5,7 +5,7 @@ ifeq ($(realpath $(SRC_PATH)),$(realpath .))
 VM_PYTHON = PYTHONPATH=$(SRC_PATH)/python /usr/bin/env python3
 VM_VENV =
 else
-VM_PYTHON = $(PYTHON)
+VM_PYTHON = $(TESTS_PYTHON)
 VM_VENV = check-venv
 endif
 
-- 
2.40.1


