Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A8CAA5438
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Apr 2025 20:52:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACWI-0003em-Vd; Wed, 30 Apr 2025 14:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACWH-0003e9-0V
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACWE-0008Kc-VU
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746039054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldv+ZvSnaqon49LS8vP/zxr1bNQw7hvkTQu1b24RYhw=;
 b=Hr0agMS8ilmhHeLWPlJXcfVwnZbsl3AuxspurvKrVBSYPEGI6O1U1DJacu5NO8kbv2UcbA
 zmdDsTvYsswqNKv7HYSjnx2IadrCzAiBSe0igH4E/swEIL4+NLJcy+TidxHAVsEFav/xep
 fK6e+lSOcgte5nC+xBhR9AFtkVK79jc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-nhYv9ujuOfG_vHLpmMtVAA-1; Wed,
 30 Apr 2025 14:50:52 -0400
X-MC-Unique: nhYv9ujuOfG_vHLpmMtVAA-1
X-Mimecast-MFC-AGG-ID: nhYv9ujuOfG_vHLpmMtVAA_1746039051
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C36BE1800984; Wed, 30 Apr 2025 18:50:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C334919560A3; Wed, 30 Apr 2025 18:50:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 5/9] Drop support for Python 3.8
Date: Wed, 30 Apr 2025 20:50:31 +0200
Message-ID: <20250430185035.724919-6-thuth@redhat.com>
In-Reply-To: <20250430185035.724919-1-thuth@redhat.com>
References: <20250430185035.724919-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Python 3.8 went "end of life" in October 2024 and Fedora 42 dropped
this version already, so the "python" CI job is currently failing.
Thus it's time to drop support for this Python version in QEMU, too.

While we're at it, also look for "python3.13" in the configure script.

Message-ID: <20250425120710.879518-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/build-platforms.rst         |  2 +-
 configure                              | 14 +++++++-------
 python/Makefile                        |  8 ++++----
 python/setup.cfg                       |  7 +++----
 python/tests/minreqs.txt               |  2 +-
 scripts/qapi/mypy.ini                  |  2 +-
 tests/docker/dockerfiles/python.docker |  1 -
 7 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 52521552c8a..c3651871d20 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -101,7 +101,7 @@ Python runtime
   option of the ``configure`` script to point QEMU to a supported
   version of the Python runtime.
 
-  As of QEMU |version|, the minimum supported version of Python is 3.8.
+  As of QEMU |version|, the minimum supported version of Python is 3.9.
 
 Python build dependencies
   Some of QEMU's build dependencies are written in Python.  Usually these
diff --git a/configure b/configure
index 000309cf610..40705afdf57 100755
--- a/configure
+++ b/configure
@@ -540,17 +540,17 @@ if test -n "$linux_arch" && ! test -d "$source_path/linux-headers/asm-$linux_arc
 fi
 
 check_py_version() {
-    # We require python >= 3.8.
+    # We require python >= 3.9.
     # NB: a True python conditional creates a non-zero return code (Failure)
-    "$1" -c 'import sys; sys.exit(sys.version_info < (3,8))'
+    "$1" -c 'import sys; sys.exit(sys.version_info < (3,9))'
 }
 
 first_python=
 if test -z "${PYTHON}"; then
     # A bare 'python' is traditionally python 2.x, but some distros
     # have it as python 3.x, so check in both places.
-    for binary in python3 python python3.12 python3.11 \
-                          python3.10 python3.9 python3.8; do
+    for binary in python3 python python3.13 python3.12 python3.11 \
+                          python3.10 python3.9 ; do
         if has "$binary"; then
             python=$(command -v "$binary")
             if check_py_version "$python"; then
@@ -933,7 +933,7 @@ then
     # If first_python is set, there was a binary somewhere even though
     # it was not suitable.  Use it for the error message.
     if test -n "$first_python"; then
-        error_exit "Cannot use '$first_python', Python >= 3.8 is required." \
+        error_exit "Cannot use '$first_python', Python >= 3.9 is required." \
             "Use --python=/path/to/python to specify a supported Python."
     else
         error_exit "Python not found. Use --python=/path/to/python"
@@ -941,11 +941,11 @@ then
 fi
 
 if ! check_py_version "$python"; then
-  error_exit "Cannot use '$python', Python >= 3.8 is required." \
+  error_exit "Cannot use '$python', Python >= 3.9 is required." \
              "Use --python=/path/to/python to specify a supported Python." \
              "Maybe try:" \
              "  openSUSE Leap 15.3+: zypper install python39" \
-             "  CentOS 8: dnf install python38"
+             "  CentOS: dnf install python3.12"
 fi
 
 # Resolve PATH
diff --git a/python/Makefile b/python/Makefile
index 1fa4ba2498e..764b79ccb23 100644
--- a/python/Makefile
+++ b/python/Makefile
@@ -9,13 +9,13 @@ help:
 	@echo "make check-minreqs:"
 	@echo "    Run tests in the minreqs virtual environment."
 	@echo "    These tests use the oldest dependencies."
-	@echo "    Requires: Python 3.8"
-	@echo "    Hint (Fedora): 'sudo dnf install python3.8'"
+	@echo "    Requires: Python 3.9"
+	@echo "    Hint (Fedora): 'sudo dnf install python3.9'"
 	@echo ""
 	@echo "make check-tox:"
 	@echo "    Run tests against multiple python versions."
 	@echo "    These tests use the newest dependencies."
-	@echo "    Requires: Python 3.8 - 3.11, and tox."
+	@echo "    Requires: Python 3.9 - 3.11, and tox."
 	@echo "    Hint (Fedora): 'sudo dnf install python3-tox python3.11'"
 	@echo "    The variable QEMU_TOX_EXTRA_ARGS can be use to pass extra"
 	@echo "    arguments to tox".
@@ -59,7 +59,7 @@ PIP_INSTALL = pip install --disable-pip-version-check
 min-venv: $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate
 $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate: setup.cfg tests/minreqs.txt
 	@echo "VENV $(QEMU_MINVENV_DIR)"
-	@python3.8 -m venv $(QEMU_MINVENV_DIR)
+	@python3.9 -m venv $(QEMU_MINVENV_DIR)
 	@(								\
 		echo "ACTIVATE $(QEMU_MINVENV_DIR)";			\
 		. $(QEMU_MINVENV_DIR)/bin/activate;			\
diff --git a/python/setup.cfg b/python/setup.cfg
index cf5af7e6641..c48dff280a3 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -14,7 +14,6 @@ classifiers =
     Natural Language :: English
     Operating System :: OS Independent
     Programming Language :: Python :: 3 :: Only
-    Programming Language :: Python :: 3.8
     Programming Language :: Python :: 3.9
     Programming Language :: Python :: 3.10
     Programming Language :: Python :: 3.11
@@ -23,7 +22,7 @@ classifiers =
     Typing :: Typed
 
 [options]
-python_requires = >= 3.8
+python_requires = >= 3.9
 packages =
     qemu.qmp
     qemu.machine
@@ -78,7 +77,7 @@ exclude = __pycache__,
 
 [mypy]
 strict = True
-python_version = 3.8
+python_version = 3.9
 warn_unused_configs = True
 namespace_packages = True
 warn_unused_ignores = False
@@ -186,7 +185,7 @@ multi_line_output=3
 # of python available on your system to run this test.
 
 [tox:tox]
-envlist = py38, py39, py310, py311, py312, py313
+envlist = py39, py310, py311, py312, py313
 skip_missing_interpreters = true
 
 [testenv]
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index a3f423efd84..6445407ba87 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -1,5 +1,5 @@
 # This file lists the ***oldest possible dependencies*** needed to run
-# "make check" successfully under ***Python 3.8***. It is used primarily
+# "make check" successfully under ***Python 3.9***. It is used primarily
 # by GitLab CI to ensure that our stated minimum versions in setup.cfg
 # are truthful and regularly validated.
 #
diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
index 8109470a031..c9dbcec2db0 100644
--- a/scripts/qapi/mypy.ini
+++ b/scripts/qapi/mypy.ini
@@ -1,4 +1,4 @@
 [mypy]
 strict = True
 disallow_untyped_calls = False
-python_version = 3.8
+python_version = 3.9
diff --git a/tests/docker/dockerfiles/python.docker b/tests/docker/dockerfiles/python.docker
index 8f0af9ef25f..59e70a02484 100644
--- a/tests/docker/dockerfiles/python.docker
+++ b/tests/docker/dockerfiles/python.docker
@@ -15,7 +15,6 @@ ENV PACKAGES \
     python3.11 \
     python3.12 \
     python3.13 \
-    python3.8 \
     python3.9
 
 RUN dnf install -y $PACKAGES
-- 
2.49.0


