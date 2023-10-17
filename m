Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA767CCDF9
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:26:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqdk-0007d3-Ar; Tue, 17 Oct 2023 16:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzo-00044x-TL; Tue, 17 Oct 2023 15:44:52 -0400
Received: from mail-bn1nam02on20618.outbound.protection.outlook.com
 ([2a01:111:f400:7eb2::618]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzm-0000vb-RZ; Tue, 17 Oct 2023 15:44:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEZNaPEwSozbI1IEhgaPZSocuORMTsZhot9YEoNZb4zyNmL3o20kJR+WvAKY9lNXD5DZ+AoyAE10WuJh7NZ3V6vLUs/Bpc2v/6vDp16FYnYGMOJXFo0APfWU4ZpUsYWqQQCAsfvu5SXSxTK3t5lWpKibF1GLQbZlNqJIEInX4NMhi1dLF6FEPY9bUb51pLzL0ul5FkHHtFqFwChxLeVsIfBJ8wzQdYKSYIXxiKRhOJOtiTogqjk1Twn5nXkRizKyYfhe3YYyzynu6yVZLpG8lLQgkfgmytdKSiAt71KpcGavZXOai7sCsjTCVsWeybMGD2l7/qcFMffB03F9D5qA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZ4v9khYxQHHJ2QwDHhrlpYpdxLf+yNlB6tsG92YXKI=;
 b=UtZEQREa1Zki+LcopqMpx9YpSu3Zu6aGquJSUr5OSKonAWWjIoegWWLb2/10PEQbry3VpSzHegc231NROWmvvzO+M7Od13+dZ938XsQDE7NjzRffPGTbnqnWA40aUHDpCoM0b3jXectG0zm42aQigKkCzDTu/eMSKwT7/3fexq6O7QCFzjvSG542nSN+ZclZupI5EFtLyGTSTx4pEfBxAW28oVjxx4m/ULzcPZyjNrKXJzCISDSRbzh4jy6LPhovA2lIXZ2bDD/WFMX2e/20pIUYDc0b/wPtyV7qr2x0yn1G2OsNPM73PBEpjBQ4btm88b0q2J8PtL3AGzJ5NM/qPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ4v9khYxQHHJ2QwDHhrlpYpdxLf+yNlB6tsG92YXKI=;
 b=WsS2aUyNuvz7o7+6dKFZEcgRZfvSW3uzLiFtlk93GXBBZyQb5smPb/KnjMj4i1KFVhFfDKF0TZSFz6dY7fE2m/MJugbGipNrxnIwbx64iBJlYnIvTiy4Dg4q0Qsmb6akqoAAw+A1umsD6xtCFlChdly43/1gCPG9NFEABF/L5F0=
Received: from MW4PR04CA0041.namprd04.prod.outlook.com (2603:10b6:303:6a::16)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 19:44:45 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::6f) by MW4PR04CA0041.outlook.office365.com
 (2603:10b6:303:6a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 19:44:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.22 via Frontend Transport; Tue, 17 Oct 2023 19:44:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:44:43 -0500
Received: from luc-work-vm.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:44:42 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, <qemu-arm@nongnu.org>, "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Wang" <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>
Subject: [PATCH 06/11] hw/net/cadence_gem: use FIELD to describe [TX|RX]STATUS
 register fields
Date: Tue, 17 Oct 2023 21:44:17 +0200
Message-ID: <20231017194422.4124691-7-luc.michel@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017194422.4124691-1-luc.michel@amd.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e71871-6540-4a4e-d937-08dbcf498384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwN3ctnSexemR69vcjBtK074H57kbg5r4sc4Z1w/EqDEMRPPZP5U/RAx6lDpkTH0976p0XAvtwivg/ScbGe1AB0CJjSGas/EYeK6arnPuItyYJ95aP/YegtOeTPY4Ktlf6u4SA1VC/964aDAOnZBpTtA4IVLgyAwDZ++PQLHt5L8gbx8TwcQ+xtT+Dp1oo4iX7bJOr2cAi6P6SUnno1sH05YDfG/pgHk3diW9zz0Crc9NGhDtSa+EwuO7bk5z5tEf+pxem+XOlWM2p1t8x5122lJsHt2Eu9O5QR7atC1f9iWIFMKkWO8hT3J5/cqM75MA0e+e383YqJA79a6OBQzJjhHrMj6oma44ILkjmQUWW/YM7c2UYksv2ZfXjuK9o8BoPDuy44r7+G3RqKdnR5i+lG5W89/8X++y3/HAdtjiwKDr08YH9fqxo++BRyYX3t0SAvVAcbANbmwrEZC4OWQIioEEeFhhCMRDvYz4Sd8FLdyeuninbI6xiOqPIxnVDo7sA6lj2I/qZkKTHLwx6V8hfV/iSB8RThoIuMojQDHRjAzv4HCPwnCQjRabN6Eje0rrlZ6rjqm1OWF7aJS1Sp/ABz1Npeho2zY0avnkjr+4FHPWmT/eJZE38mWij3lFNScDvueVmvez2DagjmcRDeX6lhuJg/Cge5jGU3/ZD1RHDYjZkQwnCTAysbQmJ27bcF3cz9VJbtELRVCazwiZr07bUiSAjYV52pxufsYrrpxNawAxqjVEEkTe4+eGy1NR5CQ+xwaJ54jmr6JM3VVX/2EA4V0+rsxUOvpKMq2LNAqQYQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(86362001)(36756003)(40480700001)(26005)(40460700003)(336012)(2906002)(478600001)(44832011)(41300700001)(5660300002)(81166007)(82740400003)(356005)(2616005)(6666004)(36860700001)(1076003)(70206006)(426003)(316002)(8936002)(8676002)(70586007)(4326008)(6916009)(54906003)(83380400001)(47076005)(83133001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:44:44.7422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e71871-6540-4a4e-d937-08dbcf498384
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113
Received-SPF: softfail client-ip=2a01:111:f400:7eb2::618;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Oct 2023 16:26:01 -0400
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

Use de FIELD macro to describe the TXSTATUS and RXSTATUS register
fields.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/net/cadence_gem.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 5c386adff2..0acee1d544 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -130,13 +130,34 @@ REG32(DMACFG, 0x10) /* DMA Control reg */
     FIELD(DMACFG, HDR_DATA_SPLIT_EN, 5, 1)
     FIELD(DMACFG, AMBA_BURST_LEN , 0, 5)
 #define GEM_DMACFG_RBUFSZ_MUL  64         /* DMA RX Buffer Size multiplier */
 
 REG32(TXSTATUS, 0x14) /* TX Status reg */
+    FIELD(TXSTATUS, TX_USED_BIT_READ_MIDFRAME, 12, 1)
+    FIELD(TXSTATUS, TX_FRAME_TOO_LARGE, 11, 1)
+    FIELD(TXSTATUS, TX_DMA_LOCKUP, 10, 1)
+    FIELD(TXSTATUS, TX_MAC_LOCKUP, 9, 1)
+    FIELD(TXSTATUS, RESP_NOT_OK, 8, 1)
+    FIELD(TXSTATUS, LATE_COLLISION, 7, 1)
+    FIELD(TXSTATUS, TRANSMIT_UNDER_RUN, 6, 1)
+    FIELD(TXSTATUS, TRANSMIT_COMPLETE, 5, 1)
+    FIELD(TXSTATUS, AMBA_ERROR, 4, 1)
+    FIELD(TXSTATUS, TRANSMIT_GO, 3, 1)
+    FIELD(TXSTATUS, RETRY_LIMIT, 2, 1)
+    FIELD(TXSTATUS, COLLISION, 1, 1)
+    FIELD(TXSTATUS, USED_BIT_READ, 0, 1)
+
 REG32(RXQBASE, 0x18) /* RX Q Base address reg */
 REG32(TXQBASE, 0x1c) /* TX Q Base address reg */
 REG32(RXSTATUS, 0x20) /* RX Status reg */
+    FIELD(RXSTATUS, RX_DMA_LOCKUP, 5, 1)
+    FIELD(RXSTATUS, RX_MAC_LOCKUP, 4, 1)
+    FIELD(RXSTATUS, RESP_NOT_OK, 3, 1)
+    FIELD(RXSTATUS, RECEIVE_OVERRUN, 2, 1)
+    FIELD(RXSTATUS, FRAME_RECEIVED, 1, 1)
+    FIELD(RXSTATUS, BUF_NOT_AVAILABLE, 0, 1)
+
 REG32(ISR, 0x24) /* Interrupt Status reg */
 REG32(IER, 0x28) /* Interrupt Enable reg */
 REG32(IDR, 0x2c) /* Interrupt Disable reg */
 REG32(IMR, 0x30) /* Interrupt Mask reg */
 REG32(PHYMNTNC, 0x34) /* Phy Maintenance reg */
@@ -284,15 +305,10 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
     FIELD(TYPE2_COMPARE_0_WORD_1, DISABLE_MASK, 9, 1)
     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
 
 /*****************************************/
 
-#define GEM_TXSTATUS_TXCMPL    0x00000020 /* Transmit Complete */
-#define GEM_TXSTATUS_USED      0x00000001 /* sw owned descriptor encountered */
-
-#define GEM_RXSTATUS_FRMRCVD   0x00000002 /* Frame received */
-#define GEM_RXSTATUS_NOBUF     0x00000001 /* Buffer unavailable */
 
 /* GEM_ISR GEM_IER GEM_IDR GEM_IMR */
 #define GEM_INT_TXCMPL        0x00000080 /* Transmit Complete */
 #define GEM_INT_AMBA_ERR      0x00000040
 #define GEM_INT_TXUSED         0x00000008
@@ -985,11 +1001,11 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
                        sizeof(uint32_t) * gem_get_desc_len(s, true));
 
     /* Descriptor owned by software ? */
     if (rx_desc_get_ownership(s->rx_desc[q]) == 1) {
         DB_PRINT("descriptor 0x%" HWADDR_PRIx " owned by sw.\n", desc_addr);
-        s->regs[R_RXSTATUS] |= GEM_RXSTATUS_NOBUF;
+        s->regs[R_RXSTATUS] |= R_RXSTATUS_BUF_NOT_AVAILABLE_MASK;
         gem_set_isr(s, q, GEM_INT_RXUSED);
         /* Handle interrupt consequences */
         gem_update_int_status(s);
     }
 }
@@ -1162,11 +1178,11 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     }
 
     /* Count it */
     gem_receive_updatestats(s, buf, size);
 
-    s->regs[R_RXSTATUS] |= GEM_RXSTATUS_FRMRCVD;
+    s->regs[R_RXSTATUS] |= R_RXSTATUS_FRAME_RECEIVED_MASK;
     gem_set_isr(s, q, GEM_INT_RXCMPL);
 
     /* Handle interrupt consequences */
     gem_update_int_status(s);
 
@@ -1313,11 +1329,11 @@ static void gem_transmit(CadenceGEMState *s)
                     s->tx_desc_addr[q] = packet_desc_addr +
                                          4 * gem_get_desc_len(s, false);
                 }
                 DB_PRINT("TX descriptor next: 0x%08x\n", s->tx_desc_addr[q]);
 
-                s->regs[R_TXSTATUS] |= GEM_TXSTATUS_TXCMPL;
+                s->regs[R_TXSTATUS] |= R_TXSTATUS_TRANSMIT_COMPLETE_MASK;
                 gem_set_isr(s, q, GEM_INT_TXCMPL);
 
                 /* Handle interrupt consequences */
                 gem_update_int_status(s);
 
@@ -1361,11 +1377,11 @@ static void gem_transmit(CadenceGEMState *s)
                                MEMTXATTRS_UNSPECIFIED, desc,
                                sizeof(uint32_t) * gem_get_desc_len(s, false));
         }
 
         if (tx_desc_get_used(desc)) {
-            s->regs[R_TXSTATUS] |= GEM_TXSTATUS_USED;
+            s->regs[R_TXSTATUS] |= R_TXSTATUS_USED_BIT_READ_MASK;
             /* IRQ TXUSED is defined only for queue 0 */
             if (q == 0) {
                 gem_set_isr(s, 0, GEM_INT_TXUSED);
             }
             gem_update_int_status(s);
-- 
2.39.2


