Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8DD789228
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Aug 2023 00:59:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZflJ-0000Ol-Jt; Fri, 25 Aug 2023 18:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qZflH-0000Nm-UK
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 18:58:39 -0400
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com
 ([40.107.92.87] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qZflE-0005Nz-AG
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 18:58:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm1mpsADDLPJJNZI08tMkg8jkTC2WbZmgBnul38aCm7tRXjWNg3Rv3U8e5OOvVFkEoaSbbGmvNjT0uCtqACuetqwaDGw7ctUC9+Dl1uhLBwmppD8l6d7Jx0yLCFy2He+x4Zve7FqVp5qIQ6zjyeBUgKDvX5qYQrY30DX6CgcqniY5KuenBEzeZfBwtMrZQP8oT2xHPvnmkXu9tOcf4ngi2zPSBvSoquVCw7Z921rI88+SuqaVksBrxQmKFPi1gfmkUYYs9e1dKUk5md1VWpWfnYf1r60k/p9W6Qmsj0ShwoJS+6GiJX06cYZfMEMFId1iEP1vgduoIMX4zEAkUxupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oS+qTaZkjuy8pMj0ta6mNWBBIbBxUekfOoEXY9J2m9o=;
 b=A2hK8TCRa67s1V4Sb9LsYTOIisFR1S8V+rb6bwyyZSl2s1bNuFOV4Zj/rmfGcaiixjc0LF9Ze5TTqP/k8hJaY9bkt85Taon+PQbwBGsJow0YyRFAX34Qm6hT3yKytdUTejkL1iahHVldLTb9yEJ7p0wr6P2xsXg3lithq5s4biX0z1k6bKgC6ASHBC4+JInGn1n3Rwb3NEDM5UflwGbEZJ842mTWS+Q7Ko+3IEiW1LlfG63Dn2Zkktf6V9m2lvIJwHUwd5xvVSRGiNns/pPXBQA1SU1A84Rc/IbSfkRwjl1Zyxj8bxunq0002rAS0cMXfeX8neXPFdVcNTqhY+/pwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS+qTaZkjuy8pMj0ta6mNWBBIbBxUekfOoEXY9J2m9o=;
 b=zjlLNG9bNCNG3bwTADvsxODsaWdDyOlSc7ceDBngkf6Ji1C8+P3PdOJ/OGccPgA6DUgB5WcBHubmWOU+HewgQRmqSDSR7PQOfLmR3cX7YXJadUY/NwN4w/TKQlyLATepvw/AZOKYj6znT+3OQs66GZ4HgSKXzwoLvJJqgUS7i4A=
Received: from SA0PR11CA0161.namprd11.prod.outlook.com (2603:10b6:806:1bb::16)
 by SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 22:53:31 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::e1) by SA0PR11CA0161.outlook.office365.com
 (2603:10b6:806:1bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Fri, 25 Aug 2023 22:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 22:53:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 17:53:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 17:53:30 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 25 Aug 2023 17:53:29 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>
Subject: [QEMU][PATCH v3 2/2] xen_arm: Initialize RAM and add hi/low memory
 regions
Date: Fri, 25 Aug 2023 15:53:26 -0700
Message-ID: <20230825225326.9438-3-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825225326.9438-1-vikram.garhwal@amd.com>
References: <20230825225326.9438-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SN7PR12MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1a2256-fe83-42ec-18e4-08dba5be1a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7PB7Gn/i7KrSjLs0/UY9cLdl27VNlXHXBGsL1Euo4iI7Zu8WB6cBEIPdL1/ZaFg2bJON8CtHt5Eac5vSfHOJuwouZtE3qUScvw2IWiBjxamf5jwlnCNX+pTD1//MEcdxZSYMl8k7Ng0DBCOU31uAAkMsdadM1HU5znwT8R0eDP6aMiZa/35jB/FedhDER1Cz9V0UFG7JvOcAaOsplgqkAhgyA1Yt6Q1D9eyfiY1xdwst0J2oLSDjjYiBjNZhUCPPxI2NPPlQAJ32T1MOWfJPzaPwtXFWnySBoZfStoC9U/E2QTXFpPH3KjRMIOq4hUHR0Z5PVdpGHYmZVFICeq3hosXvJkA7lBRMDq3zhIr+FRlkbypE+qaNG3Fl9KRLN7LfEKMxBx1oNKC053TpQaG7AO4wKCedAE4yoc2zK84OZGm6+RZaCbo6lzM134jS1vGCCzkc07YNwio1TF4pG2CLLp1CfAFQMwJNwHw5WIMtxLROstChD39ck07MGIbNd9ws/i2FsOyClyOQx0TcRWwozp7U+z268bt9Ke7Ly88+P9N0epK9G/Z6xGtWKPFtvcC/EYxjRZH1itfvQJk9kGIC0E2/mxDzgbNSRci/1QQeDfvVyJJLPAovSX/DCzQ+/RqJuXfUj/qNFaCqf05mbbVO9HMzCA9yQUnMSjPuK4IlTgAmEYRfvmVFsdn/b80o35i5RxgMb0ftwf6/9rtnub5L3gZtTzV/G7b/IMaS9Ps5X0G/pAV77KJ9CqsrJF+fEooX9o+TKnyYudy83TwKc3Uonw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(186009)(82310400011)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(40460700003)(2616005)(8676002)(8936002)(83380400001)(5660300002)(4326008)(426003)(336012)(36756003)(36860700001)(47076005)(44832011)(1076003)(26005)(40480700001)(82740400003)(6666004)(81166007)(6916009)(70586007)(70206006)(54906003)(316002)(478600001)(356005)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 22:53:30.9247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1a2256-fe83-42ec-18e4-08dba5be1a80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154
Received-SPF: softfail client-ip=40.107.92.87;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/arm/xen_arm.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index d1e9f7b488..aa8b6171ad 100644
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
@@ -80,6 +82,14 @@ static int xendevicemodel_set_irq_level(
 }
 #endif
 
+#if defined(__i386__) || defined(__x86_64__)
+#define GUEST_RAM_BANKS   2
+#define GUEST_RAM0_BASE   0x40000000ULL /* 3GB of low RAM @ 1GB */
+#define GUEST_RAM0_SIZE   0xc0000000ULL
+#define GUEST_RAM1_BASE   0x0200000000ULL /* 1016GB of RAM @ 8GB */
+#define GUEST_RAM1_SIZE   0xfe00000000ULL
+#endif
+
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41700
 #define GUEST_VIRTIO_MMIO_BASE   xen_mk_ullong(0x02000000)
 #define GUEST_VIRTIO_MMIO_SIZE   xen_mk_ullong(0x00100000)
@@ -108,6 +118,39 @@ static void xen_create_virtio_mmio_devices(XenArmState *xam)
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
@@ -157,6 +200,14 @@ static void xen_arm_init(MachineState *machine)
 
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
@@ -204,6 +255,8 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
     mc->init = xen_arm_init;
     mc->max_cpus = 1;
     mc->default_machine_opts = "accel=xen";
+    /* Set explicitly here to make sure that real ram_size is passed */
+    mc->default_ram_size = 0;
 
 #ifdef CONFIG_TPM
     object_class_property_add(oc, "tpm-base-addr", "uint64_t",
-- 
2.17.1


