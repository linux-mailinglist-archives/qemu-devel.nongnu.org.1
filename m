Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B530E789227
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Aug 2023 00:59:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZflM-0000Rv-Dm; Fri, 25 Aug 2023 18:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qZflK-0000Qo-Vz
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 18:58:43 -0400
Received: from mail-dm6nam11on2040.outbound.protection.outlook.com
 ([40.107.223.40] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qZflG-0005ON-8t
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 18:58:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7OFTmoxqR+zKpd9OUbJlKxMS+Xu7Ly7JfBRhcd/oPoj6Q3Xv+OfCpc9puHX5FNR8DsA1XK45u+oRBKDBWavtQch4IM5hAcFxZjExqgrEEGyjeab/DiSRrvnlN3Yvtn7N3MQm6KeCxsQ9GY8gpkypMFVohlkmkwfpMfTCSD0UR7p+JczdV1lqFuuga4T+Yz49xGGOToEFvZFXICaxHlGH1Bbwyh6XV/ZTgPse2/muQDbv9LEtHzqWokXTEZ2RPyg7y+PGzRRCl6lDVTo5/saAueIdIx5/wU9PU4IQa5vaCScNd4kJ5iFnlh8wx68rXCZpgcF/3INpovWvRAQgr4xLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PtkiVtZv0hsvo+Gr9PfxuXUuxYO+eXlSYfO9PnntFs=;
 b=BtOaEp8GNS4iNWOyMFmNpS5s6D9F2dj/tadXal7YoWUdZZZIruBMay9yf5WPnpCOoCCEJDXOoqjdENlSAtaSbhGHh4DnEKvGlfh0B3wafVbJ5BhBhpDitHSYj3uA4nJP8urRlVu4fcwYDqAd32gtn9IrMuGpMlv9oVwi5rLGiCnE6JPr8ro2zd7o6Ih50Bw12UsB/4dWl0lm9h71MccyontQSg51YX2hYuRr/qUfEEsrPsTYOvmptEjuvPM+2c1P1rD1CfZ1Hq6F6vnkb22hPyCkUbCvt/+KY/JyS/Om2Dy+tHtEMU2f7hRWLGnD8sTKyPOWIKCe8RBPNcf0VsrUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PtkiVtZv0hsvo+Gr9PfxuXUuxYO+eXlSYfO9PnntFs=;
 b=eJ6t148yVE6LnP7C5BYch1n1PKT1Ppn1KOabGXTUlhEnWyTYgauYBXkNkFFpMXxbqWD3zl47F914CijB4zY2NSL7amh4RKZOsFoO6IZ6o/5QKsIwWqiBSfqIZGhGwJb+hETrBGcCtZbuVAyNf90l1HRU3mPZ8V/qP3j8wCitJW8=
Received: from PH8PR15CA0013.namprd15.prod.outlook.com (2603:10b6:510:2d2::16)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 22:53:31 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::b3) by PH8PR15CA0013.outlook.office365.com
 (2603:10b6:510:2d2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 22:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 22:53:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 17:53:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 17:53:29 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 25 Aug 2023 17:53:29 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>
Subject: [QEMU][PATCH v3 1/2] xen_arm: Create virtio-mmio devices during
 initialization
Date: Fri, 25 Aug 2023 15:53:25 -0700
Message-ID: <20230825225326.9438-2-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825225326.9438-1-vikram.garhwal@amd.com>
References: <20230825225326.9438-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 59316550-2900-4c60-758c-08dba5be1a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2OQTLyS8tzwc8HyDkAMZal3xoYHEzTrDviWGGUTjB+7Wsg8CUVylFCgo3FMnHKdRVL1sKWGJWH/KuV5rE33L4X89xwqVl7sU9Fp6w/uWnPQGEajqfxL2Lx7q4OxO81Xc4dXoIuH0L4Vwva8oBTh4618q1geKEV2hPwNMRUxzX+SCrz8wPlOCZKXXTkcwucUyYNP6OmMRBLoEtv1UFadDnQ+rLAM8vbb8W7Otkj1aGcE0TOzA82iSJof5xXdbxccRNIKsaiHok1p5pTMFe1UxRh0QjegGPSkEw/WIeTIX3HIi85pU06SJyoAGbOJpBI8BgO9r34zA0p/VzyDQeeU4ECeGV83CeQKq5MvvZ5d3RiLKTMGbqSWas8sLMQqN2LMLZgWN370m6r+2wXtbiMh1hNem0ohowkhx24gsQIKUXr4Hryg3MdNWJ9Iet+XGXgd6cgjExf10p7fsxOO6lBYIxAzLWdFY6fOoZH1ujZdLuCs+u42fZBWNGdcDPexuwgvQdTwtWiOR14Mo8Q8CH6zJMuDG9Jwc21QBpVJlrY10HNI15+ueOh519we7Sc9U9C1EHxysb9o85ur8DmYLmnHGPSpyPouLdPVYverdJSR0qsJrbhsGgrrFWrJHfFWj4G2j45ctsA52ddyOgy/hAVSBUJSDjOj8ZkO9mBve2aRn5+IYBzBPTB4EfdDyghCgZVobL3Xn0M6oisN9eFFaw/5PULDVRbDT83aVH2EPZDK0ydZ6vxHJCpIJK32p6OeummHNJBoR1XSBQ7eHDkhZP3Cew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(82310400011)(1800799009)(451199024)(186009)(40470700004)(36840700001)(46966006)(1076003)(5660300002)(8676002)(8936002)(4326008)(2616005)(40480700001)(26005)(316002)(41300700001)(2906002)(70586007)(70206006)(54906003)(6916009)(44832011)(478600001)(81166007)(40460700003)(6666004)(36756003)(47076005)(36860700001)(83380400001)(336012)(426003)(86362001)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 22:53:31.0844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59316550-2900-4c60-758c-08dba5be1a98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
Received-SPF: softfail client-ip=40.107.223.40;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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
 hw/arm/xen_arm.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 1d3e6d481a..d1e9f7b488 100644
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
@@ -59,6 +60,54 @@ struct XenArmState {
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
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41500
+static int xendevicemodel_set_irq_level(
+    xendevicemodel_handle *dmod, domid_t domid, uint32_t irq,
+    unsigned int level)
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
@@ -110,6 +159,8 @@ static void xen_arm_init(MachineState *machine)
 
     xen_register_ioreq(xam->state, machine->smp.cpus, &xen_memory_listener);
 
+    xen_create_virtio_mmio_devices(xam);
+
 #ifdef CONFIG_TPM
     if (xam->cfg.tpm_base_addr) {
         xen_enable_tpm(xam);
-- 
2.17.1


