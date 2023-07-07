Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 966F374B95F
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 00:05:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHtYo-00008M-SS; Fri, 07 Jul 2023 18:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qHtYl-00007O-O9; Fri, 07 Jul 2023 18:04:15 -0400
Received: from mail-sn1nam02on20602.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::602]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1qHtYj-0003SX-7q; Fri, 07 Jul 2023 18:04:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUkjeP7W9RJoYWRkMza9N7vyIEsqlWp1KU86hELy0xjWDmNJD+d1CefbfcbH0/fydN7UeRwJaoZoLW3nIFBjUZTb9Zvwaej5JrtpJ1RE9a+8NPFvUhEr2lQ/U9zHhLSprZeOnb2uzHSuifdFvb3AwX7XrbqaOTAz/0JfIjZX7aDPvbToh9TSIEpuunbuo0FXVy4v5cFrjRfrNRdIirPQW1JIF3rs2xN65a7yp+dN+o5bcYNC0Aj6C5w/2dlA7/1uteSHesJBlxXDr+uneWGza0hdRjWw4lKvAPzZbp7KwjObBOGlxReQJF1BXTt09pJGb/6izPBk1igbZo4kUn39xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnsQVXapfS9XKxAkuj8ZbfBCsAjXU6TaGEgGeEWMyKA=;
 b=ZDsde5O4GvCMpLHwjHxli3pE7wVfpyeoDu4VSUFaG3GWMR4alIxNh5SZSOM0C6IPw6a3Y4ndhw1Z5DkSd+mRBZ5HUuYGksU+JzYjkPi6YhucFc2/tyuS2rzWKYnQy2HoTq9FqbqIp2ND0yQfqb56OHrcFU3+K3ALwe+EzhoZ2kiuNFJ/EvfDLYtlm6oN6UJo3jhWxFYifXhr022Ns5py5c7B++5KM2SmL5OiTSgLBGifSnOPTI2OOKqVT9BBQFFOvhdmxWXUkk4K/UPxzDkD3/eBfNw4l44FCuyarpT0oOfjCnuA/fYwz3wxLd4GSFQ/Rg+d+NpHv9TEr6iK200reQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnsQVXapfS9XKxAkuj8ZbfBCsAjXU6TaGEgGeEWMyKA=;
 b=xth5r/FEuzZ5vInDg7nqZr4V+lmRuRNA+bEuO/I4xIYRWmSaNGJvP+vtSeBWaj7pAtKDDrc5Xp3aNviPcB/QhOQ6d0jYouey+WKFoIIzxHNtjKySm0Eyy4z6PBUxsF2Cr7aKUlta8LrnmMmxJadRsPCwEm5alRp1TwH1bLmuoeE=
Received: from BN9PR03CA0250.namprd03.prod.outlook.com (2603:10b6:408:ff::15)
 by SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 7 Jul
 2023 22:04:08 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::f) by BN9PR03CA0250.outlook.office365.com
 (2603:10b6:408:ff::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 22:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Fri, 7 Jul 2023 22:04:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 17:04:07 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 7 Jul 2023 17:04:07 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: [QEMU][PATCH v2 1/2] xen_arm: Create virtio-mmio devices during
 initialization
Date: Fri, 7 Jul 2023 15:03:57 -0700
Message-ID: <20230707220358.920-2-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230707220358.920-1-vikram.garhwal@amd.com>
References: <20230707220358.920-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|SA1PR12MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc4818e-4517-417d-1d64-08db7f36165b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y86pnu4TaaceExxjUyQedPMvyPyY0m6BKHCI0AILnVmwthWcjMVECLUhG/XuD62xEYpVrVOqTBtTTvmAui33WJ1uaRPhVqaefTo1jeA7pjhwYVDkdxOifwlAAIYDw1p3XsdVFGH+B/X66VgatpOpXiIBs5LN64qidx1IBdSahMukvwNXUQLl55gBdSYPPGxbyg9sDgpZ4RuOk7BA9EpXmHVMwcNED1vS7Z0XtAP6H0tBfQbJDJ8ylSPz1uJ6N2NMlp1EYV6BgZNGUNU7ka5N6hSTl0FBty7BRVbn4VjK+L+oaeucU7tk42DLs5u5C4XtPbMXWJOIbxhFq40qcmFWferF+jTjw+HqEXaGOFZhJr0B7HU+u8gqx0YPafKeR1KimVv8uVlj6JoqIvqfoVPF6HmHWNRB90q78M+i0+ot4/S3Vj8Y23fqo8aMPsX1pk8JpcW21ojaIpMNjaWZd/gVSZcA6uR5prMrVx6mL9nyIHAaod5tCRAYU4m51xx/wPyKgxRh5oFLo91hAaDWcJ3uPtPjkEwLy1RJEst3w9AWrn7hdIH+5hlrf7W/BTVPDtoWyA/ze7H7v9jXonPIYDPbrFzr97NgPbNJ2mzBkMbIRwmKFgkblV01/ws3qCpSCMLkIjfI0SjquuLBatL1/PaDAMQ/zpCRa8ERabHlTiYxyHJWrDeh02F+/7ysSQhumDDKO0Vfd8yPwU0mLvALLyoNi1dXlBhYFvYJBrfnxEHK1MjMVUhizymTUGx8AoOZAr6cf+kj8sg5rNjdnCtTjMrx/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(8936002)(8676002)(5660300002)(70586007)(70206006)(2906002)(316002)(4326008)(6916009)(44832011)(41300700001)(54906003)(82310400005)(478600001)(40460700003)(82740400003)(83380400001)(36860700001)(86362001)(356005)(81166007)(40480700001)(186003)(2616005)(336012)(1076003)(26005)(47076005)(36756003)(6666004)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 22:04:08.2620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc4818e-4517-417d-1d64-08db7f36165b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::602;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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
 hw/arm/xen_arm.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 044093fec7..e700829654 100644
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
 
     xen_register_ioreq(xam->state, machine->smp.cpus, xen_memory_listener);
 
+    xen_create_virtio_mmio_devices(xam);
+
 #ifdef CONFIG_TPM
     if (xam->cfg.tpm_base_addr) {
         xen_enable_tpm(xam);
-- 
2.25.1


