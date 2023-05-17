Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7C270704C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 20:00:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLFu-0003AO-IC; Wed, 17 May 2023 13:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLET-00005r-HM
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEQ-0004Lg-OP
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUI5gP+VGMEuKYZHL551pN3vhWgbV23BFYT1rHteqTM=;
 b=S5sidhsYN6WgkeOq/+70xDnhjZrTSc8NDKiimd8DM51DnunCbPCLM1Q7dZm4zC6M8yHoE1
 oc4I59x5E9H0XLWfQRjM/CjF2ufj5i6n8gsCjvQsrpkj6cdIYFhEkB8DQ3G+oSiH1ptvtK
 5b13xU4LDw8uHketZDpHObuR07ROTMQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-OHKvPI4NMh6vyrkf0RmdNg-1; Wed, 17 May 2023 13:46:32 -0400
X-MC-Unique: OHKvPI4NMh6vyrkf0RmdNg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3062dedf7d9so752973f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345591; x=1686937591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUI5gP+VGMEuKYZHL551pN3vhWgbV23BFYT1rHteqTM=;
 b=X4lEKUBkgicrssPgd+Y9OEGE58m/B7CcESKKko0e0+qY6/kVIeLiZU+pJTXxmxb9B6
 Y7qOQ/OYZbIxliIUalLzWdK8Plzif8wbcgLTm9ADnuvhUl5UzkKrYHPGwqCMEc+SLtCv
 NZmUbeKDL9NJUITUUUVcrLFOoRrYwdtcDFtDG2k0TbZX8Q+SsQ/nBw98yJAj9GV9aPRe
 9OFA6ytC6Ey9q61jaVIR+G5yIxU1BpCNfmx8MpQ7SZxi9VdYbBHpwQzKsg6Qypsd6PCq
 giMlbcxKQltZ/LpX4rcAbrqqdtvAAUE0W7y7ku2HHottscqJZTIvuhRZUimYB7YMENhO
 paDw==
X-Gm-Message-State: AC+VfDwVbCNEEQc3um0IVIKAGs61FXsxGykK+qd+39gIuZKalijKz8ti
 maat27j4EpSCTWqjuYQxowCWZ0zV7/rudyIWUpPEmL6Yejk5hDoKrZ0jcuLuTORZO3qcOsrB/oQ
 GX5oua3lidcIy/fX2gR4YozFHD6Gf43gRx6EOVwOWj3pq6SF6rDVR3/mfUfF9sh4vjTx6rHkciN
 U=
X-Received: by 2002:a5d:6e01:0:b0:2f8:3225:2bc2 with SMTP id
 h1-20020a5d6e01000000b002f832252bc2mr1145756wrz.41.1684345590882; 
 Wed, 17 May 2023 10:46:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6aAKGWc7z9keuDsu7vgic67FbU9a9ol295noQS6AOur4l/MFnec0T+fOxTAsrzTpkm8fWzWQ==
X-Received: by 2002:a5d:6e01:0:b0:2f8:3225:2bc2 with SMTP id
 h1-20020a5d6e01000000b002f832252bc2mr1145740wrz.41.1684345590456; 
 Wed, 17 May 2023 10:46:30 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 s13-20020adff80d000000b00307bc4e39e5sm3473093wrp.117.2023.05.17.10.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 41/68] Python: Drop support for Python 3.6
Date: Wed, 17 May 2023 19:44:53 +0200
Message-Id: <20230517174520.887405-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Python 3.6 was EOL 2021-12-31. Newer versions of upstream libraries have
begun dropping support for this version and it is becoming more
cumbersome to support. Avocado-framework and qemu.qmp each have their
own reasons for wanting to drop Python 3.6, but won't until QEMU does.

Versions of Python available in our supported build platforms as of today,
with optional versions available in parentheses:

openSUSE Leap 15.4: 3.6.15 (3.9.10, 3.10.2)
CentOS Stream 8:    3.6.8  (3.8.13, 3.9.16)
CentOS Stream 9:    3.9.13
Fedora 36:          3.10
Fedora 37:          3.11
Debian 11:          3.9.2
Alpine 3.14, 3.15:  3.9.16
Alpine 3.16, 3.17:  3.10.10
Ubuntu 20.04 LTS:   3.8.10
Ubuntu 22.04 LTS:   3.10.4
NetBSD 9.3:         3.9.13*
FreeBSD 12.4:       3.9.16
FreeBSD 13.1:       3.9.16
OpenBSD 7.2:        3.9.16

Note: Our VM tests install 3.9 explicitly for FreeBSD and 3.10 for
NetBSD; the default for "python" or "python3" in FreeBSD is
3.9.16. NetBSD does not appear to have a default meta-package, but
offers several options, the lowest of which is 3.7.15. "python39"
appears to be a pre-requisite to one of the other packages we request in
tests/vm/netbsd. pip, ensurepip and other Python essentials are
currently only available for Python 3.10 for NetBSD.

CentOS and OpenSUSE support parallel installation of multiple Python
interpreters, and binaries in /usr/bin will always use Python 3.6.  However,
the newly introduced support for virtual environments ensures that all build
steps that execute QEMU Python code use a single interpreter.

Since it is safe to under our supported platform policy, bump our
minimum supported version of Python to 3.7.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20230511035435.734312-24-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                      | 10 +++++-----
 docs/about/build-platforms.rst |  2 +-
 python/Makefile                | 10 +++++-----
 python/setup.cfg               |  7 +++----
 python/tests/minreqs.txt       |  2 +-
 scripts/qapi/mypy.ini          |  2 +-
 6 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/configure b/configure
index b92da9e6605b..22e31a46d115 100755
--- a/configure
+++ b/configure
@@ -617,9 +617,9 @@ esac
 
 
 check_py_version() {
-    # We require python >= 3.6.
+    # We require python >= 3.7.
     # NB: a True python conditional creates a non-zero return code (Failure)
-    "$1" -c 'import sys; sys.exit(sys.version_info < (3,6))'
+    "$1" -c 'import sys; sys.exit(sys.version_info < (3,7))'
 }
 
 python=
@@ -628,7 +628,7 @@ first_python=
 if test -z "${PYTHON}"; then
     # A bare 'python' is traditionally python 2.x, but some distros
     # have it as python 3.x, so check in both places.
-    for binary in python3 python python3.11 python3.10 python3.9 python3.8 python3.7 python3.6; do
+    for binary in python3 python python3.11 python3.10 python3.9 python3.8 python3.7; do
         if has "$binary"; then
             python=$(command -v "$binary")
             if check_py_version "$python"; then
@@ -1077,7 +1077,7 @@ then
     # If first_python is set, there was a binary somewhere even though
     # it was not suitable.  Use it for the error message.
     if test -n "$first_python"; then
-        error_exit "Cannot use '$first_python', Python >= 3.6 is required." \
+        error_exit "Cannot use '$first_python', Python >= 3.7 is required." \
             "Use --python=/path/to/python to specify a supported Python."
     else
         error_exit "Python not found. Use --python=/path/to/python"
@@ -1090,7 +1090,7 @@ then
 fi
 
 if ! check_py_version "$python"; then
-  error_exit "Cannot use '$python', Python >= 3.6 is required." \
+  error_exit "Cannot use '$python', Python >= 3.7 is required." \
       "Use --python=/path/to/python to specify a supported Python."
 fi
 
diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 89cae5a6bb98..0e2cb9e770d5 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -98,7 +98,7 @@ Python runtime
   option of the ``configure`` script to point QEMU to a supported
   version of the Python runtime.
 
-  As of QEMU |version|, the minimum supported version of Python is 3.6.
+  As of QEMU |version|, the minimum supported version of Python is 3.7.
 
 Python build dependencies
   Some of QEMU's build dependencies are written in Python.  Usually these
diff --git a/python/Makefile b/python/Makefile
index 47560657d27e..7c70dcc8d144 100644
--- a/python/Makefile
+++ b/python/Makefile
@@ -9,14 +9,14 @@ help:
 	@echo "make check-minreqs:"
 	@echo "    Run tests in the minreqs virtual environment."
 	@echo "    These tests use the oldest dependencies."
-	@echo "    Requires: Python 3.6"
-	@echo "    Hint (Fedora): 'sudo dnf install python3.6'"
+	@echo "    Requires: Python 3.7"
+	@echo "    Hint (Fedora): 'sudo dnf install python3.7'"
 	@echo ""
 	@echo "make check-tox:"
 	@echo "    Run tests against multiple python versions."
 	@echo "    These tests use the newest dependencies."
-	@echo "    Requires: Python 3.6 - 3.10, and tox."
-	@echo "    Hint (Fedora): 'sudo dnf install python3-tox python3.10'"
+	@echo "    Requires: Python 3.7 - 3.11, and tox."
+	@echo "    Hint (Fedora): 'sudo dnf install python3-tox python3.11'"
 	@echo "    The variable QEMU_TOX_EXTRA_ARGS can be use to pass extra"
 	@echo "    arguments to tox".
 	@echo ""
@@ -59,7 +59,7 @@ PIP_INSTALL = pip install --disable-pip-version-check
 min-venv: $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate
 $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate: setup.cfg tests/minreqs.txt
 	@echo "VENV $(QEMU_MINVENV_DIR)"
-	@python3.6 -m venv $(QEMU_MINVENV_DIR)
+	@python3.7 -m venv $(QEMU_MINVENV_DIR)
 	@(								\
 		echo "ACTIVATE $(QEMU_MINVENV_DIR)";			\
 		. $(QEMU_MINVENV_DIR)/bin/activate;			\
diff --git a/python/setup.cfg b/python/setup.cfg
index fc3fae5b1076..55c0993e70b3 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -14,7 +14,6 @@ classifiers =
     Natural Language :: English
     Operating System :: OS Independent
     Programming Language :: Python :: 3 :: Only
-    Programming Language :: Python :: 3.6
     Programming Language :: Python :: 3.7
     Programming Language :: Python :: 3.8
     Programming Language :: Python :: 3.9
@@ -23,7 +22,7 @@ classifiers =
     Typing :: Typed
 
 [options]
-python_requires = >= 3.6
+python_requires = >= 3.7
 packages =
     qemu.qmp
     qemu.machine
@@ -77,7 +76,7 @@ exclude = __pycache__,
 
 [mypy]
 strict = True
-python_version = 3.6
+python_version = 3.7
 warn_unused_configs = True
 namespace_packages = True
 warn_unused_ignores = False
@@ -199,7 +198,7 @@ multi_line_output=3
 # of python available on your system to run this test.
 
 [tox:tox]
-envlist = py36, py37, py38, py39, py310, py311
+envlist = py37, py38, py39, py310, py311
 skip_missing_interpreters = true
 
 [testenv]
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index 7ecf5e7fe483..10b181d43a6b 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -1,5 +1,5 @@
 # This file lists the ***oldest possible dependencies*** needed to run
-# "make check" successfully under ***Python 3.6***. It is used primarily
+# "make check" successfully under ***Python 3.7***. It is used primarily
 # by GitLab CI to ensure that our stated minimum versions in setup.cfg
 # are truthful and regularly validated.
 #
diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
index 662535642974..3463307ddc72 100644
--- a/scripts/qapi/mypy.ini
+++ b/scripts/qapi/mypy.ini
@@ -1,7 +1,7 @@
 [mypy]
 strict = True
 disallow_untyped_calls = False
-python_version = 3.6
+python_version = 3.7
 
 [mypy-qapi.schema]
 disallow_untyped_defs = False
-- 
2.40.1


