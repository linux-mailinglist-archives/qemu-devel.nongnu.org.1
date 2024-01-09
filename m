Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8618282A9
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 10:03:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN7zD-0007rn-JP; Tue, 09 Jan 2024 04:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rN7zB-0007rE-FS; Tue, 09 Jan 2024 04:01:25 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rN7z9-0003Wo-73; Tue, 09 Jan 2024 04:01:25 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4096680I004958; Tue, 9 Jan 2024 09:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=9u0M5CrNUCxVjRY/uzE4BI8IxOo54f8PSWNdJ9hom+o=; b=DC
 KBqDwpnEQf+HBaCwYV8jEsJ6+J4c0JXiZppug0FMH7Yk/E4+051bXvoYQ/YDpqDI
 iAAkSNmOcayXppojSwMd/k38x8Cj5yxqtWftBmGHweS4FjAz1SLCLxDD3t8VvfqI
 IuCohjAI2Xg0txF+q8YfXrEc8CvznTuhZap9FSglKEdhQDb/HbvSWKXjejCtBA+l
 6Ze2i6W04ojUlgmPPsIO/iwF/fyejM+nGgX+dny+12ifbtX0MiGp3WxcDznnrgiC
 Da6lomqXyegoefpf8soTeu6idU4D4s8AFpavm9Mo9oghkGnc/fH4e4GhNtzkr+d7
 j25etTcQbb4osF2F4FvA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgxxbgfuu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 09:01:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40991KEb009636
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 9 Jan 2024 09:01:20 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 01:01:15 -0800
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <philmd@linaro.org>, <alex.bennee@linaro.org>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v1 06/11] gunyah: Add gicv3 interrupt controller
Date: Tue, 9 Jan 2024 09:00:34 +0000
Message-ID: <20240109090039.1636383-7-quic_svaddagi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: HAh53AmMlj1QSqnz5MdLDaA1i90OMVFa
X-Proofpoint-GUID: HAh53AmMlj1QSqnz5MdLDaA1i90OMVFa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Gunyah hypervisor supports emulation of a GICv3 compatible interrupt
controller. Emulation is handled by hypervisor itself, with Qemu being
allowed to specify some of the properties such as IO address at which
GICv3 should be mapped in guest address space. These properties are
conveyed to hypervisor via the device-tree, which is parsed by
hypervisor (or more specifically Resource Manager VM, which is the
trusted agent of hypervisor), before VM begins execution.

Injection of interrupts inside guest is supported by doorbell API of
Gunyah hypervisor. Each doorbell is associated with a specific
interrupt. An eventfd is created and associated with each doorbell/irq.
Injection of a specific irq is accomplished by writing to the eventfd
associated with that irq.

Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
---
 MAINTAINERS                    |   2 +
 accel/gunyah/gunyah-all.c      |   5 ++
 hw/arm/virt.c                  |   5 ++
 hw/intc/arm_gicv3_common.c     |   3 +
 hw/intc/arm_gicv3_gunyah.c     | 106 +++++++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_its_common.c |   3 +
 hw/intc/meson.build            |   1 +
 include/sysemu/gunyah_int.h    |   2 +
 8 files changed, 127 insertions(+)
 create mode 100644 hw/intc/arm_gicv3_gunyah.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cdda9208e2..b90a4558a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -543,6 +543,8 @@ S: Maintained
 F: accel/gunyah
 F: include/sysemu/gunyah.h
 F: include/sysemu/gunyah_int.h
+F: target/arm/arm_gicv3_gunyah.c
+F: hw/intc/arm_gicv3_gunyah.c
 
 WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
diff --git a/accel/gunyah/gunyah-all.c b/accel/gunyah/gunyah-all.c
index 8aaf5b7354..4e4a2b89db 100644
--- a/accel/gunyah/gunyah-all.c
+++ b/accel/gunyah/gunyah-all.c
@@ -400,6 +400,11 @@ static void gunyah_mem_ioeventfd_del(MemoryListener *listener,
     }
 }
 
+GUNYAHState *get_gunyah_state(void)
+{
+    return GUNYAH_STATE(current_accel());
+}
+
 void *gunyah_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6a62fc29ad..4f4e10c234 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -643,6 +643,9 @@ static void create_its(VirtMachineState *vms)
         if (!vms->tcg_its) {
             itsclass = NULL;
         }
+    } else if (!strcmp(itsclass, "arm-its-gunyah")) {
+        /* ITS is not yet supported */
+        itsclass = NULL;
     }
 
     if (!itsclass) {
@@ -1914,6 +1917,8 @@ static void finalize_gic_version(VirtMachineState *vms)
                 gics_supported |= VIRT_GIC_VERSION_4_MASK;
             }
         }
+    } else if (gunyah_enabled()) {
+        gics_supported |= VIRT_GIC_VERSION_3_MASK;
     } else {
         error_report("Unsupported accelerator, can not determine GIC support");
         exit(1);
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index cb55c72681..9d6bc52e45 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -32,6 +32,7 @@
 #include "gicv3_internal.h"
 #include "hw/arm/linux-boot-if.h"
 #include "sysemu/kvm.h"
+#include "sysemu/gunyah.h"
 
 
 static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
@@ -614,6 +615,8 @@ const char *gicv3_class_name(void)
 {
     if (kvm_irqchip_in_kernel()) {
         return "kvm-arm-gicv3";
+    } else if (gunyah_enabled()) {
+        return "gunyah-arm-gicv3";
     } else {
         if (kvm_enabled()) {
             error_report("Userspace GICv3 is not supported with KVM");
diff --git a/hw/intc/arm_gicv3_gunyah.c b/hw/intc/arm_gicv3_gunyah.c
new file mode 100644
index 0000000000..f52e82bf9a
--- /dev/null
+++ b/hw/intc/arm_gicv3_gunyah.c
@@ -0,0 +1,106 @@
+/*
+ * QEMU Gunyah hypervisor support
+ *
+ * Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "hw/intc/arm_gicv3_common.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "sysemu/gunyah.h"
+#include "sysemu/gunyah_int.h"
+#include "sysemu/runstate.h"
+#include "gicv3_internal.h"
+#include "vgic_common.h"
+#include "migration/blocker.h"
+#include "qom/object.h"
+#include "target/arm/cpregs.h"
+#include "qemu/event_notifier.h"
+
+struct GUNYAHARMGICv3Class {
+    ARMGICv3CommonClass parent_class;
+    DeviceRealize parent_realize;
+    ResettablePhases parent_phases;
+};
+
+#define TYPE_GUNYAH_ARM_GICV3 "gunyah-arm-gicv3"
+typedef struct GUNYAHARMGICv3Class GUNYAHARMGICv3Class;
+
+/* This is reusing the GICv3State typedef from ARM_GICV3_ITS_COMMON */
+DECLARE_OBJ_CHECKERS(GICv3State, GUNYAHARMGICv3Class,
+                     GUNYAH_ARM_GICV3, TYPE_GUNYAH_ARM_GICV3)
+
+static EventNotifier *irq_notify;
+
+static void gunyah_arm_gicv3_set_irq(void *opaque, int irq, int level)
+{
+    GICv3State *s = (GICv3State *)opaque;
+
+    if (irq < s->num_irq - GIC_INTERNAL) {
+        event_notifier_set(&irq_notify[irq]);
+    }
+}
+
+static void gunyah_arm_gicv3_realize(DeviceState *dev, Error **errp)
+{
+    GICv3State *s = GUNYAH_ARM_GICV3(dev);
+    GUNYAHARMGICv3Class *ggc = GUNYAH_ARM_GICV3_GET_CLASS(s);
+    Error *local_err = NULL;
+    int i;
+    GUNYAHState *state = get_gunyah_state();
+
+    ggc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (s->revision != 3) {
+        error_setg(errp, "unsupported GIC revision %d for in-kernel GIC",
+                   s->revision);
+        return;
+    }
+
+    gicv3_init_irqs_and_mmio(s, gunyah_arm_gicv3_set_irq, NULL);
+
+    irq_notify = g_malloc_n(s->num_irq - GIC_INTERNAL, sizeof(EventNotifier));
+
+    for (i = 0; i < s->num_irq - GIC_INTERNAL; ++i) {
+        event_notifier_init(&irq_notify[i], 0);
+        gunyah_add_irqfd(irq_notify[i].wfd, i, errp);
+    }
+
+    state->nr_irqs = s->num_irq - GIC_INTERNAL;
+}
+
+static void gunyah_arm_gicv3_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    GUNYAHARMGICv3Class *ggc = GUNYAH_ARM_GICV3_CLASS(klass);
+
+    device_class_set_parent_realize(dc, gunyah_arm_gicv3_realize,
+                                    &ggc->parent_realize);
+    resettable_class_set_parent_phases(rc, NULL, NULL, NULL,
+                                       &ggc->parent_phases);
+}
+
+static const TypeInfo gunyah_arm_gicv3_info = {
+    .name = TYPE_GUNYAH_ARM_GICV3,
+    .parent = TYPE_ARM_GICV3_COMMON,
+    .instance_size = sizeof(GICv3State),
+    .class_init = gunyah_arm_gicv3_class_init,
+    .class_size = sizeof(GUNYAHARMGICv3Class),
+};
+
+static void gunyah_arm_gicv3_register_types(void)
+{
+    type_register_static(&gunyah_arm_gicv3_info);
+}
+
+type_init(gunyah_arm_gicv3_register_types)
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 331d6b93cc..fe3752abc3 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -25,6 +25,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
+#include "sysemu/gunyah.h"
 
 static int gicv3_its_pre_save(void *opaque)
 {
@@ -164,6 +165,8 @@ const char *its_class_name(void)
 {
     if (kvm_irqchip_in_kernel()) {
         return "arm-its-kvm";
+    } else if (gunyah_enabled()) {
+        return "arm-its-gunyah";
     } else {
         /* Software emulation based model */
         return "arm-gicv3-its";
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index ed355941d1..6e680cf0f2 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -73,3 +73,4 @@ specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c'))
+specific_ss.add(when: ['CONFIG_ARM_GIC', 'CONFIG_GUNYAH', 'TARGET_AARCH64'], if_true: files('arm_gicv3_gunyah.c'))
diff --git a/include/sysemu/gunyah_int.h b/include/sysemu/gunyah_int.h
index 011b5a072c..dc5b4847a9 100644
--- a/include/sysemu/gunyah_int.h
+++ b/include/sysemu/gunyah_int.h
@@ -45,11 +45,13 @@ struct GUNYAHState {
     bool is_protected_vm;
     bool preshmem_reserved;
     uint32_t preshmem_size;
+    uint32_t nr_irqs;
 };
 
 int gunyah_create_vm(void);
 int gunyah_vm_ioctl(int type, ...);
 void *gunyah_cpu_thread_fn(void *arg);
 int gunyah_add_irqfd(int irqfd, int label, Error **errp);
+GUNYAHState *get_gunyah_state(void);
 
 #endif    /* GUNYAH_INT_H */
-- 
2.25.1


