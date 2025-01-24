Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA4FA1B7BA
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Jan 2025 15:18:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbKUu-0003HJ-UL; Fri, 24 Jan 2025 09:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tbKTf-00034z-Ea
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:16:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tbKTd-0001IK-GV
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737728164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kmmcx8XJk+cyBYvzDvNSR6t/TihZV6L8r9lXPgyChbA=;
 b=dZUDBfgT95vKP3UAay3jKdzf4Td4/eHgDHCSmlftMKB5Kr+neqZux5o36MTYLm95mR+Rf2
 DkIWs+9njAExSvc2yG6ezalsHZVL2/y8YFECz7V5CPTPdS79uROyx2vB7FGRcbYnC/3/wk
 TlK5YgrKjOa6MyJOwrP+mqwMSMZaQpA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-SCkgQNGfMZKJQk5waietzA-1; Fri,
 24 Jan 2025 09:15:44 -0500
X-MC-Unique: SCkgQNGfMZKJQk5waietzA-1
X-Mimecast-MFC-AGG-ID: SCkgQNGfMZKJQk5waietzA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 147821801F1E; Fri, 24 Jan 2025 14:15:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.187])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B4D419560B4; Fri, 24 Jan 2025 14:15:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/5] tests/functional: Add a decorator for skipping long
 running tests
Date: Fri, 24 Jan 2025 15:15:25 +0100
Message-ID: <20250124141529.1626877-2-thuth@redhat.com>
In-Reply-To: <20250124141529.1626877-1-thuth@redhat.com>
References: <20250124141529.1626877-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Some tests have a very long runtime and might run into timeout
issues e.g. when QEMU has been compiled with --enable-debug.
Add a decorator for marking them more easily and document the
corresponding environment variable that is used to enable the
tests.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing/functional.rst        |  8 ++++++++
 tests/functional/qemu_test/__init__.py   |  2 +-
 tests/functional/qemu_test/decorators.py | 14 ++++++++++++++
 tests/functional/test_arm_quanta_gsj.py  |  5 +++--
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index ae238ed3fc..7d9396b696 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -351,5 +351,13 @@ the code snippet below:
 Tests should not live in this state forever and should either be fixed
 or eventually removed.
 
+QEMU_TEST_TIMEOUT_EXPECTED
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+Tests that have a very long runtime and might run into timeout issues
+e.g. if the QEMU binary has been compiled with debugging options enabled.
+To avoid these timeout issues by default and to save some precious CPU
+cycles during normal testing, such tests are disabled by default unless
+the QEMU_TEST_TIMEOUT_EXPECTED environment variable has been set.
+
 
 .. _unittest: https://docs.python.org/3/library/unittest.html
diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index da1830286d..b1a19d2a4b 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -14,7 +14,7 @@
 from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
 from .linuxkernel import LinuxKernelTest
 from .decorators import skipIfMissingCommands, skipIfNotMachine, \
-    skipFlakyTest, skipUntrustedTest, skipBigDataTest, \
+    skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipLongRuntime, \
     skipIfMissingImports
 from .archive import archive_extract
 from .uncompress import uncompress
diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index df088bc090..8f311e5309 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -86,6 +86,20 @@ def skipBigDataTest():
     return skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'),
                       'Test requires large host storage space')
 
+'''
+Decorator to skip execution of tests which have a really long
+runtime (and might e.g. time out if QEMU has been compiled with
+debugging enabled) unless the $QEMU_TEST_TIMEOUT_EXPECTED
+environment variable is set
+
+Example:
+
+  @skipLongRuntime()
+'''
+def skipLongRuntime():
+    return skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'),
+                      'Test has a very long runtime and might time out')
+
 '''
 Decorator to skip execution of a test if the list
 of python imports is not available.
diff --git a/tests/functional/test_arm_quanta_gsj.py b/tests/functional/test_arm_quanta_gsj.py
index 7b82e2185c..fe1d60d649 100755
--- a/tests/functional/test_arm_quanta_gsj.py
+++ b/tests/functional/test_arm_quanta_gsj.py
@@ -8,7 +8,8 @@
 
 from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
 from qemu_test import interrupt_interactive_console_until_pattern
-from unittest import skipUnless
+from qemu_test import skipLongRuntime
+
 
 class EmcraftSf2Machine(LinuxKernelTest):
 
@@ -32,7 +33,7 @@ class EmcraftSf2Machine(LinuxKernelTest):
          '20200711-gsj-qemu-0/nuvoton-npcm730-gsj.dtb'),
         '3249b2da787d4b9ad4e61f315b160abfceb87b5e1895a7ce898ce7f40c8d4045')
 
-    @skipUnless(os.getenv('QEMU_TEST_TIMEOUT_EXPECTED'), 'Test might timeout')
+    @skipLongRuntime()
     def test_arm_quanta_gsj(self):
         self.set_machine('quanta-gsj')
         image_path = self.uncompress(self.ASSET_IMAGE, format='gz')
-- 
2.48.1


