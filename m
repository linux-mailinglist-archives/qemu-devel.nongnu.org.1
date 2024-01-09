Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1988282A5
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 10:03:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN7zO-0007vs-DA; Tue, 09 Jan 2024 04:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rN7zL-0007v4-9w; Tue, 09 Jan 2024 04:01:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rN7zI-0003ad-DP; Tue, 09 Jan 2024 04:01:35 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4093qk6B030231; Tue, 9 Jan 2024 09:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=Qg6et82kQFPHGaGzJ9Fv3XINC5+HT9KBW7Q2TRZWo0M=; b=Cl
 BuAWkk+jAQQZ70MJuVKIaFGmzzjHADanYpFH7NYlQscz/Lc4S2ejeNiW2/RJZwfH
 dS7kxDJFV+gzOR8PfRZkrt4a3XlBXym6NcLTcpIKTLyRD+5Fpv6tdCMy9kX+f8Xf
 u7dw9nO3oqjbsCajcnSSqXmB6f4HwXqggzR3gXLxyew2Twuv/wAv4+gvKkGTe2c1
 eiEX3MBZ1zWB1xzF63NxmIY5UIPxgMUkB/Vxfq8gG+nrfrCcnBHxxfnzGwwIxyoL
 eNjcEaS1J5NKWbpsWb1C8f/cxsmokVTE9mFtLGoNiJFEbcwacPh+PCI+WL0fZY+1
 uRbBmG/eHq67HITKO+mA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgwsjrkrk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 09:01:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40991SLO026771
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 9 Jan 2024 09:01:28 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 01:01:24 -0800
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <philmd@linaro.org>, <alex.bennee@linaro.org>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v1 08/11] gunyah: Customize device-tree
Date: Tue, 9 Jan 2024 09:00:36 +0000
Message-ID: <20240109090039.1636383-9-quic_svaddagi@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
References: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: d5M5TsRJt9QdCWpH_zocoRj0VLdTeKQP
X-Proofpoint-ORIG-GUID: d5M5TsRJt9QdCWpH_zocoRj0VLdTeKQP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090070
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Customize device-tree with Gunyah specific properties. Some of these
properties include specification of doorbells that need to be created
and associated with various interrupts.

Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
---
 accel/stubs/gunyah-stub.c |  5 +++
 hw/arm/virt.c             | 11 ++++++
 include/sysemu/gunyah.h   |  2 +
 target/arm/gunyah.c       | 79 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+)

diff --git a/accel/stubs/gunyah-stub.c b/accel/stubs/gunyah-stub.c
index faeb2af915..e9a8752bb4 100644
--- a/accel/stubs/gunyah-stub.c
+++ b/accel/stubs/gunyah-stub.c
@@ -16,3 +16,8 @@ int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size)
 {
     return -1;
 }
+
+void gunyah_arm_fdt_customize(void *fdt, uint64_t mem_base,
+                uint32_t gic_phandle) {
+    return;
+}
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 60fbe2f7c4..1aaadc1e1d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2005,6 +2005,14 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
     }
 }
 
+static void virt_modify_dtb(const struct arm_boot_info *binfo, void *fdt)
+{
+    const VirtMachineState *vms = container_of(binfo, VirtMachineState,
+                                                 bootinfo);
+
+    gunyah_arm_fdt_customize(fdt, vms->memmap[VIRT_MEM].base, vms->gic_phandle);
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
@@ -2311,6 +2319,9 @@ static void machvirt_init(MachineState *machine)
     vms->bootinfo.skip_dtb_autoload = true;
     vms->bootinfo.firmware_loaded = firmware_loaded;
     vms->bootinfo.psci_conduit = vms->psci_conduit;
+    if (gunyah_enabled()) {
+        vms->bootinfo.modify_dtb = virt_modify_dtb;
+    }
     arm_load_kernel(ARM_CPU(first_cpu), machine, &vms->bootinfo);
 
     vms->machine_done.notify = virt_machine_done;
diff --git a/include/sysemu/gunyah.h b/include/sysemu/gunyah.h
index a73d17bfb9..d0c1d8564c 100644
--- a/include/sysemu/gunyah.h
+++ b/include/sysemu/gunyah.h
@@ -28,5 +28,7 @@ DECLARE_INSTANCE_CHECKER(GUNYAHState, GUNYAH_STATE,
                          TYPE_GUNYAH_ACCEL)
 
 int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size);
+void gunyah_arm_fdt_customize(void *fdt, uint64_t mem_base,
+                uint32_t gic_phandle);
 
 #endif  /* QEMU_GUNYAH_H */
diff --git a/target/arm/gunyah.c b/target/arm/gunyah.c
index 73c1c2a88a..1521f2d414 100644
--- a/target/arm/gunyah.c
+++ b/target/arm/gunyah.c
@@ -11,6 +11,9 @@
 #include "sysemu/gunyah.h"
 #include "sysemu/gunyah_int.h"
 #include "linux-headers/linux/gunyah.h"
+#include "exec/memory.h"
+#include "sysemu/device_tree.h"
+#include "hw/arm/fdt.h"
 
 /*
  * Specify location of device-tree in guest address space.
@@ -43,3 +46,79 @@ int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size)
 
     return 0;
 }
+
+void gunyah_arm_fdt_customize(void *fdt, uint64_t mem_base,
+            uint32_t gic_phandle)
+{
+    char *nodename;
+    int i;
+    GUNYAHState *state = get_gunyah_state();
+
+    qemu_fdt_add_subnode(fdt, "/gunyah-vm-config");
+    qemu_fdt_setprop_string(fdt, "/gunyah-vm-config",
+                                "image-name", "qemu-vm");
+    qemu_fdt_setprop_string(fdt, "/gunyah-vm-config", "os-type", "linux");
+
+    nodename = g_strdup_printf("/gunyah-vm-config/memory");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 2);
+    qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 2);
+    qemu_fdt_setprop_u64(fdt, nodename, "base-address", mem_base);
+
+    g_free(nodename);
+
+    nodename = g_strdup_printf("/gunyah-vm-config/interrupts");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "config", gic_phandle);
+    g_free(nodename);
+
+    nodename = g_strdup_printf("/gunyah-vm-config/vcpus");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "affinity", "proxy");
+    g_free(nodename);
+
+    nodename = g_strdup_printf("/gunyah-vm-config/vdevices");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "generate", "/hypervisor");
+    g_free(nodename);
+
+    for (i = 0; i < state->nr_slots; ++i) {
+        if (!state->slots[i].start || state->slots[i].lend ||
+                state->slots[i].start == mem_base) {
+            continue;
+        }
+
+        nodename = g_strdup_printf("/gunyah-vm-config/vdevices/shm-%x", i);
+        qemu_fdt_add_subnode(fdt, nodename);
+        qemu_fdt_setprop_string(fdt, nodename, "vdevice-type", "shm");
+        qemu_fdt_setprop_string(fdt, nodename, "push-compatible", "dma");
+        qemu_fdt_setprop(fdt, nodename, "peer-default", NULL, 0);
+        qemu_fdt_setprop_u64(fdt, nodename, "dma_base", 0);
+        g_free(nodename);
+
+        nodename = g_strdup_printf("/gunyah-vm-config/vdevices/shm-%x/memory",
+                                                                        i);
+        qemu_fdt_add_subnode(fdt, nodename);
+        qemu_fdt_setprop_cell(fdt, nodename, "label", i);
+        qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 2);
+        qemu_fdt_setprop_u64(fdt, nodename, "base", state->slots[i].start);
+        g_free(nodename);
+    }
+
+    for (i = 0; i < state->nr_irqs; ++i) {
+        nodename = g_strdup_printf("/gunyah-vm-config/vdevices/bell-%x", i);
+        qemu_fdt_add_subnode(fdt, nodename);
+        qemu_fdt_setprop_string(fdt, nodename, "vdevice-type", "doorbell");
+        char *p = g_strdup_printf("/hypervisor/bell-%x", i);
+        qemu_fdt_setprop_string(fdt, nodename, "generate", p);
+        g_free(p);
+        qemu_fdt_setprop_cell(fdt, nodename, "label", i);
+        qemu_fdt_setprop(fdt, nodename, "peer-default", NULL, 0);
+        qemu_fdt_setprop(fdt, nodename, "source-can-clear", NULL, 0);
+
+        qemu_fdt_setprop_cells(fdt, nodename, "interrupts",
+                GIC_FDT_IRQ_TYPE_SPI, i, GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+
+        g_free(nodename);
+    }
+}
-- 
2.25.1


