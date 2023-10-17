Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1C87CCE0D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqdy-00082i-Ki; Tue, 17 Oct 2023 16:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzi-00043T-24; Tue, 17 Oct 2023 15:44:46 -0400
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzf-0000uN-UR; Tue, 17 Oct 2023 15:44:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cp2OY9KmTsUZ5gVzGX6g20zdg4KcaoebiPivUfGfJqRqlzYQ8ca1sKJOhS6+1CK0YIYWQhu7GRaj2KSM1HWly9/gvU92Oxk7V6KmIxgKl/aXgzQRQR3BloPgSyV3EPDB8NnI/2bGq90NMHTaSSWfMzjjo0n2T65CB1/vvf6P2CPqJ7l5O5qx0EKLmcLWShe6SwpWRiFyY3Df53WLly9e6LeLjWCvLac/tb3ch+JY04Nwby9rzP+ywUJB3pb9zcQ1HQROqN/RKa/6MqbGBKMmo4V9iZxINoNABUnVslVPgtbvfsehypLURNrlKDfkFqUKvvzHUcqgUC3/goMeqwQptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w8F1o/M1Injn7BVLnhvfLk0k7kBWQP2sCUJ48v2voo=;
 b=NbSppshfRejTtbDb7/KHlnKHHV6WIdNqgLgWLRDWScQfVU8zNmMbjCkNHCNKtEWKumn0Ki59br1slvn8TtLDxGRIaBxqyd+wzjH4LAYjdRJlnNXMQDBCUuh6sYJ74OpHVJkUYBj//x1C44KuI78hepHIBH10xfT+bDKBhx5sUTUjIUlVS+txO31IZtt5/IviMuVczFZ9TMh85L0o+xMDJfZeZYO32/Olr4DmvOIyVReFyKHLr/Cxp+eGBiMotdRYHhRN54SYb1cbWdWYyN+0HJyEg/Y9rvGjOsZsOkfvV8mylh7UayTGB95nTYn1j5ChJO/0d+qzz9iH6XLxhHGIwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w8F1o/M1Injn7BVLnhvfLk0k7kBWQP2sCUJ48v2voo=;
 b=y1Z1hISUwnlEDDpBryyG8XY6FqVYhmgiHh/BoX7OanDvWFe2ja8RYHZ+V8sQJRcBhANAzG1IJZvoxYM/QKwk3/6CMvY45FmJPJHZoF/UGyEDNvDGpHT8LWTLM9xPoVXvxCbXKFneg+S79CBhGwEKNXjeAvZfA0wGmdMk11yXNyE=
Received: from BYAPR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:c0::29)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 19:44:39 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::a7) by BYAPR05CA0016.outlook.office365.com
 (2603:10b6:a03:c0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 19:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.22 via Frontend Transport; Tue, 17 Oct 2023 19:44:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:44:37 -0500
Received: from luc-work-vm.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:44:36 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, <qemu-arm@nongnu.org>, "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Wang" <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>
Subject: [PATCH 03/11] hw/net/cadence_gem: use FIELD to describe NWCTRL
 register fields
Date: Tue, 17 Oct 2023 21:44:14 +0200
Message-ID: <20231017194422.4124691-4-luc.michel@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017194422.4124691-1-luc.michel@amd.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e00967d-307b-419d-e146-08dbcf497fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qf4UOjCnJQLfaHmlSuMKdWCRamtT4hE03FG7Yf6PyWtLQpSwYHJgmSg8wU6OhWIqA9p58I1QIGyjZAEHFpIEwb888EJyKFylO8G5lIIjy3UuZEqVpl+lZiW0Lg01C/glfyyOo6cnDr+4PurhXYsWsvc2M2JYOeiJpn65jO4LBZsRi8WZDt839mQ9yf9P8nR5I/QEN/UBDkFqaBvFQuIW/9Z1xilHZfWAioDX6rIfIJG6cf7EY3oDFyfzYRLQ9CSklbStTAPFng43JGs6VPYe5UGwdADG4K4ePyR1EdCTVE0KuqXe02OtxyMJKOnbimJwlHqVHFMlIRBauDq/J/jGpK7B4J2c5b15ElVTbYYjky6UX2wVc73rnXi8EO8Q1KEuoRdALYzW6mwSLAtOBr6Yq8Os35KDl11AJIQVGFWioXCBvh8cWJTsaIHEYDZiSwNqwcT3epzcy3pZb0gSoMI9tN3+3TAd1gCTN5C4i0bhe3UAF/5E1bxtVrW3iER57UOdWNnt2qDBdjJuwMLERPw2FPrXdQpK/oV29xKhj6J+dbF10hFggzDLc18fKbRXgWEozOnTAGpcJnk/SNaRmjXoGiwEIzl/h2hzgsPtpfaqyaKe/VcYC91OnZDl/9+keQfcwOTNSVh6tI5sgkC2OJTOf9B98Hlj5gi4+o/uO+YvsQKSPMBsPKBcSFKa2NqBU637a2lojA07K99EL52TvUOdTl5iZ/Y4HxPJptLiJdoOjhp13JSiCiuoGCSf923jGaLjCCjT0MnvM750YuJAxBTwxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(82310400011)(1800799009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(6916009)(36860700001)(70586007)(478600001)(54906003)(70206006)(6666004)(1076003)(26005)(336012)(81166007)(426003)(2616005)(356005)(41300700001)(8676002)(8936002)(2906002)(44832011)(4326008)(316002)(36756003)(5660300002)(86362001)(82740400003)(47076005)(83380400001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:44:38.6632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e00967d-307b-419d-e146-08dbcf497fe2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932
Received-SPF: softfail client-ip=2a01:111:f400:7eae::600;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Oct 2023 16:26:00 -0400
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

Use the FIELD macro to describe the NWCTRL register fields.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/net/cadence_gem.c | 53 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index f01c81de97..2864f0940e 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -44,10 +44,42 @@
         qemu_log(__VA_ARGS__); \
     } \
 } while (0)
 
 REG32(NWCTRL, 0x0) /* Network Control reg */
+    FIELD(NWCTRL, LOOPBACK , 0, 1)
+    FIELD(NWCTRL, LOOPBACK_LOCAL , 1, 1)
+    FIELD(NWCTRL, ENABLE_RECEIVE, 2, 1)
+    FIELD(NWCTRL, ENABLE_TRANSMIT, 3, 1)
+    FIELD(NWCTRL, MAN_PORT_EN , 4, 1)
+    FIELD(NWCTRL, CLEAR_ALL_STATS_REGS , 5, 1)
+    FIELD(NWCTRL, INC_ALL_STATS_REGS, 6, 1)
+    FIELD(NWCTRL, STATS_WRITE_EN, 7, 1)
+    FIELD(NWCTRL, BACK_PRESSURE, 8, 1)
+    FIELD(NWCTRL, TRANSMIT_START , 9, 1)
+    FIELD(NWCTRL, TRANSMIT_HALT, 10, 1)
+    FIELD(NWCTRL, TX_PAUSE_FRAME_RE, 11, 1)
+    FIELD(NWCTRL, TX_PAUSE_FRAME_ZE, 12, 1)
+    FIELD(NWCTRL, STATS_TAKE_SNAP, 13, 1)
+    FIELD(NWCTRL, STATS_READ_SNAP, 14, 1)
+    FIELD(NWCTRL, STORE_RX_TS, 15, 1)
+    FIELD(NWCTRL, PFC_ENABLE, 16, 1)
+    FIELD(NWCTRL, PFC_PRIO_BASED, 17, 1)
+    FIELD(NWCTRL, FLUSH_RX_PKT_PCLK , 18, 1)
+    FIELD(NWCTRL, TX_LPI_EN, 19, 1)
+    FIELD(NWCTRL, PTP_UNICAST_ENA, 20, 1)
+    FIELD(NWCTRL, ALT_SGMII_MODE, 21, 1)
+    FIELD(NWCTRL, STORE_UDP_OFFSET, 22, 1)
+    FIELD(NWCTRL, EXT_TSU_PORT_EN, 23, 1)
+    FIELD(NWCTRL, ONE_STEP_SYNC_MO, 24, 1)
+    FIELD(NWCTRL, PFC_CTRL , 25, 1)
+    FIELD(NWCTRL, EXT_RXQ_SEL_EN , 26, 1)
+    FIELD(NWCTRL, OSS_CORRECTION_FIELD, 27, 1)
+    FIELD(NWCTRL, SEL_MII_ON_RGMII, 28, 1)
+    FIELD(NWCTRL, TWO_PT_FIVE_GIG, 29, 1)
+    FIELD(NWCTRL, IFG_EATS_QAV_CREDIT, 30, 1)
+
 REG32(NWCFG, 0x4) /* Network Config reg */
 REG32(NWSTATUS, 0x8) /* Network Status reg */
 REG32(USERIO, 0xc) /* User IO reg */
 REG32(DMACFG, 0x10) /* DMA Control reg */
 REG32(TXSTATUS, 0x14) /* TX Status reg */
@@ -202,15 +234,10 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_OFFSET, 7, 2)
     FIELD(TYPE2_COMPARE_0_WORD_1, DISABLE_MASK, 9, 1)
     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
 
 /*****************************************/
-#define GEM_NWCTRL_TXSTART     0x00000200 /* Transmit Enable */
-#define GEM_NWCTRL_TXENA       0x00000008 /* Transmit Enable */
-#define GEM_NWCTRL_RXENA       0x00000004 /* Receive Enable */
-#define GEM_NWCTRL_LOCALLOOP   0x00000002 /* Local Loopback */
-
 #define GEM_NWCFG_STRIP_FCS    0x00020000 /* Strip FCS field */
 #define GEM_NWCFG_LERR_DISC    0x00010000 /* Discard RX frames with len err */
 #define GEM_NWCFG_BUFF_OFST_M  0x0000C000 /* Receive buffer offset mask */
 #define GEM_NWCFG_BUFF_OFST_S  14         /* Receive buffer offset shift */
 #define GEM_NWCFG_RCV_1538     0x00000100 /* Receive 1538 bytes frame */
@@ -558,11 +585,11 @@ static bool gem_can_receive(NetClientState *nc)
     int i;
 
     s = qemu_get_nic_opaque(nc);
 
     /* Do nothing if receive is not enabled. */
-    if (!(s->regs[R_NWCTRL] & GEM_NWCTRL_RXENA)) {
+    if (!FIELD_EX32(s->regs[R_NWCTRL], NWCTRL, ENABLE_RECEIVE)) {
         if (s->can_rx_state != 1) {
             s->can_rx_state = 1;
             DB_PRINT("can't receive - no enable\n");
         }
         return false;
@@ -1171,11 +1198,11 @@ static void gem_transmit(CadenceGEMState *s)
     uint8_t     *p;
     unsigned    total_bytes;
     int q = 0;
 
     /* Do nothing if transmit is not enabled. */
-    if (!(s->regs[R_NWCTRL] & GEM_NWCTRL_TXENA)) {
+    if (!FIELD_EX32(s->regs[R_NWCTRL], NWCTRL, ENABLE_TRANSMIT)) {
         return;
     }
 
     DB_PRINT("\n");
 
@@ -1196,11 +1223,11 @@ static void gem_transmit(CadenceGEMState *s)
                            sizeof(uint32_t) * gem_get_desc_len(s, false));
         /* Handle all descriptors owned by hardware */
         while (tx_desc_get_used(desc) == 0) {
 
             /* Do nothing if transmit is not enabled. */
-            if (!(s->regs[R_NWCTRL] & GEM_NWCTRL_TXENA)) {
+            if (!FIELD_EX32(s->regs[R_NWCTRL], NWCTRL, ENABLE_TRANSMIT)) {
                 return;
             }
             print_gem_tx_desc(desc, q);
 
             /* The real hardware would eat this (and possibly crash).
@@ -1269,12 +1296,12 @@ static void gem_transmit(CadenceGEMState *s)
 
                 /* Update MAC statistics */
                 gem_transmit_updatestats(s, s->tx_packet, total_bytes);
 
                 /* Send the packet somewhere */
-                if (s->phy_loop || (s->regs[R_NWCTRL] &
-                                    GEM_NWCTRL_LOCALLOOP)) {
+                if (s->phy_loop || FIELD_EX32(s->regs[R_NWCTRL], NWCTRL,
+                                              LOOPBACK_LOCAL)) {
                     qemu_receive_packet(qemu_get_queue(s->nic), s->tx_packet,
                                         total_bytes);
                 } else {
                     qemu_send_packet(qemu_get_queue(s->nic), s->tx_packet,
                                      total_bytes);
@@ -1491,19 +1518,19 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
     s->regs[offset] &= ~(s->regs_w1c[offset] & val);
 
     /* Handle register write side effects */
     switch (offset) {
     case R_NWCTRL:
-        if (val & GEM_NWCTRL_RXENA) {
+        if (FIELD_EX32(val, NWCTRL, ENABLE_RECEIVE)) {
             for (i = 0; i < s->num_priority_queues; ++i) {
                 gem_get_rx_desc(s, i);
             }
         }
-        if (val & GEM_NWCTRL_TXSTART) {
+        if (FIELD_EX32(val, NWCTRL, TRANSMIT_START)) {
             gem_transmit(s);
         }
-        if (!(val & GEM_NWCTRL_TXENA)) {
+        if (!(FIELD_EX32(val, NWCTRL, ENABLE_TRANSMIT))) {
             /* Reset to start of Q when transmit disabled. */
             for (i = 0; i < s->num_priority_queues; i++) {
                 s->tx_desc_addr[i] = gem_get_tx_queue_base_addr(s, i);
             }
         }
-- 
2.39.2


