Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF76716F61
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 23:08:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q46Z5-0000iz-FF; Tue, 30 May 2023 17:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q46Z3-0000ib-39; Tue, 30 May 2023 17:07:33 -0400
Received: from mail-dm6nam10on2062a.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::62a]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q46Yz-0002f1-I2; Tue, 30 May 2023 17:07:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjJsWWWSXZLzeERpxCBiiO4JtyagZR02/5wKYmrbbWaEWBOicAzku3tUgLb2SG7k+emuRs3wJc64/jvg4feayntycDO+euURcXLkMlZ88xr4bBNbApQuDcP1LsT4upv8wgdfE6+LkgTz6Vz4sckW5LPgYfnO8z8v9V4j/nMJFUkPmBqwKpILVjbFJWGIvijRrrFu3BBosxrjHAibnxA++gYr+4eS0UhJGQ7l/Nqs2eu8DLcu+fQ7h3gzON1posI4SPwKGOjoxqXGm7SlMdGuzsQT3jAccFoQroUReJx5lInKICSl9Mdb3S2wi3lRJv2JnqASmndkPAemy7W2VDEOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19JQ/rgm1h/p/0x17GyMRBJvVMZGK05f9xXtho9tARA=;
 b=Z7Pnakd7ikuiGALM5OVujQIqVcXFNynv+oQMl/qpehro9pDmxfHWDwg99sqhT6OIl1PhN16YGAndjH4bzdQhm+foNmMLoEkVYwNJ1X0uWPf1tYqrGjPTXstssB9d7JBFSIGsPcwEAsK2jN1yifv7F4E+A4vSc/DgCXue6TeKemLK+RUTDsbjoI+/+HLZfltvpO24WxtnMBJWuRifP5E+TESpXa2EFC/8XYJP3+93hLyUSu+RqZpuZaTskGbE37AOUkrtbmx2qXUpZPTP01sWME9f6hT9EoASH+SximNkLGAPhf+o6y99P2vlPuGXy4k+fhp6lb3qdvHmzTFiIUldew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19JQ/rgm1h/p/0x17GyMRBJvVMZGK05f9xXtho9tARA=;
 b=TFPAXAWCxq+mnXaYUZUJaqFK9lJqJ8LlVh7DCgZjt65K+TZOc1+ZOwJkXdPmzAL/QSiy3SHfirWTzWro0MNVrvk1/J97xCmr+DMnof6pkxKhsM+6EwBCnhIrTe1sKK+4P8W0uxtOqd/VX5KrJyMnIySEODxkEF/SUn/fWWmTO+s=
Received: from DM6PR13CA0006.namprd13.prod.outlook.com (2603:10b6:5:bc::19) by
 SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Tue, 30 May 2023 21:07:23 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::ab) by DM6PR13CA0006.outlook.office365.com
 (2603:10b6:5:bc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16 via Frontend
 Transport; Tue, 30 May 2023 21:07:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 21:07:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 16:07:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 16:07:22 -0500
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 30 May 2023 16:07:21 -0500
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, Vikram Garhwal <vikram.garhwal@amd.com>,
 Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "open
 list:Xilinx ZynqMP and..." <qemu-arm@nongnu.org>
Subject: [QEMU][PATCH v6 3/4] xlnx-versal: Connect Xilinx VERSAL CANFD
 controllers
Date: Tue, 30 May 2023 14:07:01 -0700
Message-ID: <20230530210703.6707-4-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230530210703.6707-1-vikram.garhwal@amd.com>
References: <20230530210703.6707-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: e01860d1-79ba-4d88-0120-08db6151dcf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXlLUHHOeoN/KxK01gWrmmy/ruUzVW3DtbaGfQt/E9pVsM2ZpHOcwHWn3BikEhhvhXNu9XP1f7mmJH/FGcrlH1gnQl/RLCrMzwEcaFjl+k/LDuWTkuZSWSr9y1dbPfRnt+gjJOVBXFmU5/XQOSHp3M2AsBS959iaVXi6Y+0yYMvvZ8L2uAf1stpcUfn4J34SiFoMGoPPF373a4MuJhqnvbun/yKLs1ZvJ8L5yplr+dxRADLuQ7lhhCGKerq061YDLDT4PXzXFaY3igRRoziXeCQTuMic/mVmp92TAbHlY9F5zyKB4ZTXFfH94JaRPOzivQQnaXglZqOeiRsmlfoTqdQR+Al6U6i4RtliXvp45KlsBEXJZO3D6wYio4krZ5U6Os3ZlCE3I+inJVzUVZx2FbCUN9yDh8KvahkblGHgD+HecsZhNFnOwXFZBucfSBChmuMpKVZupDxDW53B7u7AzZTVOcUIGV1zgu92WgL9/7MpYtsw06yjNSXu0Qb9XS76RlyR9kqC25ZWENMO8JYwP1gC5KhtfNU72sy/QhDYY80+7/OmZMaE3DK5sjxmbTXL3SwrY44wlL5ZOyeTmLXrD11d3/syO2531BG4eiKsSXJRXzkP+2FDJ0xsQB0G2oqj2YURc3qBkH3CcyOUYYkpSPKO1/jA5E6ujVlGzN8ueuDeyW4N89fIBHYlpGJYLL9sNTu9ZTYqTxHeD0Vp9lIgSdBvf8worIsGX8HMuQ/kAYD/U+4wgp/0Ii8wtXLFXSeJM1AKwYhPi+5SnITQfzDR1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(40460700003)(54906003)(8936002)(8676002)(44832011)(5660300002)(36756003)(2906002)(86362001)(82740400003)(70206006)(6916009)(356005)(70586007)(81166007)(4326008)(82310400005)(316002)(40480700001)(41300700001)(1076003)(26005)(36860700001)(83380400001)(336012)(426003)(186003)(47076005)(2616005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 21:07:22.9696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e01860d1-79ba-4d88-0120-08db6151dcf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
Received-SPF: softfail client-ip=2a01:111:f400:7e88::62a;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Connect CANFD0 and CANFD1 on the Versal-virt machine and update xlnx-versal-virt
document with CANFD command line examples.

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 docs/system/arm/xlnx-versal-virt.rst | 31 ++++++++++++++++
 hw/arm/xlnx-versal-virt.c            | 53 ++++++++++++++++++++++++++++
 hw/arm/xlnx-versal.c                 | 37 +++++++++++++++++++
 include/hw/arm/xlnx-versal.h         | 12 +++++++
 4 files changed, 133 insertions(+)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 92ad10d2da..d2d1b26692 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -34,6 +34,7 @@ Implemented devices:
 - DDR memory
 - BBRAM (36 bytes of Battery-backed RAM)
 - eFUSE (3072 bytes of one-time field-programmable bit array)
+- 2 CANFDs
 
 QEMU does not yet model any other devices, including the PL and the AI Engine.
 
@@ -224,3 +225,33 @@ To use a different index value, N, from default of 1, add:
 
   Better yet, do not use actual product data when running guest image
   on this Xilinx Versal Virt board.
+
+Using CANFDs for Versal Virt
+""""""""""""""""""""""""""""
+Versal CANFD controller is developed based on SocketCAN and QEMU CAN bus
+implementation. Bus connection and socketCAN connection for each CAN module
+can be set through command lines.
+
+To connect both CANFD0 and CANFD1 on the same bus:
+
+.. code-block:: bash
+
+    -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus
+
+To connect CANFD0 and CANFD1 to separate buses:
+
+.. code-block:: bash
+
+    -object can-bus,id=canbus0 -object can-bus,id=canbus1 \
+    -machine canbus0=canbus0 -machine canbus1=canbus1
+
+The SocketCAN interface can connect to a Physical or a Virtual CAN interfaces on
+the host machine. Please check this document to learn about CAN interface on
+Linux: docs/system/devices/can.rst
+
+To connect CANFD0 and CANFD1 to host machine's CAN interface can0:
+
+.. code-block:: bash
+
+    -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus
+    -object can-host-socketcan,id=canhost0,if=can0,canbus=canbus
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 668a9d65a4..1ee2b8697f 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -40,9 +40,11 @@ struct VersalVirt {
         uint32_t clk_25Mhz;
         uint32_t usb;
         uint32_t dwc;
+        uint32_t canfd[2];
     } phandle;
     struct arm_boot_info binfo;
 
+    CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
     struct {
         bool secure;
     } cfg;
@@ -235,6 +237,38 @@ static void fdt_add_uart_nodes(VersalVirt *s)
     }
 }
 
+static void fdt_add_canfd_nodes(VersalVirt *s)
+{
+    uint64_t addrs[] = { MM_CANFD1, MM_CANFD0 };
+    uint32_t size[] = { MM_CANFD1_SIZE, MM_CANFD0_SIZE };
+    unsigned int irqs[] = { VERSAL_CANFD1_IRQ_0, VERSAL_CANFD0_IRQ_0 };
+    const char clocknames[] = "can_clk\0s_axi_aclk";
+    int i;
+
+    /* Create and connect CANFD0 and CANFD1 nodes to canbus0. */
+    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
+        char *name = g_strdup_printf("/canfd@%" PRIx64, addrs[i]);
+        qemu_fdt_add_subnode(s->fdt, name);
+
+        qemu_fdt_setprop_cell(s->fdt, name, "rx-fifo-depth", 0x40);
+        qemu_fdt_setprop_cell(s->fdt, name, "tx-mailbox-count", 0x20);
+
+        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
+                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
+        qemu_fdt_setprop(s->fdt, name, "clock-names",
+                         clocknames, sizeof(clocknames));
+        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
+                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
+                                     2, addrs[i], 2, size[i]);
+        qemu_fdt_setprop_string(s->fdt, name, "compatible",
+                                "xlnx,canfd-2.0");
+
+        g_free(name);
+    }
+}
+
 static void fdt_add_fixed_link_nodes(VersalVirt *s, char *gemname,
                                      uint32_t phandle)
 {
@@ -639,12 +673,17 @@ static void versal_virt_init(MachineState *machine)
                             TYPE_XLNX_VERSAL);
     object_property_set_link(OBJECT(&s->soc), "ddr", OBJECT(machine->ram),
                              &error_abort);
+    object_property_set_link(OBJECT(&s->soc), "canbus0", OBJECT(s->canbus[0]),
+                             &error_abort);
+    object_property_set_link(OBJECT(&s->soc), "canbus1", OBJECT(s->canbus[1]),
+                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     fdt_create(s);
     create_virtio_regions(s);
     fdt_add_gem_nodes(s);
     fdt_add_uart_nodes(s);
+    fdt_add_canfd_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
@@ -712,6 +751,20 @@ static void versal_virt_init(MachineState *machine)
 
 static void versal_virt_machine_instance_init(Object *obj)
 {
+    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+
+    /*
+     * User can set canbus0 and canbus1 properties to can-bus object and connect
+     * to socketcan(optional) interface via command line.
+     */
+    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[0],
+                             object_property_allow_set_link,
+                             0);
+    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[1],
+                             object_property_allow_set_link,
+                             0);
 }
 
 static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 69b1b99e93..1594dd6c5c 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -184,6 +184,38 @@ static void versal_create_uarts(Versal *s, qemu_irq *pic)
     }
 }
 
+static void versal_create_canfds(Versal *s, qemu_irq *pic)
+{
+    int i;
+    uint32_t irqs[] = { VERSAL_CANFD0_IRQ_0, VERSAL_CANFD1_IRQ_0};
+    uint64_t addrs[] = { MM_CANFD0, MM_CANFD1 };
+
+    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.canfd); i++) {
+        char *name = g_strdup_printf("canfd%d", i);
+        SysBusDevice *sbd;
+        MemoryRegion *mr;
+
+        object_initialize_child(OBJECT(s), name, &s->lpd.iou.canfd[i],
+                                TYPE_XILINX_CANFD);
+        sbd = SYS_BUS_DEVICE(&s->lpd.iou.canfd[i]);
+
+        object_property_set_int(OBJECT(&s->lpd.iou.canfd[i]), "ext_clk_freq",
+                                XLNX_VERSAL_CANFD_REF_CLK , &error_abort);
+
+        object_property_set_link(OBJECT(&s->lpd.iou.canfd[i]), "canfdbus",
+                                 OBJECT(s->lpd.iou.canbus[i]),
+                                 &error_abort);
+
+        sysbus_realize(sbd, &error_fatal);
+
+        mr = sysbus_mmio_get_region(sbd, 0);
+        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
+
+        sysbus_connect_irq(sbd, 0, pic[irqs[i]]);
+        g_free(name);
+    }
+}
+
 static void versal_create_usbs(Versal *s, qemu_irq *pic)
 {
     DeviceState *dev;
@@ -718,6 +750,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_apu_gic(s, pic);
     versal_create_rpu_cpus(s);
     versal_create_uarts(s, pic);
+    versal_create_canfds(s, pic);
     versal_create_usbs(s, pic);
     versal_create_gems(s, pic);
     versal_create_admas(s, pic);
@@ -757,6 +790,10 @@ static void versal_init(Object *obj)
 static Property versal_properties[] = {
     DEFINE_PROP_LINK("ddr", Versal, cfg.mr_ddr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
+    DEFINE_PROP_LINK("canbus0", Versal, lpd.iou.canbus[0],
+                      TYPE_CAN_BUS, CanBusState *),
+    DEFINE_PROP_LINK("canbus1", Versal, lpd.iou.canbus[1],
+                      TYPE_CAN_BUS, CanBusState *),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index b6786e9832..39ee31185c 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -31,6 +31,7 @@
 #include "hw/dma/xlnx_csu_dma.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
+#include "hw/net/xlnx-versal-canfd.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
 OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
@@ -43,6 +44,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
 #define XLNX_VERSAL_NR_SDS     2
 #define XLNX_VERSAL_NR_XRAM    4
 #define XLNX_VERSAL_NR_IRQS    192
+#define XLNX_VERSAL_NR_CANFD   2
+#define XLNX_VERSAL_CANFD_REF_CLK (24 * 1000 * 1000)
 
 struct Versal {
     /*< private >*/
@@ -73,6 +76,8 @@ struct Versal {
             CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
             XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
             VersalUsb2 usb;
+            CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
+            XlnxVersalCANFDState canfd[XLNX_VERSAL_NR_CANFD];
         } iou;
 
         /* Real-time Processing Unit.  */
@@ -133,6 +138,8 @@ struct Versal {
 #define VERSAL_CRL_IRQ             10
 #define VERSAL_UART0_IRQ_0         18
 #define VERSAL_UART1_IRQ_0         19
+#define VERSAL_CANFD0_IRQ_0        20
+#define VERSAL_CANFD1_IRQ_0        21
 #define VERSAL_USB0_IRQ_0          22
 #define VERSAL_GEM0_IRQ_0          56
 #define VERSAL_GEM0_WAKE_IRQ_0     57
@@ -163,6 +170,11 @@ struct Versal {
 #define MM_UART1                    0xff010000U
 #define MM_UART1_SIZE               0x10000
 
+#define MM_CANFD0                   0xff060000U
+#define MM_CANFD0_SIZE              0x10000
+#define MM_CANFD1                   0xff070000U
+#define MM_CANFD1_SIZE              0x10000
+
 #define MM_GEM0                     0xff0c0000U
 #define MM_GEM0_SIZE                0x10000
 #define MM_GEM1                     0xff0d0000U
-- 
2.17.1


