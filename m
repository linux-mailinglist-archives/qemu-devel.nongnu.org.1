Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B8C932598
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jul 2024 13:28:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgLA-00010L-Rz; Tue, 16 Jul 2024 07:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKh-0000xV-93
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:26:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKf-0003gS-2d
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721129216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ut7/B3YSWJMlNJhfuXedKJXIltv1yhmAq/VM2uBUkSM=;
 b=D5z4xl10J4d73mqDzCsvoz/Q8Cfrh6Kod6qNZR919x2OEILlCBCfVte7iPn4VJnw3CJCc3
 8bV09Ikujn1yWlM7t1HJSl+FasOn4UvPkTVaR+yy83mwSZo4YfNnOjsEDvpmlOgksZR5uz
 Mqijz+IO4uAhEAFJkXHWf+WxROd40eg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-YT5X2P7ROOOf0rRAD1LDdA-1; Tue,
 16 Jul 2024 07:26:53 -0400
X-MC-Unique: YT5X2P7ROOOf0rRAD1LDdA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E997E1944AB2; Tue, 16 Jul 2024 11:26:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 836151955F40; Tue, 16 Jul 2024 11:26:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 08/11] tests/functional: Convert some avocado tests that
 needed avocado.utils.archive
Date: Tue, 16 Jul 2024 13:26:11 +0200
Message-ID: <20240716112614.1755692-9-thuth@redhat.com>
In-Reply-To: <20240716112614.1755692-1-thuth@redhat.com>
References: <20240716112614.1755692-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Instead of using the "archive" module from avocado.utils, switch
these tests to use the new wrapper function that is based on the
"tarfile" module instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  6 ++---
 tests/functional/meson.build                  |  6 +++++
 .../test_arm_canona1100.py}                   | 21 +++++++++-------
 .../test_ppc_bamboo.py}                       | 23 ++++++++---------
 .../test_sparc64_sun4u.py}                    | 25 +++++++++++--------
 5 files changed, 46 insertions(+), 35 deletions(-)
 rename tests/{avocado/machine_arm_canona1100.py => functional/test_arm_canona1100.py} (71%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_bamboo.py => functional/test_ppc_bamboo.py} (75%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_sparc64_sun4u.py => functional/test_sparc64_sun4u.py} (60%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 533e22b548..025227954c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -730,7 +730,7 @@ S: Odd Fixes
 F: include/hw/arm/digic.h
 F: hw/*/digic*
 F: include/hw/*/digic*
-F: tests/avocado/machine_arm_canona1100.py
+F: tests/functional/test_arm_canona1100.py
 F: docs/system/arm/digic.rst
 
 Goldfish RTC
@@ -1425,7 +1425,7 @@ L: qemu-ppc@nongnu.org
 S: Orphan
 F: hw/ppc/ppc440_bamboo.c
 F: hw/pci-host/ppc4xx_pci.c
-F: tests/avocado/ppc_bamboo.py
+F: tests/functional/test_ppc_bamboo.py
 
 e500
 L: qemu-ppc@nongnu.org
@@ -1711,7 +1711,7 @@ F: include/hw/pci-host/sabre.h
 F: hw/pci-bridge/simba.c
 F: include/hw/pci-bridge/simba.h
 F: pc-bios/openbios-sparc64
-F: tests/avocado/machine_sparc64_sun4u.py
+F: tests/functional/test_sparc64_sun4u.py
 
 Sun4v
 M: Artyom Tarasenko <atar4qemu@gmail.com>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 947f9ac74f..c8fc9f6c07 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -22,6 +22,7 @@ tests_generic = [
 ]
 
 tests_arm_thorough = [
+  'arm_canona1100',
   'arm_n8x0',
 ]
 
@@ -43,6 +44,11 @@ tests_ppc_quick = [
 
 tests_ppc_thorough = [
   'ppc_405',
+  'ppc_bamboo',
+]
+
+tests_sparc64_thorough = [
+  'sparc64_sun4u',
 ]
 
 tests_x86_64_quick = [
diff --git a/tests/avocado/machine_arm_canona1100.py b/tests/functional/test_arm_canona1100.py
old mode 100644
new mode 100755
similarity index 71%
rename from tests/avocado/machine_arm_canona1100.py
rename to tests/functional/test_arm_canona1100.py
index a42d8b0f2b..de6169f2af
--- a/tests/avocado/machine_arm_canona1100.py
+++ b/tests/functional/test_arm_canona1100.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots the canon-a1100 machine with firmware
 #
 # Copyright (c) 2020 Red Hat, Inc.
@@ -8,9 +10,9 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import archive
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import archive_extract
 
 class CanonA1100Machine(QemuSystemTest):
     """Boots the barebox firmware and checks that the console is operational"""
@@ -18,18 +20,19 @@ class CanonA1100Machine(QemuSystemTest):
     timeout = 90
 
     def test_arm_canona1100(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:canon-a1100
-        :avocado: tags=device:pflash_cfi02
-        """
+        self.set_machine('canon-a1100')
+
         tar_url = ('https://qemu-advcal.gitlab.io'
                    '/qac-best-of-multiarch/download/day18.tar.xz')
         tar_hash = '068b5fc4242b29381acee94713509f8a876e9db6'
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        archive.extract(file_path, self.workdir)
+        archive_extract(file_path, dest_dir=self.workdir,
+                        member="day18/barebox.canon-a1100.bin")
         self.vm.set_console()
         self.vm.add_args('-bios',
                          self.workdir + '/day18/barebox.canon-a1100.bin')
         self.vm.launch()
         wait_for_console_pattern(self, 'running /env/bin/init')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/ppc_bamboo.py b/tests/functional/test_ppc_bamboo.py
old mode 100644
new mode 100755
similarity index 75%
rename from tests/avocado/ppc_bamboo.py
rename to tests/functional/test_ppc_bamboo.py
index a81be3d608..652b31e95a
--- a/tests/avocado/ppc_bamboo.py
+++ b/tests/functional/test_ppc_bamboo.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Test that Linux kernel boots on the ppc bamboo board and check the console
 #
 # Copyright (c) 2021 Red Hat
@@ -5,30 +7,24 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado.utils import archive
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-from avocado_qemu import exec_command_and_wait_for_pattern
+from qemu_test.utils import archive_extract
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
 
 class BambooMachine(QemuSystemTest):
 
     timeout = 90
 
     def test_ppc_bamboo(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:bamboo
-        :avocado: tags=cpu:440epb
-        :avocado: tags=device:rtl8139
-        :avocado: tags=accel:tcg
-        """
+        self.set_machine('bamboo')
         self.require_accelerator("tcg")
         self.require_netdev('user')
         tar_url = ('http://landley.net/aboriginal/downloads/binaries/'
                    'system-image-powerpc-440fp.tar.gz')
         tar_hash = '53e5f16414b195b82d2c70272f81c2eedb39bad9'
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        archive.extract(file_path, self.workdir)
+        archive_extract(file_path, self.workdir)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.workdir +
                                    '/system-image-powerpc-440fp/linux',
@@ -40,3 +36,6 @@ def test_ppc_bamboo(self):
         exec_command_and_wait_for_pattern(self, 'ping 10.0.2.2',
                                           '10.0.2.2 is alive!')
         exec_command_and_wait_for_pattern(self, 'halt', 'System Halted')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/machine_sparc64_sun4u.py b/tests/functional/test_sparc64_sun4u.py
old mode 100644
new mode 100755
similarity index 60%
rename from tests/avocado/machine_sparc64_sun4u.py
rename to tests/functional/test_sparc64_sun4u.py
index d333c0ae91..cd89d4a1d6
--- a/tests/avocado/machine_sparc64_sun4u.py
+++ b/tests/functional/test_sparc64_sun4u.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots a Linux kernel and checks the console
 #
 # Copyright (c) 2020 Red Hat, Inc.
@@ -10,27 +12,28 @@
 
 import os
 
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import archive
-from boot_linux_console import LinuxKernelTest
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import archive_extract
 
-class Sun4uMachine(LinuxKernelTest):
+class Sun4uMachine(QemuSystemTest):
     """Boots the Linux kernel and checks that the console is operational"""
 
     timeout = 90
 
     def test_sparc64_sun4u(self):
-        """
-        :avocado: tags=arch:sparc64
-        :avocado: tags=machine:sun4u
-        """
+        self.set_machine('sun4u')
         tar_url = ('https://qemu-advcal.gitlab.io'
                    '/qac-best-of-multiarch/download/day23.tar.xz')
         tar_hash = '142db83cd974ffadc4f75c8a5cad5bcc5722c240'
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        archive.extract(file_path, self.workdir)
+        kernel_name = 'day23/vmlinux'
+        archive_extract(file_path, self.workdir, kernel_name)
         self.vm.set_console()
-        self.vm.add_args('-kernel', self.workdir + '/day23/vmlinux',
-                         '-append', self.KERNEL_COMMON_COMMAND_LINE)
+        self.vm.add_args('-kernel', os.path.join(self.workdir, kernel_name),
+                         '-append', 'printk.time=0')
         self.vm.launch()
         wait_for_console_pattern(self, 'Starting logging: OK')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


