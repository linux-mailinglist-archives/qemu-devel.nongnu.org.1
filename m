Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63454966339
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Aug 2024 15:43:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk1sU-000064-Ep; Fri, 30 Aug 2024 09:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1sQ-00088Q-Fq
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1sN-0005ca-Cl
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725025278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8reHlBu2HO9GEDbKdRUlnYq6oypIbdQw/HlVrHWB+0=;
 b=i0RhcuBZVmLmg91i1SOlosi4c+YgN/PAMn5voF3h/uOvehN/5C0Sbx5qpcvK9Rgf7XGmha
 DMlFrFd6jwju7UkFDIbDuY775GxJpH2DswV52o4wZfX49/oOEd2lm6265EDnMC/QTR/B+Y
 Dz1y0/Bc+WNHpgGSAeXcLuXIL7Anl/o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-YN8f9HqQN7qMsEBgJQItLQ-1; Fri,
 30 Aug 2024 09:41:16 -0400
X-MC-Unique: YN8f9HqQN7qMsEBgJQItLQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A05171955D45; Fri, 30 Aug 2024 13:41:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C4520300019C; Fri, 30 Aug 2024 13:41:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 33/44] tests/functional: Convert ARM Integrator/CP avocado
 tests
Date: Fri, 30 Aug 2024 15:38:27 +0200
Message-ID: <20240830133841.142644-34-thuth@redhat.com>
In-Reply-To: <20240830133841.142644-1-thuth@redhat.com>
References: <20240830133841.142644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Straight forward conversion. Update the SHA1 hashes to SHA256
hashes since SHA1 should not be used anymore nowadays.

  $ QEMU_TEST_ALLOW_UNTRUSTED_CODE=1 make check-functional-arm
  ...
  6/6 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_integratorcp   OK   3.90s   2 subtests passed

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240822110238.82312-1-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 tests/functional/meson.build                  |  1 +
 .../test_arm_integratorcp.py}                 | 56 ++++++++++---------
 3 files changed, 33 insertions(+), 26 deletions(-)
 rename tests/{avocado/machine_arm_integratorcp.py => functional/test_arm_integratorcp.py} (63%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 25e71ac14c..14500cf8a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -785,7 +785,7 @@ S: Maintained
 F: hw/arm/integratorcp.c
 F: hw/misc/arm_integrator_debug.c
 F: include/hw/misc/arm_integrator_debug.h
-F: tests/avocado/machine_arm_integratorcp.py
+F: tests/functional/test_arm_integratorcp.py
 F: docs/system/arm/integratorcp.rst
 
 MCIMX6UL EVK / i.MX6ul
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 58f6bcf95d..182d40e052 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -34,6 +34,7 @@ tests_generic_bsduser = [
 
 tests_arm_system_thorough = [
   'arm_canona1100',
+  'arm_integratorcp',
   'arm_n8x0',
 ]
 
diff --git a/tests/avocado/machine_arm_integratorcp.py b/tests/functional/test_arm_integratorcp.py
old mode 100644
new mode 100755
similarity index 63%
rename from tests/avocado/machine_arm_integratorcp.py
rename to tests/functional/test_arm_integratorcp.py
index 87f5cf3953..0fe083f661
--- a/tests/avocado/machine_arm_integratorcp.py
+++ b/tests/functional/test_arm_integratorcp.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots a Linux kernel and checks the console
 #
 # Copyright (c) 2020 Red Hat, Inc.
@@ -7,13 +9,15 @@
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
 
 import os
 import logging
 
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from unittest import skipUnless
 
 
 NUMPY_AVAILABLE = True
@@ -33,50 +37,49 @@ class IntegratorMachine(QemuSystemTest):
 
     timeout = 90
 
-    def boot_integratorcp(self):
-        kernel_url = ('https://github.com/zayac/qemu-arm/raw/master/'
-                      'arm-test/kernel/zImage.integrator')
-        kernel_hash = '0d7adba893c503267c946a3cbdc63b4b54f25468'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+    ASSET_KERNEL = Asset(
+        ('https://github.com/zayac/qemu-arm/raw/master/'
+         'arm-test/kernel/zImage.integrator'),
+        '26e7c7e8f943de785d95bd3c74d66451604a9b6a7a3d25dceb279e7548fd8e78')
+
+    ASSET_INITRD = Asset(
+        ('https://github.com/zayac/qemu-arm/raw/master/'
+         'arm-test/kernel/arm_root.img'),
+        'e187c27fb342ad148c7f33475fbed124933e0b3f4be8c74bc4f3426a4793373a')
 
-        initrd_url = ('https://github.com/zayac/qemu-arm/raw/master/'
-                      'arm-test/kernel/arm_root.img')
-        initrd_hash = 'b51e4154285bf784e017a37586428332d8c7bd8b'
-        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+    ASSET_TUXLOGO = Asset(
+        ('https://github.com/torvalds/linux/raw/v2.6.12/'
+         'drivers/video/logo/logo_linux_vga16.ppm'),
+        'b762f0d91ec018887ad1b334543c2fdf9be9fdfc87672b409211efaa3ea0ef79')
 
+    def boot_integratorcp(self):
+        kernel_path = self.ASSET_KERNEL.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
+
+        self.set_machine('integratorcp')
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_path,
                          '-initrd', initrd_path,
                          '-append', 'printk.time=0 console=ttyAMA0')
         self.vm.launch()
 
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_integratorcp_console(self):
         """
         Boots the Linux kernel and checks that the console is operational
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:integratorcp
-        :avocado: tags=device:pl011
         """
         self.boot_integratorcp()
         wait_for_console_pattern(self, 'Log in as root')
 
     @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
     @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_framebuffer_tux_logo(self):
         """
         Boot Linux and verify the Tux logo is displayed on the framebuffer.
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:integratorcp
-        :avocado: tags=device:pl110
-        :avocado: tags=device:framebuffer
         """
         screendump_path = os.path.join(self.workdir, "screendump.pbm")
-        tuxlogo_url = ('https://github.com/torvalds/linux/raw/v2.6.12/'
-                       'drivers/video/logo/logo_linux_vga16.ppm')
-        tuxlogo_hash = '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
-        tuxlogo_path = self.fetch_asset(tuxlogo_url, asset_hash=tuxlogo_hash)
+        tuxlogo_path = self.ASSET_TUXLOGO.fetch()
 
         self.boot_integratorcp()
         framebuffer_ready = 'Console: switching to colour frame buffer device'
@@ -97,3 +100,6 @@ def test_framebuffer_tux_logo(self):
         for tux_count, pt in enumerate(zip(*loc[::-1]), start=1):
             logger.debug('found Tux at position [x, y] = %s', pt)
         self.assertGreaterEqual(tux_count, cpu_count)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


