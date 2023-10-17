Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B897CCDFA
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:26:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqe0-00083s-Bc; Tue, 17 Oct 2023 16:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzl-00044J-MI; Tue, 17 Oct 2023 15:44:49 -0400
Received: from mail-dm6nam11on2060b.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::60b]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzj-0000v2-LD; Tue, 17 Oct 2023 15:44:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQK7VuFCY61YnFxdEFXkPzMm4joEf6IrjHpo6iXNL3ilQgDJF8JD98lacbFknK8LVBr/wKTDlEO36fGXseVNK8Nb3Pa2j6ESFXujujVgZaH3m38HGlCRNuwlWq7hKlXxbd202RaDebglY/CZdPOLia0OYpJ+gQIKoClLAbGQ7DeC5vIFdxs4TbdO1oPvQ0sIyfwY/QRnJ6a2U4m1/68bl8HclPZ1PwCUGEMD2fTIFQM1BeMTwWWEM/S9FvCY9okkiGt0XDf6ndod0iFKoOnHhY0GRQdxGH3xXeW+1XV3/lGfDQPVirym+oGWKWWRbsVWnew9FH9f0wsNWClDov3W1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmoVqKpHJv02WQOVFouzw4IskBOZEEJDik76TxVclHM=;
 b=KMhKZDzjCs1IPjgUDTSR39V1kZ0ugWkt8IAgm+2YS47LeMrOgzJpzI6SOmgCOVx7qlqTq/4tvJ5otnat38SBGvW/lEBuOV43DL7OO98q7mTvzcYyqnBSxcfmSH+fZHlGGEoZ9GEhWcjcSbM35Tj1U7Pr1LaGTG59wyxSBHSx1ZnqDCS1ECJwlME+KRHm5HzWHXdcZtROAR9ITzP6D62dkxE15AEP2iLgVKv3XfW3s2WJOnBm2xCzmScp4+Pi2ntDru/XKYFAcHMeb1InOO7tnUAVDlObEy1bmVNaGpFjUghk1pHbXLdQBZsfT8sML8GpnMdnfV6V54Ilqj7o0YRAlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmoVqKpHJv02WQOVFouzw4IskBOZEEJDik76TxVclHM=;
 b=sf/ZGREPNYyEKtOqJsJ/89f3s1kPCshyQ1ILXBfkLGqDsvzMuTPXPPrbnKdxxHNx2dTLzJBZi6txZCYPeeS3eQfyhfZxOCEAO1j//GpaOB1rDoG9dTt8wYKIbnqx+OmepXR9NtJw7b13dZGGjK5F92WJDJ/79SYxyghNaWLZRGs=
Received: from BY5PR13CA0034.namprd13.prod.outlook.com (2603:10b6:a03:180::47)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 19:44:43 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::c1) by BY5PR13CA0034.outlook.office365.com
 (2603:10b6:a03:180::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Tue, 17 Oct 2023 19:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.22 via Frontend Transport; Tue, 17 Oct 2023 19:44:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:44:41 -0500
Received: from luc-work-vm.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:44:40 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, <qemu-arm@nongnu.org>, "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Wang" <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>
Subject: [PATCH 05/11] hw/net/cadence_gem: use FIELD to describe DMACFG
 register fields
Date: Tue, 17 Oct 2023 21:44:16 +0200
Message-ID: <20231017194422.4124691-6-luc.michel@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017194422.4124691-1-luc.michel@amd.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a7d50b-77cb-4b8e-14a7-08dbcf498294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bW8WpoXWifAEW75DAgKwyJLdVVT0jeslzYbci1jcO9qPY9O83AtfhMiY+rZMfQZ27TCU4CP/nlRm3b5UPo2bS8jekelUKztfU6kOL+hwKgN9s6oHczeD5BollkcO2DkDckowxds7ZQmYyRX5v0lWOxvromh+k7W0zgUXH90kyGzRmFJo6srRh59WQKE5q1EXOlwAEshogVd7TFzb88RTHDkbAJDDazlvL08XAH7Y4t0n5r/YRLfvgJ50eP2nYOt9zsTqu57mJ8WCxpcXGM4nBjf8qSF6XUkmv7rLwSvCZz44cGTLkrUifIjRUjRslLZNn4jwSeRTmdEcg0EwocbQcvyuOV3R8SDxt/W8u/RfUmCmKrtv4kblRR+/tcaNNM6UYsf11Bkhx3WQTssNeNtDTNrBm1I5VN2stW/ccgdJodvp95xWAJfL8u9Hv//QaNtrNAzKW5gdr+EzISNbDSR1ujbiumm0LGvjQr3DNYoD/tsPAL4SdCAqqHk7JL6m8ZyVE2KNfH8yN2jnTyhhqVTtKS2QU74J2FWRpI/0j2d1DLJNufXsM51yPMACOEP/Fz6k8Qtffnk/U3XVu5pAK40+gCojWU/ISE9mqqXYHYzSdHmhNuGzOAn8ePp+Ql4QgTE9xtqCkw+fNeP5ZvXiUXsctnBhubtFbwZYQTuOrLRrasTwU7Ayp5lONkNGt2wvkuaIBAWWKd3mEKs9sZ9hlhEWs2ZYiauFMwx8nSutbxUQ+eHs1WnMJXzWKx3Ww03P74spmn8v1fU3aSsEmttzIHD9vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(40470700004)(46966006)(36840700001)(83380400001)(6666004)(478600001)(2616005)(356005)(81166007)(1076003)(82740400003)(26005)(426003)(336012)(36860700001)(44832011)(40460700003)(5660300002)(41300700001)(8676002)(8936002)(4326008)(316002)(6916009)(47076005)(54906003)(40480700001)(70586007)(86362001)(70206006)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:44:43.1174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a7d50b-77cb-4b8e-14a7-08dbcf498294
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::60b;
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

Use de FIELD macro to describe the DMACFG register fields.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/net/cadence_gem.c | 48 ++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 09f570b6fb..5c386adff2 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -108,11 +108,31 @@ REG32(NWCFG, 0x4) /* Network Config reg */
     FIELD(NWCFG, IGNORE_IPG_RX_ER, 30, 1)
     FIELD(NWCFG, UNI_DIRECTION_ENABLE, 31, 1)
 
 REG32(NWSTATUS, 0x8) /* Network Status reg */
 REG32(USERIO, 0xc) /* User IO reg */
+
 REG32(DMACFG, 0x10) /* DMA Control reg */
+    FIELD(DMACFG, SEND_BCAST_TO_ALL_QS, 31, 1)
+    FIELD(DMACFG, DMA_ADDR_BUS_WIDTH, 30, 1)
+    FIELD(DMACFG, TX_BD_EXT_MODE_EN , 29, 1)
+    FIELD(DMACFG, RX_BD_EXT_MODE_EN , 28, 1)
+    FIELD(DMACFG, FORCE_MAX_AMBA_BURST_TX, 26, 1)
+    FIELD(DMACFG, FORCE_MAX_AMBA_BURST_RX, 25, 1)
+    FIELD(DMACFG, FORCE_DISCARD_ON_ERR, 24, 1)
+    FIELD(DMACFG, RX_BUF_SIZE, 16, 8)
+    FIELD(DMACFG, CRC_ERROR_REPORT, 13, 1)
+    FIELD(DMACFG, INF_LAST_DBUF_SIZE_EN, 12, 1)
+    FIELD(DMACFG, TX_PBUF_CSUM_OFFLOAD, 11, 1)
+    FIELD(DMACFG, TX_PBUF_SIZE, 10, 1)
+    FIELD(DMACFG, RX_PBUF_SIZE, 8, 2)
+    FIELD(DMACFG, ENDIAN_SWAP_PACKET, 7, 1)
+    FIELD(DMACFG, ENDIAN_SWAP_MGNT, 6, 1)
+    FIELD(DMACFG, HDR_DATA_SPLIT_EN, 5, 1)
+    FIELD(DMACFG, AMBA_BURST_LEN , 0, 5)
+#define GEM_DMACFG_RBUFSZ_MUL  64         /* DMA RX Buffer Size multiplier */
+
 REG32(TXSTATUS, 0x14) /* TX Status reg */
 REG32(RXQBASE, 0x18) /* RX Q Base address reg */
 REG32(TXQBASE, 0x1c) /* TX Q Base address reg */
 REG32(RXSTATUS, 0x20) /* RX Status reg */
 REG32(ISR, 0x24) /* Interrupt Status reg */
@@ -263,17 +283,10 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_OFFSET, 7, 2)
     FIELD(TYPE2_COMPARE_0_WORD_1, DISABLE_MASK, 9, 1)
     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
 
 /*****************************************/
-#define GEM_DMACFG_ADDR_64B    (1U << 30)
-#define GEM_DMACFG_TX_BD_EXT   (1U << 29)
-#define GEM_DMACFG_RX_BD_EXT   (1U << 28)
-#define GEM_DMACFG_RBUFSZ_M    0x00FF0000 /* DMA RX Buffer Size mask */
-#define GEM_DMACFG_RBUFSZ_S    16         /* DMA RX Buffer Size shift */
-#define GEM_DMACFG_RBUFSZ_MUL  64         /* DMA RX Buffer Size multiplier */
-#define GEM_DMACFG_TXCSUM_OFFL 0x00000800 /* Transmit checksum offload */
 
 #define GEM_TXSTATUS_TXCMPL    0x00000020 /* Transmit Complete */
 #define GEM_TXSTATUS_USED      0x00000001 /* sw owned descriptor encountered */
 
 #define GEM_RXSTATUS_FRMRCVD   0x00000002 /* Frame received */
@@ -367,11 +380,11 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
 
 static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
 {
     uint64_t ret = desc[0];
 
-    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
+    if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, DMA_ADDR_BUS_WIDTH)) {
         ret |= (uint64_t)desc[2] << 32;
     }
     return ret;
 }
 
@@ -412,25 +425,25 @@ static inline void print_gem_tx_desc(uint32_t *desc, uint8_t queue)
 
 static inline uint64_t rx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
 {
     uint64_t ret = desc[0] & ~0x3UL;
 
-    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
+    if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, DMA_ADDR_BUS_WIDTH)) {
         ret |= (uint64_t)desc[2] << 32;
     }
     return ret;
 }
 
 static inline int gem_get_desc_len(CadenceGEMState *s, bool rx_n_tx)
 {
     int ret = 2;
 
-    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
+    if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, DMA_ADDR_BUS_WIDTH)) {
         ret += 2;
     }
-    if (s->regs[R_DMACFG] & (rx_n_tx ? GEM_DMACFG_RX_BD_EXT
-                                       : GEM_DMACFG_TX_BD_EXT)) {
+    if (s->regs[R_DMACFG] & (rx_n_tx ? R_DMACFG_RX_BD_EXT_MODE_EN_MASK
+                                     : R_DMACFG_TX_BD_EXT_MODE_EN_MASK)) {
         ret += 2;
     }
 
     assert(ret <= DESC_MAX_NUM_WORDS);
     return ret;
@@ -940,11 +953,11 @@ static inline uint32_t gem_get_rx_queue_base_addr(CadenceGEMState *s, int q)
 
 static hwaddr gem_get_desc_addr(CadenceGEMState *s, bool tx, int q)
 {
     hwaddr desc_addr = 0;
 
-    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
+    if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, DMA_ADDR_BUS_WIDTH)) {
         desc_addr = s->regs[tx ? R_TBQPH : R_RBQPH];
     }
     desc_addr <<= 32;
     desc_addr |= tx ? s->tx_desc_addr[q] : s->rx_desc_addr[q];
     return desc_addr;
@@ -1022,12 +1035,13 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     rxbuf_offset = FIELD_EX32(s->regs[R_NWCFG], NWCFG, RECV_BUF_OFFSET);
 
     /* The configure size of each receive buffer.  Determines how many
      * buffers needed to hold this packet.
      */
-    rxbufsize = ((s->regs[R_DMACFG] & GEM_DMACFG_RBUFSZ_M) >>
-                 GEM_DMACFG_RBUFSZ_S) * GEM_DMACFG_RBUFSZ_MUL;
+    rxbufsize = FIELD_EX32(s->regs[R_DMACFG], DMACFG, RX_BUF_SIZE);
+    rxbufsize *= GEM_DMACFG_RBUFSZ_MUL;
+
     bytes_to_copy = size;
 
     /* Hardware allows a zero value here but warns against it. To avoid QEMU
      * indefinite loops we enforce a minimum value here
      */
@@ -1306,11 +1320,11 @@ static void gem_transmit(CadenceGEMState *s)
 
                 /* Handle interrupt consequences */
                 gem_update_int_status(s);
 
                 /* Is checksum offload enabled? */
-                if (s->regs[R_DMACFG] & GEM_DMACFG_TXCSUM_OFFL) {
+                if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, TX_PBUF_CSUM_OFFLOAD)) {
                     net_checksum_calculate(s->tx_packet, total_bytes, CSUM_ALL);
                 }
 
                 /* Update MAC statistics */
                 gem_transmit_updatestats(s, s->tx_packet, total_bytes);
@@ -1330,11 +1344,11 @@ static void gem_transmit(CadenceGEMState *s)
                 total_bytes = 0;
             }
 
             /* read next descriptor */
             if (tx_desc_get_wrap(desc)) {
-                if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
+                if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, DMA_ADDR_BUS_WIDTH)) {
                     packet_desc_addr = s->regs[R_TBQPH];
                     packet_desc_addr <<= 32;
                 } else {
                     packet_desc_addr = 0;
                 }
-- 
2.39.2


