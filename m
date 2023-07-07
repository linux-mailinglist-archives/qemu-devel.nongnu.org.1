Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6886474B95E
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 00:05:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHtYr-0000AK-Gh; Fri, 07 Jul 2023 18:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qHtYo-00008X-IU; Fri, 07 Jul 2023 18:04:18 -0400
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::600]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qHtYl-0003Sn-Iv; Fri, 07 Jul 2023 18:04:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PszV35NqOzZSXoRynJAlz2dLzOiAphxGc989xnM0qpBOCvwjweN5MgnQXbXjsxEgpKICV4dyOw4fV2maGpV9L+XCEik0jzE4oxU7kl9rz0Pwi+iOlB7pHwQBL4ELIS4AzT9ooZ2Rj0Nj/uksXegZjggEZYymxhYRl9+FrhBvN0PMUi7NksUSzXWNZWvdsdZcDuqPUhNT963mhnUmlZf0aYL70eBUHIJs2XFztysqgZYS0x8g5Yq797wrpeSJrQsGaKuUubH2A4vhN4KzBQx1MD02N/Airimcck1T2zbSPy3U//6stPJpWLzRB1vBQsdWfUGHyw21G9yT7pzhyHL0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHhFU9n68Xxnl6tJ029TeOOKXjypEuE9xWwuXZ8fmBs=;
 b=GDPTjq0RscRDErjhbC+cE0H7rsLZzfMAO5DLHJxw8Qfx5G9HTrNxZeO8h5v4jjxoEp7rQG9wSqfyqGbddAqJ2BxOHR+bsgegKP9OfZPBDWUDBAtjNdT7Fre5Al2V4Ht4wHUav1neQSg3nT2XoHDw7XpdNQcAjnGFpXWpFOmnwacyeAnr1X8DtaWESR4bySLg0aUg5EmYR6E8jAyPNUlY4EtK4XpbLSJt3eqydoAFAnpxnCv+LlQtoOvYZrkE6AKwKqeDc1NA2X/c38M+gz9w7HWBaZqXRv4yPlENYm8dclKWFwTseFGsSCUp7EvsKusmM9PSC3nV42Jo17gNKlWiCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHhFU9n68Xxnl6tJ029TeOOKXjypEuE9xWwuXZ8fmBs=;
 b=Hy5mqgR9IYooB72QiEqwbK2RuFMfLFfTHsjAPtfYpsnr1PIdXHwhtzKkceJTQijg0/j29DneOcAmG8Uh301ghROl9SsYAmM8B80mNBgWc5jCFQQwAGCw5+7mLqBk+huImHHo4yqDu14ESeKUx+hXIcYHG+YkZtIeDin/GiI2RfI=
Received: from BN8PR15CA0040.namprd15.prod.outlook.com (2603:10b6:408:80::17)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 22:04:11 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::2f) by BN8PR15CA0040.outlook.office365.com
 (2603:10b6:408:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 22:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 22:04:10 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 17:04:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 7 Jul 2023
 15:04:10 -0700
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 7 Jul 2023 17:04:09 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: [QEMU][PATCH v2 2/2] xen_arm: Initialize RAM and add hi/low memory
 regions
Date: Fri, 7 Jul 2023 15:03:58 -0700
Message-ID: <20230707220358.920-3-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230707220358.920-1-vikram.garhwal@amd.com>
References: <20230707220358.920-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: f9663d88-1d7e-4850-74ea-08db7f3617c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FTeGs4yM88EjJucL5+IzWmLw2mBFpjPdAWsOMihBKJd+X4fF4IIrB/AC27ugzxmc2yqh4x/9t/NKhoaUIKNxCSh2l+UWX5Rh9DCrh7cNzruWmKgN1qO9a5yAkra4uwU+eXEoXqPDTvk9/803OVhCFTChnJSJAsuYCalLqZcCBdC6m977WmbhykZcX1u9OE6KzCtGNOPaHJeykEhxgTIOt9vq4CRVC+xoPKJbaKKqP3pR/M9ydLiQw2J/YDDe7nOcwZT0glspPqq3DSNTzx3tOMb0ozcWbG8Va9YYZ5YqUo+otMy3lI+P43kBs9h8bWkCfx5DBDzspeLJ0/jAAfVbrTaVsyyXa+cJ1ZxCgDHoMi+fRU5GuwjegzPH+lQ3AVe4MGNVlV2e5hd8H604CLC2I9+EuB+8T4KxFEM+GPP4avw82sKfz+b3ntXYttx4sl5ZVCicQUTE/VF+k3cPn0j6lN1p7qfgtL/wQ72j3gEv7Tz7NpUd3LK0coAW9wRs3y5Pse4jsfaO8+up/bg3kgSptuCJbJR2cr1oemiUsglQO5LMPGs8b58bxS/lV5tfBEvQSwyzQ2C3dDWTNunB0I1etE0wUsuwaCyxK2fh8aFzweYaTR28w7ne+sV5BDMsFyWxBzhp1tJLQEbm772qySpdt32hxZGm85b6DVeyBDSo2ES9UR2UEfvfxvEXnKWcoc9uPAuWk48J0uEdI0x8Py67evmb2vo7TuHd6z9h0X/XMQsXS3pShTYulzGD0lyn3otW7ewgU2CJqJxSE4kmOVcWsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(44832011)(316002)(36756003)(70586007)(4326008)(6916009)(70206006)(5660300002)(8936002)(2906002)(41300700001)(8676002)(40460700003)(40480700001)(47076005)(54906003)(86362001)(36860700001)(82310400005)(478600001)(82740400003)(336012)(186003)(26005)(83380400001)(6666004)(1076003)(356005)(426003)(2616005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 22:04:10.6104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9663d88-1d7e-4850-74ea-08db7f3617c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::600;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

In order to use virtio backends we need to initialize RAM for the
xen-mapcache (which is responsible for mapping guest memory using foreign
mapping) to work. Calculate and add hi/low memory regions based on
machine->ram_size.

Use the constants defined in public header arch-arm.h to be aligned with the xen
toolstack.

While using this machine, the toolstack should then pass real ram_size using
"-m" arg. If "-m" is not given, create a QEMU machine without IOREQ and other
emulated devices like TPM and VIRTIO. This is done to keep this QEMU machine
usable for /etc/init.d/xencommons.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
---
 hw/arm/xen_arm.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index e700829654..ec8de00cf5 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -60,6 +60,8 @@ struct XenArmState {
     } cfg;
 };
 
+static MemoryRegion ram_lo, ram_hi;
+
 /*
  * VIRTIO_MMIO_DEV_SIZE is imported from tools/libs/light/libxl_arm.c under Xen
  * repository.
@@ -92,6 +94,39 @@ static void xen_create_virtio_mmio_devices(XenArmState *xam)
     }
 }
 
+static void xen_init_ram(MachineState *machine)
+{
+    MemoryRegion *sysmem = get_system_memory();
+    ram_addr_t block_len, ram_size[GUEST_RAM_BANKS];
+
+    if (machine->ram_size <= GUEST_RAM0_SIZE) {
+        ram_size[0] = machine->ram_size;
+        ram_size[1] = 0;
+        block_len = GUEST_RAM0_BASE + ram_size[0];
+    } else {
+        ram_size[0] = GUEST_RAM0_SIZE;
+        ram_size[1] = machine->ram_size - GUEST_RAM0_SIZE;
+        block_len = GUEST_RAM1_BASE + ram_size[1];
+    }
+
+    memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
+                           &error_fatal);
+
+    memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo", &ram_memory,
+                             GUEST_RAM0_BASE, ram_size[0]);
+    memory_region_add_subregion(sysmem, GUEST_RAM0_BASE, &ram_lo);
+    DPRINTF("Initialized region xen.ram.lo: base 0x%llx size 0x%lx\n",
+            GUEST_RAM0_BASE, ram_size[0]);
+
+    if (ram_size[1] > 0) {
+        memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi", &ram_memory,
+                                 GUEST_RAM1_BASE, ram_size[1]);
+        memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
+        DPRINTF("Initialized region xen.ram.hi: base 0x%llx size 0x%lx\n",
+                GUEST_RAM1_BASE, ram_size[1]);
+    }
+}
+
 void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
 {
     hw_error("Invalid ioreq type 0x%x\n", req->type);
@@ -141,6 +176,14 @@ static void xen_arm_init(MachineState *machine)
 
     xam->state =  g_new0(XenIOState, 1);
 
+    if (machine->ram_size == 0) {
+        DPRINTF("ram_size not specified. QEMU machine started without IOREQ"
+                "(no emulated devices including Virtio)\n");
+        return;
+    }
+
+    xen_init_ram(machine);
+
     xen_register_ioreq(xam->state, machine->smp.cpus, xen_memory_listener);
 
     xen_create_virtio_mmio_devices(xam);
@@ -188,6 +231,8 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
     mc->init = xen_arm_init;
     mc->max_cpus = 1;
     mc->default_machine_opts = "accel=xen";
+    /* Set explicitly here to make sure that real ram_size is passed */
+    mc->default_ram_size = 0;
 
 #ifdef CONFIG_TPM
     object_class_property_add(oc, "tpm-base-addr", "uint64_t",
-- 
2.25.1


