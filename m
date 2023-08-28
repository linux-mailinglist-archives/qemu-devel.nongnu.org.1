Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBD378ACA9
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 12:42:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaZen-0003Qy-BJ; Mon, 28 Aug 2023 06:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeX-0003OJ-9i
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeR-00057b-H1
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693219158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pz7ZyjjzpgXLctfdSRjcfpn/5nBsICJw714i/8sNLk=;
 b=RogySQW3xtD3mB86oW12wUh/bIWp+oU3j3cpKCljzo9KLurXlgSLRH8EqqRB1OkwujsCf0
 Ng0cdaVNCoPkuRjNX6bl/89LZGi3csjQR7xORus3Fjn4lJUf/Wh26CZfE391Tghax/D9mF
 fA8yGcYrkWpSeW2UwRcPVfLx7E7ikkM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-xrbU_eC1O6WUDXj0K6cjWw-1; Mon, 28 Aug 2023 06:39:16 -0400
X-MC-Unique: xrbU_eC1O6WUDXj0K6cjWw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3172a94b274so2248143f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 03:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693219155; x=1693823955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2pz7ZyjjzpgXLctfdSRjcfpn/5nBsICJw714i/8sNLk=;
 b=DH5ry4s0aEItkxKNnKBtxpCSRtT7ZTp6LqS2u82srDE31I61XQA5DZuHH6RpQHNwKv
 +rgzfJlBM8GvzRh4lgEIrgt7T5dlOcX83mA1oENVTx8kefjPswnee+U8bNi1zjr4MyOI
 bbdYqP2Em9XLtSkYYu27Hp67A5vvmVCxBLPowiLYkLinenn2y5hnyyW2rRcAyXVvbquX
 NNAieyXS0mdZEJSuuSEpin14lJbcO4gQsiU51B8AvVV4612Hn6s6lUWdGdu7aGi4j9Dj
 k2FcrM2i4nw07fIpd44eMCOKyKqt3bJ/cKSLFK/WdT3WuKAFnu6cDWQjGhqaJsbB+90Z
 1HDg==
X-Gm-Message-State: AOJu0Yz8oTkk/szpjfHNzpI+WiO5OzcIQ3CNtdMYUjA3izaXzOqeKlsV
 9F+CQja14LSc3ZYliWQXb2xM8NxJC2or3LAgfz8+q0pvHlqI3P4VZ2DcuHaWxzx40uJ/7QvmO++
 UWJPP/Oe0Edvj8GGU2oqugrLyH/iAFmxrWIh4hKhVpu9p07TIi6tRQ2S5TIJ0bLe4zljp1ARagi
 U=
X-Received: by 2002:adf:cd01:0:b0:314:4a15:e557 with SMTP id
 w1-20020adfcd01000000b003144a15e557mr17696384wrm.5.1693219155018; 
 Mon, 28 Aug 2023 03:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs2740CfG5SAg6dFe7S5FaB4fv1hSmk6RdSf9G44UWmFS9NONsGQffqInnGXeQGqGEo1gbHw==
X-Received: by 2002:adf:cd01:0:b0:314:4a15:e557 with SMTP id
 w1-20020adfcd01000000b003144a15e557mr17696371wrm.5.1693219154455; 
 Mon, 28 Aug 2023 03:39:14 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 y3-20020adfe6c3000000b0031c5ce91ad6sm10145828wrm.97.2023.08.28.03.39.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 03:39:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/14] Revert "tests: Use separate virtual environment for
 avocado"
Date: Mon, 28 Aug 2023 12:38:49 +0200
Message-ID: <20230828103856.46031-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828103856.46031-1-pbonzini@redhat.com>
References: <20230828103856.46031-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reverts commit e8e4298feadae7924cf7600bb3bcc5b0a8d7cbe9.

ensuregroup allows to specify both the acceptable versions of avocado,
and a locked version to be used when avocado is not installed as a system
pacakge.  This lets us install avocado in pyvenv/ using "mkvenv.py" and
reuse the distro package on Fedora and CentOS Stream (the only distros
where it's available).

ensuregroup's usage of "(>=..., <=...)" constraints when evaluating
the distro package, and "==" constraints when installing it from PyPI,
makes it possible to avoid conflicts between the known-good version and
a package plugins included in the distro.

This is because package plugins have "==" constraints on the version
that is included in the distro, and, using "pip install avocado==88.1"
on a venv that includes system packages will result in an error:

   avocado-framework-plugin-varianter-yaml-to-mux 98.0 requires avocado-framework==98.0, but you have avocado-framework 88.1 which is incompatible.
   avocado-framework-plugin-result-html 98.0 requires avocado-framework==98.0, but you have avocado-framework 88.1 which is incompatible.

But at the same time, if the venv does not include a system distribution
of avocado then we can install a known-good version and stick to LTS
releases.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1663
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml                    |  6 +++---
 docs/devel/acpi-bits.rst                      |  6 +++---
 docs/devel/testing.rst                        | 14 +++++++-------
 python/scripts/mkvenv.py                      | 13 +++++--------
 pythondeps.toml                               |  7 +++++++
 .../org.centos/stream/8/x86_64/test-avocado   |  4 ++--
 scripts/device-crash-test                     |  2 +-
 tests/Makefile.include                        | 19 ++++++++-----------
 tests/requirements.txt                        |  6 ------
 tests/vm/Makefile.include                     |  2 +-
 10 files changed, 37 insertions(+), 42 deletions(-)
 delete mode 100644 tests/requirements.txt

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 77dc83a6be0..aee91015077 100644
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
index 22e2580200c..9677b0098f4 100644
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
index b6ad21bed1c..5d1fc0aa95f 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -894,9 +894,9 @@ You can run the avocado tests simply by executing:
 
   make check-avocado
 
-This involves the automatic creation of Python virtual environment
-within the build tree (at ``tests/venv``) which will have all the
-right dependencies, and will save tests results also within the
+This involves the automatic installation, from PyPI, of all the
+necessary avocado-framework dependencies into the QEMU venv within the
+build tree (at ``./pyvenv``). Test results are also saved within the
 build tree (at ``tests/results``).
 
 Note: the build environment must be using a Python 3 stack, and have
@@ -953,7 +953,7 @@ may be invoked by running:
 
  .. code::
 
-  tests/venv/bin/avocado run $OPTION1 $OPTION2 tests/avocado/
+  pyvenv/bin/avocado run $OPTION1 $OPTION2 tests/avocado/
 
 Note that if ``make check-avocado`` was not executed before, it is
 possible to create the Python virtual environment with the dependencies
@@ -968,20 +968,20 @@ a test file. To run tests from a single file within the build tree, use:
 
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
diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 02bcd9a8c92..4f2349fbb65 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -964,14 +964,11 @@ def _parse_groups(file: str) -> Dict[str, Dict[str, Any]]:
             "Python >=3.11 does not have tomllib... what have you done!?"
         )
 
-    try:
-        # Use loads() to support both tomli v1.2.x (Ubuntu 22.04,
-        # Debian bullseye-backports) and v2.0.x
-        with open(file, "r", encoding="ascii") as depfile:
-            contents = depfile.read()
-            return tomllib.loads(contents)  # type: ignore
-    except tomllib.TOMLDecodeError as exc:
-        raise Ouch(f"parsing {file} failed: {exc}") from exc
+    # Use loads() to support both tomli v1.2.x (Ubuntu 22.04,
+    # Debian bullseye-backports) and v2.0.x
+    with open(file, "r", encoding="ascii") as depfile:
+        contents = depfile.read()
+        return tomllib.loads(contents)  # type: ignore
 
 
 def ensure_group(
diff --git a/pythondeps.toml b/pythondeps.toml
index 6be31dba301..0a35ebcf9f0 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -23,3 +23,10 @@ meson = { accepted = ">=0.63.0", installed = "0.63.3", canary = "meson" }
 [docs]
 sphinx = { accepted = ">=1.6", installed = "5.3.0", canary = "sphinx-build" }
 sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
+
+[avocado]
+# Note that qemu.git/python/ is always implicitly installed.
+# Prefer an LTS version when updating the accepted versions of
+# avocado-framework, for example right now the limit is 92.x.
+avocado-framework = { accepted = "(>=88.1, <93.0)", installed = "88.1", canary = "avocado" }
+pycdlib = { accepted = ">=1.11.0" }
diff --git a/scripts/ci/org.centos/stream/8/x86_64/test-avocado b/scripts/ci/org.centos/stream/8/x86_64/test-avocado
index e0443fc8ae8..73e7a1a3126 100755
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
index b74d887331d..353aa575d7b 100755
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
index 9422ddaece5..985cda7a945 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -89,10 +89,8 @@ distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
 # Build up our target list from the filtered list of ninja targets
 TARGETS=$(patsubst libqemu-%.fa, %, $(filter libqemu-%.fa, $(ninja-targets)))
 
-TESTS_VENV_DIR=$(BUILD_DIR)/tests/venv
-TESTS_VENV_REQ=$(SRC_PATH)/tests/requirements.txt
+TESTS_VENV_TOKEN=$(BUILD_DIR)/pyvenv/tests.group
 TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
-TESTS_PYTHON=$(TESTS_VENV_DIR)/bin/python3
 ifndef AVOCADO_TESTS
 	AVOCADO_TESTS=tests/avocado
 endif
@@ -108,20 +106,19 @@ else
 endif
 
 quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
-    $(TESTS_PYTHON) -m pip -q --disable-pip-version-check $1, \
+    $(PYTHON) -m pip -q --disable-pip-version-check $1, \
     "VENVPIP","$1")
 
-$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
-	$(call quiet-command, $(PYTHON) -m venv $@, VENV, $@)
+$(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
 	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
-	$(call quiet-venv-pip,install -r $(TESTS_VENV_REQ))
+	$(PYTHON) python/scripts/mkvenv.py ensuregroup --online $< avocado
 	$(call quiet-command, touch $@)
 
 $(TESTS_RESULTS_DIR):
 	$(call quiet-command, mkdir -p $@, \
             MKDIR, $@)
 
-check-venv: $(TESTS_VENV_DIR)
+check-venv: $(TESTS_VENV_TOKEN)
 
 FEDORA_31_ARCHES_TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGETS)))
 FEDORA_31_ARCHES_CANDIDATES=$(patsubst ppc64,ppc64le,$(FEDORA_31_ARCHES_TARGETS))
@@ -131,7 +128,7 @@ FEDORA_31_DOWNLOAD=$(filter $(FEDORA_31_ARCHES),$(FEDORA_31_ARCHES_CANDIDATES))
 # download one specific Fedora 31 image
 get-vm-image-fedora-31-%: check-venv
 	$(call quiet-command, \
-             $(TESTS_PYTHON) -m avocado vmimage get \
+             $(PYTHON) -m avocado vmimage get \
              --distro=fedora --distro-version=31 --arch=$*, \
 	"AVOCADO", "Downloading avocado tests VM image for $*")
 
@@ -140,7 +137,7 @@ get-vm-images: check-venv $(patsubst %,get-vm-image-fedora-31-%, $(FEDORA_31_DOW
 
 check-avocado: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 	$(call quiet-command, \
-            $(TESTS_PYTHON) -m avocado \
+            $(PYTHON) -m avocado \
             --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
             $(if $(AVOCADO_TAGS),, --filter-by-tags-include-empty \
 			--filter-by-tags-include-empty-key) \
@@ -163,7 +160,7 @@ check:
 check-build: run-ninja
 
 check-clean:
-	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
+	rm -rf $(TESTS_RESULTS_DIR)
 
 clean: check-clean clean-tcg
 distclean: distclean-tcg
diff --git a/tests/requirements.txt b/tests/requirements.txt
deleted file mode 100644
index 0ba561b6bdf..00000000000
--- a/tests/requirements.txt
+++ /dev/null
@@ -1,6 +0,0 @@
-# Add Python module requirements, one per line, to be installed
-# in the tests/venv Python virtual environment. For more info,
-# refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-# Note that qemu.git/python/ is always implicitly installed.
-avocado-framework==88.1
-pycdlib==1.11.0
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index c2a8ca1c175..f0f5d32fb0f 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -5,7 +5,7 @@ ifeq ($(realpath $(SRC_PATH)),$(realpath .))
 VM_PYTHON = PYTHONPATH=$(SRC_PATH)/python /usr/bin/env python3
 VM_VENV =
 else
-VM_PYTHON = $(TESTS_PYTHON)
+VM_PYTHON = $(PYTHON)
 VM_VENV = check-venv
 endif
 
-- 
2.41.0


