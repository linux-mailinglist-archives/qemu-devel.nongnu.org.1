Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E12107CCDFE
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:27:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqdu-0007kv-PI; Tue, 17 Oct 2023 16:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzk-000443-Gn; Tue, 17 Oct 2023 15:44:48 -0400
Received: from mail-dm6nam10on2062e.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::62e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzi-0000uh-EX; Tue, 17 Oct 2023 15:44:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiW9pabxcn/H5hkw/djpHK4ZrFN1NYJsRtFJKv+snN0nkciZp2WjDthy/vK6AIzcEmCXNogrcyoTVEvoB9xrQ+N1l85vDp5lpPW3x/JAu1WDm9S3928XypE0dBpXmlsr63rTc6B5MHHBjPWKGFY6m4TSz5QfUxX8vP7YdCpwo+c/Wtdz+QMbfJplKOq/zY9Rc2EBQINaBVRXuUDOQrG86bjrNndBuRhMC4GTJGeiKZn3ZqtG+uLHWxwYEV2xQ4qxNrmKnYA8WB9GOaRtariaEGrH657B7PtHID+8z3qtg3QgDUp5ENwnManRPltZl2+Xo3CO+jXGQMnPW2rpTeUdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUEEqSMbQGyfrWX0W8w0jGx46xmz7TqvVvB6RlxOSCc=;
 b=Lxm81r9YHApPtKxhArCN+RMORWSr2McH0p2kw8RnMlte/vADtSG+yoj9QHelGYnTs3MNi77DGTZEjFZi4BEIIWGdBygrRjRFjf4oJB/O9lngpkHqneFdDymSbf5Cm6W4xOaeLmxrrJgHGNi2oNTdTZiNoNXFERLL8Ff+3koD8TIfnPStIN3vw2vrWo0vn6Jx9ADb7WLb+aF5G8ptyPLMeuqiC7cPwpo9WR4kGBchem3f1WgVxj9ViQhSHCCvsSPXaOAnaglZAyQ1vU7xgl0ftv2a/d3gRF9LUPhHudjyGCE0XFE+l9rtgXeNFqrH1JdOTrCfIITJCSNdSfdw8QqnVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUEEqSMbQGyfrWX0W8w0jGx46xmz7TqvVvB6RlxOSCc=;
 b=K2ef0PFqd/TuUVRdNO45tvIiiuzkEYDk0IISR7usxtpd6mgIu8+LGSEIb27PKJEeW8yiE2TwYk6GykiNJGmPDo8+omPAOoGSrQQRoIbZPCczU7MGVs1yAn+zTZXJbrfXIL9kAkUCFddEj8FuF07eSBfsYXwfnEJhWyUSrjN89P4=
Received: from MW4PR04CA0149.namprd04.prod.outlook.com (2603:10b6:303:84::34)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 19:44:40 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::16) by MW4PR04CA0149.outlook.office365.com
 (2603:10b6:303:84::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 19:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Tue, 17 Oct 2023 19:44:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:44:39 -0500
Received: from luc-work-vm.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:44:38 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, <qemu-arm@nongnu.org>, "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Wang" <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>
Subject: [PATCH 04/11] hw/net/cadence_gem: use FIELD to describe NWCFG
 register fields
Date: Tue, 17 Oct 2023 21:44:15 +0200
Message-ID: <20231017194422.4124691-5-luc.michel@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017194422.4124691-1-luc.michel@amd.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 518c829b-bb74-41c0-6eaa-08dbcf498119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G3v7ciW9tCtFh9TFEF8ekD9r1vF+n0R88otrYc1P69W5a6QG6OVld4j+9SWz2YsvSIu3F2QJxida72HzMLVhHxXCf3o3kgrx9aBsWdgB+sRIrqzBCt05OYI/Tu6sPrtDDF6f+mwhCDwiLlOiOby2y9xdIrOj90bdm9hM7TbF/hrgjT3nSOoJTKve9VTNGOwrjClDIlh4IjKVP/NaeObw4kufEbK1PBd1KhHUmvhIORhjgDxBi8I2hn9lM6YEE50ROLD6FypEw3uB92AYdWTxNvRTBb+c/pEJDlswWIRXC2gOiLsQOzhXP1fBv7VF3mWBnwPzTHtq2dj1nLNc80oNYSuBdqr3Wo0srPvNoUNQj3hxv7ZGImF/zewdp4iCgph15f0HaMHRgqQmvAXh1SqOqbOGqRQ4nRlFjfgAglpXh5ho2DrYcalvz95IdbFTJORsM31mfiCtrOFOZkRkiXCNNKeCkQVuweXIxjtUdYtDkCTclPVTBKMxTpb0S6AT3erhIpTV+8GJ68HifwffdP68mYd5/J0MpfAde8MUvbMANvIuIbuTws9K6rVvpqvl4Yle1OI+BP0UyZTIJfYInCzo7vLwoAA4b3QfGKVpVfKRH7OcLFuAiEPq/20YQBqWBZQxp1v8gPiizIF5/dxabLZXyjuaT8CV/Xc/d/rX2PqGsIql4yb3ZgetH/+VfYiwMTOat8ZohLqwSAlsmkr/q7muVe7IH217zaP5oLVUtXnLQUvISaeR8P47OTToK//V+PUnK4WoQ5WU35ex4xvz2ykkag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(8936002)(6916009)(2616005)(26005)(36860700001)(83380400001)(54906003)(70586007)(316002)(4326008)(8676002)(70206006)(47076005)(5660300002)(6666004)(41300700001)(82740400003)(478600001)(2906002)(44832011)(356005)(81166007)(40480700001)(36756003)(86362001)(426003)(336012)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:44:40.7140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 518c829b-bb74-41c0-6eaa-08dbcf498119
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188
Received-SPF: softfail client-ip=2a01:111:f400:7e88::62e;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

Use de FIELD macro to describe the NWCFG register fields.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/net/cadence_gem.c | 60 ++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 2864f0940e..09f570b6fb 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -77,10 +77,39 @@ REG32(NWCTRL, 0x0) /* Network Control reg */
     FIELD(NWCTRL, SEL_MII_ON_RGMII, 28, 1)
     FIELD(NWCTRL, TWO_PT_FIVE_GIG, 29, 1)
     FIELD(NWCTRL, IFG_EATS_QAV_CREDIT, 30, 1)
 
 REG32(NWCFG, 0x4) /* Network Config reg */
+    FIELD(NWCFG, SPEED, 0, 1)
+    FIELD(NWCFG, FULL_DUPLEX, 1, 1)
+    FIELD(NWCFG, DISCARD_NON_VLAN_FRAMES, 2, 1)
+    FIELD(NWCFG, JUMBO_FRAMES, 3, 1)
+    FIELD(NWCFG, PROMISC, 4, 1)
+    FIELD(NWCFG, NO_BROADCAST, 5, 1)
+    FIELD(NWCFG, MULTICAST_HASH_EN, 6, 1)
+    FIELD(NWCFG, UNICAST_HASH_EN, 7, 1)
+    FIELD(NWCFG, RECV_1536_BYTE_FRAMES, 8, 1)
+    FIELD(NWCFG, EXTERNAL_ADDR_MATCH_EN, 9, 1)
+    FIELD(NWCFG, GIGABIT_MODE_ENABLE, 10, 1)
+    FIELD(NWCFG, PCS_SELECT, 11, 1)
+    FIELD(NWCFG, RETRY_TEST, 12, 1)
+    FIELD(NWCFG, PAUSE_ENABLE, 13, 1)
+    FIELD(NWCFG, RECV_BUF_OFFSET, 14, 2)
+    FIELD(NWCFG, LEN_ERR_DISCARD, 16, 1)
+    FIELD(NWCFG, FCS_REMOVE, 17, 1)
+    FIELD(NWCFG, MDC_CLOCK_DIV, 18, 3)
+    FIELD(NWCFG, DATA_BUS_WIDTH, 21, 2)
+    FIELD(NWCFG, DISABLE_COPY_PAUSE_FRAMES, 23, 1)
+    FIELD(NWCFG, RECV_CSUM_OFFLOAD_EN, 24, 1)
+    FIELD(NWCFG, EN_HALF_DUPLEX_RX, 25, 1)
+    FIELD(NWCFG, IGNORE_RX_FCS, 26, 1)
+    FIELD(NWCFG, SGMII_MODE_ENABLE, 27, 1)
+    FIELD(NWCFG, IPG_STRETCH_ENABLE, 28, 1)
+    FIELD(NWCFG, NSP_ACCEPT, 29, 1)
+    FIELD(NWCFG, IGNORE_IPG_RX_ER, 30, 1)
+    FIELD(NWCFG, UNI_DIRECTION_ENABLE, 31, 1)
+
 REG32(NWSTATUS, 0x8) /* Network Status reg */
 REG32(USERIO, 0xc) /* User IO reg */
 REG32(DMACFG, 0x10) /* DMA Control reg */
 REG32(TXSTATUS, 0x14) /* TX Status reg */
 REG32(RXQBASE, 0x18) /* RX Q Base address reg */
@@ -234,21 +263,10 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_OFFSET, 7, 2)
     FIELD(TYPE2_COMPARE_0_WORD_1, DISABLE_MASK, 9, 1)
     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
 
 /*****************************************/
-#define GEM_NWCFG_STRIP_FCS    0x00020000 /* Strip FCS field */
-#define GEM_NWCFG_LERR_DISC    0x00010000 /* Discard RX frames with len err */
-#define GEM_NWCFG_BUFF_OFST_M  0x0000C000 /* Receive buffer offset mask */
-#define GEM_NWCFG_BUFF_OFST_S  14         /* Receive buffer offset shift */
-#define GEM_NWCFG_RCV_1538     0x00000100 /* Receive 1538 bytes frame */
-#define GEM_NWCFG_UCAST_HASH   0x00000080 /* accept unicast if hash match */
-#define GEM_NWCFG_MCAST_HASH   0x00000040 /* accept multicast if hash match */
-#define GEM_NWCFG_BCAST_REJ    0x00000020 /* Reject broadcast packets */
-#define GEM_NWCFG_PROMISC      0x00000010 /* Accept all packets */
-#define GEM_NWCFG_JUMBO_FRAME  0x00000008 /* Jumbo Frames enable */
-
 #define GEM_DMACFG_ADDR_64B    (1U << 30)
 #define GEM_DMACFG_TX_BD_EXT   (1U << 29)
 #define GEM_DMACFG_RX_BD_EXT   (1U << 28)
 #define GEM_DMACFG_RBUFSZ_M    0x00FF0000 /* DMA RX Buffer Size mask */
 #define GEM_DMACFG_RBUFSZ_S    16         /* DMA RX Buffer Size shift */
@@ -480,21 +498,22 @@ static inline void rx_desc_set_sar(uint32_t *desc, int sar_idx)
 static const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 
 static uint32_t gem_get_max_buf_len(CadenceGEMState *s, bool tx)
 {
     uint32_t size;
-    if (s->regs[R_NWCFG] & GEM_NWCFG_JUMBO_FRAME) {
+    if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, JUMBO_FRAMES)) {
         size = s->regs[R_JUMBO_MAX_LEN];
         if (size > s->jumbo_max_len) {
             size = s->jumbo_max_len;
             qemu_log_mask(LOG_GUEST_ERROR, "GEM_JUMBO_MAX_LEN reg cannot be"
                 " greater than 0x%" PRIx32 "\n", s->jumbo_max_len);
         }
     } else if (tx) {
         size = 1518;
     } else {
-        size = s->regs[R_NWCFG] & GEM_NWCFG_RCV_1538 ? 1538 : 1518;
+        size = FIELD_EX32(s->regs[R_NWCFG],
+                          NWCFG, RECV_1536_BYTE_FRAMES) ? 1538 : 1518;
     }
     return size;
 }
 
 static void gem_set_isr(CadenceGEMState *s, int q, uint32_t flag)
@@ -730,26 +749,26 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
 {
     uint8_t *gem_spaddr;
     int i, is_mc;
 
     /* Promiscuous mode? */
-    if (s->regs[R_NWCFG] & GEM_NWCFG_PROMISC) {
+    if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, PROMISC)) {
         return GEM_RX_PROMISCUOUS_ACCEPT;
     }
 
     if (!memcmp(packet, broadcast_addr, 6)) {
         /* Reject broadcast packets? */
-        if (s->regs[R_NWCFG] & GEM_NWCFG_BCAST_REJ) {
+        if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, NO_BROADCAST)) {
             return GEM_RX_REJECT;
         }
         return GEM_RX_BROADCAST_ACCEPT;
     }
 
     /* Accept packets -w- hash match? */
     is_mc = is_multicast_ether_addr(packet);
-    if ((is_mc && (s->regs[R_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
-        (!is_mc && (s->regs[R_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
+    if ((is_mc && (FIELD_EX32(s->regs[R_NWCFG], NWCFG, MULTICAST_HASH_EN))) ||
+        (!is_mc && FIELD_EX32(s->regs[R_NWCFG], NWCFG, UNICAST_HASH_EN))) {
         uint64_t buckets;
         unsigned hash_index;
 
         hash_index = calc_mac_hash(packet);
         buckets = ((uint64_t)s->regs[R_HASHHI] << 32) | s->regs[R_HASHLO];
@@ -981,11 +1000,11 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     if (maf == GEM_RX_REJECT) {
         return size;  /* no, drop silently b/c it's not an error */
     }
 
     /* Discard packets with receive length error enabled ? */
-    if (s->regs[R_NWCFG] & GEM_NWCFG_LERR_DISC) {
+    if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, LEN_ERR_DISCARD)) {
         unsigned type_len;
 
         /* Fish the ethertype / length field out of the RX packet */
         type_len = buf[12] << 8 | buf[13];
         /* It is a length field, not an ethertype */
@@ -998,12 +1017,11 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     }
 
     /*
      * Determine configured receive buffer offset (probably 0)
      */
-    rxbuf_offset = (s->regs[R_NWCFG] & GEM_NWCFG_BUFF_OFST_M) >>
-                   GEM_NWCFG_BUFF_OFST_S;
+    rxbuf_offset = FIELD_EX32(s->regs[R_NWCFG], NWCFG, RECV_BUF_OFFSET);
 
     /* The configure size of each receive buffer.  Determines how many
      * buffers needed to hold this packet.
      */
     rxbufsize = ((s->regs[R_DMACFG] & GEM_DMACFG_RBUFSZ_M) >>
@@ -1024,11 +1042,11 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
     if (size < 60) {
         size = 60;
     }
 
     /* Strip of FCS field ? (usually yes) */
-    if (s->regs[R_NWCFG] & GEM_NWCFG_STRIP_FCS) {
+    if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, FCS_REMOVE)) {
         rxbuf_ptr = (void *)buf;
     } else {
         unsigned crc_val;
 
         if (size > MAX_FRAME_SIZE - sizeof(crc_val)) {
-- 
2.39.2


