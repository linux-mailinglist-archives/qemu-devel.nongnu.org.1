Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0881BB52A12
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Sep 2025 09:33:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwbhx-0001F0-EV; Thu, 11 Sep 2025 03:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uwbhg-0000fJ-Hh; Thu, 11 Sep 2025 03:26:48 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uwbhe-00015t-0k; Thu, 11 Sep 2025 03:26:48 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 11 Sep
 2025 15:24:57 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 11 Sep 2025 15:24:57 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>, <wuhaotsh@google.com>, <titusr@google.com>
Subject: [PATCH v2 14/14] tests/functional/aarch64/aspeed_ast2700: add PCIe
 enumeration test
Date: Thu, 11 Sep 2025 15:24:38 +0800
Message-ID: <20250911072452.314553-15-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911072452.314553-1-jamin_lin@aspeedtech.com>
References: <20250911072452.314553-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Add PCIe enumeration checks for AST2700 and AST2700fc functional tests.

This patch introduces a helper "do_ast2700_pcie_test()" that runs
"lspci -s 0002:00:00.0" on the emulated system and verifies the
expected PCIe device is present:

- 0002:00:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI
   Bridge

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/functional/aarch64/test_aspeed_ast2700.py   | 7 +++++++
 tests/functional/aarch64/test_aspeed_ast2700fc.py | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index a3db267294..de3ef7d83b 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -69,6 +69,11 @@ def do_ast2700_i2c_test(self):
         exec_command_and_wait_for_pattern(self,
             'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '18000')
 
+    def do_ast2700_pcie_test(self):
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 0002:00:00.0',
+            '0002:00:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
+
     def start_ast2700_test(self, name):
         num_cpu = 4
         uboot_size = os.path.getsize(self.scratch_file(name,
@@ -130,6 +135,7 @@ def test_aarch64_ast2700a1_evb_sdk_v09_06(self):
         self.start_ast2700_test('ast2700-default')
         self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700_i2c_test()
+        self.do_ast2700_pcie_test()
 
     def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_07(self):
         self.set_machine('ast2700a1-evb')
@@ -139,6 +145,7 @@ def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_07(self):
         self.verify_vbootrom_firmware_flow()
         self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700_i2c_test()
+        self.do_ast2700_pcie_test()
 
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
index b85370e182..8ba2ddab0d 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
@@ -49,6 +49,11 @@ def do_ast2700_i2c_test(self):
         exec_command_and_wait_for_pattern(self,
             'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '18000')
 
+    def do_ast2700_pcie_test(self):
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 0002:00:00.0',
+            '0002:00:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
+
     def do_ast2700fc_ssp_test(self):
         self.vm.shutdown()
         self.vm.set_console(console_index=1)
@@ -128,6 +133,7 @@ def test_aarch64_ast2700fc_sdk_v09_06(self):
         self.start_ast2700fc_test('ast2700-default')
         self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700_i2c_test()
+        self.do_ast2700_pcie_test()
         self.do_ast2700fc_ssp_test()
         self.do_ast2700fc_tsp_test()
 
-- 
2.43.0


