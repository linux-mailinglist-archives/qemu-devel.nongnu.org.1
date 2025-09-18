Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF4EB22380
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Aug 2025 11:42:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ullVb-0007zp-TT; Tue, 12 Aug 2025 05:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1ullVZ-0007yE-LW; Tue, 12 Aug 2025 05:41:29 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1ullVT-0000lv-BE; Tue, 12 Aug 2025 05:41:29 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 12 Aug
 2025 17:40:16 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 12 Aug 2025 17:40:16 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v5 09/10] tests/function/aspeed: Add OTP functional test
Date: Tue, 12 Aug 2025 17:40:06 +0800
Message-ID: <20250812094011.2617526-10-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812094011.2617526-1-kane_chen@aspeedtech.com>
References: <20250812094011.2617526-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

On boot, the SoC firmware reads data from the OTP region to obtain the
chip ID and default settings. This change adds test cases to verify
that the firmware can boot correctly with a pre-configured OTP image.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 tests/functional/meson.build            |  2 +
 tests/functional/test_arm_aspeed_otp.py | 55 +++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 tests/functional/test_arm_aspeed_otp.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 311c6f1806..c731b779dd 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -34,6 +34,7 @@ test_timeouts = {
   'arm_aspeed_bletchley' : 480,
   'arm_aspeed_catalina' : 480,
   'arm_aspeed_gb200nvl_bmc' : 480,
+  'arm_aspeed_otp': 1200,
   'arm_aspeed_rainier' : 480,
   'arm_bpim2u' : 500,
   'arm_collie' : 180,
@@ -132,6 +133,7 @@ tests_arm_system_thorough = [
   'arm_aspeed_bletchley',
   'arm_aspeed_catalina',
   'arm_aspeed_gb200nvl_bmc',
+  'arm_aspeed_otp',
   'arm_aspeed_rainier',
   'arm_bpim2u',
   'arm_canona1100',
diff --git a/tests/functional/test_arm_aspeed_otp.py b/tests/functional/test_arm_aspeed_otp.py
new file mode 100644
index 0000000000..48c7cad3f3
--- /dev/null
+++ b/tests/functional/test_arm_aspeed_otp.py
@@ -0,0 +1,55 @@
+import os
+import time
+import tempfile
+import subprocess
+
+from qemu_test import LinuxKernelTest, Asset
+from aspeed import AspeedTest
+from qemu_test import exec_command_and_wait_for_pattern, skipIfMissingCommands
+
+class AspeedOtpMemoryTest(AspeedTest):
+    # AST2600 SDK image
+    ASSET_SDK_V907_AST2600 = Asset(
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.07/ast2600-default-obmc.tar.gz',
+        'cb6c08595bcbba1672ce716b068ba4e48eda1ed9abe78a07b30392ba2278feba')
+
+    # AST1030 Zephyr image
+    ASSET_ZEPHYR_3_02 = Asset(
+        'https://github.com/AspeedTech-BMC/zephyr/releases/download/v00.03.02/ast1030-evb-demo.zip',
+        '1ec83caab3ddd5d09481772801be7210e222cb015ce22ec6fffb8a76956dcd4f')
+
+    def generate_otpmem_image(self):
+        path = self.scratch_file("otpmem.img")
+        pattern = b'\x00\x00\x00\x00\xff\xff\xff\xff' * (16 * 1024 // 8)
+        with open(path, "wb") as f:
+            f.write(pattern)
+        return path
+
+    def test_ast2600_otp_blockdev_device(self):
+        image_path = self.archive_extract(self.ASSET_SDK_V907_AST2600)
+        otp_img = self.generate_otpmem_image()
+        self.vm.set_machine("ast2600-evb")
+        self.vm.set_console()
+        self.vm.add_args(
+            "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
+            "-global", "aspeed-otp.drive=otp",
+        )
+        self.do_test_arm_aspeed_sdk_start(self.scratch_file("ast2600-default", "image-bmc"))
+        self.wait_for_console_pattern("ast2600-default login:")
+
+    def test_ast1030_otp_blockdev_device(self):
+        kernel_name = "ast1030-evb-demo-3/zephyr.elf"
+        kernel_file = self.archive_extract(self.ASSET_ZEPHYR_3_02, member=kernel_name)
+        otp_img = self.generate_otpmem_image()
+        self.vm.set_machine("ast1030-evb")
+        self.vm.set_console()
+        self.vm.add_args(
+            "-kernel", kernel_file,
+            "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
+            "-global", "aspeed-otp.drive=otp",
+        )
+        self.vm.launch()
+        self.wait_for_console_pattern("Booting Zephyr OS")
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.43.0


