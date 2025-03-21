Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 158FBA6B759
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Mar 2025 10:30:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvYg0-0001ht-VT; Fri, 21 Mar 2025 05:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tvYfk-0001M5-Nu; Fri, 21 Mar 2025 05:28:13 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tvYfh-0005jH-P2; Fri, 21 Mar 2025 05:28:12 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 21 Mar
 2025 17:26:30 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 21 Mar 2025 17:26:30 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 20/22] test/qtest/hace: Support to test upper 32 bits of
 digest and source addresses
Date: Fri, 21 Mar 2025 17:26:16 +0800
Message-ID: <20250321092623.2097234-21-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Added "src_hi" and "dest_hi" fields to "AspeedMasks" for 64-bit addresses test.
Updated "aspeed_test_addresses" to validate "HACE_HASH_SRC_HI" and
"HACE_HASH_DIGEST_HI".
Ensured correct masking of 64-bit addresses by checking both lower and upper
32-bit registers.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/qtest/aspeed-hace-utils.h |  2 ++
 tests/qtest/aspeed-hace-utils.c | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-utils.h
index d8684d3f83..de8055a1db 100644
--- a/tests/qtest/aspeed-hace-utils.h
+++ b/tests/qtest/aspeed-hace-utils.h
@@ -51,6 +51,8 @@ struct AspeedMasks {
     uint32_t src;
     uint32_t dest;
     uint32_t len;
+    uint32_t src_hi;
+    uint32_t dest_hi;
 };
 
 void aspeed_test_md5(const char *machine, const uint32_t base,
diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-utils.c
index 8d9c464f72..fc209353f3 100644
--- a/tests/qtest/aspeed-hace-utils.c
+++ b/tests/qtest/aspeed-hace-utils.c
@@ -588,30 +588,43 @@ void aspeed_test_addresses(const char *machine, const uint32_t base,
      */
     g_assert_cmphex(qtest_readl(s, base + HACE_CMD), ==, 0);
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_SRC), ==, 0);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_SRC_HI), ==, 0);
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST), ==, 0);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST_HI), ==, 0);
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DATA_LEN), ==, 0);
 
-
     /* Check that the address masking is correct */
     qtest_writel(s, base + HACE_HASH_SRC, 0xffffffff);
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_SRC), ==, expected->src);
 
+    qtest_writel(s, base + HACE_HASH_SRC_HI, 0xffffffff);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_SRC_HI),
+                    ==, expected->src_hi);
+
     qtest_writel(s, base + HACE_HASH_DIGEST, 0xffffffff);
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST), ==,
                     expected->dest);
 
+    qtest_writel(s, base + HACE_HASH_DIGEST_HI, 0xffffffff);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST_HI), ==,
+                    expected->dest_hi);
+
     qtest_writel(s, base + HACE_HASH_DATA_LEN, 0xffffffff);
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DATA_LEN), ==,
                     expected->len);
 
     /* Reset to zero */
     qtest_writel(s, base + HACE_HASH_SRC, 0);
+    qtest_writel(s, base + HACE_HASH_SRC_HI, 0);
     qtest_writel(s, base + HACE_HASH_DIGEST, 0);
+    qtest_writel(s, base + HACE_HASH_DIGEST_HI, 0);
     qtest_writel(s, base + HACE_HASH_DATA_LEN, 0);
 
     /* Check that all bits are now zero */
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_SRC), ==, 0);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_SRC_HI), ==, 0);
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST), ==, 0);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST_HI), ==, 0);
     g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DATA_LEN), ==, 0);
 
     qtest_quit(s);
-- 
2.43.0


