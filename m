Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A229E6C12
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Dec 2024 11:26:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJVVl-0001Rh-Oq; Fri, 06 Dec 2024 05:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJVVk-0001RQ-C0
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:24:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJVVi-00049v-20
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733480673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s+im4OO3hCjJQgqD3GiQCbQKHWzu0C0Dxbxj7TZu/uQ=;
 b=Rin7AQ4YNiHcIBQl6g6SWbWxM8o/Z00t3Zbz/uTRoJDLqmKKDKnwwE5+Xye230O2g4un25
 hJ0+C5a7Yz2nTAJYwRWGoPIHpZRcssnrBTnw2EEDMqHFurrNcqE11/F11XTRvtKpsFlOdS
 kQRYYjsLbsvgZ71sXQ64YM9jjq7p9uA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-Gus4826VPUOV6GlZiaQs4w-1; Fri,
 06 Dec 2024 05:24:30 -0500
X-MC-Unique: Gus4826VPUOV6GlZiaQs4w-1
X-Mimecast-MFC-AGG-ID: Gus4826VPUOV6GlZiaQs4w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6E9D1955F39; Fri,  6 Dec 2024 10:24:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.66])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C18BF3000238; Fri,  6 Dec 2024 10:24:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 4/6] tests/functional: Convert the cubieboard avocado tests
Date: Fri,  6 Dec 2024 11:23:54 +0100
Message-ID: <20241206102358.1186644-5-thuth@redhat.com>
In-Reply-To: <20241206102358.1186644-1-thuth@redhat.com>
References: <20241206102358.1186644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Straight forward conversion, just the hashsums needed to be
updated to sha256 now.

These were the last tests that used image_pow2ceil_expand in
boot_linux_console.py, so we can remove that function from that
file now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                             |   1 +
 tests/avocado/boot_linux_console.py     | 157 ------------------------
 tests/functional/meson.build            |   2 +
 tests/functional/test_arm_cubieboard.py | 150 ++++++++++++++++++++++
 4 files changed, 153 insertions(+), 157 deletions(-)
 create mode 100755 tests/functional/test_arm_cubieboard.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b1c3459b4..dc583d5853 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -633,6 +633,7 @@ F: include/hw/*/allwinner*
 F: hw/arm/cubieboard.c
 F: docs/system/arm/cubieboard.rst
 F: hw/misc/axp209.c
+F: tests/functional/test_arm_cubieboard.py
 
 Allwinner-h3
 M: Niek Linnenbank <nieklinnenbank@gmail.com>
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 3250168ccf..ea31f154e3 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -24,22 +24,6 @@
 from avocado.utils import process
 from avocado.utils import archive
 
-"""
-Round up to next power of 2
-"""
-def pow2ceil(x):
-    return 1 if x == 0 else 2**(x - 1).bit_length()
-
-"""
-Expand file size to next power of 2
-"""
-def image_pow2ceil_expand(path):
-        size = os.path.getsize(path)
-        size_aligned = pow2ceil(size)
-        if size != size_aligned:
-            with open(path, 'ab+') as fd:
-                fd.truncate(size_aligned)
-
 class LinuxKernelTest(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
@@ -132,147 +116,6 @@ def test_arm_virt(self):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
-    def test_arm_cubieboard_initrd(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:cubieboard
-        :avocado: tags=accel:tcg
-        """
-        deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
-        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
-        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
-                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
-                      'arm/rootfs-armv5.cpio.gz')
-        initrd_hash = '2b50f1873e113523967806f4da2afe385462ff9b'
-        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
-        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
-        archive.gzip_uncompress(initrd_path_gz, initrd_path)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyS0,115200 '
-                               'usbcore.nousb '
-                               'panic=-1 noreboot')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-dtb', dtb_path,
-                         '-initrd', initrd_path,
-                         '-append', kernel_command_line,
-                         '-no-reboot')
-        self.vm.launch()
-        self.wait_for_console_pattern('Boot successful.')
-
-        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
-                                                'Allwinner sun4i/sun5i')
-        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
-                                                'system-control@1c00000')
-        exec_command_and_wait_for_pattern(self, 'reboot',
-                                                'reboot: Restarting system')
-        # Wait for VM to shut down gracefully
-        self.vm.wait()
-
-    def test_arm_cubieboard_sata(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:cubieboard
-        :avocado: tags=accel:tcg
-        """
-        deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb')
-        deb_hash = 'f7c3c8c5432f765445dc6e7eab02f3bbe668256b'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-6.6.16-current-sunxi')
-        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
-        dtb_path = self.extract_from_deb(deb_path, dtb_path)
-        rootfs_url = ('https://github.com/groeck/linux-build-test/raw/'
-                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
-                      'arm/rootfs-armv5.ext2.gz')
-        rootfs_hash = '093e89d2b4d982234bf528bc9fb2f2f17a9d1f93'
-        rootfs_path_gz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
-        rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
-        archive.gzip_uncompress(rootfs_path_gz, rootfs_path)
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyS0,115200 '
-                               'usbcore.nousb '
-                               'root=/dev/sda ro '
-                               'panic=-1 noreboot')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-dtb', dtb_path,
-                         '-drive', 'if=none,format=raw,id=disk0,file='
-                                   + rootfs_path,
-                         '-device', 'ide-hd,bus=ide.0,drive=disk0',
-                         '-append', kernel_command_line,
-                         '-no-reboot')
-        self.vm.launch()
-        self.wait_for_console_pattern('Boot successful.')
-
-        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
-                                                'Allwinner sun4i/sun5i')
-        exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
-                                                'sda')
-        exec_command_and_wait_for_pattern(self, 'reboot',
-                                                'reboot: Restarting system')
-        # Wait for VM to shut down gracefully
-        self.vm.wait()
-
-    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
-    def test_arm_cubieboard_openwrt_22_03_2(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:cubieboard
-        :avocado: tags=device:sd
-        """
-
-        # This test download a 7.5 MiB compressed image and expand it
-        # to 126 MiB.
-        image_url = ('https://downloads.openwrt.org/releases/22.03.2/targets/'
-                     'sunxi/cortexa8/openwrt-22.03.2-sunxi-cortexa8-'
-                     'cubietech_a10-cubieboard-ext4-sdcard.img.gz')
-        image_hash = ('94b5ecbfbc0b3b56276e5146b899eafa'
-                      '2ac5dc2d08733d6705af9f144f39f554')
-        image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash,
-                                         algorithm='sha256')
-        image_path = archive.extract(image_path_gz, self.workdir)
-        image_pow2ceil_expand(image_path)
-
-        self.vm.set_console()
-        self.vm.add_args('-drive', 'file=' + image_path + ',if=sd,format=raw',
-                         '-nic', 'user',
-                         '-no-reboot')
-        self.vm.launch()
-
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'usbcore.nousb '
-                               'noreboot')
-
-        self.wait_for_console_pattern('U-Boot SPL')
-
-        interrupt_interactive_console_until_pattern(
-                self, 'Hit any key to stop autoboot:', '=>')
-        exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
-                                                kernel_command_line + "'", '=>')
-        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...');
-
-        self.wait_for_console_pattern(
-            'Please press Enter to activate this console.')
-
-        exec_command_and_wait_for_pattern(self, ' ', 'root@')
-
-        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
-                                                'Allwinner sun4i/sun5i')
-        exec_command_and_wait_for_pattern(self, 'reboot',
-                                                'reboot: Restarting system')
-        # Wait for VM to shut down gracefully
-        self.vm.wait()
-
     @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_arm_quanta_gsj(self):
         """
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 905afba4a6..8457b14b37 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -21,6 +21,7 @@ test_timeouts = {
   'arm_aspeed' : 600,
   'arm_bpim2u' : 500,
   'arm_collie' : 180,
+  'arm_cubieboard' : 360,
   'arm_orangepi' : 540,
   'arm_raspi2' : 120,
   'arm_tuxrun' : 240,
@@ -75,6 +76,7 @@ tests_arm_system_thorough = [
   'arm_bpim2u',
   'arm_canona1100',
   'arm_collie',
+  'arm_cubieboard',
   'arm_emcraft_sf2',
   'arm_integratorcp',
   'arm_orangepi',
diff --git a/tests/functional/test_arm_cubieboard.py b/tests/functional/test_arm_cubieboard.py
new file mode 100755
index 0000000000..2b33a1b50b
--- /dev/null
+++ b/tests/functional/test_arm_cubieboard.py
@@ -0,0 +1,150 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import shutil
+
+from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import interrupt_interactive_console_until_pattern
+from qemu_test.utils import gzip_uncompress, image_pow2ceil_expand
+from unittest import skipUnless
+
+class CubieboardMachine(LinuxKernelTest):
+
+    ASSET_DEB = Asset(
+        ('https://apt.armbian.com/pool/main/l/linux-6.6.16/'
+         'linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb'),
+        '3d968c15b121ede871dce49d13ee7644d6f74b6b121b84c9a40f51b0c80d6d22')
+
+    ASSET_INITRD = Asset(
+        ('https://github.com/groeck/linux-build-test/raw/'
+         '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
+         'arm/rootfs-armv5.cpio.gz'),
+        '334b8d256db67a3f2b3ad070aa08b5ade39624e0e7e35b02f4359a577bc8f39b')
+
+    ASSET_SATA_ROOTFS = Asset(
+        ('https://github.com/groeck/linux-build-test/raw/'
+         '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
+         'arm/rootfs-armv5.ext2.gz'),
+        '17fc750da568580b39372133051ef2f0a963c0c0b369b845614442d025701745')
+
+    ASSET_OPENWRT = Asset(
+        ('https://downloads.openwrt.org/releases/22.03.2/targets/sunxi/cortexa8/'
+         'openwrt-22.03.2-sunxi-cortexa8-cubietech_a10-cubieboard-ext4-sdcard.img.gz'),
+        '94b5ecbfbc0b3b56276e5146b899eafa2ac5dc2d08733d6705af9f144f39f554')
+
+    def test_arm_cubieboard_initrd(self):
+        self.set_machine('cubieboard')
+        deb_path = self.ASSET_DEB.fetch()
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+        initrd_path_gz = self.ASSET_INITRD.fetch()
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'usbcore.nousb '
+                               'panic=-1 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'Allwinner sun4i/sun5i')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
+                                                'system-control@1c00000')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
+
+    def test_arm_cubieboard_sata(self):
+        self.set_machine('cubieboard')
+        deb_path = self.ASSET_DEB.fetch()
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-6.6.16-current-sunxi')
+        dtb_path = '/usr/lib/linux-image-6.6.16-current-sunxi/sun4i-a10-cubieboard.dtb'
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+
+        rootfs_path_gz = self.ASSET_SATA_ROOTFS.fetch()
+        rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
+        gzip_uncompress(rootfs_path_gz, rootfs_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'usbcore.nousb '
+                               'root=/dev/sda ro '
+                               'panic=-1 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-drive', 'if=none,format=raw,id=disk0,file='
+                                   + rootfs_path,
+                         '-device', 'ide-hd,bus=ide.0,drive=disk0',
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'Allwinner sun4i/sun5i')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
+                                                'sda')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
+
+    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
+    def test_arm_cubieboard_openwrt_22_03_2(self):
+        # This test download a 7.5 MiB compressed image and expand it
+        # to 126 MiB.
+        self.set_machine('cubieboard')
+        image_path_gz = self.ASSET_OPENWRT.fetch()
+        image_path = os.path.join(self.workdir, 'sdcard.img')
+        gzip_uncompress(image_path_gz, image_path)
+        image_pow2ceil_expand(image_path)
+
+        self.vm.set_console()
+        self.vm.add_args('-drive', 'file=' + image_path + ',if=sd,format=raw',
+                         '-nic', 'user',
+                         '-no-reboot')
+        self.vm.launch()
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'usbcore.nousb '
+                               'noreboot')
+
+        self.wait_for_console_pattern('U-Boot SPL')
+
+        interrupt_interactive_console_until_pattern(
+                self, 'Hit any key to stop autoboot:', '=>')
+        exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
+                                                kernel_command_line + "'", '=>')
+        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...');
+
+        self.wait_for_console_pattern(
+            'Please press Enter to activate this console.')
+
+        exec_command_and_wait_for_pattern(self, ' ', 'root@')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'Allwinner sun4i/sun5i')
+        exec_command_and_wait_for_pattern(self, 'reboot',
+                                                'reboot: Restarting system')
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.1


