Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 890599DA4A8
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Nov 2024 10:18:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGEA3-0002y1-Ii; Wed, 27 Nov 2024 04:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tGEA0-0002pY-9t; Wed, 27 Nov 2024 04:16:36 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tGE9y-0004aA-KK; Wed, 27 Nov 2024 04:16:36 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 27 Nov
 2024 17:15:47 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 27 Nov 2024 17:15:47 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v3 10/10] test/qtest/ast2700-smc-test: Support to test AST2700
Date: Wed, 27 Nov 2024 17:15:43 +0800
Message-ID: <20241127091543.1243114-11-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241127091543.1243114-1-jamin_lin@aspeedtech.com>
References: <20241127091543.1243114-1-jamin_lin@aspeedtech.com>
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

Add test_ast2700_evb function and reused testcases which are from
aspeed_smc-test.c for AST2700 testing. The base address, flash base address
and ce index of fmc_cs0 are 0x14000000, 0x100000000 and 0, respectively.
The default flash model of fmc_cs0 is "w25q01jvq" whose size is 128MB,
so set jedec_id 0xef4021.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/qtest/ast2700-smc-test.c | 71 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |  4 +-
 2 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/ast2700-smc-test.c

diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-test.c
new file mode 100644
index 0000000000..d1c4856307
--- /dev/null
+++ b/tests/qtest/ast2700-smc-test.c
@@ -0,0 +1,71 @@
+/*
+ * QTest testcase for the M25P80 Flash using the ASPEED SPI Controller since
+ * AST2700.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2024 ASPEED Technology Inc.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "libqtest-single.h"
+#include "qemu/bitops.h"
+#include "aspeed-smc-utils.h"
+
+static void test_ast2700_evb(AspeedSMCTestData *data)
+{
+    int ret;
+    int fd;
+
+    fd = g_file_open_tmp("qtest.m25p80.w25q01jvq.XXXXXX",
+                         &data->tmp_path, NULL);
+    g_assert(fd >= 0);
+    ret = ftruncate(fd, 128 * 1024 * 1024);
+    g_assert(ret == 0);
+    close(fd);
+
+    data->s = qtest_initf("-machine ast2700-evb "
+                          "-drive file=%s,format=raw,if=mtd",
+                          data->tmp_path);
+
+    /* fmc cs0 with w25q01jvq flash */
+    data->flash_base = 0x100000000;
+    data->spi_base = 0x14000000;
+    data->jedec_id = 0xef4021;
+    data->cs = 0;
+    data->node = "/machine/soc/fmc/ssi.0/child[0]";
+    /* beyond 64MB */
+    data->page_addr = 0x40000 * FLASH_PAGE_SIZE;
+
+    qtest_add_data_func("/ast2700/smc/read_jedec",
+                        data, aspeed_smc_test_read_jedec);
+    qtest_add_data_func("/ast2700/smc/erase_sector",
+                        data, aspeed_smc_test_erase_sector);
+    qtest_add_data_func("/ast2700/smc/erase_all",
+                        data, aspeed_smc_test_erase_all);
+    qtest_add_data_func("/ast2700/smc/write_page",
+                        data, aspeed_smc_test_write_page);
+    qtest_add_data_func("/ast2700/smc/read_page_mem",
+                        data, aspeed_smc_test_read_page_mem);
+    qtest_add_data_func("/ast2700/smc/write_page_mem",
+                        data, aspeed_smc_test_write_page_mem);
+    qtest_add_data_func("/ast2700/smc/read_status_reg",
+                        data, aspeed_smc_test_read_status_reg);
+    qtest_add_data_func("/ast2700/smc/write_page_qpi",
+                        data, aspeed_smc_test_write_page_qpi);
+}
+
+int main(int argc, char **argv)
+{
+    AspeedSMCTestData ast2700_evb_data;
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    test_ast2700_evb(&ast2700_evb_data);
+    ret = g_test_run();
+
+    qtest_quit(ast2700_evb_data.s);
+    unlink(ast2700_evb_data.tmp_path);
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ea68ec1441..21e9320a95 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -214,7 +214,8 @@ qtests_aspeed = \
    'aspeed_smc-test',
    'aspeed_gpio-test']
 qtests_aspeed64 = \
-  ['ast2700-gpio-test']
+  ['ast2700-gpio-test',
+   'ast2700-smc-test']
 
 qtests_stm32l4x5 = \
   ['stm32l4x5_exti-test',
@@ -361,6 +362,7 @@ qtests = {
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
   'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
+  'ast2700-smc-test': files('aspeed-smc-utils.c', 'ast2700-smc-test.c'),
 }
 
 if vnc.found()
-- 
2.34.1


