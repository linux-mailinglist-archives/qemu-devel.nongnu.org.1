Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D55D5797295
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:08:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdl-0003yg-T7; Thu, 07 Sep 2023 09:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdg-0003cC-Jd
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdb-0007RA-Bx
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JObfOMUfiKmSxE4EE7U/B9LeLOcbPewGoVRQKbqkoB8=;
 b=gJAwFWxn9vxRmPWp5duo5wAI/ESTI2ExsxeOizjToH6KlgdZTVR8a60TZK9jFjhCmhl1pH
 akdWb5Gk9l2PifS1rJFk575gsNWgV2t0iPjvjj0uUS8YiZW9NmzMx79hajtk3sdlytrvh/
 rny5gO/QE1xEY2cMRzFnhJIfCuQYgXU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-4y0lFzuzMPCAy3tBxfH5Hg-1; Thu, 07 Sep 2023 09:01:31 -0400
X-MC-Unique: 4y0lFzuzMPCAy3tBxfH5Hg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4011f56165eso8833915e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091686; x=1694696486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JObfOMUfiKmSxE4EE7U/B9LeLOcbPewGoVRQKbqkoB8=;
 b=RatG+j2wG2+KGFV1Sf0JwEYmwhFKfWqtNa1VciV1oAviPNu5xIfbpundQGLHBYGHZg
 Bp1hXamW8gpA8gf4JtOgbeR6rHINhinaCuGgFFV7e+Di06oH08IJnoRSG0kBZhnSZzQk
 Ki9HHGP7PBkuXRU2uHlQq7pq3by5EBq3MQgXu2bNA6UlA4Vgk90opC93eq76Sxp5Q+RW
 ECcK+Xuvj/f+S2e+Wgpc6J7ercytRQKIyWr4oyVpYT7ga0s9E3MtnmXXB56MTHdflDKj
 ZM1yDd/oaePX3twnt9eShLiTqKL088E/KXK9Aday8CpaAA9Nn0FSUPG/XVOSYYNCHpuS
 63Kw==
X-Gm-Message-State: AOJu0YwTdDHU13IpIzayliAxbjwWLCoaIXLKXVXCuUtdYjMrCUUdPzsn
 Hnkhtu9n7rlglRsek5DyQHDReAfk2m8RraiplznjOCDKowFOTYHpMwPoaMZmNVKkXh3su7R8a3E
 93+gT0qE8bRPNkOKeFBte4Iw/lWedMi+egoiYQqL/u8VB4/H5xC8ycPT+NoYbkAjJIIgrcloObF
 Q=
X-Received: by 2002:a7b:cd8c:0:b0:401:b24b:8279 with SMTP id
 y12-20020a7bcd8c000000b00401b24b8279mr2062093wmj.1.1694091686539; 
 Thu, 07 Sep 2023 06:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSI6HVP33PxzZTFqn42jBS3oOdsVO6AzcJA/lte9Z90ohHIglV4jiRyZL/Lgv7PUfiEDVx9Q==
X-Received: by 2002:a7b:cd8c:0:b0:401:b24b:8279 with SMTP id
 y12-20020a7bcd8c000000b00401b24b8279mr2062066wmj.1.1694091686010; 
 Thu, 07 Sep 2023 06:01:26 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a1cf70f000000b003fee849df23sm2480857wmh.22.2023.09.07.06.01.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/51] Python: Drop support for Python 3.7
Date: Thu,  7 Sep 2023 14:59:43 +0200
Message-ID: <20230907130004.500601-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Debian 10 is not anymore a supported distro, since Debian 12 was
released on June 10, 2023.  Our supported build platforms as of today
all support at least 3.8 (and all of them except for Ubuntu 20.04
support 3.9):

openSUSE Leap 15.5: 3.6.15 (3.11.2)
CentOS Stream 8:    3.6.8  (3.8.13, 3.9.16, 3.11.4)
CentOS Stream 9:    3.9.17 (3.11.4)
Fedora 37:          3.11.4
Fedora 38:          3.11.4
Debian 11:          3.9.2
Debian 12:          3.11.2
Alpine 3.14, 3.15:  3.9.16
Alpine 3.16, 3.17:  3.10.10
Ubuntu 20.04 LTS:   3.8.10
Ubuntu 22.04 LTS:   3.10.12
NetBSD 9.3:         3.9.13*
FreeBSD 12.4:       3.9.16
FreeBSD 13.1:       3.9.18
OpenBSD 7.2:        3.9.17

Note: NetBSD does not appear to have a default meta-package, but offers
several options, the lowest of which is 3.7.15. However, "python39"
appears to be a pre-requisite to one of the other packages we request
in tests/vm/netbsd.

Since it is safe under our supported platform policy, bump our
minimum supported version of Python to 3.8.  The two most interesting
features to have by default include:

- the importlib.metadata module, whose lack is responsible for over 100
  lines of code in mkvenv.py

- improvements to asyncio, for example asyncio.CancelledError
  inherits from BaseException rather than Exception

In addition, code can now use the assignment operator ':='

Because mypy now learns about importlib.metadata, a small change to
mkvenv.py is needed to pass type checking.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                | 8 ++++----
 python/Makefile          | 8 ++++----
 python/scripts/mkvenv.py | 5 ++++-
 python/setup.cfg         | 7 +++----
 python/tests/minreqs.txt | 2 +-
 scripts/qapi/mypy.ini    | 2 +-
 6 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/configure b/configure
index 48ae0fc05ab..e08127045d0 100755
--- a/configure
+++ b/configure
@@ -552,16 +552,16 @@ if test -n "$linux_arch" && ! test -d "$source_path/linux-headers/asm-$linux_arc
 fi
 
 check_py_version() {
-    # We require python >= 3.7.
+    # We require python >= 3.8.
     # NB: a True python conditional creates a non-zero return code (Failure)
-    "$1" -c 'import sys; sys.exit(sys.version_info < (3,7))'
+    "$1" -c 'import sys; sys.exit(sys.version_info < (3,8))'
 }
 
 first_python=
 if test -z "${PYTHON}"; then
     # A bare 'python' is traditionally python 2.x, but some distros
     # have it as python 3.x, so check in both places.
-    for binary in python3 python python3.11 python3.10 python3.9 python3.8 python3.7; do
+    for binary in python3 python python3.11 python3.10 python3.9 python3.8; do
         if has "$binary"; then
             python=$(command -v "$binary")
             if check_py_version "$python"; then
@@ -952,7 +952,7 @@ then
 fi
 
 if ! check_py_version "$python"; then
-  error_exit "Cannot use '$python', Python >= 3.7 is required." \
+  error_exit "Cannot use '$python', Python >= 3.8 is required." \
              "Use --python=/path/to/python to specify a supported Python." \
              "Maybe try:" \
              "  openSUSE Leap 15.3+: zypper install python39" \
diff --git a/python/Makefile b/python/Makefile
index 7c70dcc8d14..1fa4ba2498e 100644
--- a/python/Makefile
+++ b/python/Makefile
@@ -9,13 +9,13 @@ help:
 	@echo "make check-minreqs:"
 	@echo "    Run tests in the minreqs virtual environment."
 	@echo "    These tests use the oldest dependencies."
-	@echo "    Requires: Python 3.7"
-	@echo "    Hint (Fedora): 'sudo dnf install python3.7'"
+	@echo "    Requires: Python 3.8"
+	@echo "    Hint (Fedora): 'sudo dnf install python3.8'"
 	@echo ""
 	@echo "make check-tox:"
 	@echo "    Run tests against multiple python versions."
 	@echo "    These tests use the newest dependencies."
-	@echo "    Requires: Python 3.7 - 3.11, and tox."
+	@echo "    Requires: Python 3.8 - 3.11, and tox."
 	@echo "    Hint (Fedora): 'sudo dnf install python3-tox python3.11'"
 	@echo "    The variable QEMU_TOX_EXTRA_ARGS can be use to pass extra"
 	@echo "    arguments to tox".
@@ -59,7 +59,7 @@ PIP_INSTALL = pip install --disable-pip-version-check
 min-venv: $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate
 $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate: setup.cfg tests/minreqs.txt
 	@echo "VENV $(QEMU_MINVENV_DIR)"
-	@python3.7 -m venv $(QEMU_MINVENV_DIR)
+	@python3.8 -m venv $(QEMU_MINVENV_DIR)
 	@(								\
 		echo "ACTIVATE $(QEMU_MINVENV_DIR)";			\
 		. $(QEMU_MINVENV_DIR)/bin/activate;			\
diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 4f2349fbb65..57a24948031 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -435,6 +435,7 @@ def _gen_importlib(packages: Sequence[str]) -> Iterator[str]:
     try:
         # First preference: Python 3.8+ stdlib
         from importlib.metadata import (  # type: ignore
+            EntryPoint,
             PackageNotFoundError,
             distribution,
         )
@@ -442,6 +443,7 @@ def _gen_importlib(packages: Sequence[str]) -> Iterator[str]:
         logger.debug("%s", str(exc))
         # Second preference: Commonly available PyPI backport
         from importlib_metadata import (  # type: ignore
+            EntryPoint,
             PackageNotFoundError,
             distribution,
         )
@@ -449,7 +451,8 @@ def _gen_importlib(packages: Sequence[str]) -> Iterator[str]:
     def _generator() -> Iterator[str]:
         for package in packages:
             try:
-                entry_points = distribution(package).entry_points
+                entry_points: Iterator[EntryPoint] = \
+                    iter(distribution(package).entry_points)
             except PackageNotFoundError:
                 continue
 
diff --git a/python/setup.cfg b/python/setup.cfg
index e74b58a8c24..f6d2d8a1362 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -14,7 +14,6 @@ classifiers =
     Natural Language :: English
     Operating System :: OS Independent
     Programming Language :: Python :: 3 :: Only
-    Programming Language :: Python :: 3.7
     Programming Language :: Python :: 3.8
     Programming Language :: Python :: 3.9
     Programming Language :: Python :: 3.10
@@ -22,7 +21,7 @@ classifiers =
     Typing :: Typed
 
 [options]
-python_requires = >= 3.7
+python_requires = >= 3.8
 packages =
     qemu.qmp
     qemu.machine
@@ -76,7 +75,7 @@ exclude = __pycache__,
 
 [mypy]
 strict = True
-python_version = 3.7
+python_version = 3.8
 warn_unused_configs = True
 namespace_packages = True
 warn_unused_ignores = False
@@ -192,7 +191,7 @@ multi_line_output=3
 # of python available on your system to run this test.
 
 [tox:tox]
-envlist = py37, py38, py39, py310, py311
+envlist = py38, py39, py310, py311
 skip_missing_interpreters = true
 
 [testenv]
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index 979461be6bb..a3f423efd84 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -1,5 +1,5 @@
 # This file lists the ***oldest possible dependencies*** needed to run
-# "make check" successfully under ***Python 3.7***. It is used primarily
+# "make check" successfully under ***Python 3.8***. It is used primarily
 # by GitLab CI to ensure that our stated minimum versions in setup.cfg
 # are truthful and regularly validated.
 #
diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
index 3463307ddc7..56e0dfb1327 100644
--- a/scripts/qapi/mypy.ini
+++ b/scripts/qapi/mypy.ini
@@ -1,7 +1,7 @@
 [mypy]
 strict = True
 disallow_untyped_calls = False
-python_version = 3.7
+python_version = 3.8
 
 [mypy-qapi.schema]
 disallow_untyped_defs = False
-- 
2.41.0


