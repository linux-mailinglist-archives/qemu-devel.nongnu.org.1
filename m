Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED5C742B7A
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 19:45:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEvgX-00044A-Nt; Thu, 29 Jun 2023 13:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qEvgV-00043O-EJ; Thu, 29 Jun 2023 13:43:59 -0400
Received: from mail-mw2nam12on2061d.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::61d]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qEvgT-0001Z1-9z; Thu, 29 Jun 2023 13:43:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g29tH9kT3jvTCA4An7IZw0i39OeQ28oh+O03mUs+pWiSkQD7k0omG3cUe/Gq0Ua8b4ZwNLtNW0BvFROQxM9ZyU9d4cfZfdylitDFYDii4HEPJ5ybJsjPfRG0+R5uesfMZHyZgluwVEzpZ4EDS5WT61+JeZYqRHQONYyuGr7Iy57hdeTrvAYiq358Coy7/yRwJqtd5jU0R26xw4H8U+cBrLF1CeMwB/qZ2zoa3ZiYHsp8ro6/yAt/S18TMLpPkO6KRZoEASVJHJOlmBP1sbTRV3mvkkmP7oTBPsT2SXf4uEAQZhmSK+tw8pKTLvE7ZLSGXo22s0v38Z2ne2qErSWPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrYsHFilp114q9j94TPQpC14aZpB6X6+VlgUoKWEiiE=;
 b=aMsC6ttX6wbgfaDG4hDwjWrejwnhDh8si53P8ftrW6vxU+Ejp4x/Zir0aORYhuXW61iAxos4IOpq/7fi2zDwsL8EkRRW4VSH3JCO9O+2iDQdyIRtXDsAvZQnA5OLrOz8Ri0TlR/5f1LpmJu9ZlOd51UNiLhp9hUS6n+l4vkzesZKaZvr+WiATRA53uLeowTr4QC534qwoQXCCxwucnCDprENLEmqwqXWaD2RDD4S5X9If9Xr4JGKbaM1O6RN0w9R5ewKN84UGmKq66HZGZIZaSv/kYEynRnDo5hxrtxyIjUXs32Gzj5ArL3dHxCpbVDn4tMyly1nWPuI8RWGmVlMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrYsHFilp114q9j94TPQpC14aZpB6X6+VlgUoKWEiiE=;
 b=WxGat1Os9dFV5ziAAOhTORPV0KoXHc6Gfti4KmoVx/QkXHfnUz7RERnkNa2ywvQSpuW79nXdH93iAhXuJYFNItoEQMFG5mDVHPam9auzOmJQ0vkhpuaIn0oGPkScfgVWBHZlNbyjeAlu+yXnZ3jhREp8/hTplIOCZDxjnRetYZk=
Received: from BN0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:408:e7::34)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 17:43:52 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::1a) by BN0PR03CA0059.outlook.office365.com
 (2603:10b6:408:e7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 17:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 17:43:52 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 12:43:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 29 Jun
 2023 10:43:51 -0700
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 29 Jun 2023 12:43:50 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: [RESEND][PATCH v1 2/2] xen_arm: Initialize RAM and add hi/low memory
 regions
Date: Thu, 29 Jun 2023 10:43:10 -0700
Message-ID: <20230629174310.14434-3-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230629174310.14434-1-vikram.garhwal@amd.com>
References: <20230629174310.14434-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d5a625-e61e-4664-a5eb-08db78c8671e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LbKnlBApZq64k1UFnH/icoffbSCraoXF5RgAA2fBIFZ3mcWGBgVWQyNyhjnc7l253UA4Ji/0K9/sf7Ce8ClInwv0MRrP7hdvVfOslB/5ioYsuMoV12QEn1sfPohkiQ0rW9o67Civ3KQ8weXwJkhO9+futxtyisTzjRO87Rloc4u6pIfJo+uQyiXZoqutKNhhLLulOUeWBBoVbzhsRuhrrz3btdLfJvpUH/QRwJNfd5WYiU9qr/eu5SGRbqvFBItuwIrbBO7rhBnmylaBZnqchmBb0zRFikcS5yfso9/lDw279OyGwjzJb5/xSk4gzU+5UfrtZDmJFuCm3kMUN/qpI8gMxq9Hn+WkiB/czfCa/VJhqSK/JDi1LGNlspQV1EoxSbC4NbMHOd+fSmxcG+BKbhgjwSKPDuMWEXFWtcHbPPjiwNAYuXPLWliWl7vXDLDFtzs0DRyKpgXjZ3NVtMhgWJdOx40Rl6SclPZFo+Q726tLJWVj5vOBQVoLB4IqhnnY29tRXcJCYapsEabeS7fM9cqYD5gMRtHiM8FE6bwU0e4AAdclwuid7SCT27CHYJHc4CKEmT5maD7sWxyuyzJXQeyOZEJCuKOoSKtWY5ERKKFQ3rCbuhjFHeDrO93p5D2norkgdAe8BNbb2YPKGkT8AiuoJ6OlXNzbJllTHugKFoXs/McVeud6fiKR2q/77Dv+ksoHJLIjmym6wM83PzZIDHBPJaftY/C+lqwzw/flFSOpEZzocQ3ZNvOJbq22Xi8ZhWTbtLGy2oJHMKyeWKI3pA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(82310400005)(36860700001)(47076005)(336012)(26005)(6666004)(54906003)(2616005)(426003)(83380400001)(2906002)(186003)(478600001)(1076003)(44832011)(356005)(86362001)(316002)(5660300002)(70206006)(40460700003)(82740400003)(81166007)(40480700001)(70586007)(8676002)(4326008)(6916009)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 17:43:52.1442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d5a625-e61e-4664-a5eb-08db78c8671e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::61d;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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
"-m" arg. If "-m" is not given, create a QEMU machine without IOREQ, TPM and
VIRTIO to keep it usable for /etc/init.d/xencommons.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
---
 hw/arm/xen_arm.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index c0a93f2c9d..cc4dffee70 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -60,6 +60,8 @@ struct XenArmState {
     } cfg;
 };
 
+static MemoryRegion ram_lo, ram_hi;
+
 #define VIRTIO_MMIO_DEV_SIZE   0x200
 
 #define NR_VIRTIO_MMIO_DEVICES   \
@@ -86,6 +88,39 @@ static void xen_create_virtio_mmio_devices(XenArmState *xam)
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
@@ -135,6 +170,14 @@ static void xen_arm_init(MachineState *machine)
 
     xam->state =  g_new0(XenIOState, 1);
 
+    if (machine->ram_size == 0) {
+        DPRINTF("ram_size not specified. QEMU machine will be started without"
+                " TPM, IOREQ and Virtio-MMIO backends\n");
+        return;
+    }
+
+    xen_init_ram(machine);
+
     xen_register_ioreq(xam->state, machine->smp.cpus, xen_memory_listener);
 
     xen_create_virtio_mmio_devices(xam);
@@ -182,6 +225,8 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
     mc->init = xen_arm_init;
     mc->max_cpus = 1;
     mc->default_machine_opts = "accel=xen";
+    /* Set explicitly here to make sure that real ram_size is passed */
+    mc->default_ram_size = 0;
 
     printf("CHECK for NEW BUILD\n");
 #ifdef CONFIG_TPM
-- 
2.25.1


