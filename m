Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4660A9737AE
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Sep 2024 14:40:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so08U-00043t-Ez; Tue, 10 Sep 2024 08:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so08J-0002rM-CT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so08A-0005Ak-0i
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725971879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUPlNmswNBNwGGbdP+FKNLR2RiuR+lcerOVxdPuz66Y=;
 b=gwkQbNERtwFEKi9sHs0dGnFSp+n9lst6gNMC9iKFLQfp+Zki0kjDJYHrYunvRvZR2Z5ETl
 H5Rv2laj8YtLSgWRMFn8FfSd8rNS2Q79RDkR7lMsbP/Yu6Xv82U4WoJfTN2eHX7se94hIv
 7PAqcHHoRb/55WYR7NP1yP13MLoTyU0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-yMBvp3hEM4qbzdzdTr8eWw-1; Tue,
 10 Sep 2024 08:37:56 -0400
X-MC-Unique: yMBvp3hEM4qbzdzdTr8eWw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A44C197701A; Tue, 10 Sep 2024 12:37:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.120])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C66519560AB; Tue, 10 Sep 2024 12:37:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/22] tests/functional: Convert mips32el Malta YAMON avocado
 test
Date: Tue, 10 Sep 2024 14:37:13 +0200
Message-ID: <20240910123726.182975-13-thuth@redhat.com>
In-Reply-To: <20240910123726.182975-1-thuth@redhat.com>
References: <20240910123726.182975-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Straight forward conversion using the Python standard zipfile
module instead of avocado.utils package. Update the SHA1 hashes
to SHA256 hashes since SHA1 should not be used anymore nowadays.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240827094905.80648-6-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240906180549.792832-7-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                             |  2 +-
 tests/avocado/machine_mips_malta.py     | 54 -------------------------
 tests/functional/meson.build            |  4 ++
 tests/functional/test_mips64el_malta.py | 16 ++++----
 tests/functional/test_mipsel_malta.py   | 47 +++++++++++++++++++++
 5 files changed, 61 insertions(+), 62 deletions(-)
 delete mode 100644 tests/avocado/machine_mips_malta.py
 create mode 100755 tests/functional/test_mipsel_malta.py

diff --git a/MAINTAINERS b/MAINTAINERS
index dcf3823169..2f76098230 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1370,7 +1370,7 @@ F: hw/mips/malta.c
 F: hw/pci-host/gt64120.c
 F: include/hw/southbridge/piix.h
 F: tests/avocado/linux_ssh_mips_malta.py
-F: tests/avocado/machine_mips_malta.py
+F: tests/functional/test_mipsel_malta.py
 F: tests/functional/test_mips64el_malta.py
 
 Mipssim
diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
deleted file mode 100644
index 05c64e18c4..0000000000
--- a/tests/avocado/machine_mips_malta.py
+++ /dev/null
@@ -1,54 +0,0 @@
-# Functional tests for the MIPS Malta board
-#
-# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or later.
-# See the COPYING file in the top-level directory.
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-
-import os
-
-from avocado.utils import archive
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import interrupt_interactive_console_until_pattern
-from avocado_qemu import wait_for_console_pattern
-
-
-class MaltaMachine(QemuSystemTest):
-
-    def do_test_yamon(self):
-        rom_url = ('https://s3-eu-west-1.amazonaws.com/'
-                   'downloads-mips/mips-downloads/'
-                   'YAMON/yamon-bin-02.22.zip')
-        rom_hash = '8da7ecddbc5312704b8b324341ee238189bde480'
-        zip_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
-
-        archive.extract(zip_path, self.workdir)
-        yamon_path = os.path.join(self.workdir, 'yamon-02.22.bin')
-
-        self.vm.set_console()
-        self.vm.add_args('-bios', yamon_path)
-        self.vm.launch()
-
-        prompt =  'YAMON>'
-        pattern = 'YAMON ROM Monitor'
-        interrupt_interactive_console_until_pattern(self, pattern, prompt)
-        wait_for_console_pattern(self, prompt)
-        self.vm.shutdown()
-
-    def test_mipsel_malta_yamon(self):
-        """
-        :avocado: tags=arch:mipsel
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        """
-        self.do_test_yamon()
-
-    def test_mips64el_malta_yamon(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:little
-        """
-        self.do_test_yamon()
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 9baf903e39..daee61ec3c 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -69,6 +69,10 @@ tests_microblazeel_system_thorough = [
   'microblazeel_s3adsp1800'
 ]
 
+tests_mipsel_system_thorough = [
+  'mipsel_malta',
+]
+
 tests_mips64el_system_quick = [
   'mips64el_fuloong2e',
 ]
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index 1be93d7ff0..6c6355b131 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -30,7 +30,7 @@
     CV2_AVAILABLE = False
 
 
-class MaltaMachineConsole(QemuSystemTest):
+class MaltaMachineConsole(LinuxKernelTest):
 
     ASSET_KERNEL_2_63_2 = Asset(
         ('http://snapshot.debian.org/archive/debian/'
@@ -52,17 +52,17 @@ def test_mips64el_malta(self):
             ch-common-tasks.html#s-common-official
         """
         deb_path = self.ASSET_KERNEL_2_63_2.fetch()
-        kernel_path = extract_from_deb(deb_path, self.workdir,
-                                       '/boot/vmlinux-2.6.32-5-5kc-malta')
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinux-2.6.32-5-5kc-malta')
 
         self.set_machine('malta')
         self.vm.set_console()
-        kernel_command_line = KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
         self.vm.add_args('-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
-        linux_kernel_wait_for_pattern(self, console_pattern)
+        self.wait_for_console_pattern(console_pattern)
 
     ASSET_KERNEL_3_19_3 = Asset(
         ('https://github.com/philmd/qemu-testing-blob/'
@@ -85,7 +85,7 @@ def test_mips64el_malta_5KEc_cpio(self):
 
         self.set_machine('malta')
         self.vm.set_console()
-        kernel_command_line = (KERNEL_COMMON_COMMAND_LINE
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
                                + 'console=ttyS0 console=tty '
                                + 'rdinit=/sbin/init noreboot')
         self.vm.add_args('-cpu', '5KEc',
@@ -94,7 +94,7 @@ def test_mips64el_malta_5KEc_cpio(self):
                          '-append', kernel_command_line,
                          '-no-reboot')
         self.vm.launch()
-        linux_kernel_wait_for_pattern(self, 'Boot successful.')
+        self.wait_for_console_pattern('Boot successful.')
 
         exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
                                                 'MIPS 5KE')
@@ -180,5 +180,7 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         self.do_test_i6400_framebuffer_logo(8)
 
 
+from test_mipsel_malta import MaltaMachineYAMON
+
 if __name__ == '__main__':
     LinuxKernelTest.main()
diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/test_mipsel_malta.py
new file mode 100755
index 0000000000..f31f96b012
--- /dev/null
+++ b/tests/functional/test_mipsel_malta.py
@@ -0,0 +1,47 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the little-endian 32-bit MIPS Malta board
+#
+# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import interrupt_interactive_console_until_pattern
+from qemu_test import wait_for_console_pattern
+from zipfile import ZipFile
+
+
+class MaltaMachineYAMON(QemuSystemTest):
+
+    ASSET_YAMON_ROM = Asset(
+        ('https://s3-eu-west-1.amazonaws.com/downloads-mips/mips-downloads/'
+         'YAMON/yamon-bin-02.22.zip'),
+        'eef86f0eed0ef554f041dcd47b87eebea0e6f9f1184ed31f7e9e8b4a803860ab')
+
+    def test_mipsel_malta_yamon(self):
+        yamon_bin = 'yamon-02.22.bin'
+        zip_path = self.ASSET_YAMON_ROM.fetch()
+        with ZipFile(zip_path, 'r') as zf:
+            zf.extract(yamon_bin, path=self.workdir)
+        yamon_path = os.path.join(self.workdir, yamon_bin)
+
+        self.set_machine('malta')
+        self.vm.set_console()
+        self.vm.add_args('-bios', yamon_path)
+        self.vm.launch()
+
+        prompt =  'YAMON>'
+        pattern = 'YAMON ROM Monitor'
+        interrupt_interactive_console_until_pattern(self, pattern, prompt)
+        wait_for_console_pattern(self, prompt)
+        self.vm.shutdown()
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


