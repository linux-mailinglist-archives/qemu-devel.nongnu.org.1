Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F029737C9
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Sep 2024 14:41:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so08X-0004bD-Fd; Tue, 10 Sep 2024 08:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so08Q-0003aA-2Q
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so08K-0005BJ-8y
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725971886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMdOD3sPPSy1EnK30Zx5hlrtQNyWnAmBF/Lo0F4+p3A=;
 b=E3MTa6qlfFLkyRSO3S1kqYIgQXsNddsSy5Pqf9pSrMb1gFPIetFcgOlQ/kKCt8Req09077
 3i4gWpR3KU4dBv/VZ6bdxrfSR2/PD1SfG9bBylR0AJPjV72M+fUAZGsbJ+ytZNRT1InrDi
 GiKmzNr4A2X1TsHBbnmVf29CHomr7tA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-x_4KqeQMMAu9h3iKLDM80Q-1; Tue,
 10 Sep 2024 08:38:03 -0400
X-MC-Unique: x_4KqeQMMAu9h3iKLDM80Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52EC41955D44; Tue, 10 Sep 2024 12:38:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.120])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16E9419560AB; Tue, 10 Sep 2024 12:37:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/22] tests/functional: Convert mips32eb 4Kc Malta avocado
 tests
Date: Tue, 10 Sep 2024 14:37:15 +0200
Message-ID: <20240910123726.182975-15-thuth@redhat.com>
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

Straight forward conversion. Update the SHA1 hashes to
SHA256 hashes since SHA1 should not be used anymore nowadays.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240827094905.80648-8-philmd@linaro.org>
[thuth: Use LinuxKernelTest class]
Message-ID: <20240906180549.792832-9-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                         |  1 +
 tests/avocado/boot_linux_console.py | 63 ----------------------
 tests/functional/meson.build        |  4 ++
 tests/functional/test_mips_malta.py | 81 +++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 63 deletions(-)
 create mode 100755 tests/functional/test_mips_malta.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f76098230..6e0044ab58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1370,6 +1370,7 @@ F: hw/mips/malta.c
 F: hw/pci-host/gt64120.c
 F: include/hw/southbridge/piix.h
 F: tests/avocado/linux_ssh_mips_malta.py
+F: tests/functional/test_mips_malta.py
 F: tests/functional/test_mipsel_malta.py
 F: tests/functional/test_mips64el_malta.py
 
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 34f4abadd0..e3e4576099 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -116,69 +116,6 @@ def test_x86_64_pc(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    def test_mips_malta(self):
-        """
-        :avocado: tags=arch:mips
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:big
-        """
-        deb_url = ('http://snapshot.debian.org/archive/debian/'
-                   '20130217T032700Z/pool/main/l/linux-2.6/'
-                   'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb')
-        deb_hash = 'a8cfc28ad8f45f54811fc6cf74fc43ffcfe0ba04'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-2.6.32-5-4kc-malta')
-
-        self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
-        self.vm.add_args('-kernel', kernel_path,
-                         '-append', kernel_command_line)
-        self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
-        self.wait_for_console_pattern(console_pattern)
-
-    def test_mips_malta_cpio(self):
-        """
-        :avocado: tags=arch:mips
-        :avocado: tags=machine:malta
-        :avocado: tags=endian:big
-        """
-        deb_url = ('http://snapshot.debian.org/archive/debian/'
-                   '20160601T041800Z/pool/main/l/linux/'
-                   'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb')
-        deb_hash = 'a3c84f3e88b54e06107d65a410d1d1e8e0f340f8'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-4.5.0-2-4kc-malta')
-        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
-                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
-                      'mips/rootfs.cpio.gz')
-        initrd_hash = 'bf806e17009360a866bf537f6de66590de349a99'
-        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
-        initrd_path = self.workdir + "rootfs.cpio"
-        archive.gzip_uncompress(initrd_path_gz, initrd_path)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
-                               + 'console=ttyS0 console=tty '
-                               + 'rdinit=/sbin/init noreboot')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-initrd', initrd_path,
-                         '-append', kernel_command_line,
-                         '-no-reboot')
-        self.vm.launch()
-        self.wait_for_console_pattern('Boot successful.')
-
-        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
-                                                'BogoMIPS')
-        exec_command_and_wait_for_pattern(self, 'uname -a',
-                                                'Debian')
-        exec_command_and_wait_for_pattern(self, 'reboot',
-                                                'reboot: Restarting system')
-        # Wait for VM to shut down gracefully
-        self.vm.wait()
-
     def test_aarch64_xlnx_versal_virt(self):
         """
         :avocado: tags=arch:aarch64
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index daee61ec3c..eb2de2a8fd 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -69,6 +69,10 @@ tests_microblazeel_system_thorough = [
   'microblazeel_s3adsp1800'
 ]
 
+tests_mips_system_thorough = [
+  'mips_malta',
+]
+
 tests_mipsel_system_thorough = [
   'mipsel_malta',
 ]
diff --git a/tests/functional/test_mips_malta.py b/tests/functional/test_mips_malta.py
new file mode 100755
index 0000000000..a012081382
--- /dev/null
+++ b/tests/functional/test_mips_malta.py
@@ -0,0 +1,81 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the little-endian 32-bit MIPS Malta board
+#
+# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test.utils import gzip_uncompress
+
+
+class MaltaMachineConsole(LinuxKernelTest):
+
+    ASSET_KERNEL_2_63_2 = Asset(
+        ('http://snapshot.debian.org/archive/debian/'
+         '20130217T032700Z/pool/main/l/linux-2.6/'
+         'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb'),
+        '16ca524148afb0626f483163e5edf352bc1ab0e4fc7b9f9d473252762f2c7a43')
+
+    def test_mips_malta(self):
+        deb_path = self.ASSET_KERNEL_2_63_2.fetch()
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinux-2.6.32-5-4kc-malta')
+
+        self.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
+
+    ASSET_KERNEL_4_5_0 = Asset(
+        ('http://snapshot.debian.org/archive/debian/'
+         '20160601T041800Z/pool/main/l/linux/'
+         'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb'),
+        '526b17d5889840888b76fc2c36a0ebde182c9b1410a3a1e68203c3b160eb2027')
+
+    ASSET_INITRD = Asset(
+        ('https://github.com/groeck/linux-build-test/raw/'
+         '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
+         'mips/rootfs.cpio.gz'),
+        'dcfe3a7fe3200da3a00d176b95caaa086495eb158f2bff64afc67d7e1eb2cddc')
+
+    def test_mips_malta_cpio(self):
+        deb_path = self.ASSET_KERNEL_4_5_0.fetch()
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinux-4.5.0-2-4kc-malta')
+        initrd_path_gz = self.ASSET_INITRD.fetch()
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 console=tty '
+                               + 'rdinit=/sbin/init noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'BogoMIPS')
+        exec_command_and_wait_for_pattern(self, 'uname -a',
+                                                'Debian')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.46.0


