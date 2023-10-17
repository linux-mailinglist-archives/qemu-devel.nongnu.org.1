Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4C47CCE09
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:28:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqdq-0007jH-U0; Tue, 17 Oct 2023 16:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzh-000435-8P; Tue, 17 Oct 2023 15:44:45 -0400
Received: from mail-bn1nam02on2061b.outbound.protection.outlook.com
 ([2a01:111:f400:7eb2::61b]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspze-0000u3-DN; Tue, 17 Oct 2023 15:44:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWwDAfuDD4iru340ifAdmkCD8UW3WcOQGr+9ZWXjTf535oSlNhYwuELYlXGuA9BbmkOxB3wjKo9EpeQ4h+g/AosOjXWX0O9xuE0buuakXgnFlFzGu5qB46/GfCNBpBBBEA1aqJikyPfQYh6AEXIr1Q24+de7fl3iE4lCtcD5FqvCi8jj4K327evdbvxjrs9BYxpvNSLPohDRL+EsPNy6QQ+v0QYfzBayFp+1AoXt6yIyHGei05mopidnJg7kvmo3mnk/BDRn05CeTvslm1lSRy55OzORNMxR8SJ3iVZSVSlfoaQ7rTl/3azFnRtiUjSRJI4ZqAwm02oLGDPPJkLASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q0dnvdbQlF1bJqfFRsE0ZmlyUc0gOndOwgmh7x4pZE=;
 b=kf718eYxAhJObHUYgOD2ZI28VCNox1cUSAjbKYOd5CqXfbqXQli41HDhjEJhbkyXuF/67hKGammdq+vTCgioHY5PfCc40UTdvhtI7ikl15m+tY8ENmWzXPgSaGnpXoK5iiGw1nDv0WCnhl37yI1/fJMZG3p1qKbbYkw/ehRA3Ocj66yx7jStemRMlWAIS6fKfbtEMqjnWBEKkrZvvxePonNX8Mvg+NOQyysjt0rCe6oap2vLq23+V2tp+R5QOO/ZsW0lyrHCvSIlyCeizTM4eiOkfo4RHfnGapG9+TL7P7rTFMSUQRic6pn6E5+16kp0bEPTFtw5y+RJCXMmy40hiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q0dnvdbQlF1bJqfFRsE0ZmlyUc0gOndOwgmh7x4pZE=;
 b=a0/1/KE3GgtSbhf/4zXOUJj+BXvfBb/CI3Gg2Cc9L5TQflXRBTLUlHbDVNT4E00k0R54OZkXZXdexbJr9ZkFEvPBTdq89OzroakmsZYTF8e7VhptF9p3kGl9xzhw0bSipFKWG1mwAtQ/DQIfmOeaY30sOzb237lwcfHMyZRB6IY=
Received: from MW4PR04CA0144.namprd04.prod.outlook.com (2603:10b6:303:84::29)
 by PH8PR12MB7253.namprd12.prod.outlook.com (2603:10b6:510:226::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Tue, 17 Oct
 2023 19:44:37 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::26) by MW4PR04CA0144.outlook.office365.com
 (2603:10b6:303:84::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 19:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Tue, 17 Oct 2023 19:44:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:44:35 -0500
Received: from luc-work-vm.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:44:34 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, <qemu-arm@nongnu.org>, "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Wang" <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>
Subject: [PATCH 02/11] hw/net/cadence_gem: use FIELD for screening registers
Date: Tue, 17 Oct 2023 21:44:13 +0200
Message-ID: <20231017194422.4124691-3-luc.michel@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017194422.4124691-1-luc.michel@amd.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH8PR12MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: d6478dca-50fa-498e-d996-08dbcf497ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0eWhmyEmCAfz11NQSMQuDx/R1HukuZ6/B03bszCJ1Nn65VcacxttS0rsovdacmFIPHzY10qv/pI2a0+BflVFRoqgcv9q5B+PqC8DDmHmLqxJ3uAybbzkPI2EAOPJltJjFBkniQXQGv45VpOBAOqTa2GVBPsomZ6kD6ueMXIVYA4VGZAlbZStpWLA+lAL6qkfv70ian8NoMgtecmND4NdieXiZwghMuuUx4nzVM6SbdKvkVep0o/E1GrKl7N4imVoqcqtWuGvRPVlleXoI3Nykwo7eAwhaLWcjnuZrrD8+7HucoJyWUhzybNCmNGWZFgddMU8TL/WWgHJ7W8st7neMSdjm38cEJX+fuXTJphaDVmzGlxsEx6jczVD8u0D3su9ZhFmUNm9IxI8BL04NnF1+mXKLeB9vAnopusCyVa/65CUMD01NXbvcbg7vnr87/CtJBx6Xk4VJLikQ5DjrWfnJQm7c8FaxX8Ih5ib/wHkqxP1shLkB5SOMwafioDE2ngyiASRml84I/PfeS6BUBWas81o/2Yu5bthnDuXaIB8nZfjWWFRaq+Zv/ymfzRh/a8PlHgEy+NSFy4orNmr5mmiWEIRYAv2goIlAnRSORhCeBOvVQJo8VOAW3iaeI7ttaSYDgFgh5N6cStPDR7PzU41YbgKbuAVYjQQHIK7uNGM5xqoieKZulEKtQGBDsns1tm7JAA0XMJyF8UnSmr6+6RUfdz3QuaSylqzs8PL8ivlJbVSvZzVXirNmGv7CtxyYQKi2YTtQc/dKLo6OggpV6b9Fg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(82310400011)(1800799009)(64100799003)(186009)(46966006)(40470700004)(36840700001)(1076003)(82740400003)(40480700001)(336012)(40460700003)(26005)(81166007)(426003)(2616005)(478600001)(44832011)(54906003)(6666004)(8676002)(4326008)(316002)(6916009)(8936002)(70586007)(5660300002)(86362001)(36756003)(2906002)(41300700001)(70206006)(356005)(47076005)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:44:36.7297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6478dca-50fa-498e-d996-08dbcf497ebb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7253
Received-SPF: softfail client-ip=2a01:111:f400:7eb2::61b;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Describe screening registers fields using the FIELD macros.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/net/cadence_gem.c | 92 ++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 45 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 0e5744ecd7..f01c81de97 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -168,39 +168,42 @@ REG32(INT_Q7_ENABLE, 0x618)
 
 REG32(INT_Q1_DISABLE, 0x620)
 REG32(INT_Q7_DISABLE, 0x638)
 
 REG32(SCREENING_TYPE1_REG0, 0x500)
-
-#define GEM_ST1R_UDP_PORT_MATCH_ENABLE  (1 << 29)
-#define GEM_ST1R_DSTC_ENABLE            (1 << 28)
-#define GEM_ST1R_UDP_PORT_MATCH_SHIFT   (12)
-#define GEM_ST1R_UDP_PORT_MATCH_WIDTH   (27 - GEM_ST1R_UDP_PORT_MATCH_SHIFT + 1)
-#define GEM_ST1R_DSTC_MATCH_SHIFT       (4)
-#define GEM_ST1R_DSTC_MATCH_WIDTH       (11 - GEM_ST1R_DSTC_MATCH_SHIFT + 1)
-#define GEM_ST1R_QUEUE_SHIFT            (0)
-#define GEM_ST1R_QUEUE_WIDTH            (3 - GEM_ST1R_QUEUE_SHIFT + 1)
+    FIELD(SCREENING_TYPE1_REG0, QUEUE_NUM, 0, 4)
+    FIELD(SCREENING_TYPE1_REG0, DSTC_MATCH, 4, 8)
+    FIELD(SCREENING_TYPE1_REG0, UDP_PORT_MATCH, 12, 16)
+    FIELD(SCREENING_TYPE1_REG0, DSTC_ENABLE, 28, 1)
+    FIELD(SCREENING_TYPE1_REG0, UDP_PORT_MATCH_EN, 29, 1)
+    FIELD(SCREENING_TYPE1_REG0, DROP_ON_MATCH, 30, 1)
 
 REG32(SCREENING_TYPE2_REG0, 0x540)
-
-#define GEM_ST2R_COMPARE_A_ENABLE       (1 << 18)
-#define GEM_ST2R_COMPARE_A_SHIFT        (13)
-#define GEM_ST2R_COMPARE_WIDTH          (17 - GEM_ST2R_COMPARE_A_SHIFT + 1)
-#define GEM_ST2R_ETHERTYPE_ENABLE       (1 << 12)
-#define GEM_ST2R_ETHERTYPE_INDEX_SHIFT  (9)
-#define GEM_ST2R_ETHERTYPE_INDEX_WIDTH  (11 - GEM_ST2R_ETHERTYPE_INDEX_SHIFT \
-                                            + 1)
-#define GEM_ST2R_QUEUE_SHIFT            (0)
-#define GEM_ST2R_QUEUE_WIDTH            (3 - GEM_ST2R_QUEUE_SHIFT + 1)
+    FIELD(SCREENING_TYPE2_REG0, QUEUE_NUM, 0, 4)
+    FIELD(SCREENING_TYPE2_REG0, VLAN_PRIORITY, 4, 3)
+    FIELD(SCREENING_TYPE2_REG0, VLAN_ENABLE, 8, 1)
+    FIELD(SCREENING_TYPE2_REG0, ETHERTYPE_REG_INDEX, 9, 3)
+    FIELD(SCREENING_TYPE2_REG0, ETHERTYPE_ENABLE, 12, 1)
+    FIELD(SCREENING_TYPE2_REG0, COMPARE_A, 13, 5)
+    FIELD(SCREENING_TYPE2_REG0, COMPARE_A_ENABLE, 18, 1)
+    FIELD(SCREENING_TYPE2_REG0, COMPARE_B, 19, 5)
+    FIELD(SCREENING_TYPE2_REG0, COMPARE_B_ENABLE, 24, 1)
+    FIELD(SCREENING_TYPE2_REG0, COMPARE_C, 25, 5)
+    FIELD(SCREENING_TYPE2_REG0, COMPARE_C_ENABLE, 30, 1)
+    FIELD(SCREENING_TYPE2_REG0, DROP_ON_MATCH, 31, 1)
 
 REG32(SCREENING_TYPE2_ETHERTYPE_REG0, 0x6e0)
+
 REG32(TYPE2_COMPARE_0_WORD_0, 0x700)
+    FIELD(TYPE2_COMPARE_0_WORD_0, MASK_VALUE, 0, 16)
+    FIELD(TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE, 16, 16)
 
-#define GEM_T2CW1_COMPARE_OFFSET_SHIFT  (7)
-#define GEM_T2CW1_COMPARE_OFFSET_WIDTH  (8 - GEM_T2CW1_COMPARE_OFFSET_SHIFT + 1)
-#define GEM_T2CW1_OFFSET_VALUE_SHIFT    (0)
-#define GEM_T2CW1_OFFSET_VALUE_WIDTH    (6 - GEM_T2CW1_OFFSET_VALUE_SHIFT + 1)
+REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
+    FIELD(TYPE2_COMPARE_0_WORD_1, OFFSET_VALUE, 0, 7)
+    FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_OFFSET, 7, 2)
+    FIELD(TYPE2_COMPARE_0_WORD_1, DISABLE_MASK, 9, 1)
+    FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
 
 /*****************************************/
 #define GEM_NWCTRL_TXSTART     0x00000200 /* Transmit Enable */
 #define GEM_NWCTRL_TXENA       0x00000008 /* Transmit Enable */
 #define GEM_NWCTRL_RXENA       0x00000004 /* Receive Enable */
@@ -753,45 +756,43 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
         reg = s->regs[R_SCREENING_TYPE1_REG0 + i];
         matched = false;
         mismatched = false;
 
         /* Screening is based on UDP Port */
-        if (reg & GEM_ST1R_UDP_PORT_MATCH_ENABLE) {
+        if (FIELD_EX32(reg, SCREENING_TYPE1_REG0, UDP_PORT_MATCH_EN)) {
             uint16_t udp_port = rxbuf_ptr[14 + 22] << 8 | rxbuf_ptr[14 + 23];
-            if (udp_port == extract32(reg, GEM_ST1R_UDP_PORT_MATCH_SHIFT,
-                                           GEM_ST1R_UDP_PORT_MATCH_WIDTH)) {
+            if (udp_port == FIELD_EX32(reg, SCREENING_TYPE1_REG0, UDP_PORT_MATCH)) {
                 matched = true;
             } else {
                 mismatched = true;
             }
         }
 
         /* Screening is based on DS/TC */
-        if (reg & GEM_ST1R_DSTC_ENABLE) {
+        if (FIELD_EX32(reg, SCREENING_TYPE1_REG0, DSTC_ENABLE)) {
             uint8_t dscp = rxbuf_ptr[14 + 1];
-            if (dscp == extract32(reg, GEM_ST1R_DSTC_MATCH_SHIFT,
-                                       GEM_ST1R_DSTC_MATCH_WIDTH)) {
+            if (dscp == FIELD_EX32(reg, SCREENING_TYPE1_REG0, DSTC_MATCH)) {
                 matched = true;
             } else {
                 mismatched = true;
             }
         }
 
         if (matched && !mismatched) {
-            return extract32(reg, GEM_ST1R_QUEUE_SHIFT, GEM_ST1R_QUEUE_WIDTH);
+            return FIELD_EX32(reg, SCREENING_TYPE1_REG0, QUEUE_NUM);
         }
     }
 
     for (i = 0; i < s->num_type2_screeners; i++) {
         reg = s->regs[R_SCREENING_TYPE2_REG0 + i];
         matched = false;
         mismatched = false;
 
-        if (reg & GEM_ST2R_ETHERTYPE_ENABLE) {
+        if (FIELD_EX32(reg, SCREENING_TYPE2_REG0, ETHERTYPE_ENABLE)) {
             uint16_t type = rxbuf_ptr[12] << 8 | rxbuf_ptr[13];
-            int et_idx = extract32(reg, GEM_ST2R_ETHERTYPE_INDEX_SHIFT,
-                                        GEM_ST2R_ETHERTYPE_INDEX_WIDTH);
+            int et_idx = FIELD_EX32(reg, SCREENING_TYPE2_REG0,
+                                    ETHERTYPE_REG_INDEX);
 
             if (et_idx > s->num_type2_screeners) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Out of range ethertype "
                               "register index: %d\n", et_idx);
             }
@@ -803,31 +804,31 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
             }
         }
 
         /* Compare A, B, C */
         for (j = 0; j < 3; j++) {
-            uint32_t cr0, cr1, mask;
+            uint32_t cr0, cr1, mask, compare;
             uint16_t rx_cmp;
             int offset;
-            int cr_idx = extract32(reg, GEM_ST2R_COMPARE_A_SHIFT + j * 6,
-                                        GEM_ST2R_COMPARE_WIDTH);
+            int cr_idx = extract32(reg, R_SCREENING_TYPE2_REG0_COMPARE_A_SHIFT + j * 6,
+                                   R_SCREENING_TYPE2_REG0_COMPARE_A_LENGTH);
 
-            if (!(reg & (GEM_ST2R_COMPARE_A_ENABLE << (j * 6)))) {
+            if (!extract32(reg, R_SCREENING_TYPE2_REG0_COMPARE_A_ENABLE_SHIFT + j * 6,
+                           R_SCREENING_TYPE2_REG0_COMPARE_A_ENABLE_LENGTH)) {
                 continue;
             }
+
             if (cr_idx > s->num_type2_screeners) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Out of range compare "
                               "register index: %d\n", cr_idx);
             }
 
             cr0 = s->regs[R_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2];
-            cr1 = s->regs[R_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2 + 1];
-            offset = extract32(cr1, GEM_T2CW1_OFFSET_VALUE_SHIFT,
-                                    GEM_T2CW1_OFFSET_VALUE_WIDTH);
+            cr1 = s->regs[R_TYPE2_COMPARE_0_WORD_1 + cr_idx * 2];
+            offset = FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1, OFFSET_VALUE);
 
-            switch (extract32(cr1, GEM_T2CW1_COMPARE_OFFSET_SHIFT,
-                                   GEM_T2CW1_COMPARE_OFFSET_WIDTH)) {
+            switch (FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1, COMPARE_OFFSET)) {
             case 3: /* Skip UDP header */
                 qemu_log_mask(LOG_UNIMP, "TCP compare offsets"
                               "unimplemented - assuming UDP\n");
                 offset += 8;
                 /* Fallthrough */
@@ -841,21 +842,22 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
                 /* Offset from start of frame */
                 break;
             }
 
             rx_cmp = rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
-            mask = extract32(cr0, 0, 16);
+            mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
+            compare = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
 
-            if ((rx_cmp & mask) == (extract32(cr0, 16, 16) & mask)) {
+            if ((rx_cmp & mask) == (compare & mask)) {
                 matched = true;
             } else {
                 mismatched = true;
             }
         }
 
         if (matched && !mismatched) {
-            return extract32(reg, GEM_ST2R_QUEUE_SHIFT, GEM_ST2R_QUEUE_WIDTH);
+            return FIELD_EX32(reg, SCREENING_TYPE2_REG0, QUEUE_NUM);
         }
     }
 
     /* We made it here, assume it's queue 0 */
     return 0;
-- 
2.39.2


