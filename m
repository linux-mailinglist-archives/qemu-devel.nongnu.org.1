Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADACA87F14
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Apr 2025 13:32:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4I22-0003YS-Na; Mon, 14 Apr 2025 07:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4I1c-0003UV-Dx
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 07:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4I1Y-0003u5-Dp
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 07:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744630247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8DOSS9IVMvZ8b33XF5KfvbMXvheoSGL306thDeeG1kM=;
 b=WDxN3VjfNyKwr21vuzPbT0KW7dnY0DF/bmGfyx+nmRlXeWNjqkWz7GC3wtpdUsrjVeZISq
 0zcuRreEoJdoKctNGeBJvZ5HL23H3UNSH6hTutfumS8vKMN8L3tVZEEeW2m/6BPH9L+Qgf
 VSQ86UsYIvhW5rqeRsLvuG8PPnMHm64=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-H1yWFk3QPgOZ5oQzJ406yg-1; Mon,
 14 Apr 2025 07:30:41 -0400
X-MC-Unique: H1yWFk3QPgOZ5oQzJ406yg-1
X-Mimecast-MFC-AGG-ID: H1yWFk3QPgOZ5oQzJ406yg_1744630241
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35F601955BC5; Mon, 14 Apr 2025 11:30:40 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EFEB41955BC1; Mon, 14 Apr 2025 11:30:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH v2 03/15] tests/functional: Convert reverse_debugging tests to
 the functional framework
Date: Mon, 14 Apr 2025 13:30:17 +0200
Message-ID: <20250414113031.151105-4-thuth@redhat.com>
In-Reply-To: <20250414113031.151105-1-thuth@redhat.com>
References: <20250414113031.151105-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Thomas Huth <thuth@redhat.com>

These tests are using the gdb-related library functions from the
Avocado framework which we don't have in the functional framework
yet. So for the time being, keep those imports and skip the test
if the Avocado framework is not installed on the host.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |   2 +-
 tests/functional/meson.build                  |   4 +
 .../reverse_debugging.py                      | 114 +++---------------
 .../functional/test_aarch64_reverse_debug.py  |  38 ++++++
 tests/functional/test_ppc64_reverse_debug.py  |  41 +++++++
 tests/functional/test_x86_64_reverse_debug.py |  36 ++++++
 6 files changed, 139 insertions(+), 96 deletions(-)
 rename tests/{avocado => functional}/reverse_debugging.py (66%)
 create mode 100755 tests/functional/test_aarch64_reverse_debug.py
 create mode 100755 tests/functional/test_ppc64_reverse_debug.py
 create mode 100755 tests/functional/test_x86_64_reverse_debug.py

diff --git a/MAINTAINERS b/MAINTAINERS
index d54b5578f88..af1d847f8ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3671,7 +3671,7 @@ F: docs/system/replay.rst
 F: stubs/replay.c
 F: tests/avocado/replay_kernel.py
 F: tests/avocado/replay_linux.py
-F: tests/avocado/reverse_debugging.py
+F: tests/functional/*reverse_debug*.py
 F: tests/functional/*replay*.py
 F: qapi/replay.json
 
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 0f8be30fe27..7b0f4ab0b1d 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -13,6 +13,7 @@ endif
 test_timeouts = {
   'aarch64_aspeed' : 600,
   'aarch64_raspi4' : 480,
+  'aarch64_reverse_debug' : 180,
   'aarch64_rme_virt' : 1200,
   'aarch64_rme_sbsaref' : 1200,
   'aarch64_sbsaref_alpine' : 1200,
@@ -78,6 +79,7 @@ tests_aarch64_system_thorough = [
   'aarch64_raspi3',
   'aarch64_raspi4',
   'aarch64_replay',
+  'aarch64_reverse_debug',
   'aarch64_rme_virt',
   'aarch64_rme_sbsaref',
   'aarch64_sbsaref',
@@ -229,6 +231,7 @@ tests_ppc64_system_thorough = [
   'ppc64_powernv',
   'ppc64_pseries',
   'ppc64_replay',
+  'ppc64_reverse_debug',
   'ppc64_tuxrun',
   'ppc64_mac99',
 ]
@@ -311,6 +314,7 @@ tests_x86_64_system_thorough = [
   'x86_64_hotplug_cpu',
   'x86_64_kvm_xen',
   'x86_64_replay',
+  'x86_64_reverse_debug',
   'x86_64_tuxrun',
 ]
 
diff --git a/tests/avocado/reverse_debugging.py b/tests/functional/reverse_debugging.py
similarity index 66%
rename from tests/avocado/reverse_debugging.py
rename to tests/functional/reverse_debugging.py
index f24287cd0a0..f9a1d395f1d 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -1,5 +1,7 @@
 # Reverse debugging test
 #
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
 # Copyright (c) 2020 ISP RAS
 #
 # Author:
@@ -10,14 +12,9 @@
 import os
 import logging
 
-from avocado import skipUnless
-from avocado_qemu import BUILD_DIR
-from avocado.utils import datadrainer
-from avocado.utils import gdb
-from avocado.utils import process
-from avocado.utils.network.ports import find_free_port
-from avocado.utils.path import find_command
-from boot_linux_console import LinuxKernelTest
+from qemu_test import LinuxKernelTest, get_qemu_img
+from qemu_test.ports import Ports
+
 
 class ReverseDebugging(LinuxKernelTest):
     """
@@ -36,8 +33,10 @@ class ReverseDebugging(LinuxKernelTest):
     endian_is_le = True
 
     def run_vm(self, record, shift, args, replay_path, image_path, port):
+        from avocado.utils import datadrainer
+
         logger = logging.getLogger('replay')
-        vm = self.get_vm()
+        vm = self.get_vm(name='record' if record else 'replay')
         vm.set_console()
         if record:
             logger.info('recording the execution...')
@@ -100,25 +99,25 @@ def vm_get_icount(vm):
         return vm.qmp('query-replay')['return']['icount']
 
     def reverse_debugging(self, shift=7, args=None):
+        from avocado.utils import gdb
+        from avocado.utils import process
+
         logger = logging.getLogger('replay')
 
         # create qcow2 for snapshots
         logger.info('creating qcow2 image for VM snapshots')
         image_path = os.path.join(self.workdir, 'disk.qcow2')
-        qemu_img = os.path.join(BUILD_DIR, 'qemu-img')
-        if not os.path.exists(qemu_img):
-            qemu_img = find_command('qemu-img', False)
-        if qemu_img is False:
-            self.cancel('Could not find "qemu-img", which is required to '
-                        'create the temporary qcow2 image')
+        qemu_img = get_qemu_img(self)
+        if qemu_img is None:
+            self.skipTest('Could not find "qemu-img", which is required to '
+                          'create the temporary qcow2 image')
         cmd = '%s create -f qcow2 %s 128M' % (qemu_img, image_path)
         process.run(cmd)
 
         replay_path = os.path.join(self.workdir, 'replay.bin')
-        port = find_free_port()
 
         # record the log
-        vm = self.run_vm(True, shift, args, replay_path, image_path, port)
+        vm = self.run_vm(True, shift, args, replay_path, image_path, -1)
         while self.vm_get_icount(vm) <= self.STEPS:
             pass
         last_icount = self.vm_get_icount(vm)
@@ -127,7 +126,9 @@ def reverse_debugging(self, shift=7, args=None):
         logger.info("recorded log with %s+ steps" % last_icount)
 
         # replay and run debug commands
-        vm = self.run_vm(False, shift, args, replay_path, image_path, port)
+        with Ports() as ports:
+            port = ports.find_free_port()
+            vm = self.run_vm(False, shift, args, replay_path, image_path, port)
         logger.info('connecting to gdbstub')
         g = gdb.GDBRemote('127.0.0.1', port, False, False)
         g.connect()
@@ -193,80 +194,3 @@ def reverse_debugging(self, shift=7, args=None):
 
         logger.info('exiting gdb and qemu')
         vm.shutdown()
-
-class ReverseDebugging_X86_64(ReverseDebugging):
-    """
-    :avocado: tags=accel:tcg
-    """
-
-    REG_PC = 0x10
-    REG_CS = 0x12
-    def get_pc(self, g):
-        return self.get_reg_le(g, self.REG_PC) \
-            + self.get_reg_le(g, self.REG_CS) * 0x10
-
-    # unidentified gitlab timeout problem
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-    def test_x86_64_pc(self):
-        """
-        :avocado: tags=arch:x86_64
-        :avocado: tags=machine:pc
-        """
-        # start with BIOS only
-        self.reverse_debugging()
-
-class ReverseDebugging_AArch64(ReverseDebugging):
-    """
-    :avocado: tags=accel:tcg
-    """
-
-    REG_PC = 32
-
-    # unidentified gitlab timeout problem
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-    def test_aarch64_virt(self):
-        """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=machine:virt
-        :avocado: tags=cpu:cortex-a53
-        """
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
-                      '/linux/releases/29/Everything/aarch64/os/images/pxeboot'
-                      '/vmlinuz')
-        kernel_hash = '8c73e469fc6ea06a58dc83a628fc695b693b8493'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        self.reverse_debugging(
-            args=('-kernel', kernel_path))
-
-class ReverseDebugging_ppc64(ReverseDebugging):
-    """
-    :avocado: tags=accel:tcg
-    """
-
-    REG_PC = 0x40
-
-    # unidentified gitlab timeout problem
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-    def test_ppc64_pseries(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:pseries
-        :avocado: tags=flaky
-        """
-        # SLOF branches back to its entry point, which causes this test
-        # to take the 'hit a breakpoint again' path. That's not a problem,
-        # just slightly different than the other machines.
-        self.endian_is_le = False
-        self.reverse_debugging()
-
-    # See https://gitlab.com/qemu-project/qemu/-/issues/1992
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-    def test_ppc64_powernv(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:powernv
-        :avocado: tags=flaky
-        """
-        self.endian_is_le = False
-        self.reverse_debugging()
diff --git a/tests/functional/test_aarch64_reverse_debug.py b/tests/functional/test_aarch64_reverse_debug.py
new file mode 100755
index 00000000000..58d45328350
--- /dev/null
+++ b/tests/functional/test_aarch64_reverse_debug.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reverse debugging test
+#
+# Copyright (c) 2020 ISP RAS
+#
+# Author:
+#  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from qemu_test import Asset, skipIfMissingImports, skipFlakyTest
+from reverse_debugging import ReverseDebugging
+
+
+@skipIfMissingImports('avocado.utils')
+class ReverseDebugging_AArch64(ReverseDebugging):
+
+    REG_PC = 32
+
+    KERNEL_ASSET = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
+         'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
+        '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7')
+
+    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2921")
+    def test_aarch64_virt(self):
+        self.set_machine('virt')
+        self.cpu = 'cortex-a53'
+        kernel_path = self.KERNEL_ASSET.fetch()
+        self.reverse_debugging(args=('-kernel', kernel_path))
+
+
+if __name__ == '__main__':
+    ReverseDebugging.main()
diff --git a/tests/functional/test_ppc64_reverse_debug.py b/tests/functional/test_ppc64_reverse_debug.py
new file mode 100755
index 00000000000..5931adef5a9
--- /dev/null
+++ b/tests/functional/test_ppc64_reverse_debug.py
@@ -0,0 +1,41 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reverse debugging test
+#
+# Copyright (c) 2020 ISP RAS
+#
+# Author:
+#  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from qemu_test import skipIfMissingImports, skipFlakyTest
+from reverse_debugging import ReverseDebugging
+
+
+@skipIfMissingImports('avocado.utils')
+class ReverseDebugging_ppc64(ReverseDebugging):
+
+    REG_PC = 0x40
+
+    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
+    def test_ppc64_pseries(self):
+        self.set_machine('pseries')
+        # SLOF branches back to its entry point, which causes this test
+        # to take the 'hit a breakpoint again' path. That's not a problem,
+        # just slightly different than the other machines.
+        self.endian_is_le = False
+        self.reverse_debugging()
+
+    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
+    def test_ppc64_powernv(self):
+        self.set_machine('powernv')
+        self.endian_is_le = False
+        self.reverse_debugging()
+
+
+if __name__ == '__main__':
+    ReverseDebugging.main()
diff --git a/tests/functional/test_x86_64_reverse_debug.py b/tests/functional/test_x86_64_reverse_debug.py
new file mode 100755
index 00000000000..d713e91e144
--- /dev/null
+++ b/tests/functional/test_x86_64_reverse_debug.py
@@ -0,0 +1,36 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reverse debugging test
+#
+# Copyright (c) 2020 ISP RAS
+#
+# Author:
+#  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from qemu_test import skipIfMissingImports, skipFlakyTest
+from reverse_debugging import ReverseDebugging
+
+
+@skipIfMissingImports('avocado.utils')
+class ReverseDebugging_X86_64(ReverseDebugging):
+
+    REG_PC = 0x10
+    REG_CS = 0x12
+    def get_pc(self, g):
+        return self.get_reg_le(g, self.REG_PC) \
+            + self.get_reg_le(g, self.REG_CS) * 0x10
+
+    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2922")
+    def test_x86_64_pc(self):
+        self.set_machine('pc')
+        # start with BIOS only
+        self.reverse_debugging()
+
+
+if __name__ == '__main__':
+    ReverseDebugging.main()
-- 
2.49.0


