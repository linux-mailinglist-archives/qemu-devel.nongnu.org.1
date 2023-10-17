Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D873B7CCDFD
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:27:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqdm-0007d5-MN; Tue, 17 Oct 2023 16:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzp-000455-IB; Tue, 17 Oct 2023 15:44:53 -0400
Received: from mail-dm6nam11on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::608]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzn-0000vm-JD; Tue, 17 Oct 2023 15:44:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCy/iamP79AIRKb6WL4OgvNcPP9jxorXzN1kqRhIzWowCmUBphbBO3dH4+03fKGzolhlkS/FUhULq1MIbmtNC8PFtU37n5aMNDxss4jKgBisUACPSEuHsrSJWCVWo6WTYPA9tOkxMYGX8O911pzlpj/TqE4KT8gq94AonGwcrnFnDtIe+I/Q1nTpMXIw2i+oovwhkNHm2LohmioOaJzcYsC8SDO7aWojmcflswJ97NfEzuQjXSbPAplu46hEQl07ZzXjgKn1c1D9NhNecRxv07QoO5CDZLDupBB6nSiy17ftBDj7CgVLiHyWCLyNK+/mJozEJQXIaznQkAJQ4QLaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpFZ+m3FMZcFkiO8EUyTwZ2nJYfSiCBTYgSFpHc6ywA=;
 b=IIhPUDK8wQfWKQNdsJU2evtb2essWfG+Hg0TYu+Y+bq5N1FvieBbN1BOZIrV65KIW93mbHfnIBipl1MIugwYcUUJTw53cOhKkdU1POSYlFCl5ghp3up9eyOCMIiTVmrTcGwCxPDOKsbkdoNcrbHnqEuNnzx1p1+38zjXEvPIg85Xf4BU99otRaEVw/hvqy3zcPyHTnjg/HTcAwTo+1m3XOTsx0HVc3dM3azVlq1BWcBrH9A+oI4ZU7bH1vlRn+6ljGRECofGyrhOuSRH4GWor5mQvg/Kt3HewgDb9n8sDbTSvYF79g/N99yvTi61TRbSxT6SxY5W6SDZS58S3y8KZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpFZ+m3FMZcFkiO8EUyTwZ2nJYfSiCBTYgSFpHc6ywA=;
 b=vE4YRS4Nz0saXbTAomnBmRTQLNjPVtntYg0KHEG9Jl5d/Mn/gX1hfOWwBN3FjQTbq4pdQnAAGYR1ERBOrgmIFZOBAgW7og+eG3SLdeRJQue77If15fXzcKUpeWpQBmduXW/BGo/csUG12FNFue8MpO+EP4Ok0m2TPZgeK+E1ylI=
Received: from BY5PR20CA0034.namprd20.prod.outlook.com (2603:10b6:a03:1f4::47)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 19:44:47 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::b6) by BY5PR20CA0034.outlook.office365.com
 (2603:10b6:a03:1f4::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 19:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Tue, 17 Oct 2023 19:44:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:44:45 -0500
Received: from luc-work-vm.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:44:44 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, <qemu-arm@nongnu.org>, "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Wang" <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>
Subject: [PATCH 07/11] hw/net/cadence_gem: use FIELD to describe IRQ register
 fields
Date: Tue, 17 Oct 2023 21:44:18 +0200
Message-ID: <20231017194422.4124691-8-luc.michel@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017194422.4124691-1-luc.michel@amd.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fb2be4-dd75-46c2-7542-08dbcf4984ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2irgnGx82jkPb8+YAG6Rq5rsMdPCy5YUnMkhs1fqqJFZq98YiWfv9XflPPUy8k215IVuMdqp/ycynHXdlmA0C03WKwPB1JHGE9JSB2ZbTZImEtYSX4Q0QJwztt3o0BwI09DPu7r3ilDxZtvK3ZstX4OLlQ5q4WL8m+bkfZrKuwleUqTuDiZ5alwEYemZGhdLDv0JnJ1NW3iYOJapoF+Yvz1J/uqiP30lasWE95ne/QaukIRo97yWxZyfjufzqWVTqXhI6CLzX+OU9BMnskGPAbG1AKipWYO0I0SR0bwM66YUsUqpwlOGf5rw+sNzJbJH/XWcUqmbp2nql0zedSSxZgIj4U9nJy10DPFcH73JJ9/JELzgd5oEK7E9uJy4J2AlMxJRfJjljvS4c/0vjrKI8U+BWZrKgih0n2nI9CwbYiBiSxX0zBLPeimJn1moIJimO4yrPjrBwXYbXin04tj8IAM3UrN+cK6ZgSCUc/Zp79nysCKTx7wWoDhehBjgoCaKBrzS4vK2vmepMQrMl7f5FHYj3pj66TdGbhHH20rDKl94AiKX8tyh54MoOm6K7FWf0DOgEXhsne1QGLoFPMUIovkdBg5Lkb3ogBwuPY4XeN+2WD+/siA5T+nKGZJB0BafUsW4EWQxSYFLLzfGIkBf7px2xIhb1BN4kbVLOzDg2wZ7qRhwKCNS16ibmGx+6AFhs6UL5pmbNS16yulINAMgaZZbpnk703zTaRI1CADYACNVZAed/HflqQkLbQTc61/19iSwSfkEAmcAWdFQoF6/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(40460700003)(26005)(2616005)(1076003)(6666004)(8936002)(426003)(70586007)(36860700001)(336012)(83380400001)(8676002)(5660300002)(4326008)(44832011)(47076005)(41300700001)(70206006)(2906002)(478600001)(316002)(6916009)(54906003)(82740400003)(356005)(81166007)(86362001)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:44:46.7869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fb2be4-dd75-46c2-7542-08dbcf4984ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::608;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

Use de FIELD macro to describe the IRQ related register fields.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/net/cadence_gem.c | 51 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 0acee1d544..6d084a3b31 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -155,13 +155,46 @@ REG32(RXSTATUS, 0x20) /* RX Status reg */
     FIELD(RXSTATUS, RECEIVE_OVERRUN, 2, 1)
     FIELD(RXSTATUS, FRAME_RECEIVED, 1, 1)
     FIELD(RXSTATUS, BUF_NOT_AVAILABLE, 0, 1)
 
 REG32(ISR, 0x24) /* Interrupt Status reg */
+    FIELD(ISR, TX_LOCKUP, 31, 1)
+    FIELD(ISR, RX_LOCKUP, 30, 1)
+    FIELD(ISR, TSU_TIMER, 29, 1)
+    FIELD(ISR, WOL, 28, 1)
+    FIELD(ISR, RECV_LPI, 27, 1)
+    FIELD(ISR, TSU_SEC_INCR, 26, 1)
+    FIELD(ISR, PTP_PDELAY_RESP_XMIT, 25, 1)
+    FIELD(ISR, PTP_PDELAY_REQ_XMIT, 24, 1)
+    FIELD(ISR, PTP_PDELAY_RESP_RECV, 23, 1)
+    FIELD(ISR, PTP_PDELAY_REQ_RECV, 22, 1)
+    FIELD(ISR, PTP_SYNC_XMIT, 21, 1)
+    FIELD(ISR, PTP_DELAY_REQ_XMIT, 20, 1)
+    FIELD(ISR, PTP_SYNC_RECV, 19, 1)
+    FIELD(ISR, PTP_DELAY_REQ_RECV, 18, 1)
+    FIELD(ISR, PCS_LP_PAGE_RECV, 17, 1)
+    FIELD(ISR, PCS_AN_COMPLETE, 16, 1)
+    FIELD(ISR, EXT_IRQ, 15, 1)
+    FIELD(ISR, PAUSE_FRAME_XMIT, 14, 1)
+    FIELD(ISR, PAUSE_TIME_ELAPSED, 13, 1)
+    FIELD(ISR, PAUSE_FRAME_RECV, 12, 1)
+    FIELD(ISR, RESP_NOT_OK, 11, 1)
+    FIELD(ISR, RECV_OVERRUN, 10, 1)
+    FIELD(ISR, LINK_CHANGE, 9, 1)
+    FIELD(ISR, USXGMII_INT, 8, 1)
+    FIELD(ISR, XMIT_COMPLETE, 7, 1)
+    FIELD(ISR, AMBA_ERROR, 6, 1)
+    FIELD(ISR, RETRY_EXCEEDED, 5, 1)
+    FIELD(ISR, XMIT_UNDER_RUN, 4, 1)
+    FIELD(ISR, TX_USED, 3, 1)
+    FIELD(ISR, RX_USED, 2, 1)
+    FIELD(ISR, RECV_COMPLETE, 1, 1)
+    FIELD(ISR, MGNT_FRAME_SENT, 0, 1)
 REG32(IER, 0x28) /* Interrupt Enable reg */
 REG32(IDR, 0x2c) /* Interrupt Disable reg */
 REG32(IMR, 0x30) /* Interrupt Mask reg */
+
 REG32(PHYMNTNC, 0x34) /* Phy Maintenance reg */
 REG32(RXPAUSE, 0x38) /* RX Pause Time reg */
 REG32(TXPAUSE, 0x3c) /* TX Pause Time reg */
 REG32(TXPARTIALSF, 0x40) /* TX Partial Store and Forward */
 REG32(RXPARTIALSF, 0x44) /* RX Partial Store and Forward */
@@ -306,16 +339,10 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
 
 /*****************************************/
 
 
-/* GEM_ISR GEM_IER GEM_IDR GEM_IMR */
-#define GEM_INT_TXCMPL        0x00000080 /* Transmit Complete */
-#define GEM_INT_AMBA_ERR      0x00000040
-#define GEM_INT_TXUSED         0x00000008
-#define GEM_INT_RXUSED         0x00000004
-#define GEM_INT_RXCMPL        0x00000002
 
 #define GEM_PHYMNTNC_OP_R      0x20000000 /* read operation */
 #define GEM_PHYMNTNC_OP_W      0x10000000 /* write operation */
 #define GEM_PHYMNTNC_ADDR      0x0F800000 /* Address bits */
 #define GEM_PHYMNTNC_ADDR_SHFT 23
@@ -1002,11 +1029,11 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
 
     /* Descriptor owned by software ? */
     if (rx_desc_get_ownership(s->rx_desc[q]) == 1) {
         DB_PRINT("descriptor 0x%" HWADDR_PRIx " owned by sw.\n", desc_addr);
         s->regs[R_RXSTATUS] |= R_RXSTATUS_BUF_NOT_AVAILABLE_MASK;
-        gem_set_isr(s, q, GEM_INT_RXUSED);
+        gem_set_isr(s, q, R_ISR_RX_USED_MASK);
         /* Handle interrupt consequences */
         gem_update_int_status(s);
     }
 }
 
@@ -1102,11 +1129,11 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     /* Find which queue we are targeting */
     q = get_queue_from_screen(s, rxbuf_ptr, rxbufsize);
 
     if (size > gem_get_max_buf_len(s, false)) {
         qemu_log_mask(LOG_GUEST_ERROR, "rx frame too long\n");
-        gem_set_isr(s, q, GEM_INT_AMBA_ERR);
+        gem_set_isr(s, q, R_ISR_AMBA_ERROR_MASK);
         return -1;
     }
 
     while (bytes_to_copy) {
         hwaddr desc_addr;
@@ -1179,11 +1206,11 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
 
     /* Count it */
     gem_receive_updatestats(s, buf, size);
 
     s->regs[R_RXSTATUS] |= R_RXSTATUS_FRAME_RECEIVED_MASK;
-    gem_set_isr(s, q, GEM_INT_RXCMPL);
+    gem_set_isr(s, q, R_ISR_RECV_COMPLETE_MASK);
 
     /* Handle interrupt consequences */
     gem_update_int_status(s);
 
     return size;
@@ -1292,11 +1319,11 @@ static void gem_transmit(CadenceGEMState *s)
                                                (p - s->tx_packet)) {
                 qemu_log_mask(LOG_GUEST_ERROR, "TX descriptor @ 0x%" \
                          HWADDR_PRIx " too large: size 0x%x space 0x%zx\n",
                          packet_desc_addr, tx_desc_get_length(desc),
                          gem_get_max_buf_len(s, true) - (p - s->tx_packet));
-                gem_set_isr(s, q, GEM_INT_AMBA_ERR);
+                gem_set_isr(s, q, R_ISR_AMBA_ERROR_MASK);
                 break;
             }
 
             /* Gather this fragment of the packet from "dma memory" to our
              * contig buffer.
@@ -1330,11 +1357,11 @@ static void gem_transmit(CadenceGEMState *s)
                                          4 * gem_get_desc_len(s, false);
                 }
                 DB_PRINT("TX descriptor next: 0x%08x\n", s->tx_desc_addr[q]);
 
                 s->regs[R_TXSTATUS] |= R_TXSTATUS_TRANSMIT_COMPLETE_MASK;
-                gem_set_isr(s, q, GEM_INT_TXCMPL);
+                gem_set_isr(s, q, R_ISR_XMIT_COMPLETE_MASK);
 
                 /* Handle interrupt consequences */
                 gem_update_int_status(s);
 
                 /* Is checksum offload enabled? */
@@ -1380,11 +1407,11 @@ static void gem_transmit(CadenceGEMState *s)
 
         if (tx_desc_get_used(desc)) {
             s->regs[R_TXSTATUS] |= R_TXSTATUS_USED_BIT_READ_MASK;
             /* IRQ TXUSED is defined only for queue 0 */
             if (q == 0) {
-                gem_set_isr(s, 0, GEM_INT_TXUSED);
+                gem_set_isr(s, 0, R_ISR_TX_USED_MASK);
             }
             gem_update_int_status(s);
         }
     }
 }
-- 
2.39.2


