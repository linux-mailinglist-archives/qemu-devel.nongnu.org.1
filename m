Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F559E6F00
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Dec 2024 14:12:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJY7z-0004AN-Tf; Fri, 06 Dec 2024 08:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJY7w-00043N-Ts
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:12:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJY7u-000755-PX
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733490730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UAAAAiM0475wZNa8rSgVc1/uIRi97fuWFDt0ZAEV3Kk=;
 b=Jb08dYPiMKyKqrcQH27aKtZoLox1OoJx3z/NaPkvwIEBeLNBuUZ1lZmkT/ENp0yAWFO2pq
 fDOPKJApm9BSFhTnvt159iOw4XNoDStRql2kmBtaXZL3f/b9Typ5WP8y5euMu0GnLtmLb2
 6C0Yn/MOHOLPAqdZOX0YSAWd1w5Sqig=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-Z7mVCnkGMpymbmtWs0vGzg-1; Fri,
 06 Dec 2024 08:12:04 -0500
X-MC-Unique: Z7mVCnkGMpymbmtWs0vGzg-1
X-Mimecast-MFC-AGG-ID: Z7mVCnkGMpymbmtWs0vGzg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B7DD195C256; Fri,  6 Dec 2024 13:12:02 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.16])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 833DA1955F3F; Fri,  6 Dec 2024 13:11:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 4/7] tests/functional: Introduce a specific test for ast2500
 SoC
Date: Fri,  6 Dec 2024 14:11:29 +0100
Message-ID: <20241206131132.520911-5-clg@redhat.com>
In-Reply-To: <20241206131132.520911-1-clg@redhat.com>
References: <20241206131132.520911-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This moves the ast2500-evb tests to a new test file and extends the
aspeed module with routines used to run the buildroot and sdk
tests. No changes in the test.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aspeed.py                  | 33 ++++++++++++
 tests/functional/meson.build                |  2 +
 tests/functional/test_arm_aspeed.py         | 44 ---------------
 tests/functional/test_arm_aspeed_ast2500.py | 59 +++++++++++++++++++++
 4 files changed, 94 insertions(+), 44 deletions(-)
 create mode 100644 tests/functional/test_arm_aspeed_ast2500.py

diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
index d4dc5320b97a..62f50bab7a33 100644
--- a/tests/functional/aspeed.py
+++ b/tests/functional/aspeed.py
@@ -2,6 +2,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import LinuxKernelTest
 
 class AspeedTest(LinuxKernelTest):
@@ -21,3 +22,35 @@ def do_test_arm_aspeed(self, machine, image):
                 "aspeed-smc 1e620000.spi: read control register: 203b0641")
         self.wait_for_console_pattern("ftgmac100 1e660000.ethernet eth0: irq ")
         self.wait_for_console_pattern("systemd[1]: Set hostname to")
+
+    def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'):
+        self.require_netdev('user')
+        self.vm.set_console()
+        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw,read-only=true',
+                         '-net', 'nic', '-net', 'user')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('U-Boot 2019.04')
+        self.wait_for_console_pattern('## Loading kernel from FIT Image')
+        self.wait_for_console_pattern('Starting kernel ...')
+        self.wait_for_console_pattern('Booting Linux on physical CPU ' + cpu_id)
+        self.wait_for_console_pattern('lease of 10.0.2.15')
+        # the line before login:
+        self.wait_for_console_pattern(pattern)
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
+        exec_command_and_wait_for_pattern(self, 'passw0rd', '#')
+
+    def do_test_arm_aspeed_buildroot_poweroff(self):
+        exec_command_and_wait_for_pattern(self, 'poweroff',
+                                          'reboot: System halted');
+
+    def do_test_arm_aspeed_sdk_start(self, image):
+        self.require_netdev('user')
+        self.vm.set_console()
+        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
+                         '-net', 'nic', '-net', 'user', '-snapshot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('U-Boot 2019.04')
+        self.wait_for_console_pattern('## Loading kernel from FIT Image')
+        self.wait_for_console_pattern('Starting kernel ...')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 65eda5a394bc..6a9c20b30156 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -21,6 +21,7 @@ test_timeouts = {
   'arm_aspeed_ast1030' : 10,
   'arm_aspeed_palmetto' : 120,
   'arm_aspeed_romulus' : 120,
+  'arm_aspeed_ast2500' : 480,
   'arm_aspeed' : 600,
   'arm_bpim2u' : 500,
   'arm_collie' : 180,
@@ -72,6 +73,7 @@ tests_arm_system_thorough = [
   'arm_aspeed_ast1030',
   'arm_aspeed_palmetto',
   'arm_aspeed_romulus',
+  'arm_aspeed_ast2500',
   'arm_bpim2u',
   'arm_canona1100',
   'arm_collie',
diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
index bdc000a00a32..48cf0bfb27ca 100755
--- a/tests/functional/test_arm_aspeed.py
+++ b/tests/functional/test_arm_aspeed.py
@@ -41,34 +41,6 @@ def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'
     def do_test_arm_aspeed_buildroot_poweroff(self):
         exec_command_and_wait_for_pattern(self, 'poweroff',
                                           'reboot: System halted');
-
-    ASSET_BR2_202311_AST2500_FLASH = Asset(
-        ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
-         'images/ast2500-evb/buildroot-2023.11/flash.img'),
-        'c23db6160cf77d0258397eb2051162c8473a56c441417c52a91ba217186e715f')
-
-    def test_arm_ast2500_evb_buildroot(self):
-        self.set_machine('ast2500-evb')
-
-        image_path = self.ASSET_BR2_202311_AST2500_FLASH.fetch()
-
-        self.vm.add_args('-device',
-                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
-        self.do_test_arm_aspeed_buildroot_start(image_path, '0x0',
-                                                'ast2500-evb login:')
-
-        exec_command_and_wait_for_pattern(self,
-             'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
-             'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d');
-        exec_command_and_wait_for_pattern(self,
-                             'cat /sys/class/hwmon/hwmon1/temp1_input', '0')
-        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
-                    property='temperature', value=18000);
-        exec_command_and_wait_for_pattern(self,
-                             'cat /sys/class/hwmon/hwmon1/temp1_input', '18000')
-
-        self.do_test_arm_aspeed_buildroot_poweroff()
-
     ASSET_BR2_202311_AST2600_FLASH = Asset(
         ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
          'images/ast2600-evb/buildroot-2023.11/flash.img'),
@@ -161,22 +133,6 @@ def do_test_arm_aspeed_sdk_start(self, image):
         self.wait_for_console_pattern('## Loading kernel from FIT Image')
         self.wait_for_console_pattern('Starting kernel ...')
 
-    ASSET_SDK_V806_AST2500 = Asset(
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v08.06/ast2500-default-obmc.tar.gz',
-        'e1755f3cadff69190438c688d52dd0f0d399b70a1e14b1d3d5540fc4851d38ca')
-
-    def test_arm_ast2500_evb_sdk(self):
-        self.set_machine('ast2500-evb')
-
-        image_path = self.ASSET_SDK_V806_AST2500.fetch()
-
-        archive_extract(image_path, self.workdir)
-
-        self.do_test_arm_aspeed_sdk_start(
-            self.workdir + '/ast2500-default/image-bmc')
-
-        self.wait_for_console_pattern('ast2500-default login:')
-
     ASSET_SDK_V806_AST2600_A2 = Asset(
         'https://github.com/AspeedTech-BMC/openbmc/releases/download/v08.06/ast2600-a2-obmc.tar.gz',
         '9083506135f622d5e7351fcf7d4e1c7125cee5ba16141220c0ba88931f3681a4')
diff --git a/tests/functional/test_arm_aspeed_ast2500.py b/tests/functional/test_arm_aspeed_ast2500.py
new file mode 100644
index 000000000000..79baf37537e5
--- /dev/null
+++ b/tests/functional/test_arm_aspeed_ast2500.py
@@ -0,0 +1,59 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from aspeed import AspeedTest
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test.utils import archive_extract
+
+class AST2500Machine(AspeedTest):
+
+    ASSET_BR2_202311_AST2500_FLASH = Asset(
+        ('https://github.com/legoater/qemu-aspeed-boot/raw/master/'
+         'images/ast2500-evb/buildroot-2023.11/flash.img'),
+        'c23db6160cf77d0258397eb2051162c8473a56c441417c52a91ba217186e715f')
+
+    def test_arm_ast2500_evb_buildroot(self):
+        self.set_machine('ast2500-evb')
+
+        image_path = self.ASSET_BR2_202311_AST2500_FLASH.fetch()
+
+        self.vm.add_args('-device',
+                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
+        self.do_test_arm_aspeed_buildroot_start(image_path, '0x0',
+                                                'ast2500-evb login:')
+
+        exec_command_and_wait_for_pattern(self,
+             'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
+             'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d');
+        exec_command_and_wait_for_pattern(self,
+                             'cat /sys/class/hwmon/hwmon1/temp1_input', '0')
+        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
+                    property='temperature', value=18000);
+        exec_command_and_wait_for_pattern(self,
+                             'cat /sys/class/hwmon/hwmon1/temp1_input', '18000')
+
+        self.do_test_arm_aspeed_buildroot_poweroff()
+
+    ASSET_SDK_V806_AST2500 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v08.06/ast2500-default-obmc.tar.gz',
+        'e1755f3cadff69190438c688d52dd0f0d399b70a1e14b1d3d5540fc4851d38ca')
+
+    def test_arm_ast2500_evb_sdk(self):
+        self.set_machine('ast2500-evb')
+
+        image_path = self.ASSET_SDK_V806_AST2500.fetch()
+
+        archive_extract(image_path, self.workdir)
+
+        self.do_test_arm_aspeed_sdk_start(
+            self.workdir + '/ast2500-default/image-bmc')
+
+        self.wait_for_console_pattern('ast2500-default login:')
+
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.47.0


