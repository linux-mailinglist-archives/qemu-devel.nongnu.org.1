Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8602496FAA0
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 20:09:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smdLf-0007U6-GZ; Fri, 06 Sep 2024 14:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdLc-0007Ip-50
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdLZ-00052y-VV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725645973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ub4EdjOKYt/jlou1XjJlBkMdWzBzXKOMezJwizt4hm8=;
 b=EhhrFc9Y18Rcf5klZmVEL8VgBxNaF1eugpeENe3S47dssJI5b+UytmdhTCmF1D2xPDUGQH
 LV6pg4WqMg/Y4KYQrJ4vilmxFSoSA483+N8cd4VpFoPSt3W/Vi6audqroxP0G+NgDOQ2bN
 LNY+oOqA7k3u4mrtCKeNlDdna1H2tY8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-62049y95NEuaGdx8686qLw-1; Fri,
 06 Sep 2024 14:06:10 -0400
X-MC-Unique: 62049y95NEuaGdx8686qLw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC7DB1944AB5; Fri,  6 Sep 2024 18:06:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A1F119560AF; Fri,  6 Sep 2024 18:06:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH 04/14] tests/functional: Convert mips64el I6400 Malta avocado
 tests
Date: Fri,  6 Sep 2024 20:05:39 +0200
Message-ID: <20240906180549.792832-5-thuth@redhat.com>
In-Reply-To: <20240906180549.792832-1-thuth@redhat.com>
References: <20240906180549.792832-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240827094905.80648-4-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                             |   1 +
 tests/avocado/machine_mips_malta.py     | 108 ------------------------
 tests/functional/meson.build            |   1 +
 tests/functional/test_mips64el_malta.py | 108 ++++++++++++++++++++++++
 4 files changed, 110 insertions(+), 108 deletions(-)
 create mode 100755 tests/functional/test_mips64el_malta.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a88c2c3467..7aa17574aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1371,6 +1371,7 @@ F: hw/pci-host/gt64120.c
 F: include/hw/southbridge/piix.h
 F: tests/avocado/linux_ssh_mips_malta.py
 F: tests/avocado/machine_mips_malta.py
+F: tests/functional/test_mips64el_malta.py
 
 Mipssim
 R: Aleksandar Rikalo <arikalo@gmail.com>
diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
index 07a80633b5..05c64e18c4 100644
--- a/tests/avocado/machine_mips_malta.py
+++ b/tests/avocado/machine_mips_malta.py
@@ -8,121 +8,13 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import os
-import gzip
-import logging
 
-from avocado import skipUnless
-from avocado import skipUnless
 from avocado.utils import archive
 from avocado_qemu import QemuSystemTest
-from avocado_qemu import exec_command_and_wait_for_pattern
 from avocado_qemu import interrupt_interactive_console_until_pattern
 from avocado_qemu import wait_for_console_pattern
 
 
-NUMPY_AVAILABLE = True
-try:
-    import numpy as np
-except ImportError:
-    NUMPY_AVAILABLE = False
-
-CV2_AVAILABLE = True
-try:
-    import cv2
-except ImportError:
-    CV2_AVAILABLE = False
-
-
-@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
-@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
-class MaltaMachineFramebuffer(QemuSystemTest):
-
-    timeout = 30
-
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
-
-    def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
-        """
-        Boot Linux kernel and check Tux logo is displayed on the framebuffer.
-        """
-        screendump_path = os.path.join(self.workdir, 'screendump.pbm')
-
-        kernel_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
-                      'a5966ca4b5/mips/malta/mips64el/'
-                      'vmlinux-4.7.0-rc1.I6400.gz')
-        kernel_hash = '096f50c377ec5072e6a366943324622c312045f6'
-        kernel_path_gz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        kernel_path = self.workdir + "vmlinux"
-        archive.gzip_uncompress(kernel_path_gz, kernel_path)
-
-        tuxlogo_url = ('https://github.com/torvalds/linux/raw/v2.6.12/'
-                       'drivers/video/logo/logo_linux_vga16.ppm')
-        tuxlogo_hash = '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
-        tuxlogo_path = self.fetch_asset(tuxlogo_url, asset_hash=tuxlogo_hash)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'clocksource=GIC console=tty0 console=ttyS0')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-smp', '%u' % cpu_cores_count,
-                         '-vga', 'std',
-                         '-append', kernel_command_line)
-        self.vm.launch()
-        framebuffer_ready = 'Console: switching to colour frame buffer device'
-        wait_for_console_pattern(self, framebuffer_ready,
-                                 failure_message='Kernel panic - not syncing')
-        self.vm.cmd('human-monitor-command', command_line='stop')
-        self.vm.cmd('human-monitor-command',
-                    command_line='screendump %s' % screendump_path)
-        logger = logging.getLogger('framebuffer')
-
-        match_threshold = 0.95
-        screendump_bgr = cv2.imread(screendump_path, cv2.IMREAD_COLOR)
-        tuxlogo_bgr = cv2.imread(tuxlogo_path, cv2.IMREAD_COLOR)
-        result = cv2.matchTemplate(screendump_bgr, tuxlogo_bgr,
-                                   cv2.TM_CCOEFF_NORMED)
-        loc = np.where(result >= match_threshold)
-        tuxlogo_count = 0
-        h, w = tuxlogo_bgr.shape[:2]
-        debug_png = os.getenv('AVOCADO_CV2_SCREENDUMP_PNG_PATH')
-        for tuxlogo_count, pt in enumerate(zip(*loc[::-1]), start=1):
-            logger.debug('found Tux at position (x, y) = %s', pt)
-            cv2.rectangle(screendump_bgr, pt,
-                          (pt[0] + w, pt[1] + h), (0, 0, 255), 2)
-        if debug_png:
-            cv2.imwrite(debug_png, screendump_bgr)
-        self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
-
-    def test_mips_malta_i6400_framebuffer_logo_1core(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        :avocado: tags=cpu:I6400
-        """
-        self.do_test_i6400_framebuffer_logo(1)
-
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-    def test_mips_malta_i6400_framebuffer_logo_7cores(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        :avocado: tags=cpu:I6400
-        :avocado: tags=mips:smp
-        :avocado: tags=flaky
-        """
-        self.do_test_i6400_framebuffer_logo(7)
-
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-    def test_mips_malta_i6400_framebuffer_logo_8cores(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        :avocado: tags=cpu:I6400
-        :avocado: tags=mips:smp
-        :avocado: tags=flaky
-        """
-        self.do_test_i6400_framebuffer_logo(8)
-
 class MaltaMachine(QemuSystemTest):
 
     def do_test_yamon(self):
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index c6bb345d2c..9baf903e39 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -75,6 +75,7 @@ tests_mips64el_system_quick = [
 
 tests_mips64el_system_thorough = [
   'mips64el_loongson3v',
+  'mips64el_malta',
 ]
 
 tests_ppc_system_quick = [
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
new file mode 100755
index 0000000000..0c4e9a00ef
--- /dev/null
+++ b/tests/functional/test_mips64el_malta.py
@@ -0,0 +1,108 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the little-endian 64-bit MIPS Malta board
+#
+# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import logging
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test.utils import gzip_uncompress
+from unittest import skipUnless
+
+NUMPY_AVAILABLE = True
+try:
+    import numpy as np
+except ImportError:
+    NUMPY_AVAILABLE = False
+
+CV2_AVAILABLE = True
+try:
+    import cv2
+except ImportError:
+    CV2_AVAILABLE = False
+
+
+@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
+class MaltaMachineFramebuffer(LinuxKernelTest):
+
+    timeout = 30
+
+    ASSET_KERNEL_4_7_0 = Asset(
+        ('https://github.com/philmd/qemu-testing-blob/raw/a5966ca4b5/'
+         'mips/malta/mips64el/vmlinux-4.7.0-rc1.I6400.gz'),
+        '1f64efc59968a3c328672e6b10213fe574bb2308d9d2ed44e75e40be59e9fbc2')
+
+    ASSET_TUXLOGO = Asset(
+        ('https://github.com/torvalds/linux/raw/v2.6.12/'
+         'drivers/video/logo/logo_linux_vga16.ppm'),
+        'b762f0d91ec018887ad1b334543c2fdf9be9fdfc87672b409211efaa3ea0ef79')
+
+    def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
+        """
+        Boot Linux kernel and check Tux logo is displayed on the framebuffer.
+        """
+        screendump_path = os.path.join(self.workdir, 'screendump.pbm')
+
+        kernel_path_gz = self.ASSET_KERNEL_4_7_0.fetch()
+        kernel_path = self.workdir + "vmlinux"
+        gzip_uncompress(kernel_path_gz, kernel_path)
+
+        tuxlogo_path = self.ASSET_TUXLOGO.fetch()
+
+        self.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'clocksource=GIC console=tty0 console=ttyS0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-cpu', 'I6400',
+                         '-smp', '%u' % cpu_cores_count,
+                         '-vga', 'std',
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        framebuffer_ready = 'Console: switching to colour frame buffer device'
+        self.wait_for_console_pattern(framebuffer_ready)
+        self.vm.cmd('human-monitor-command', command_line='stop')
+        self.vm.cmd('human-monitor-command',
+                    command_line='screendump %s' % screendump_path)
+        logger = logging.getLogger('framebuffer')
+
+        match_threshold = 0.95
+        screendump_bgr = cv2.imread(screendump_path, cv2.IMREAD_COLOR)
+        tuxlogo_bgr = cv2.imread(tuxlogo_path, cv2.IMREAD_COLOR)
+        result = cv2.matchTemplate(screendump_bgr, tuxlogo_bgr,
+                                   cv2.TM_CCOEFF_NORMED)
+        loc = np.where(result >= match_threshold)
+        tuxlogo_count = 0
+        h, w = tuxlogo_bgr.shape[:2]
+        debug_png = os.getenv('AVOCADO_CV2_SCREENDUMP_PNG_PATH')
+        for tuxlogo_count, pt in enumerate(zip(*loc[::-1]), start=1):
+            logger.debug('found Tux at position (x, y) = %s', pt)
+            cv2.rectangle(screendump_bgr, pt,
+                          (pt[0] + w, pt[1] + h), (0, 0, 255), 2)
+        if debug_png:
+            cv2.imwrite(debug_png, screendump_bgr)
+        self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
+
+    def test_mips_malta_i6400_framebuffer_logo_1core(self):
+        self.do_test_i6400_framebuffer_logo(1)
+
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+    def test_mips_malta_i6400_framebuffer_logo_7cores(self):
+        self.do_test_i6400_framebuffer_logo(7)
+
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+    def test_mips_malta_i6400_framebuffer_logo_8cores(self):
+        self.do_test_i6400_framebuffer_logo(8)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.46.0


