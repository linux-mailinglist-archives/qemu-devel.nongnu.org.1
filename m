Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 783FE741979
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 22:34:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbqz-0007DV-Ak; Wed, 28 Jun 2023 16:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qEbqv-0007D6-SP
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 16:33:26 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com
 ([40.107.243.89] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qEbqt-0005qw-Aq
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 16:33:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5nrPygX1IXnjNCiHjtKEdTN8i3+5Vf5M9Btydoz0LwOKQU1NzaNJ1NC8kLU7E3jkbXwQ/V2Y2B9uVs5DluBGC3kVyPYxdL/5tOFctLIvBb/wINc/whb40Ip+hnqAa0nDhSnJGILKjVP00BHIOwEiT6dhdffHmxkzI2eJicr6s2iNXOj9cyLUrlxjU2dM7TFzYbAU8P6g1ZbtU448ut5NXWi+bGOViXFye+OsS9Jgx8JUc5/zjLDUE0+acA/jffWPIFetlO+RWhiFJh2uk8OtUNGvYv4U+3hA36KWCnyczXm+qGLDVvWhxLKYnLCQPAKjupHAey8BNq2i8QN1hmiqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtD8s8cFtg77xmFKqbMs0OCm5P/BLvrTxfkRyAQUUuI=;
 b=Q/EjA5ymn53p/nqv8gy5scRcJ/YK2wcDqcJKVS42NnERLIMqvqqivqSeaENtbfTtZs7USpAtjbsB4epaQYgDnBw8i6YfAJ+GIzp2DGiadh0h404gh8qYNPwkuFMf46ERRSI4DZystzv+W4zF86CsxFa+68hCdVYd/LL7TniG8gXuuqdNBz40RD8jr1pNjbHtsSOkKTW+qsRekKe/YZw+pVtJoFCNGeH4MQKfvqNzw0OybY1FHiyz1zYdbQv2FlnzKll2ccYkYHD5GcmCX4rAyQX/RoHDV0Fj5F3iWVB/sgWD1+0gg6rSYSLQQ7sLpoNK1uBjPlTpzyQv8MJ9L+V/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtD8s8cFtg77xmFKqbMs0OCm5P/BLvrTxfkRyAQUUuI=;
 b=i4hQZH2U7hUzDb44ZnqyKkmPnKeCDEPWpXQj4OZfQZ0nrGMeJoOdyDAo38u+h2LFwdn7HhtDe5dgA0bkBjV1dtbsAQQs//qke88W9zjNRauNx1yCBp3/WMRRzBosRzn6QNrPbkLPa/g7nh8p2sue/pw2jTT0T7VxUkcKEtfKITA=
Received: from DS7PR05CA0094.namprd05.prod.outlook.com (2603:10b6:8:56::11) by
 SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Wed, 28 Jun
 2023 20:28:17 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::43) by DS7PR05CA0094.outlook.office365.com
 (2603:10b6:8:56::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Wed, 28 Jun 2023 20:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 20:28:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 15:28:14 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 28 Jun 2023 15:28:14 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, Vikram Garhwal <vikram.garhwal@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: [QEMU][PATCH v1] tests/qtest: xlnx-canfd-test: Fix code coverity
 issues
Date: Wed, 28 Jun 2023 13:27:58 -0700
Message-ID: <20230628202758.16398-1-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af7f49c-36f5-4ec8-14ea-08db781633fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVQsQ80SHVjomwAdSQRLmH1qEvYBb7zpGHbEfOshJMTAYAdd18zZ5QRdTTCtSALnkroUvewAP2iZi7gGL0hS4GYCaEmHpq5S3U5g2KBA0hq4yM4ILxvhUjv6GB5auwbhWJ1Or7gSXvSOukpNXMy+Wd5JfCBiQ4prfSOidWBXthaPBq8dA8LlvUoX/gp2aNHaBwytsTuNHGmxzfv5ETJeyh2fqmt8hH+HP9U6Yioz+/R1Z7glwahcLEga0iOTWQWIe0iW7eYC1QuGyOBZLy2z6meYesRXUn7xhnViW9Rvt97TEkz4vmbUiA/MzF00PhhId4p2UNxtg3H0IqaHVJsldTx4oAOLBXHLV0sCzkA12x5qGxDnTfOT3KiHt+KMbTunPz1jwIH3aRoNdWoQyRKdIGnbacI4mfpToJVzqwK5NvCqyNSaExLYPVEtX3d+z1pOlTYpYbEXCxkz7S/r6tZU0IoxhQ9cs+2YYXRuaB3w+G2le0/BpfYJd8y9YWfiQr1Nur5MbjptLF1xOGE5ODlOmaKY83fOape/8pjHbHaqQB3bgbJuzfvOb1pIPcBlfNBdhiR+u2N8L2NfgaR+GbFI37s+6uBpO6r/42+VBlexD/Ut8llJq3iGXfv/3Z5AbZpdoY5XOAMZaRabDWk9fIhYmXmLdq5xVRvKX/s27GeuEsI3ChUCfN6MeBekFXEHdFU9swHA/+ipXL/ASHzxss0BpMQYrs3UK8PRXguuqAaZ8KwN7yWDoB9wb9kFwl5crnLDtqA6TCW/0Ass20MH21PEVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(82310400005)(426003)(2906002)(2616005)(40460700003)(336012)(186003)(26005)(4326008)(70586007)(316002)(6916009)(70206006)(40480700001)(356005)(36756003)(81166007)(6666004)(54906003)(86362001)(36860700001)(478600001)(83380400001)(1076003)(47076005)(41300700001)(8936002)(8676002)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 20:28:15.8982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af7f49c-36f5-4ec8-14ea-08db781633fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
Received-SPF: softfail client-ip=40.107.243.89;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Following are done to fix the coverity issues:
1. Change read_data to fix the CID 1512899: Out-of-bounds access (OVERRUN)
2. Fix match_rx_tx_data to fix CID 1512900: Logically dead code (DEADCODE)
3. Replace rand() in generate_random_data() with g_rand_int()

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
---
 tests/qtest/xlnx-canfd-test.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/tests/qtest/xlnx-canfd-test.c b/tests/qtest/xlnx-canfd-test.c
index 76ee106d4f..78ec9ef2a7 100644
--- a/tests/qtest/xlnx-canfd-test.c
+++ b/tests/qtest/xlnx-canfd-test.c
@@ -170,23 +170,23 @@ static void generate_random_data(uint32_t *buf_tx, bool is_canfd_frame)
     /* Generate random TX data for CANFD frame. */
     if (is_canfd_frame) {
         for (int i = 0; i < CANFD_FRAME_SIZE - 2; i++) {
-            buf_tx[2 + i] = rand();
+            buf_tx[2 + i] = g_random_int();
         }
     } else {
         /* Generate random TX data for CAN frame. */
         for (int i = 0; i < CAN_FRAME_SIZE - 2; i++) {
-            buf_tx[2 + i] = rand();
+            buf_tx[2 + i] = g_random_int();
         }
     }
 }
 
-static void read_data(QTestState *qts, uint64_t can_base_addr, uint32_t *buf_rx)
+static void read_data(QTestState *qts, uint64_t can_base_addr, uint32_t *buf_rx,
+                      uint32_t frame_size)
 {
     uint32_t int_status;
     uint32_t fifo_status_reg_value;
     /* At which RX FIFO the received data is stored. */
     uint8_t store_ind = 0;
-    bool is_canfd_frame = false;
 
     /* Read the interrupt on CANFD rx. */
     int_status = qtest_readl(qts, can_base_addr + R_ISR_OFFSET) & ISR_RXOK;
@@ -207,16 +207,9 @@ static void read_data(QTestState *qts, uint64_t can_base_addr, uint32_t *buf_rx)
     buf_rx[0] = qtest_readl(qts, can_base_addr + R_RX0_ID_OFFSET);
     buf_rx[1] = qtest_readl(qts, can_base_addr + R_RX0_DLC_OFFSET);
 
-    is_canfd_frame = (buf_rx[1] >> DLC_FD_BIT_SHIFT) & 1;
-
-    if (is_canfd_frame) {
-        for (int i = 0; i < CANFD_FRAME_SIZE - 2; i++) {
-            buf_rx[i + 2] = qtest_readl(qts,
-                                    can_base_addr + R_RX0_DATA1_OFFSET + 4 * i);
-        }
-    } else {
-        buf_rx[2] = qtest_readl(qts, can_base_addr + R_RX0_DATA1_OFFSET);
-        buf_rx[3] = qtest_readl(qts, can_base_addr + R_RX0_DATA2_OFFSET);
+    for (int i = 0; i < frame_size - 2; i++) {
+        buf_rx[i + 2] = qtest_readl(qts,
+                                can_base_addr + R_RX0_DATA1_OFFSET + 4 * i);
     }
 
     /* Clear the RX interrupt. */
@@ -272,10 +265,6 @@ static void match_rx_tx_data(const uint32_t *buf_tx, const uint32_t *buf_rx,
             g_assert_cmpint((buf_rx[size] & DLC_FD_BIT_MASK), ==,
                             (buf_tx[size] & DLC_FD_BIT_MASK));
         } else {
-            if (!is_canfd_frame && size == 4) {
-                break;
-            }
-
             g_assert_cmpint(buf_rx[size], ==, buf_tx[size]);
         }
 
@@ -318,7 +307,7 @@ static void test_can_data_transfer(void)
     write_data(qts, CANFD0_BASE_ADDR, buf_tx, false);
 
     send_data(qts, CANFD0_BASE_ADDR);
-    read_data(qts, CANFD1_BASE_ADDR, buf_rx);
+    read_data(qts, CANFD1_BASE_ADDR, buf_rx, CAN_FRAME_SIZE);
     match_rx_tx_data(buf_tx, buf_rx, false);
 
     qtest_quit(qts);
@@ -358,7 +347,7 @@ static void test_canfd_data_transfer(void)
     write_data(qts, CANFD0_BASE_ADDR, buf_tx, true);
 
     send_data(qts, CANFD0_BASE_ADDR);
-    read_data(qts, CANFD1_BASE_ADDR, buf_rx);
+    read_data(qts, CANFD1_BASE_ADDR, buf_rx, CANFD_FRAME_SIZE);
     match_rx_tx_data(buf_tx, buf_rx, true);
 
     qtest_quit(qts);
@@ -397,7 +386,7 @@ static void test_can_loopback(void)
     write_data(qts, CANFD0_BASE_ADDR, buf_tx, true);
 
     send_data(qts, CANFD0_BASE_ADDR);
-    read_data(qts, CANFD0_BASE_ADDR, buf_rx);
+    read_data(qts, CANFD0_BASE_ADDR, buf_rx, CANFD_FRAME_SIZE);
     match_rx_tx_data(buf_tx, buf_rx, true);
 
     generate_random_data(buf_tx, true);
@@ -405,7 +394,7 @@ static void test_can_loopback(void)
     write_data(qts, CANFD1_BASE_ADDR, buf_tx, true);
 
     send_data(qts, CANFD1_BASE_ADDR);
-    read_data(qts, CANFD1_BASE_ADDR, buf_rx);
+    read_data(qts, CANFD1_BASE_ADDR, buf_rx, CANFD_FRAME_SIZE);
     match_rx_tx_data(buf_tx, buf_rx, true);
 
     qtest_quit(qts);
-- 
2.30.2


