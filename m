Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E7F7CCE08
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:28:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqdu-0007kb-Of; Tue, 17 Oct 2023 16:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzy-0004AC-Rh; Tue, 17 Oct 2023 15:45:03 -0400
Received: from mail-mw2nam04on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::608]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1qspzw-0000x0-Kr; Tue, 17 Oct 2023 15:45:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UygQfx1p9f+OZ0vXgJbckQdaSxMLvQSAlTY3c/D2uO9WOOMnaPMqIxjArovEJrBTwFjAV8JM0m1U9Spq08Lv/o2JBl5H5DOXxnFivytjUq7P1cLh+KIl5xEaW3eOGFogCLbiksBZYgx4WigZpgwtZHKbPGvu5HLLxIKEeqYNI6kRpe1V7daMIxOvH8gud+05F2lUIb0gZtXiTkVBQBeFBtqdacLiMDM7mxGypapbvzJZan/LAtiAVfQfe5KdKkR7RjHh88Juo7usvLGgqLj9qsKFlwLpVsdW/866UqBiEocDNmOvJZSGameE0bPBXMDPmCCiCNCykiZRKA6Lk3x53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQsObzDJJCO53LAy33lKO1Fy6gpAiDcO1l1m8Z/RXUA=;
 b=Vp02kCWR4f7gN6NKsmZDd/fk/mIFAb+OQknPj2DRJdMCE5eJAw26L8GOJcDz5mhtIR5APtB4RCfB8eX+NXl4DaLV+s32OHubr6H/lzVR12CrEWq5H/nEXwDLo1w4tRkSIy7KogyARXrbZWhFtWXvz+aHFruDfTe7Kj9WXPyKuvLkehb8hP6pNvHOpB7apEJ4OqjRphogYb5PKGIx27IzXqG11uE1dBFtjNe/Uu5mqbhBKe/HWtsuDMzv4DgzGDDNRaWNXb29jE/+g1QkcvjJm9oKu3dOCFYGAKEL7Jxso4cGBeGpzO9Dh6K84tiCb6uTtiBmrrsx3GITHQy6oyZPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQsObzDJJCO53LAy33lKO1Fy6gpAiDcO1l1m8Z/RXUA=;
 b=sfNj9/5IDR7ZT+XLeVQe7NJgzkRl8sX8QobapQYwQASHBP6R0zOZZlIAMAyuIesn5vVhudgkGe90+Fdjs7BDZyuaIGJtUNu8g2uxMMDwMyC4nsMsNSjXNwyYlKBIZDr76rI2ptpCctHQ/o9K60ELQr5cyoN10U0tZsNTpHJMiew=
Received: from DM6PR01CA0018.prod.exchangelabs.com (2603:10b6:5:296::23) by
 PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 19:44:55 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::bf) by DM6PR01CA0018.outlook.office365.com
 (2603:10b6:5:296::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 19:44:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.22 via Frontend Transport; Tue, 17 Oct 2023 19:44:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:44:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:44:54 -0500
Received: from luc-work-vm.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:44:52 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, <qemu-arm@nongnu.org>, "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Wang" <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>
Subject: [PATCH 10/11] hw/net/cadence_gem: perform PHY access on write only
Date: Tue, 17 Oct 2023 21:44:21 +0200
Message-ID: <20231017194422.4124691-11-luc.michel@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017194422.4124691-1-luc.michel@amd.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb5ce89-c9fe-42a0-4691-08dbcf49899e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Js2HASlXgHPSvYBAZuoGVhM+/VCBc2V2egI5Ml0epXUWSum0bfI98DFFcY4JmlrybwGhRiBKpLfnbfK8I4xOla7mISeUns+WiBLsVjd8ohcMJUKmmvXw1nJO+Om6AnFYWJSrhC1uH9ZoARAyi7zXFinPJ3mKOC5nSCZrz9eNz3nkSwQCVfhCjBO8RwtpvH9Ln2TxRX1cmJhy/a97T/GLzbO5wh1BM1TJ+GS9byeBW0JNY0gepUrM3oFGWTpdYi9V4p8N+1/NqgHRH6KZLBfiFPUScVYashMUVwMfidKKx6DZ5wrvEy2vv5LukXUpsEdcVEANGY2CXNoQyTSvERy6RjrZqdTcQsoIfPZo6+rDLhpdOoKLjK9P25gThgGLzfD+Ahqc4VJpoM8pHqTzKlN/BF7s5mH5k5RonP/3CHUN9Q3KIcVsjHrEO2Qbj0lC8VVW0SnfJhOd7wSHkC7kXEEGY2KqSkEdipjAfcdsljj61yPLrJG4ypbib6AwtVaNLKMVPpJ2rKlLXnwJ3mBdA03AngtcUiifyXPGHKAoWwX+eUZwlG1Mm7nhTkRefe4/55t+i0ZlgARHXw/rbam8vDQiyknUcjoyL5FiE2tMbycTSOFg0jqeut8ANuY8jDlRaViByHLbXZ2VcXyinkt4a+Pi8Grk4EjfMzrbX0Hx7YuVi6F/EnsJLlXs6UDg38sQTn7hqnXA8L0OqQ7uZMFEyYIeNYDJS0rhJyEBTCjSNpKkl9mx/P4JgNsOSyVCvQ0PiRZ2KTice/y+51xth71sqX1zqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(36860700001)(47076005)(82740400003)(40480700001)(356005)(81166007)(2906002)(6666004)(6916009)(70586007)(316002)(70206006)(478600001)(54906003)(5660300002)(8676002)(44832011)(8936002)(2616005)(83380400001)(336012)(426003)(26005)(1076003)(4326008)(41300700001)(40460700003)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:44:55.0689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb5ce89-c9fe-42a0-4691-08dbcf49899e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
Received-SPF: softfail client-ip=2a01:111:f400:7e8c::608;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

The MDIO access is done only on a write to the PHYMNTNC register. A
subsequent read is used to retrieve the result but does not trigger an
MDIO access by itself.

Refactor the PHY access logic to perform all accesses (MDIO reads and
writes) at PHYMNTNC write time.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/net/cadence_gem.c | 56 ++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 4c5fe10316..21146f4242 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1519,10 +1519,42 @@ static void gem_phy_write(CadenceGEMState *s, unsigned reg_num, uint16_t val)
         break;
     }
     s->phy_regs[reg_num] = val;
 }
 
+static void gem_handle_phy_access(CadenceGEMState *s)
+{
+    uint32_t val = s->regs[R_PHYMNTNC];
+    uint32_t phy_addr, reg_num;
+
+    phy_addr = FIELD_EX32(val, PHYMNTNC, PHY_ADDR);
+
+    if (phy_addr != s->phy_addr) {
+        /* no phy at this address */
+        if (FIELD_EX32(val, PHYMNTNC, OP) == MDIO_OP_READ) {
+            s->regs[R_PHYMNTNC] = FIELD_DP32(val, PHYMNTNC, DATA, 0xffff);
+        }
+        return;
+    }
+
+    reg_num = FIELD_EX32(val, PHYMNTNC, REG_ADDR);
+
+    switch (FIELD_EX32(val, PHYMNTNC, OP)) {
+    case MDIO_OP_READ:
+        s->regs[R_PHYMNTNC] = FIELD_DP32(val, PHYMNTNC, DATA,
+                                         gem_phy_read(s, reg_num));
+        break;
+
+    case MDIO_OP_WRITE:
+        gem_phy_write(s, reg_num, val);
+        break;
+
+    default:
+        break; /* only clause 22 operations are supported */
+    }
+}
+
 /*
  * gem_read32:
  * Read a GEM register.
  */
 static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
@@ -1539,24 +1571,10 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
     switch (offset) {
     case R_ISR:
         DB_PRINT("lowering irqs on ISR read\n");
         /* The interrupts get updated at the end of the function. */
         break;
-    case R_PHYMNTNC:
-        if (FIELD_EX32(retval, PHYMNTNC, OP) == MDIO_OP_READ) {
-            uint32_t phy_addr, reg_num;
-
-            phy_addr = FIELD_EX32(retval, PHYMNTNC, PHY_ADDR);
-            if (phy_addr == s->phy_addr) {
-                reg_num = FIELD_EX32(retval, PHYMNTNC, REG_ADDR);
-                retval &= 0xFFFF0000;
-                retval |= gem_phy_read(s, reg_num);
-            } else {
-                retval |= 0xFFFF; /* No device at this address */
-            }
-        }
-        break;
     }
 
     /* Squash read to clear bits */
     s->regs[offset] &= ~(s->regs_rtc[offset]);
 
@@ -1663,19 +1681,11 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
     case R_SPADDR3HI:
     case R_SPADDR4HI:
         s->sar_active[(offset - R_SPADDR1HI) / 2] = true;
         break;
     case R_PHYMNTNC:
-        if (FIELD_EX32(val, PHYMNTNC, OP) == MDIO_OP_WRITE) {
-            uint32_t phy_addr, reg_num;
-
-            phy_addr = FIELD_EX32(val, PHYMNTNC, PHY_ADDR);
-            if (phy_addr == s->phy_addr) {
-                reg_num = FIELD_EX32(val, PHYMNTNC, REG_ADDR);
-                gem_phy_write(s, reg_num, val);
-            }
-        }
+        gem_handle_phy_access(s);
         break;
     }
 
     DB_PRINT("newval: 0x%08x\n", s->regs[offset]);
 }
-- 
2.39.2


