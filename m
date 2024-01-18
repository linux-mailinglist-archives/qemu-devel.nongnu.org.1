Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 720B4831371
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:57:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNGL-0006CG-ES; Thu, 18 Jan 2024 02:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNG3-0005Qg-Ne; Thu, 18 Jan 2024 02:56:16 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNG1-0007vX-Mw; Thu, 18 Jan 2024 02:56:15 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A8B5A45047;
 Thu, 18 Jan 2024 10:54:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D362A661AF;
 Thu, 18 Jan 2024 10:54:06 +0300 (MSK)
Received: (nullmailer pid 2381713 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 28/38] readthodocs: fully specify a build environment
Date: Thu, 18 Jan 2024 10:52:55 +0300
Message-Id: <20240118075404.2381519-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Alex Bennée <alex.bennee@linaro.org>

This is now expected by rtd so I've expanded using their example as
22.04 is one of our supported platforms. I tried to work out if there
was an easy way to re-generate a requirements.txt from our
pythondeps.toml but in the end went for the easier solution.

Cc:  <qemu-stable@nongnu.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231221174200.2693694-1-alex.bennee@linaro.org>
(cherry picked from commit b16a45bc5e0e329a16af8a2e020a6e7044f9afa2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.readthedocs.yml b/.readthedocs.yml
index 7fb7b8dd61..0b262469ce 100644
--- a/.readthedocs.yml
+++ b/.readthedocs.yml
@@ -5,16 +5,21 @@
 # Required
 version: 2
 
+# Set the version of Python and other tools you might need
+build:
+  os: ubuntu-22.04
+  tools:
+    python: "3.11"
+
 # Build documentation in the docs/ directory with Sphinx
 sphinx:
   configuration: docs/conf.py
 
+# We recommend specifying your dependencies to enable reproducible builds:
+# https://docs.readthedocs.io/en/stable/guides/reproducible-builds.html
+python:
+  install:
+    - requirements: docs/requirements.txt
+
 # We want all the document formats
 formats: all
-
-# For consistency, we require that QEMU's Sphinx extensions
-# run with at least the same minimum version of Python that
-# we require for other Python in our codebase (our conf.py
-# enforces this, and some code needs it.)
-python:
-  version: 3.6
diff --git a/docs/requirements.txt b/docs/requirements.txt
new file mode 100644
index 0000000000..691e5218ec
--- /dev/null
+++ b/docs/requirements.txt
@@ -0,0 +1,2 @@
+sphinx==5.3.0
+sphinx_rtd_theme==1.1.1
-- 
2.39.2


