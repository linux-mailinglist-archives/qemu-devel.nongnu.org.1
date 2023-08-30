Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1D078D2CC
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 06:37:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbCvx-0005XZ-N5; Wed, 30 Aug 2023 00:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qbCvg-0005Wk-FM
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 00:35:44 -0400
Received: from mail-dm6nam11on20629.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::629]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qbCvc-0000JB-MB
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 00:35:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNwEJwmA0sC3Iot+PrE1fD94i7Kef8jU1jSVCBQRNIiQ3vMDXEthFWZBeO3tZcm/ja/FdM4yOSEkLBYp8sH26zvO2UISFnjxKAhA7YLlDQddIALu2pEwjlrwK1298/GgWtxwBTthPRy1ZjdMU4sJGRg/JawEYZ1V9XWxQ03bf+V2McJ+ycDepcKAQ3anHFACabaJi4Ms5t3TDtxiPErbw7ESdgjuvW3VW3XOxvgVk+T6djWNgNDByyev1diOeE81DGBg5VaeXQURaZqX7P6mq7umB44mAdGqGdrbvWLMhraSFFDLc+kwAmTixGC4XoHct8bsdN3sN1LBmHfKLvuXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oOd2yxwvC45JP2TsBafod6gHXyZWFbz3/LOKqVOoqE=;
 b=a2BveGBypglfhZMgTKvtlnTydM+41y2hsMaFD4sa6vhn/etKqLElqkRTW11lCix+uku4Vb8QpsjLA7w/GMmk8RKAZMnX0Y82SseSFv5diUVigDXd9iRrCTGa/FXbJjrocb4rCPxRlzIsvMPSUcslq7Mr0jyzrUpEglNZcg4fXjiLfaygSMB3+s4vyXIXRBJpPNcVQ26E1+K+DrXlWPG6VFMI954Nc4hZqfTNK593M7hovTo2JMNRaj8i9v3MAG8D6LpVAyh0sLVngLWmYLXt/QEjbDH/hN7UJ+z8a+LUG6RNKWiLArNs9Tsi2Ml96KWPHH5n/GuF7UBzxjaKrRFDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oOd2yxwvC45JP2TsBafod6gHXyZWFbz3/LOKqVOoqE=;
 b=owHW6yaWefcgCmnDP1A4hG4GGsZhydRnZpSFcz5zmnURa5kafAqyrfi1hOGLCHVpceIDbn6ym598HeMmBc7sGI0/zGic+Q0pnZOzTmQEoQyfECdrg9WSVlYZh9uz472pS8m0ALbmge0HWLi6Tq21gxT7cDXlck8kfOGTfGD8ddM=
Received: from MW4PR03CA0275.namprd03.prod.outlook.com (2603:10b6:303:b5::10)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 04:35:36 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::96) by MW4PR03CA0275.outlook.office365.com
 (2603:10b6:303:b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 04:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 04:35:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 23:35:34 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 29 Aug 2023 23:35:34 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>
Subject: [QEMU][PATCH v4 1/2] xen_arm: Create virtio-mmio devices during
 initialization
Date: Tue, 29 Aug 2023 21:35:17 -0700
Message-ID: <20230830043518.21584-2-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230830043518.21584-1-vikram.garhwal@amd.com>
References: <20230830043518.21584-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: d3647b91-7c5d-4325-8c96-08dba9128dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SH6lyIi8SOhVIQDqwVLaaXfvVl2KTWrl1pgUj9gFUr3lOBaldXQHef8wcUcPELftRrS3d/IUNTYw+tNjhu3GSuWGisZyHixLfL9B2hQmSc4NMqL5/FLrqJ26ZEBw97fGC2InRPuE+AWLAG8B8Y6ZKoXKMVokfWGVr5rTv3mIqGemrTUu3d3cbHFX06NmNYJ5lfrOjp7yqgrbVAz/lMKrq3i6yKz7irpwyDbWiswo9DiTk39ngl+2yxj1hmsVxWXCPc1hS5/J3AUsj1o5S107mjsbTxtDeBmMPgeeThgW12FRMksc4zT+6UTZ+oHrXmp2fEZVOY9hOl+OEexr6LYjlZ8OZlBhT9q9x7DJ5K5+SGJ+znoYqg8ONOxuDE+rOViwaOMYhdsrFhxTlz2qdB0X9USUKxc1aGfNZ+sJdQ8ITORCUUDxQQZSJ6o6wQHMClzF9Zw7VDqwVMG4zhcqz/doIT7holcVPKB0Y2xp5mK/CtZlXZh8lnZ0qiP4PlS2qqHX3Zb45/++tvC+TvbX81C8PekuffxRToXLSYGqLQmsD/XfQephFM9vZID2BNN+/+vc3FL8HO5H9c6SeJABcusi3+IlBwu7SqpdshGO9eqLyH3oIicPOGr+kERyYuabGiIncN8vmeIuKj7iWhOeZrsfXQgNRXP5IpVS+/BVybYXm+/f9x8qam8SmsC4G5lZHpx0CLtMIUFq9KEBTrNi1Dz7Zll21d7boo3XK8ktnM9cHqFKxWp9TB6ayRkIEWywmWr0CR/GUFEiekknLdhqaHLaQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(40470700004)(8936002)(8676002)(4326008)(54906003)(2906002)(6916009)(316002)(36756003)(70206006)(70586007)(5660300002)(44832011)(40460700003)(41300700001)(36860700001)(26005)(2616005)(336012)(426003)(1076003)(40480700001)(81166007)(82740400003)(356005)(478600001)(47076005)(83380400001)(86362001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 04:35:35.5804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3647b91-7c5d-4325-8c96-08dba9128dd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::629;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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
 hw/arm/xen_arm.c            | 35 +++++++++++++++++++++++++++++++++++
 include/hw/xen/xen_native.h | 16 ++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 1d3e6d481a..7393b37355 100644
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
@@ -59,6 +60,38 @@ struct XenArmState {
     } cfg;
 };
 
+/*
+ * VIRTIO_MMIO_DEV_SIZE is imported from tools/libs/light/libxl_arm.c under Xen
+ * repository.
+ *
+ * Origin: git://xenbits.xen.org/xen.git 2128143c114c
+ */
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
@@ -110,6 +143,8 @@ static void xen_arm_init(MachineState *machine)
 
     xen_register_ioreq(xam->state, machine->smp.cpus, &xen_memory_listener);
 
+    xen_create_virtio_mmio_devices(xam);
+
 #ifdef CONFIG_TPM
     if (xam->cfg.tpm_base_addr) {
         xen_enable_tpm(xam);
diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
index 4dce905fde..a4b1aa9e5d 100644
--- a/include/hw/xen/xen_native.h
+++ b/include/hw/xen/xen_native.h
@@ -523,4 +523,20 @@ static inline int xen_set_ioreq_server_state(domid_t dom,
                                                  enable);
 }
 
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41500
+static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
+                                               domid_t domid, uint32_t irq,
+                                               unsigned int level)
+{
+    return 0;
+}
+#endif
+
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41700
+#define GUEST_VIRTIO_MMIO_BASE   xen_mk_ullong(0x02000000)
+#define GUEST_VIRTIO_MMIO_SIZE   xen_mk_ullong(0x00100000)
+#define GUEST_VIRTIO_MMIO_SPI_FIRST   33
+#define GUEST_VIRTIO_MMIO_SPI_LAST    43
+#endif
+
 #endif /* QEMU_HW_XEN_NATIVE_H */
-- 
2.17.1


