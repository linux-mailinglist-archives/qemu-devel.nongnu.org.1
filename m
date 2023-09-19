Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9B87A5D55
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:04:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWdL-0002s3-J2; Tue, 19 Sep 2023 05:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qiWd8-0002q3-Dh; Tue, 19 Sep 2023 05:02:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qiWd6-0003e4-0o; Tue, 19 Sep 2023 05:02:49 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38J8BDXA024369; Tue, 19 Sep 2023 09:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=bDAUtNXgeGisXtWIgptjHg1sD35SyUoj+DZVs21mBX8=;
 b=oevRh99H8JRJz85VuTgamXLG4M39UaktmjcvSf6WWntjCfZMAq2R2J95R9qR7nxuA42P
 wGSN4FoTgSMR/PsAM9NgVnlX+cKWWP3naB+Zhe8sK2W6ENv015BW9eyIlv1b4z1cRuRi
 3nfIMcpHzpnRtAqGN8GkDCQvS3G/Ljg8/QAwYHfVLGqS7RGA7OdAf3eM+cvcMp25usZr
 vGD7o2oMl1FZiNZSDcmuHq2KYqBJWbXOJ7HY7RHJC1ROJ6vZeXe+pPi8GVo7WGUSU6iN
 VRi/nsuQ0HYummMPK5GhNAVG3ghPplSYDfeHxeWk324dyCZOa9ZHj5hTPMxT7veqHipx Pw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t77wn831d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 09:02:41 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38J92ebJ031245
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 09:02:40 GMT
Received: from qc-i7.qualcomm.com (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 19 Sep
 2023 02:02:38 -0700
From: Leif Lindholm <quic_llindhol@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>, Peter
 Maydell <peter.maydell@linaro.org>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [PATCH v2 1/3] {include/}hw/arm: refactor virt PPI logic
Date: Tue, 19 Sep 2023 10:02:27 +0100
Message-ID: <20230919090229.188092-2-quic_llindhol@quicinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230919090229.188092-1-quic_llindhol@quicinc.com>
References: <20230919090229.188092-1-quic_llindhol@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: BOPyK7kCli4RCs45AM_FJ8QKc2rPupu1
X-Proofpoint-GUID: BOPyK7kCli4RCs45AM_FJ8QKc2rPupu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_03,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2
 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 mlxscore=2 lowpriorityscore=0 adultscore=0
 mlxlogscore=170 priorityscore=1501 spamscore=2 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

GIC Private Peripheral Interrupts (PPI) are defined as GIC INTID 16-31.
As in, PPI0 is INTID16 .. PPI15 is INTID31.
Arm's Base System Architecture specification (BSA) lists the mandated and
recommended private interrupt IDs by INTID, not by PPI index. But current
definitions in virt define them by PPI index, complicating cross
referencing.

Meanwhile, the PPI(x) macro counterintuitively adds 16 to the input value,
converting a PPI index to an INTID.

Resolve this by redefining the BSA-allocated PPIs by their INTIDs,
and replacing the PPI(x) macro with an INTID_TO_PPI(x) one where required.

Signed-off-by: Leif Lindholm <quic_llindhol@quicinc.com>
---
 hw/arm/virt-acpi-build.c | 12 ++++++------
 hw/arm/virt.c            | 24 ++++++++++++++----------
 include/hw/arm/virt.h    | 14 +++++++-------
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6b674231c2..9ce136cd88 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -601,21 +601,21 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
      * The interrupt values are the same with the device tree when adding 16
      */
     /* Secure EL1 timer GSIV */
-    build_append_int_noprefix(table_data, ARCH_TIMER_S_EL1_IRQ + 16, 4);
+    build_append_int_noprefix(table_data, ARCH_TIMER_S_EL1_IRQ, 4);
     /* Secure EL1 timer Flags */
     build_append_int_noprefix(table_data, irqflags, 4);
     /* Non-Secure EL1 timer GSIV */
-    build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL1_IRQ + 16, 4);
+    build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL1_IRQ, 4);
     /* Non-Secure EL1 timer Flags */
     build_append_int_noprefix(table_data, irqflags |
                               1UL << 2, /* Always-on Capability */
                               4);
     /* Virtual timer GSIV */
-    build_append_int_noprefix(table_data, ARCH_TIMER_VIRT_IRQ + 16, 4);
+    build_append_int_noprefix(table_data, ARCH_TIMER_VIRT_IRQ, 4);
     /* Virtual Timer Flags */
     build_append_int_noprefix(table_data, irqflags, 4);
     /* Non-Secure EL2 timer GSIV */
-    build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL2_IRQ + 16, 4);
+    build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL2_IRQ, 4);
     /* Non-Secure EL2 timer Flags */
     build_append_int_noprefix(table_data, irqflags, 4);
     /* CntReadBase Physical address */
@@ -729,9 +729,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     for (i = 0; i < MACHINE(vms)->smp.cpus; i++) {
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
         uint64_t physical_base_address = 0, gich = 0, gicv = 0;
-        uint32_t vgic_interrupt = vms->virt ? PPI(ARCH_GIC_MAINT_IRQ) : 0;
+        uint32_t vgic_interrupt = vms->virt ? ARCH_GIC_MAINT_IRQ : 0;
         uint32_t pmu_interrupt = arm_feature(&armcpu->env, ARM_FEATURE_PMU) ?
-                                             PPI(VIRTUAL_PMU_IRQ) : 0;
+                                             VIRTUAL_PMU_IRQ : 0;
 
         if (vms->gic_version == VIRT_GIC_VERSION_2) {
             physical_base_address = memmap[VIRT_GIC_CPU].base;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8ad78b23c2..869358faab 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -366,10 +366,14 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
     }
     qemu_fdt_setprop(ms->fdt, "/timer", "always-on", NULL, 0);
     qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
-                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_S_EL1_IRQ, irqflags,
-                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL1_IRQ, irqflags,
-                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_VIRT_IRQ, irqflags,
-                       GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL2_IRQ, irqflags);
+                           GIC_FDT_IRQ_TYPE_PPI,
+                           INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ), irqflags,
+                           GIC_FDT_IRQ_TYPE_PPI,
+                           INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ), irqflags,
+                           GIC_FDT_IRQ_TYPE_PPI,
+                           INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ), irqflags,
+                           GIC_FDT_IRQ_TYPE_PPI,
+                           INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ), irqflags);
 }
 
 static void fdt_add_cpu_nodes(const VirtMachineState *vms)
@@ -800,7 +804,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
      */
     for (i = 0; i < smp_cpus; i++) {
         DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
-        int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
+        int intidbase = NUM_IRQS + i * GIC_INTERNAL;
         int irq;
         /* Mapping from the output timer irq lines from the CPU to the
          * GIC PPI inputs we use for the virt board.
@@ -815,22 +819,22 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
             qdev_connect_gpio_out(cpudev, irq,
                                   qdev_get_gpio_in(vms->gic,
-                                                   ppibase + timer_irq[irq]));
+                                                   intidbase + timer_irq[irq]));
         }
 
         if (vms->gic_version != VIRT_GIC_VERSION_2) {
             qemu_irq irq = qdev_get_gpio_in(vms->gic,
-                                            ppibase + ARCH_GIC_MAINT_IRQ);
+                                            intidbase + ARCH_GIC_MAINT_IRQ);
             qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
                                         0, irq);
         } else if (vms->virt) {
             qemu_irq irq = qdev_get_gpio_in(vms->gic,
-                                            ppibase + ARCH_GIC_MAINT_IRQ);
+                                            intidbase + ARCH_GIC_MAINT_IRQ);
             sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
         }
 
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
-                                    qdev_get_gpio_in(vms->gic, ppibase
+                                    qdev_get_gpio_in(vms->gic, intidbase
                                                      + VIRTUAL_PMU_IRQ));
 
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
@@ -1990,7 +1994,7 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
             if (pmu) {
                 assert(arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_PMU));
                 if (kvm_irqchip_in_kernel()) {
-                    kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ));
+                    kvm_arm_pmu_set_irq(cpu, VIRTUAL_PMU_IRQ);
                 }
                 kvm_arm_pmu_init(cpu);
             }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index e1ddbea96b..5704d95736 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -43,16 +43,16 @@
 #define NUM_VIRTIO_TRANSPORTS 32
 #define NUM_SMMU_IRQS          4
 
-#define ARCH_GIC_MAINT_IRQ  9
+#define ARCH_GIC_MAINT_IRQ  25
 
-#define ARCH_TIMER_VIRT_IRQ   11
-#define ARCH_TIMER_S_EL1_IRQ  13
-#define ARCH_TIMER_NS_EL1_IRQ 14
-#define ARCH_TIMER_NS_EL2_IRQ 10
+#define ARCH_TIMER_VIRT_IRQ   27
+#define ARCH_TIMER_S_EL1_IRQ  29
+#define ARCH_TIMER_NS_EL1_IRQ 30
+#define ARCH_TIMER_NS_EL2_IRQ 26
 
-#define VIRTUAL_PMU_IRQ 7
+#define VIRTUAL_PMU_IRQ 23
 
-#define PPI(irq) ((irq) + 16)
+#define INTID_TO_PPI(irq) ((irq) - 16)
 
 /* See Linux kernel arch/arm64/include/asm/pvclock-abi.h */
 #define PVTIME_SIZE_PER_CPU 64
-- 
2.30.2


