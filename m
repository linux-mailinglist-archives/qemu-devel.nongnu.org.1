Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C35BBBED2F
	for <lists+qemu-devel@lfdr.de>; Mon, 06 Oct 2025 19:36:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5p7K-0007EE-Ud; Mon, 06 Oct 2025 13:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v5p7H-0007BG-Hr
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 13:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v5p77-0004mH-W8
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 13:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759772104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5o16LswEGSQUMfNRNCxwWDZ4yf5f+bSbJYyy3l3QuNU=;
 b=P2MdA40synRcyPy5j5Jq3oV7n9fKMp7fzcKNfK6ZqTY5R0nggb4WkVY5DcTJaCquzpd5Pl
 OPIlmQthgHkAc1tYpRGNkXSz3VWCzonKj5+geXoE6n82SXf72yV/YNs1JzQBP9iBXMU2u0
 A9J4cv96x64ZFI/5OsR11t1g2mCQZjo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-oD_K0xIEM1eTNayWYIsd6A-1; Mon,
 06 Oct 2025 13:35:00 -0400
X-MC-Unique: oD_K0xIEM1eTNayWYIsd6A-1
X-Mimecast-MFC-AGG-ID: oD_K0xIEM1eTNayWYIsd6A_1759772099
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CFE819560B0; Mon,  6 Oct 2025 17:34:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.108])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C967518004D8; Mon,  6 Oct 2025 17:34:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] test/functional/arm: Split the ast2600 tests in two files
Date: Mon,  6 Oct 2025 19:34:51 +0200
Message-ID: <20251006173451.528310-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The ast2600 test file currently includes tests for both the Buildroot
and SDK images. Since the SDK image tests can take long to run, split
them into a separate file to clearly distinguish the two sets of
tests, improve parallelism and allow for different CI timeouts.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/meson.build              |  6 +-
 ...00.py => test_aspeed_ast2600_buildroot.py} | 74 --------------
 .../functional/arm/test_aspeed_ast2600_sdk.py | 96 +++++++++++++++++++
 3 files changed, 100 insertions(+), 76 deletions(-)
 rename tests/functional/arm/{test_aspeed_ast2600.py => test_aspeed_ast2600_buildroot.py} (57%)
 create mode 100755 tests/functional/arm/test_aspeed_ast2600_sdk.py

diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index e4e7dba8d087..d1ed076a6aa8 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -5,7 +5,8 @@ test_arm_timeouts = {
   'aspeed_romulus' : 120,
   'aspeed_witherspoon' : 120,
   'aspeed_ast2500' : 720,
-  'aspeed_ast2600' : 1200,
+  'aspeed_ast2600_buildroot' : 720,
+  'aspeed_ast2600_sdk' : 1200,
   'aspeed_bletchley' : 480,
   'aspeed_catalina' : 480,
   'aspeed_gb200nvl_bmc' : 480,
@@ -31,7 +32,8 @@ tests_arm_system_thorough = [
   'aspeed_romulus',
   'aspeed_witherspoon',
   'aspeed_ast2500',
-  'aspeed_ast2600',
+  'aspeed_ast2600_buildroot',
+  'aspeed_ast2600_sdk',
   'aspeed_bletchley',
   'aspeed_catalina',
   'aspeed_gb200nvl_bmc',
diff --git a/tests/functional/arm/test_aspeed_ast2600.py b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
similarity index 57%
rename from tests/functional/arm/test_aspeed_ast2600.py
rename to tests/functional/arm/test_aspeed_ast2600_buildroot.py
index 0127913cfb65..51f2676c9061 100755
--- a/tests/functional/arm/test_aspeed_ast2600.py
+++ b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
@@ -97,80 +97,6 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
 
         self.do_test_arm_aspeed_buildroot_poweroff()
 
-    ASSET_SDK_V908_AST2600 = Asset(
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2600-default-obmc.tar.gz',
-        'a0414f14ad696550efe083c2156dbeda855c08cc9ae7f40fe1b41bf292295f82')
-
-    def do_ast2600_pcie_test(self):
-        exec_command_and_wait_for_pattern(self,
-            'lspci -s 80:00.0',
-            '80:00.0 Host bridge: '
-            'ASPEED Technology, Inc. Device 2600')
-        exec_command_and_wait_for_pattern(self,
-            'lspci -s 80:08.0',
-            '80:08.0 PCI bridge: '
-            'ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
-        exec_command_and_wait_for_pattern(self,
-            'lspci -s 81:00.0',
-            '81:00.0 Ethernet controller: '
-            'Intel Corporation 82574L Gigabit Network Connection')
-        exec_command_and_wait_for_pattern(self,
-            'ip addr show dev eth4',
-            'inet 10.0.2.15/24')
-
-    def test_arm_ast2600_evb_sdk(self):
-        self.set_machine('ast2600-evb')
-        self.require_netdev('user')
-
-        self.archive_extract(self.ASSET_SDK_V908_AST2600)
-
-        self.vm.add_args('-device',
-            'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test')
-        self.vm.add_args('-device',
-            'ds1338,bus=aspeed.i2c.bus.5,address=0x32')
-        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.0')
-        self.vm.add_args('-netdev', 'user,id=net1')
-        self.do_test_arm_aspeed_sdk_start(
-            self.scratch_file("ast2600-default", "image-bmc"))
-
-        self.wait_for_console_pattern('ast2600-default login:')
-
-        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
-        exec_command_and_wait_for_pattern(self, '0penBmc',
-                                          'root@ast2600-default:~#')
-
-        exec_command_and_wait_for_pattern(self,
-            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-5/device/new_device',
-            'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d')
-        exec_command_and_wait_for_pattern(self,
-             'cat /sys/class/hwmon/hwmon19/temp1_input', '0')
-        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
-                    property='temperature', value=18000)
-        exec_command_and_wait_for_pattern(self,
-             'cat /sys/class/hwmon/hwmon19/temp1_input', '18000')
-
-        exec_command_and_wait_for_pattern(self,
-             'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-5/device/new_device',
-             'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32')
-        year = time.strftime("%Y")
-        exec_command_and_wait_for_pattern(self,
-             '/sbin/hwclock -f /dev/rtc1', year)
-        self.do_ast2600_pcie_test()
-
-    def test_arm_ast2600_otp_blockdev_device(self):
-        self.vm.set_machine("ast2600-evb")
-
-        image_path = self.archive_extract(self.ASSET_SDK_V908_AST2600)
-        otp_img = self.generate_otpmem_image()
-
-        self.vm.set_console()
-        self.vm.add_args(
-            "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
-            "-global", "aspeed-otp.drive=otp",
-        )
-        self.do_test_arm_aspeed_sdk_start(
-            self.scratch_file("ast2600-default", "image-bmc"))
-        self.wait_for_console_pattern("ast2600-default login:")
 
 if __name__ == '__main__':
     AspeedTest.main()
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functional/arm/test_aspeed_ast2600_sdk.py
new file mode 100755
index 000000000000..735a20b8df0e
--- /dev/null
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py
@@ -0,0 +1,96 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import time
+import tempfile
+import subprocess
+
+from qemu_test import Asset
+from aspeed import AspeedTest
+from qemu_test import exec_command_and_wait_for_pattern, skipIfMissingCommands
+
+
+class AST2600Machine(AspeedTest):
+
+    ASSET_SDK_V908_AST2600 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2600-default-obmc.tar.gz',
+        'a0414f14ad696550efe083c2156dbeda855c08cc9ae7f40fe1b41bf292295f82')
+
+    def do_ast2600_pcie_test(self):
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 80:00.0',
+            '80:00.0 Host bridge: '
+            'ASPEED Technology, Inc. Device 2600')
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 80:08.0',
+            '80:08.0 PCI bridge: '
+            'ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 81:00.0',
+            '81:00.0 Ethernet controller: '
+            'Intel Corporation 82574L Gigabit Network Connection')
+        exec_command_and_wait_for_pattern(self,
+            'ip addr show dev eth4',
+            'inet 10.0.2.15/24')
+
+    def test_arm_ast2600_evb_sdk(self):
+        self.set_machine('ast2600-evb')
+        self.require_netdev('user')
+
+        self.archive_extract(self.ASSET_SDK_V908_AST2600)
+
+        self.vm.add_args('-device',
+            'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test')
+        self.vm.add_args('-device',
+            'ds1338,bus=aspeed.i2c.bus.5,address=0x32')
+        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.0')
+        self.vm.add_args('-netdev', 'user,id=net1')
+        self.do_test_arm_aspeed_sdk_start(
+            self.scratch_file("ast2600-default", "image-bmc"))
+
+        self.wait_for_console_pattern('ast2600-default login:')
+
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
+        exec_command_and_wait_for_pattern(self, '0penBmc',
+                                          'root@ast2600-default:~#')
+
+        exec_command_and_wait_for_pattern(self,
+            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-5/device/new_device',
+            'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d')
+        exec_command_and_wait_for_pattern(self,
+             'cat /sys/class/hwmon/hwmon19/temp1_input', '0')
+        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
+                    property='temperature', value=18000)
+        exec_command_and_wait_for_pattern(self,
+             'cat /sys/class/hwmon/hwmon19/temp1_input', '18000')
+
+        exec_command_and_wait_for_pattern(self,
+             'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-5/device/new_device',
+             'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32')
+        year = time.strftime("%Y")
+        exec_command_and_wait_for_pattern(self,
+             '/sbin/hwclock -f /dev/rtc1', year)
+        self.do_ast2600_pcie_test()
+
+    def test_arm_ast2600_otp_blockdev_device(self):
+        self.vm.set_machine("ast2600-evb")
+
+        image_path = self.archive_extract(self.ASSET_SDK_V908_AST2600)
+        otp_img = self.generate_otpmem_image()
+
+        self.vm.set_console()
+        self.vm.add_args(
+            "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
+            "-global", "aspeed-otp.drive=otp",
+        )
+        self.do_test_arm_aspeed_sdk_start(
+            self.scratch_file("ast2600-default", "image-bmc"))
+        self.wait_for_console_pattern("ast2600-default login:")
+
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.51.0


