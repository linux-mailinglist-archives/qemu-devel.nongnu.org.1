Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F94A70AE5
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Mar 2025 21:02:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txASv-0000Z2-7o; Tue, 25 Mar 2025 16:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txASJ-0000UB-70
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 16:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txASG-0002gz-TA
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 16:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742932855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wA6kZWskR3gX7n4FZRHHsZx4j9G6Km3r5VMFvGP0AWs=;
 b=iCtJhxcirAc4TBT8cf+PzIx2o/J3o+fiWzzooi3VXqK2CMX3+Z2mXpl6PSdl66WEq8w5S4
 UAXNgOfc8kYJ+GXvDBP7DsekSUVpGvWJ2hHkqVG/t5hV45JE7kmY5+3A1VuVyXJAm+BA1c
 jNth1V1c5oFephiM4u4fWQH7nUxnndY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-4GM_mtezMBiPNdUuSCHScw-1; Tue,
 25 Mar 2025 16:00:52 -0400
X-MC-Unique: 4GM_mtezMBiPNdUuSCHScw-1
X-Mimecast-MFC-AGG-ID: 4GM_mtezMBiPNdUuSCHScw_1742932851
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A070180025E; Tue, 25 Mar 2025 20:00:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.142])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 552081801767; Tue, 25 Mar 2025 20:00:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/15] tests/functional: Convert the 32-bit big endian Wheezy
 mips test
Date: Tue, 25 Mar 2025 21:00:14 +0100
Message-ID: <20250325200026.344006-7-thuth@redhat.com>
In-Reply-To: <20250325200026.344006-1-thuth@redhat.com>
References: <20250325200026.344006-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The test checks some entries in /proc and the output of some commands ...
we put these checks into exportable functions now so that they can
be reused more easily.

Additionally the linux_ssh_mips_malta.py uses SSH to test the networking
of the guest. Since we don't have a SSH module in the functional
framework yet, let's use the check_http_download() function here instead.

And while we're at it, also switch the NIC to e1000 now to get some more
test coverage, since the "pcnet" device is already tested in the test
test_mips_malta_cpio.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/linux_ssh_mips_malta.py |   8 --
 tests/functional/meson.build          |   2 +-
 tests/functional/test_mips_malta.py   | 108 +++++++++++++++++++++++++-
 3 files changed, 107 insertions(+), 11 deletions(-)

diff --git a/tests/avocado/linux_ssh_mips_malta.py b/tests/avocado/linux_ssh_mips_malta.py
index d9bb525ad9c..73d294ad5cf 100644
--- a/tests/avocado/linux_ssh_mips_malta.py
+++ b/tests/avocado/linux_ssh_mips_malta.py
@@ -172,14 +172,6 @@ def check_mips_malta(self, uname_m, endianess):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
-    def test_mips_malta32eb_kernel3_2_0(self):
-        """
-        :avocado: tags=arch:mips
-        :avocado: tags=endian:big
-        :avocado: tags=device:pcnet32
-        """
-        self.check_mips_malta('mips', 'be')
-
     def test_mips_malta32el_kernel3_2_0(self):
         """
         :avocado: tags=arch:mipsel
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 452d863f187..3f8fabd218d 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -39,7 +39,7 @@ test_timeouts = {
   'arm_tuxrun' : 240,
   'arm_sx1' : 360,
   'intel_iommu': 300,
-  'mips_malta' : 120,
+  'mips_malta' : 480,
   'mipsel_replay' : 480,
   'mips64el_replay' : 180,
   'netdev_ethtool' : 180,
diff --git a/tests/functional/test_mips_malta.py b/tests/functional/test_mips_malta.py
index 9697c7d63f8..89b9556f30d 100755
--- a/tests/functional/test_mips_malta.py
+++ b/tests/functional/test_mips_malta.py
@@ -6,10 +6,93 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import LinuxKernelTest, Asset
+import os
+
+from qemu_test import LinuxKernelTest, Asset, wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern
 
 
+def mips_run_common_commands(test, prompt='#'):
+    exec_command_and_wait_for_pattern(test,
+        'uname -m',
+        'mips')
+    exec_command_and_wait_for_pattern(test,
+        'grep XT-PIC /proc/interrupts',
+        'timer')
+    wait_for_console_pattern(test, prompt)
+    exec_command_and_wait_for_pattern(test,
+        'grep XT-PIC /proc/interrupts',
+        'serial')
+    wait_for_console_pattern(test, prompt)
+    exec_command_and_wait_for_pattern(test,
+        'grep XT-PIC /proc/interrupts',
+        'ata_piix')
+    wait_for_console_pattern(test, prompt)
+    exec_command_and_wait_for_pattern(test,
+        'grep XT-PIC /proc/interrupts',
+        'rtc')
+    wait_for_console_pattern(test, prompt)
+    exec_command_and_wait_for_pattern(test,
+        'cat /proc/devices',
+        'input')
+    wait_for_console_pattern(test, prompt)
+    exec_command_and_wait_for_pattern(test,
+        'cat /proc/devices',
+        'fb')
+    wait_for_console_pattern(test, prompt)
+    exec_command_and_wait_for_pattern(test,
+        'cat /proc/ioports',
+        ' : serial')
+    wait_for_console_pattern(test, prompt)
+    exec_command_and_wait_for_pattern(test,
+        'cat /proc/ioports',
+        ' : ata_piix')
+    wait_for_console_pattern(test, prompt)
+
+def mips_check_wheezy(test, kernel_path, image_path, kernel_command_line,
+                      dl_file, hsum, nic='pcnet', cpuinfo='MIPS 24Kc'):
+    test.require_netdev('user')
+    test.require_device(nic)
+    test.set_machine('malta')
+
+    port=8080
+    test.vm.add_args('-kernel', kernel_path,
+                     '-append', kernel_command_line,
+                     '-drive', 'file=%s,snapshot=on' % image_path,
+                     '-netdev', 'user,id=n1' +
+                                ',tftp=' + os.path.basename(kernel_path) +
+                                ',hostfwd=tcp:127.0.0.1:0-:%d' % port,
+                     '-device', f'{nic},netdev=n1',
+                     '-no-reboot')
+    test.vm.set_console()
+    test.vm.launch()
+
+    wait_for_console_pattern(test, 'login: ', 'Oops')
+    exec_command_and_wait_for_pattern(test, 'root', 'Password:')
+    exec_command_and_wait_for_pattern(test, 'root', ':~# ')
+    mips_run_common_commands(test)
+
+    exec_command_and_wait_for_pattern(test, 'cd /', '# ')
+    test.check_http_download(dl_file, hsum, port,
+                             pythoncmd='python -m SimpleHTTPServer')
+
+    exec_command_and_wait_for_pattern(test, 'cat /proc/cpuinfo', cpuinfo)
+    exec_command_and_wait_for_pattern(test, 'cat /proc/devices', 'usb')
+    exec_command_and_wait_for_pattern(test, 'cat /proc/ioports',
+                                      ' : piix4_smbus')
+    # lspci for the host bridge does not work on big endian targets:
+    # https://gitlab.com/qemu-project/qemu/-/issues/2826
+    # exec_command_and_wait_for_pattern(test, 'lspci -d 11ab:4620',
+    #                                   'GT-64120')
+    exec_command_and_wait_for_pattern(test,
+                                      'cat /sys/bus/i2c/devices/i2c-0/name',
+                                      'SMBus PIIX4 adapter')
+    exec_command_and_wait_for_pattern(test, 'cat /proc/mtd', 'YAMON')
+    # Empty 'Board Config' (64KB)
+    exec_command_and_wait_for_pattern(test, 'md5sum /dev/mtd2ro',
+                                      '0dfbe8aa4c20b52e1b8bf3cb6cbdf193')
+
+
 class MaltaMachineConsole(LinuxKernelTest):
 
     ASSET_KERNEL_2_63_2 = Asset(
@@ -70,7 +153,8 @@ def test_mips_malta_cpio(self):
         exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
                                                 'BogoMIPS')
         exec_command_and_wait_for_pattern(self, 'uname -a',
-                                                'Debian')
+                                                '4.5.0-2-4kc-malta #1 Debian')
+        mips_run_common_commands(self)
 
         exec_command_and_wait_for_pattern(self, 'ip link set eth0 up',
                                           'eth0: link up')
@@ -89,6 +173,26 @@ def test_mips_malta_cpio(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
+    ASSET_WHEEZY_KERNEL = Asset(
+        ('https://people.debian.org/~aurel32/qemu/mips/'
+         'vmlinux-3.2.0-4-4kc-malta'),
+        '0377fcda31299213c10b8e5babe7260ef99188b3ae1aca6f56594abb71e7f67e')
+
+    ASSET_WHEEZY_DISK = Asset(
+        ('https://people.debian.org/~aurel32/qemu/mips/'
+         'debian_wheezy_mips_standard.qcow2'),
+        'de03599285b8382ad309309a6c4869f6c6c42a5cfc983342bab9ec0dfa7849a2')
+
+    def test_wheezy(self):
+        kernel_path = self.ASSET_WHEEZY_KERNEL.fetch()
+        image_path = self.ASSET_WHEEZY_DISK.fetch()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 root=/dev/sda1')
+        mips_check_wheezy(self,
+            kernel_path, image_path, kernel_command_line, nic='e1000',
+            dl_file='/boot/initrd.img-3.2.0-4-4kc-malta',
+            hsum='ff0c0369143d9bbb9a6e6bc79322a2be535619df639e84103237f406e87493dc')
+
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.49.0


