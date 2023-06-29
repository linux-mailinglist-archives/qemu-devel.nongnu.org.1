Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D14742B79
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 19:45:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEvgU-00042z-7d; Thu, 29 Jun 2023 13:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qEvgN-00041u-66; Thu, 29 Jun 2023 13:43:55 -0400
Received: from mail-dm6nam04on20628.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::628]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qEvgK-0001Xq-U4; Thu, 29 Jun 2023 13:43:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5/KhZBWY6xkErFigA0Q7AfkgtZlXrPt5nTG8Dv5i1K/7jqJ5+ADPLGR0ICHwXq04ON/LmQPx6x83z6xWUfLEsDU4fOb+ieW2p7lk7FZvtLUQE4yEbkZ0sOXKBfQsYOiROkq8CEJ4kdt6E4f85ghZk5LuApKN7fjJv4q+T9rhCnyLR7e3e40Y7EE3tdunLkeFGkONX/EMawrZ/UyjPttET1g1DvRMpvzjgy0+C5BWxOX58Mn+0lzD3+ZVJp9+IOupcxWO9mVeNs9dwaM/wwm8KOTqrzLEyYEmlZ0mu1t9gtlYWBUhgxJdoxQG64xWSyiM91OwReuh9gE+7aJnYuF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTC8PVrYAgKRtT1DAmYqS6rfIxhYG3TVn5kzPutM/IA=;
 b=KPUUba1eRvh0va++LLfmc/qWAqOVn/FLjPzYy1S40TzseHq5BFFI+/GDJ5Gl19cmNRhdAkDCMW0ckID6jWJTaGbjhzwgkSW0n+kyGJoxfAhCxJfEbn2UaHCg425e5sd5vpeSTYQKspdj7o5EuDJGDekor81beKmDUs49TOBf/Ar/Kl/422XUJlIAvOxG3U58cBq8ZZYSaKPe63G0ddOEVLSaZprHu7NdFceNLiCc1JgXGXPEawNuDTApP4T2LNl0lGLn77YM8vk636kaL2ElyThGtgJyR2QQ9/2ml0Z2RVhCmew0+9AZrC38s0vo6E4zDRZrp7Na5WRzT3s8nn6F6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTC8PVrYAgKRtT1DAmYqS6rfIxhYG3TVn5kzPutM/IA=;
 b=Jx2h4YC1zspilpaHVMjMUTv871L8LUHEYiR6XC8ELl3mN3KkAf116FBR/stfw4xYtmlHH6/UNtD56/gbVt9XKX/cRJu8e8QKl4SqOxYenYij/Hk3RyaGun4tdV9g01wx/B2reMYfGVisRVevYRXz2xKi/gUX3UoJ4tPVkcgFIFQ=
Received: from BN9PR03CA0407.namprd03.prod.outlook.com (2603:10b6:408:111::22)
 by SN7PR12MB7786.namprd12.prod.outlook.com (2603:10b6:806:349::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 17:43:43 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::2d) by BN9PR03CA0407.outlook.office365.com
 (2603:10b6:408:111::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 17:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 17:43:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 12:43:42 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 29 Jun 2023 12:43:42 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: [RESEND][PATCH v1 1/2] xen_arm: Create virtio-mmio devices during
 initialization
Date: Thu, 29 Jun 2023 10:43:09 -0700
Message-ID: <20230629174310.14434-2-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230629174310.14434-1-vikram.garhwal@amd.com>
References: <20230629174310.14434-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT047:EE_|SN7PR12MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 765efa18-0a73-4bf1-aaf8-08db78c861cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6Ro4tyrlgM0+PbFvt14DzrI4/RtLdDnLSSIQ90g9fIjqLJDjDWb1eI5XGXHxGGXXwxAY9EjWKVPbkgXQpTHWY/E8TZzjqKHzJPsGfq0hmNUbI1ogpfpXb1RX32t6udAsON6IsBLPpGq7u1iVDf9bsW8s9lf0JAUWZLYmUVWm211bzxyMl2j6GGkXrxgl3I/NK1cQ+6ETL+DyK4ftKA9kn9RGFVtEpysl6XV81EeJPK/k+5T8BsS8u2zbij6I/dtBQXwvhATGwfqL1MbrnL8nWyD97LttpPZSjQSDVl0SP4M/L6BffJ4nqivZmR2MchxnxJ6DrmTwNIPPIL07Amj2lc+0mjADUU55xYUaiWjrkvV8bGVu52ep005TpRtglwBgNYytsCtai2aHQYAC1TXeX+Ngnv4f2c4FWkz+nV/wWZPQ4ggBxq11BT11bzqeahO9VLzU04YEYahHrrQadRPw4+b0MMLBQoqE15IKKZJsP8GmeBjGFF0khE7Rm40lc8nKW5wKuW+xI5h7yznlh6kkNVAE3Ij//W5eQ1s4c4JqLX9r2+Z9q2LyEIl0z9bFvO/O0nfERzTFv2+hnFGHLO71r7uUcy+zm+s/uFqJczIU+mGrjxUJtb6j5JY14tJOuSjEpSpq9MzS61PY0oJUGyJ1iUngc0SD9FlPuCd6GvVq7dA7RLFS4kvwecluTU3NY0WYx25cpFl7uPp02rAcsCQQAZqM+HmWuZnC9o22/8Ed4ao0k+OQJVNIdGEqKyzIxXp4W2yyW8gBDcCdkpqiN/jMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(4326008)(36860700001)(478600001)(47076005)(336012)(6666004)(54906003)(83380400001)(26005)(356005)(186003)(426003)(1076003)(2616005)(2906002)(44832011)(70206006)(36756003)(82740400003)(40480700001)(81166007)(5660300002)(8676002)(70586007)(6916009)(86362001)(41300700001)(8936002)(40460700003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 17:43:43.2118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 765efa18-0a73-4bf1-aaf8-08db78c861cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7786
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::628;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

In order to use virtio backends we need to allocate virtio-mmio
parameters (irq and base) and register corresponding buses.

Use the constants defined in public header arch-arm.h to be
aligned with the toolstack. So the number of current supported
virtio-mmio devices is 10.

For the interrupts triggering use already existing on Arm
device-model hypercall.

The toolstack should then insert the same amount of device nodes
into guest device-tree.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
---
 hw/arm/xen_arm.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 60dcd1bcc7..c0a93f2c9d 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -26,6 +26,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/visitor.h"
 #include "hw/boards.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/tpm_backend.h"
@@ -59,6 +60,32 @@ struct XenArmState {
     } cfg;
 };
 
+#define VIRTIO_MMIO_DEV_SIZE   0x200
+
+#define NR_VIRTIO_MMIO_DEVICES   \
+   (GUEST_VIRTIO_MMIO_SPI_LAST - GUEST_VIRTIO_MMIO_SPI_FIRST)
+
+static void xen_set_irq(void *opaque, int irq, int level)
+{
+    xendevicemodel_set_irq_level(xen_dmod, xen_domid, irq, level);
+}
+
+static void xen_create_virtio_mmio_devices(XenArmState *xam)
+{
+    int i;
+
+    for (i = 0; i < NR_VIRTIO_MMIO_DEVICES; i++) {
+        hwaddr base = GUEST_VIRTIO_MMIO_BASE + i * VIRTIO_MMIO_DEV_SIZE;
+        qemu_irq irq = qemu_allocate_irq(xen_set_irq, NULL,
+                                         GUEST_VIRTIO_MMIO_SPI_FIRST + i);
+
+        sysbus_create_simple("virtio-mmio", base, irq);
+
+        DPRINTF("Created virtio-mmio device %d: irq %d base 0x%lx\n",
+                i, GUEST_VIRTIO_MMIO_SPI_FIRST + i, base);
+    }
+}
+
 void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
 {
     hw_error("Invalid ioreq type 0x%x\n", req->type);
@@ -110,6 +137,8 @@ static void xen_arm_init(MachineState *machine)
 
     xen_register_ioreq(xam->state, machine->smp.cpus, xen_memory_listener);
 
+    xen_create_virtio_mmio_devices(xam);
+
 #ifdef CONFIG_TPM
     if (xam->cfg.tpm_base_addr) {
         xen_enable_tpm(xam);
-- 
2.25.1


