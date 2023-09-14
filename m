Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E157A034D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:04:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgl2z-0008WU-MM; Thu, 14 Sep 2023 08:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qgl2r-0008PA-GR; Thu, 14 Sep 2023 08:02:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1qgl2l-0007Mp-N4; Thu, 14 Sep 2023 08:02:04 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38E9NYqL026572; Thu, 14 Sep 2023 12:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=3FGUYySYZxKnz78fstv0mHNiEKrlt5b7fwvduZANZIc=;
 b=ho4pmsTXUmBMc+i2QxGN3NKo54sGvDORHZJs93a7CNFePxTg0aAfctZPUcJKvrYxoxtX
 zOEEGo2Sivn9MYJ3R7+9dV+FV938EmV4/0eG0e8QlZ+MT3v7/7yWtoxrk25BHZwXMgQO
 c7ulYMDIrbrV9FaD+HE8p5a94FbWA/J4iyxnna5M4pSLfcA1HrkNGWeVGYllZ+SGA6X+
 O538qHAOyoYZcOakqQL2cdItew6eTe1qeey/JBi15seaphIxNfEdeCFpGQMzLGW622FC
 kObyTebkyqT0VKuCRr4i44ej1dQJISWlwH6XrmRjaCGToB0sKTgOriHBDPAF1QVJJKH5 YA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3wx18n5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Sep 2023 12:01:54 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EC1gvE032547
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Sep 2023 12:01:42 GMT
Received: from qc-i7.qualcomm.com (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 05:01:41 -0700
From: Leif Lindholm <quic_llindhol@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>, Peter
 Maydell <peter.maydell@linaro.org>, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>
Subject: [RFC PATCH 2/3] {include/}hw/arm: refactor BSA/virt PPI logic
Date: Thu, 14 Sep 2023 13:01:23 +0100
Message-ID: <20230914120124.55410-3-quic_llindhol@quicinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230914120124.55410-1-quic_llindhol@quicinc.com>
References: <20230914120124.55410-1-quic_llindhol@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: J5q4eM-BUMTOjtzlJb56wZHm1Ta2mxnO
X-Proofpoint-ORIG-GUID: J5q4eM-BUMTOjtzlJb56wZHm1Ta2mxnO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1015
 phishscore=0 mlxlogscore=411 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140103
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
definitions in qemu define them by PPI index, complicating cross
referencing.

Meanwhile, the PPI(x) macro counterintuitively adds 16 to the input value,
converting a PPI index to an INTID.

Resolve this by redefining the BSA-allocated PPIs by their INTIDs,
inverting the logic of the PPI(x) macro and flipping where it is used.

Signed-off-by: Leif Lindholm <quic_llindhol@quicinc.com>
---
 hw/arm/virt-acpi-build.c |  4 ++--
 hw/arm/virt.c            |  9 +++++----
 include/hw/arm/bsa.h     | 14 +++++++-------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6b674231c2..963c58a88a 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
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
index 8ad78b23c2..bb70f3eec8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -815,23 +815,24 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
             qdev_connect_gpio_out(cpudev, irq,
                                   qdev_get_gpio_in(vms->gic,
-                                                   ppibase + timer_irq[irq]));
+                                                   ppibase
+                                                   + PPI(timer_irq[irq])));
         }
 
         if (vms->gic_version != VIRT_GIC_VERSION_2) {
             qemu_irq irq = qdev_get_gpio_in(vms->gic,
-                                            ppibase + ARCH_GIC_MAINT_IRQ);
+                                            ppibase + PPI(ARCH_GIC_MAINT_IRQ));
             qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
                                         0, irq);
         } else if (vms->virt) {
             qemu_irq irq = qdev_get_gpio_in(vms->gic,
-                                            ppibase + ARCH_GIC_MAINT_IRQ);
+                                            ppibase + PPI(ARCH_GIC_MAINT_IRQ));
             sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
         }
 
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
                                     qdev_get_gpio_in(vms->gic, ppibase
-                                                     + VIRTUAL_PMU_IRQ));
+                                                     + PPI(VIRTUAL_PMU_IRQ)));
 
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
         sysbus_connect_irq(gicbusdev, i + smp_cpus,
diff --git a/include/hw/arm/bsa.h b/include/hw/arm/bsa.h
index 8277b3a379..b7db1cacf1 100644
--- a/include/hw/arm/bsa.h
+++ b/include/hw/arm/bsa.h
@@ -21,15 +21,15 @@
 #ifndef QEMU_ARM_BSA_H
 #define QEMU_ARM_BSA_H
 
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
+#define PPI(irq) ((irq) - 16)
 
 #endif /* QEMU_ARM_BSA_H */
-- 
2.30.2


