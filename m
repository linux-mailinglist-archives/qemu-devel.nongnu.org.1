Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B065A5EB4E
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Mar 2025 06:50:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsbOr-000547-26; Thu, 13 Mar 2025 01:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tsbOg-0004wZ-Mc; Thu, 13 Mar 2025 01:46:23 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tsbOe-0005Ve-Uq; Thu, 13 Mar 2025 01:46:22 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 13 Mar
 2025 13:40:24 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 13 Mar 2025 13:40:24 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <yunlin.tang@aspeedtech.com>
Subject: [PATCH 12/13] tests/function/aspeed: Add functional test for
 AST2700FC A1
Date: Thu, 13 Mar 2025 13:40:16 +0800
Message-ID: <20250313054020.2583556-13-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313054020.2583556-1-steven_lee@aspeedtech.com>
References: <20250313054020.2583556-1-steven_lee@aspeedtech.com>
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

Add functional test for AST2700a1-fc machine.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
Change-Id: I87584164b2632c58d2e051fd92d9e280347bcf19
---
 tests/functional/test_aarch64_ast2700fc.py | 38 +++++++++++++++++-----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/tests/functional/test_aarch64_ast2700fc.py b/tests/functional/test_aarch64_ast2700fc.py
index 243b74d77e..b54346a57f 100755
--- a/tests/functional/test_aarch64_ast2700fc.py
+++ b/tests/functional/test_aarch64_ast2700fc.py
@@ -14,6 +14,9 @@
 
 
 class AST2700fcMachineSDK(QemuSystemTest):
+    ASSET_SDK_V905_AST2700 = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.05/ast2700-default-obmc.tar.gz',
+            'c1f4496aec06743c812a6e9a1a18d032f34d62f3ddb6956e924fef62aa2046a5')
     ASSET_SDK_V905_AST2700_A0 = Asset(
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.05/ast2700-a0-default-obmc.tar.gz',
             'cfbbd1cce72f2a3b73b9080c41eecdadebb7077fba4f7806d72ac99f3e84b74a')
@@ -81,10 +84,16 @@ def start_ast2700fc_test(self, name):
             self.vm.add_args('-device',
                              f'loader,addr=0x430000000,cpu-num={i}')
 
-        load_elf_list = {
-            'ssp': self.scratch_file('ast2700-a0-ssp-tsp', 'ast2700-ssp.elf'),
-            'tsp': self.scratch_file('ast2700-a0-ssp-tsp', 'ast2700-tsp.elf')
-        }
+        if name == 'ast2700-a0-default':
+            load_elf_list = {
+                'ssp': self.scratch_file('ast2700-a0-ssp-tsp', 'ast2700-ssp.elf'),
+                'tsp': self.scratch_file('ast2700-a0-ssp-tsp', 'ast2700-tsp.elf')
+            }
+        else:
+            load_elf_list = {
+                'ssp': self.scratch_file(name, 'ast2700-ssp.elf'),
+                'tsp': self.scratch_file(name, 'ast2700-tsp.elf')
+            }
 
         for cpu_num, key in enumerate(load_elf_list, start=4):
             file = load_elf_list[key]
@@ -119,14 +128,27 @@ def start_ast2700fc_test(self, name):
         exec_command_and_wait_for_pattern(self, '\012', 'ssp:~$')
         exec_command_and_wait_for_pattern(self, 'version',
                                           'Zephyr version 3.7.1')
-        exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
-                                          '[72c02000] 06000103')
+        if name == 'ast2700-a0-default':
+            exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
+                                              '[72c02000] 06000103')
+        else:
+            exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
+                                              '[72c02000] 06010103')
         self.do_test_aarch64_ast2700fc_tsp_start()
         exec_command_and_wait_for_pattern(self, '\012', 'tsp:~$')
         exec_command_and_wait_for_pattern(self, 'version',
                                           'Zephyr version 3.7.1')
-        exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
-                                          '[72c02000] 06000103')
+        if name == 'ast2700-a0-default':
+            exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
+                                              '[72c02000] 06000103')
+        else:
+            exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
+                                              '[72c02000] 06010103')
+
+    def test_aarch64_ast2700fc_sdk_v09_05(self):
+        self.set_machine('ast2700fc-a1')
+        self.archive_extract(self.ASSET_SDK_V905_AST2700)
+        self.start_ast2700fc_test('ast2700-default')
 
     def test_aarch64_ast2700fc_a0_sdk_v09_05(self):
         self.set_machine('ast2700fc-a0')
-- 
2.34.1


