Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 271F7A91A56
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Apr 2025 13:14:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5NBe-0003XS-TP; Thu, 17 Apr 2025 07:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1u5NBc-0003Wj-2S
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 07:13:40 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1u5NBX-0007AU-HO
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 07:13:39 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:381b:0:640:f69d:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 55C1A60AB0;
 Thu, 17 Apr 2025 14:13:31 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6b8:b081:8014::1:10])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MDH9PZ2FiKo0-8qlmYwjS; Thu, 17 Apr 2025 14:13:30 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744888410;
 bh=OFnYkElq7KLQOliisIu7XXuHdcEvLFLPedH92jINYp0=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=PV6WmtkucY51a4DtZLPykerG8WZU1ykIdI8VykDW/6pfcy/4ZZqnUst2nXpNjMqY+
 MBmfyHxDHsWWRkaQwpL3jLo84SY3xBCK7vDhM4PLyKTNK55CjLRCwkYM/zKY+MkWVR
 DHue1Qlac2Ji4GXGN1A24sUKo9J+zD0qBw5Pp4FI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v5 1/2] tests/functional: add skipLockedMemoryTest decorator
Date: Thu, 17 Apr 2025 16:13:20 +0500
Message-Id: <20250417111321.167008-2-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417111321.167008-1-dtalexundeer@yandex-team.ru>
References: <20250417111321.167008-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Used in future commit to skipping execution of a tests if the system's
locked memory limit is below the required threshold.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 tests/functional/qemu_test/__init__.py   |  2 +-
 tests/functional/qemu_test/decorators.py | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index af41c2c6a2..6e666a059f 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -15,6 +15,6 @@
 from .linuxkernel import LinuxKernelTest
 from .decorators import skipIfMissingCommands, skipIfNotMachine, \
     skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipSlowTest, \
-    skipIfMissingImports, skipIfOperatingSystem
+    skipIfMissingImports, skipIfOperatingSystem, skipLockedMemoryTest
 from .archive import archive_extract
 from .uncompress import uncompress
diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index 50d29de533..c0d1567b14 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -5,6 +5,7 @@
 import importlib
 import os
 import platform
+import resource
 from unittest import skipIf, skipUnless
 
 from .cmd import which
@@ -131,3 +132,20 @@ def skipIfMissingImports(*args):
 
     return skipUnless(has_imports, 'required import(s) "%s" not installed' %
                                    ", ".join(args))
+
+'''
+Decorator to skip execution of a test if the system's
+locked memory limit is below the required threshold.
+Takes required locked memory threshold in kB.
+Example:
+
+  @skipLockedMemoryTest(2_097_152)
+'''
+def skipLockedMemoryTest(locked_memory):
+    # get memlock hard limit in bytes
+    _, ulimit_memory = resource.getrlimit(resource.RLIMIT_MEMLOCK)
+
+    return skipUnless(
+        ulimit_memory == resource.RLIM_INFINITY or ulimit_memory >= locked_memory * 1024,
+        f'Test required {locked_memory} kB of available locked memory',
+    )
-- 
2.34.1


