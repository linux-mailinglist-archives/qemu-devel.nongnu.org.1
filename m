Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED02AAA06F2
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Apr 2025 11:21:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9h7u-0005jd-6G; Tue, 29 Apr 2025 05:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1u9h7p-0005g8-Vx; Tue, 29 Apr 2025 05:19:38 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1u9h7n-0004Ff-Uh; Tue, 29 Apr 2025 05:19:37 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 29 Apr
 2025 17:18:58 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 29 Apr 2025 17:18:58 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <longzl2@lenovo.com>,
 <yunlin.tang@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [PATCH v3 8/9] tests/function/aspeed: Add functional test for
 AST2700FC
Date: Tue, 29 Apr 2025 17:18:52 +0800
Message-ID: <20250429091855.1948374-9-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429091855.1948374-1-steven_lee@aspeedtech.com>
References: <20250429091855.1948374-1-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=steven_lee@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Steven Lee <steven_lee@aspeedtech.com>
From:  Steven Lee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Add functional test for AST2700-fc machine.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
Change-Id: Ieced249cf471515a33f8f5f5386a2f58d431f2f9
---
 tests/functional/test_aarch64_ast2700fc.py | 137 +++++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100755 tests/functional/test_aarch64_ast2700fc.py

diff --git a/tests/functional/test_aarch64_ast2700fc.py b/tests/functional/test_aarch64_ast2700fc.py
new file mode 100755
index 0000000000..f7b7907fde
--- /dev/null
+++ b/tests/functional/test_aarch64_ast2700fc.py
@@ -0,0 +1,137 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the AST2700 multi-SoCs with firmware
+#
+# Copyright (C) 2025 ASPEED Technology Inc
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+
+
+class AST2700fcMachineSDK(QemuSystemTest):
+    ASSET_SDK_V905_AST2700 = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.05/ast2700-default-obmc.tar.gz',
+            'c1f4496aec06743c812a6e9a1a18d032f34d62f3ddb6956e924fef62aa2046a5')
+
+    def do_test_aarch64_ast2700fc_ca35_start(self, image):
+        self.require_netdev('user')
+        self.vm.set_console()
+        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
+                         '-net', 'nic', '-net', 'user', '-snapshot')
+
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'U-Boot 2023.10')
+        wait_for_console_pattern(self, '## Loading kernel from FIT Image')
+        wait_for_console_pattern(self, 'Starting kernel ...')
+
+    def do_test_aarch64_ast2700fc_ssp_start(self):
+
+        self.vm.shutdown()
+        self.vm.set_console(console_index=1)
+        self.vm.launch()
+
+    def do_test_aarch64_ast2700fc_tsp_start(self):
+        self.vm.shutdown()
+        self.vm.set_console(console_index=2)
+        self.vm.launch()
+
+    def start_ast2700fc_test(self, name):
+        ca35_core = 4
+        uboot_size = os.path.getsize(self.scratch_file(name,
+                                                       'u-boot-nodtb.bin'))
+        uboot_dtb_load_addr = hex(0x400000000 + uboot_size)
+
+        load_images_list = [
+            {
+                'addr': '0x400000000',
+                'file': self.scratch_file(name,
+                                          'u-boot-nodtb.bin')
+            },
+            {
+                'addr': str(uboot_dtb_load_addr),
+                'file': self.scratch_file(name, 'u-boot.dtb')
+            },
+            {
+                'addr': '0x430000000',
+                'file': self.scratch_file(name, 'bl31.bin')
+            },
+            {
+                'addr': '0x430080000',
+                'file': self.scratch_file(name, 'optee',
+                                          'tee-raw.bin')
+            }
+        ]
+
+        for load_image in load_images_list:
+            addr = load_image['addr']
+            file = load_image['file']
+            self.vm.add_args('-device',
+                             f'loader,force-raw=on,addr={addr},file={file}')
+
+        for i in range(ca35_core):
+            self.vm.add_args('-device',
+                             f'loader,addr=0x430000000,cpu-num={i}')
+
+        load_elf_list = {
+            'ssp': self.scratch_file(name, 'ast2700-ssp.elf'),
+            'tsp': self.scratch_file(name, 'ast2700-tsp.elf')
+        }
+
+        for cpu_num, key in enumerate(load_elf_list, start=4):
+            file = load_elf_list[key]
+            self.vm.add_args('-device',
+                             f'loader,file={file},cpu-num={cpu_num}')
+
+        self.vm.add_args('-device',
+                         'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
+        self.do_test_aarch64_ast2700fc_ca35_start(
+            self.scratch_file(name, 'image-bmc'))
+
+        wait_for_console_pattern(self, f'{name} login:')
+
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
+        exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
+
+        exec_command_and_wait_for_pattern(
+                self,
+                'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device ',
+                'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d')
+        exec_command_and_wait_for_pattern(
+                self,
+                'cat /sys/class/hwmon/hwmon*/temp1_input', '0')
+        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
+                    property='temperature', value=18000)
+        exec_command_and_wait_for_pattern(
+                self,
+                'cat /sys/class/hwmon/hwmon*/temp1_input', '18000')
+
+        self.do_test_aarch64_ast2700fc_ssp_start()
+
+        exec_command_and_wait_for_pattern(self, '\012', 'ssp:~$')
+        exec_command_and_wait_for_pattern(self, 'version',
+                                          'Zephyr version 3.7.1')
+        exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
+                                          '[72c02000] 06010103')
+
+        self.do_test_aarch64_ast2700fc_tsp_start()
+
+        exec_command_and_wait_for_pattern(self, '\012', 'tsp:~$')
+        exec_command_and_wait_for_pattern(self, 'version',
+                                          'Zephyr version 3.7.1')
+        exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
+                                          '[72c02000] 06010103')
+
+    def test_aarch64_ast2700fc_sdk_v09_05(self):
+        self.set_machine('ast2700fc')
+        self.archive_extract(self.ASSET_SDK_V905_AST2700)
+        self.start_ast2700fc_test('ast2700-default')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.34.1


