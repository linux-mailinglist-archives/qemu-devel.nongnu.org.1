Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC6178D2CD
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 06:37:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbCwJ-0005YM-Bt; Wed, 30 Aug 2023 00:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qbCvg-0005Wl-Gt
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 00:35:45 -0400
Received: from mail-co1nam11on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::62c]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qbCvd-0000Jf-Gg
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 00:35:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYXUiRwS0z/7gZPYQz4CMhd+1da0joO/FNEfRrsAnKEsHufLulEL7juhouJ2hgragv4h2sjzcy8CJXlWOkQR12xVnDUrihG+bq5/QRDlyoQ9sQMDvXN859ZLOyC6fRwxoZc2t/VUTJWbRuFBhGyg4acPuJVItHRMjjlIdYGGGjIagzn0htv0RUDqQwWOvldnkcJDjU2gMX4QoRfrsUDlzuSHOixo5hG4KB0hwjxtq3G5HLMenzWEo/QAfpnbY3gdvjpR7VGxvRDj2E/ZT8MEmFiePgH6+dyPpsioEe+11OQVu8VmX2d0jkcKaK9QnRDoTReZ4SzLVWEIlMMnpDSyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1a/A4UAgepJ+GzXsqiD6GCsQifRd+u9n12Dmn6XslQE=;
 b=fqoJmsxMxQYcbJnkjMA8TQLHKbJZUeamCK0uLtshykxEbHk4ohyYjwFLi7xUCyuyJ6n2/E45dPOX2/Ps4m/sWKsY4TsX5NipSwoRDYdnys1mdLw6kpCpf0GebSh9vAwOVcNQt88hbDy3iLnowRNUPL9Ew6zrmUaDCeNBOwrmlBO0fZO7yVpu4KjA9e0LanP2n89SVzULrEjvEKNMdRWzyKi3fuKEybx+qZSYsUWIFnaMRrHhS8Lc1gebRSPdvxPIJL7KaqeoZ7o1/m6NvBK+viCfxD8w7uGTrutg0NTyGmwVnk7zVv2EMjNlNyX0Qna0kFWLhqV+KUAFnVHrpwNPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1a/A4UAgepJ+GzXsqiD6GCsQifRd+u9n12Dmn6XslQE=;
 b=QIwsvfZMPtHQ7JJ5a3vlZbCdS3gA10USg+kE4Hk5ppfsxn2dCKzlDGC8vY+jnTsYtmPeCPJ059c855alrsrpSzsd0JnjQZJqX8ki583CyH5BXMHKhepSCSBEGtnrVcOGFbEIJHBcxJrCtEqfkIIc3wWo8hQ9LttSDtSCvGe1nQY=
Received: from MW4PR03CA0094.namprd03.prod.outlook.com (2603:10b6:303:b7::9)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 04:35:37 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::fe) by MW4PR03CA0094.outlook.office365.com
 (2603:10b6:303:b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Wed, 30 Aug 2023 04:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Wed, 30 Aug 2023 04:35:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 23:35:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 23:35:35 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 29 Aug 2023 23:35:34 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>
Subject: [QEMU][PATCH v4 2/2] xen_arm: Initialize RAM and add hi/low memory
 regions
Date: Tue, 29 Aug 2023 21:35:18 -0700
Message-ID: <20230830043518.21584-3-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230830043518.21584-1-vikram.garhwal@amd.com>
References: <20230830043518.21584-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: cde0b46d-a1cd-4e8c-236f-08dba9128e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLcDD6GuaeCFhUN9gSi7eyThLW7t9MLvHqV8rYsLyMO7gZ2iBpmFO1orEY+dIlrApsJw4mvi/DKF2EjgJiGFxfgxI64RVPBYW7MKZhRnzwS1WVwxcMXoGISCWujC/HMEp44uDCCKwpSvubRrT8NDazgLUsMlMJSvao7GgATOxUHkFl+zMhfkVOoBQ8MfsSb3t/XGxlbUSCUadu4QdaK90eyVbTtcqrV5sczN4ucoFHLOJaT824Idc3whPqd7pGyPPvCLtskMVqzDHx+WkzYtCwT5dRTI/h8r/zjrcbigVenjK4XgH8j/TeVNPK4gs0TNHBaSpBQ7cloasmof1SOuBMN/zsUQvDN0WXZMHvdYXy+KPj+h4+NBVjd4ui+3D5EDUbcPnE0WIXjiU+LN/+8rjlXPyzvDLnOSXoeMKuhHyOK52ETHkB6umrfjmG1KXfRRIYS1N84uXjyAjoY0Fy6v1ys2xshVYFr13SHWlVft2WnqxF3ElyOKxwKzbWx4XZ/TS8KOdx8ki8VTdMl5On6JQyqj/cT06NDIFC/qpfLCxXY1xJp0MXA2jnj5tMiem3CzJZBFi7MEbQwZA2SjFcObB/5yjw6bconX36AU0fRKbt2wB+a4z/cucgDbflYc3iqKWJWt+JoE2TJRLgW6Z/8x02yTH9BHhVZcl7DtxJt9J0nFxL+PmJlC4vnW2X9SlEpmZhRXb2dluLc5GX5j5ocEb12iF+62kDT7VA64Ui8D1DwEH1KQD2YW/glkpwmfIaF8yNOQyxON9ZeRm3a6bd9+8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(40480700001)(83380400001)(44832011)(86362001)(41300700001)(4326008)(5660300002)(8676002)(8936002)(26005)(6666004)(1076003)(2616005)(426003)(336012)(36860700001)(47076005)(82740400003)(478600001)(81166007)(2906002)(356005)(54906003)(70586007)(70206006)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 04:35:36.6213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cde0b46d-a1cd-4e8c-236f-08dba9128e7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424
Received-SPF: softfail client-ip=2a01:111:f400:7eab::62c;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/arm/xen_arm.c            | 45 +++++++++++++++++++++++++++++++++++++
 include/hw/xen/xen_native.h |  8 +++++++
 2 files changed, 53 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 7393b37355..f83b983ec5 100644
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
     xen_register_ioreq(xam->state, machine->smp.cpus, &xen_memory_listener);
 
     xen_create_virtio_mmio_devices(xam);
@@ -188,6 +231,8 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
     mc->init = xen_arm_init;
     mc->max_cpus = 1;
     mc->default_machine_opts = "accel=xen";
+    /* Set explicitly here to make sure that real ram_size is passed */
+    mc->default_ram_size = 0;
 
 #ifdef CONFIG_TPM
     object_class_property_add(oc, "tpm-base-addr", "uint64_t",
diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
index a4b1aa9e5d..5d2718261f 100644
--- a/include/hw/xen/xen_native.h
+++ b/include/hw/xen/xen_native.h
@@ -539,4 +539,12 @@ static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
 #define GUEST_VIRTIO_MMIO_SPI_LAST    43
 #endif
 
+#if defined(__i386__) || defined(__x86_64__)
+#define GUEST_RAM_BANKS   2
+#define GUEST_RAM0_BASE   0x40000000ULL /* 3GB of low RAM @ 1GB */
+#define GUEST_RAM0_SIZE   0xc0000000ULL
+#define GUEST_RAM1_BASE   0x0200000000ULL /* 1016GB of RAM @ 8GB */
+#define GUEST_RAM1_SIZE   0xfe00000000ULL
+#endif
+
 #endif /* QEMU_HW_XEN_NATIVE_H */
-- 
2.17.1


