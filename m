Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B50DFA22D81
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Jan 2025 14:19:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUQI-0000rB-GF; Thu, 30 Jan 2025 08:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUP9-0007Wn-Ry
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUP4-0000Bb-Vv
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738242978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DuxX692H1MLvRwRVYiFpDcKXuYGU4JwO3UPNwM+LK+8=;
 b=Fm4xsmS8A6aXdQFGt5/PKgmxwWWoINOxdKO7ZnbYDputRCtv5UcpX0BqsYvlLV3ydSI/eH
 iiIJwn6PtjkxJmkXgmxesMhwiNCaRMDkvMloC86O52gahkpu8aiZY0Wz9vPnTMF0Y1eRUM
 DD1Y1bzP2iO91zuFYZR4RuZSIG4DxuU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-oyBjd1YFNYKwtvdNTIBlWQ-1; Thu,
 30 Jan 2025 08:16:16 -0500
X-MC-Unique: oyBjd1YFNYKwtvdNTIBlWQ-1
X-Mimecast-MFC-AGG-ID: oyBjd1YFNYKwtvdNTIBlWQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD0411955DDF
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:16:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 554FD30001BE; Thu, 30 Jan 2025 13:16:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 15/20] tests/functional: Add a decorator for skipping long
 running tests
Date: Thu, 30 Jan 2025 14:15:29 +0100
Message-ID: <20250130131535.91297-16-thuth@redhat.com>
In-Reply-To: <20250130131535.91297-1-thuth@redhat.com>
References: <20250130131535.91297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Some tests have a very long runtime and might run into timeout issues
e.g. when QEMU has been compiled with --enable-debug. Add a decorator
for marking them more easily. Rename the corresponding environment
variable to be more in sync with the other QEMU_TEST_ALLOW_* switches
that we already have, and add a paragraph about it in the documentation.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250128152839.184599-2-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing/functional.rst                |  8 ++++++++
 tests/functional/qemu_test/__init__.py           |  2 +-
 tests/functional/qemu_test/decorators.py         | 14 ++++++++++++++
 tests/functional/test_aarch64_sbsaref_alpine.py  |  5 ++---
 tests/functional/test_aarch64_sbsaref_freebsd.py |  9 +++------
 tests/functional/test_arm_quanta_gsj.py          |  6 +++---
 6 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index ae238ed3fc..ecc738922b 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -351,5 +351,13 @@ the code snippet below:
 Tests should not live in this state forever and should either be fixed
 or eventually removed.
 
+QEMU_TEST_ALLOW_SLOW
+^^^^^^^^^^^^^^^^^^^^
+Tests that have a very long runtime and might run into timeout issues
+e.g. if the QEMU binary has been compiled with debugging options enabled.
+To avoid these timeout issues by default and to save some precious CPU
+cycles during normal testing, such tests are disabled by default unless
+the QEMU_TEST_ALLOW_SLOW environment variable has been set.
+
 
 .. _unittest: https://docs.python.org/3/library/unittest.html
diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index da1830286d..5c972843a6 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -14,7 +14,7 @@
 from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
 from .linuxkernel import LinuxKernelTest
 from .decorators import skipIfMissingCommands, skipIfNotMachine, \
-    skipFlakyTest, skipUntrustedTest, skipBigDataTest, \
+    skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipSlowTest, \
     skipIfMissingImports
 from .archive import archive_extract
 from .uncompress import uncompress
diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index 3d9c02fd59..1651eb739a 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -86,6 +86,20 @@ def skipBigDataTest():
     return skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'),
                       'Test requires large host storage space')
 
+'''
+Decorator to skip execution of tests which have a really long
+runtime (and might e.g. time out if QEMU has been compiled with
+debugging enabled) unless the $QEMU_TEST_ALLOW_SLOW
+environment variable is set
+
+Example:
+
+  @skipSlowTest()
+'''
+def skipSlowTest():
+    return skipUnless(os.getenv('QEMU_TEST_ALLOW_SLOW'),
+                      'Test has a very long runtime and might time out')
+
 '''
 Decorator to skip execution of a test if the list
 of python imports is not available.
diff --git a/tests/functional/test_aarch64_sbsaref_alpine.py b/tests/functional/test_aarch64_sbsaref_alpine.py
index 6dbc90f30e..ce974fd7e1 100755
--- a/tests/functional/test_aarch64_sbsaref_alpine.py
+++ b/tests/functional/test_aarch64_sbsaref_alpine.py
@@ -10,7 +10,7 @@
 
 import os
 
-from qemu_test import QemuSystemTest, Asset
+from qemu_test import QemuSystemTest, Asset, skipSlowTest
 from qemu_test import wait_for_console_pattern
 from unittest import skipUnless
 from test_aarch64_sbsaref import fetch_firmware
@@ -53,8 +53,7 @@ def test_sbsaref_alpine_linux_max_pauth_off(self):
     def test_sbsaref_alpine_linux_max_pauth_impdef(self):
         self.boot_alpine_linux("max,pauth-impdef=on")
 
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
-                'Test might timeout due to PAuth emulation')
+    @skipSlowTest()  # Test might timeout due to PAuth emulation
     def test_sbsaref_alpine_linux_max(self):
         self.boot_alpine_linux("max")
 
diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/functional/test_aarch64_sbsaref_freebsd.py
index 77ba2ba1da..5b10bb9b64 100755
--- a/tests/functional/test_aarch64_sbsaref_freebsd.py
+++ b/tests/functional/test_aarch64_sbsaref_freebsd.py
@@ -10,9 +10,8 @@
 
 import os
 
-from qemu_test import QemuSystemTest, Asset
+from qemu_test import QemuSystemTest, Asset, skipSlowTest
 from qemu_test import wait_for_console_pattern
-from unittest import skipUnless
 from test_aarch64_sbsaref import fetch_firmware
 
 
@@ -50,13 +49,11 @@ def test_sbsaref_freebsd14_default_cpu(self):
     def test_sbsaref_freebsd14_max_pauth_off(self):
         self.boot_freebsd14("max,pauth=off")
 
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
-                'Test might timeout due to PAuth emulation')
+    @skipSlowTest()  # Test might timeout due to PAuth emulation
     def test_sbsaref_freebsd14_max_pauth_impdef(self):
         self.boot_freebsd14("max,pauth-impdef=on")
 
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
-                'Test might timeout due to PAuth emulation')
+    @skipSlowTest()  # Test might timeout due to PAuth emulation
     def test_sbsaref_freebsd14_max(self):
         self.boot_freebsd14("max")
 
diff --git a/tests/functional/test_arm_quanta_gsj.py b/tests/functional/test_arm_quanta_gsj.py
index 7b82e2185c..da60aeb659 100755
--- a/tests/functional/test_arm_quanta_gsj.py
+++ b/tests/functional/test_arm_quanta_gsj.py
@@ -7,8 +7,8 @@
 import os
 
 from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
-from qemu_test import interrupt_interactive_console_until_pattern
-from unittest import skipUnless
+from qemu_test import interrupt_interactive_console_until_pattern, skipSlowTest
+
 
 class EmcraftSf2Machine(LinuxKernelTest):
 
@@ -32,7 +32,7 @@ class EmcraftSf2Machine(LinuxKernelTest):
          '20200711-gsj-qemu-0/nuvoton-npcm730-gsj.dtb'),
         '3249b2da787d4b9ad4e61f315b160abfceb87b5e1895a7ce898ce7f40c8d4045')
 
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
+    @skipSlowTest()
     def test_arm_quanta_gsj(self):
         self.set_machine('quanta-gsj')
         image_path = self.uncompress(self.ASSET_IMAGE, format='gz')
-- 
2.48.1


