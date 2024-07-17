Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5F39335D8
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jul 2024 05:49:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTve4-0006Tk-Mp; Tue, 16 Jul 2024 23:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1sTvdz-0006IQ-Fe
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 23:47:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1sTvdp-00047X-It
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 23:47:55 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx7+vaPpdm3VoFAA--.13497S3;
 Wed, 17 Jul 2024 11:47:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx08TYPpdmIgdMAA--.29770S5; 
 Wed, 17 Jul 2024 11:47:38 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 kvm@vger.kernel.org, Bibo Mao <maobibo@loongson.cn>
Subject: [RFC 3/4] hw/loongarch: Add KVM pch pic device support
Date: Wed, 17 Jul 2024 11:29:55 +0800
Message-Id: <5cb9e3d2beea1bf9434ebb1810f15049778bd3bc.1721186636.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1721186636.git.lixianglai@loongson.cn>
References: <cover.1721186636.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx08TYPpdmIgdMAA--.29770S5
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Added pch_pic interrupt controller for kvm emulation.
The main process is to send the command word for
creating an pch_pic device to the kernel,
Delivers the pch pic interrupt controller configuration
register base address to the kernel.
When the VM is saved, the ioctl obtains the pch_pic
interrupt controller data in the kernel and saves it.
When the VM is recovered, the saved data is sent to the kernel.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Paolo Bonzini <pbonzini@redhat.com> 
Cc: Song Gao <gaosong@loongson.cn> 
Cc: Huacai Chen <chenhuacai@kernel.org> 
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com> 
Cc: "Michael S. Tsirkin" <mst@redhat.com> 
Cc: Cornelia Huck <cohuck@redhat.com> 
Cc: kvm@vger.kernel.org 
Cc: Bibo Mao <maobibo@loongson.cn> 

 hw/intc/Kconfig                     |   4 +
 hw/intc/loongarch_pch_pic.c         |  20 ++-
 hw/intc/loongarch_pch_pic_kvm.c     | 189 ++++++++++++++++++++++++++++
 hw/intc/meson.build                 |   1 +
 hw/loongarch/virt.c                 |  65 +++++-----
 include/hw/intc/loongarch_pch_pic.h |  51 +++++++-
 linux-headers/asm-loongarch/kvm.h   |   5 +
 linux-headers/linux/kvm.h           |   2 +
 8 files changed, 304 insertions(+), 33 deletions(-)
 create mode 100644 hw/intc/loongarch_pch_pic_kvm.c

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index c672774c6e..c9f96bffd6 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -98,6 +98,10 @@ config LOONGARCH_PCH_PIC
     bool
     select UNIMP
 
+config LOONGARCH_PCH_PIC_KVM
+    bool
+    default y
+
 config LOONGARCH_PCH_MSI
     select MSI_NONBROKEN
     bool
diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 2d5e65abff..b64e3db77f 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -16,18 +16,27 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "sysemu/kvm.h"
 
 static void pch_pic_update_irq(LoongArchPCHPIC *s, uint64_t mask, int level)
 {
     uint64_t val;
     int irq;
+    int kvm_irq;
 
     if (level) {
         val = mask & s->intirr & ~s->int_mask;
         if (val) {
             irq = ctz64(val);
             s->intisr |= MAKE_64BIT_MASK(irq, 1);
-            qemu_set_irq(s->parent_irq[s->htmsi_vector[irq]], 1);
+            if (kvm_kernel_irqchip_allowed()) {
+                kvm_irq = (
+                KVM_LOONGARCH_IRQ_TYPE_IOAPIC << KVM_LOONGARCH_IRQ_TYPE_SHIFT)
+                | (0 <<  KVM_LOONGARCH_IRQ_VCPU_SHIFT) | s->htmsi_vector[irq];
+                kvm_set_irq(kvm_state, kvm_irq, !!level);
+            } else {
+                qemu_set_irq(s->parent_irq[s->htmsi_vector[irq]], 1);
+            }
         }
     } else {
         /*
@@ -38,7 +47,14 @@ static void pch_pic_update_irq(LoongArchPCHPIC *s, uint64_t mask, int level)
         if (val) {
             irq = ctz64(val);
             s->intisr &= ~MAKE_64BIT_MASK(irq, 1);
-            qemu_set_irq(s->parent_irq[s->htmsi_vector[irq]], 0);
+            if (kvm_kernel_irqchip_allowed()) {
+                kvm_irq = (
+                KVM_LOONGARCH_IRQ_TYPE_IOAPIC << KVM_LOONGARCH_IRQ_TYPE_SHIFT)
+                | (0 <<  KVM_LOONGARCH_IRQ_VCPU_SHIFT) | s->htmsi_vector[irq];
+                kvm_set_irq(kvm_state, kvm_irq, !!level);
+            } else {
+                qemu_set_irq(s->parent_irq[s->htmsi_vector[irq]], 0);
+            }
         }
     }
 }
diff --git a/hw/intc/loongarch_pch_pic_kvm.c b/hw/intc/loongarch_pch_pic_kvm.c
new file mode 100644
index 0000000000..8f66d9a01f
--- /dev/null
+++ b/hw/intc/loongarch_pch_pic_kvm.c
@@ -0,0 +1,189 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch kvm pch pic interrupt support
+ *
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "qemu/typedefs.h"
+#include "hw/intc/loongarch_pch_pic.h"
+#include "hw/sysbus.h"
+#include "linux/kvm.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "sysemu/kvm.h"
+#include "hw/loongarch/virt.h"
+#include "hw/pci-host/ls7a.h"
+#include "qemu/error-report.h"
+
+static void kvm_pch_pic_access_regs(int fd, uint64_t addr,
+                                       void *val, int is_write)
+{
+        kvm_device_access(fd, KVM_DEV_LOONGARCH_PCH_PIC_GRP_REGS,
+                          addr, val, is_write, &error_abort);
+}
+
+static int kvm_loongarch_pch_pic_pre_save(void *opaque)
+{
+    KVMLoongArchPCHPIC *s = (KVMLoongArchPCHPIC *)opaque;
+    KVMLoongArchPCHPICClass *class = KVM_LOONGARCH_PCH_PIC_GET_CLASS(s);
+    int fd = class->dev_fd;
+
+    kvm_pch_pic_access_regs(fd, PCH_PIC_MASK_START,
+                            (void *)&s->int_mask, false);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_HTMSI_EN_START,
+                            (void *)&s->htmsi_en, false);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_EDGE_START,
+                            (void *)&s->intedge, false);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_AUTO_CTRL0_START,
+                            (void *)&s->auto_crtl0, false);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_AUTO_CTRL1_START,
+                            (void *)&s->auto_crtl1, false);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_ROUTE_ENTRY_START,
+                            (void *)s->route_entry, false);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_HTMSI_VEC_START,
+                            (void *)s->htmsi_vector, false);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_INT_IRR_START,
+                            (void *)&s->intirr, false);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_INT_ISR_START,
+                            (void *)&s->intisr, false);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_POLARITY_START,
+                            (void *)&s->int_polarity, false);
+
+    return 0;
+}
+
+static int kvm_loongarch_pch_pic_post_load(void *opaque, int version_id)
+{
+    KVMLoongArchPCHPIC *s = (KVMLoongArchPCHPIC *)opaque;
+    KVMLoongArchPCHPICClass *class = KVM_LOONGARCH_PCH_PIC_GET_CLASS(s);
+    int fd = class->dev_fd;
+
+    kvm_pch_pic_access_regs(fd, PCH_PIC_MASK_START,
+                            (void *)&s->int_mask, true);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_HTMSI_EN_START,
+                            (void *)&s->htmsi_en, true);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_EDGE_START,
+                            (void *)&s->intedge, true);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_AUTO_CTRL0_START,
+                            (void *)&s->auto_crtl0, true);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_AUTO_CTRL1_START,
+                            (void *)&s->auto_crtl1, true);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_ROUTE_ENTRY_START,
+                            (void *)s->route_entry, true);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_HTMSI_VEC_START,
+                            (void *)s->htmsi_vector, true);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_INT_IRR_START,
+                            (void *)&s->intirr, true);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_INT_ISR_START,
+                            (void *)&s->intisr, true);
+    kvm_pch_pic_access_regs(fd, PCH_PIC_POLARITY_START,
+                            (void *)&s->int_polarity, true);
+
+    return 0;
+}
+
+static void kvm_pch_pic_handler(void *opaque, int irq, int level)
+{
+    int kvm_irq;
+
+    if (kvm_enabled()) {
+        kvm_irq = \
+            (KVM_LOONGARCH_IRQ_TYPE_IOAPIC << KVM_LOONGARCH_IRQ_TYPE_SHIFT)
+            | (0 <<  KVM_LOONGARCH_IRQ_VCPU_SHIFT) | irq;
+        kvm_set_irq(kvm_state, kvm_irq, !!level);
+    }
+}
+
+static void kvm_loongarch_pch_pic_realize(DeviceState *dev, Error **errp)
+{
+    KVMLoongArchPCHPICClass *pch_pic_class =
+            KVM_LOONGARCH_PCH_PIC_GET_CLASS(dev);
+    struct kvm_create_device cd = {0};
+    uint64_t pch_pic_base = VIRT_PCH_REG_BASE;
+    Error *err = NULL;
+    int ret;
+
+    pch_pic_class->parent_realize(dev, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    if (!pch_pic_class->is_created) {
+        cd.type = KVM_DEV_TYPE_LA_PCH_PIC;
+        ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
+        if (ret < 0) {
+            error_setg_errno(errp, errno,
+                             "Creating the KVM pch pic device failed");
+            return;
+        }
+        pch_pic_class->is_created = true;
+        pch_pic_class->dev_fd = cd.fd;
+        fprintf(stdout, "Create LoongArch pch pic irqchip in KVM done!\n");
+
+        ret = kvm_device_access(cd.fd, KVM_DEV_LOONGARCH_PCH_PIC_GRP_CTRL,
+                                KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT,
+                                &pch_pic_base, true, NULL);
+        if (ret < 0) {
+            error_report(
+                "KVM EXTIOI: failed to set the base address of EXTIOI");
+            exit(1);
+        }
+
+        qdev_init_gpio_in(dev, kvm_pch_pic_handler, VIRT_PCH_PIC_IRQ_NUM);
+    }
+}
+
+static const VMStateDescription vmstate_kvm_loongarch_pch_pic = {
+    .name = TYPE_LOONGARCH_PCH_PIC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_save = kvm_loongarch_pch_pic_pre_save,
+    .post_load = kvm_loongarch_pch_pic_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(int_mask, KVMLoongArchPCHPIC),
+        VMSTATE_UINT64(htmsi_en, KVMLoongArchPCHPIC),
+        VMSTATE_UINT64(intedge, KVMLoongArchPCHPIC),
+        VMSTATE_UINT64(intclr, KVMLoongArchPCHPIC),
+        VMSTATE_UINT64(auto_crtl0, KVMLoongArchPCHPIC),
+        VMSTATE_UINT64(auto_crtl1, KVMLoongArchPCHPIC),
+        VMSTATE_UINT8_ARRAY(route_entry, KVMLoongArchPCHPIC, 64),
+        VMSTATE_UINT8_ARRAY(htmsi_vector, KVMLoongArchPCHPIC, 64),
+        VMSTATE_UINT64(last_intirr, KVMLoongArchPCHPIC),
+        VMSTATE_UINT64(intirr, KVMLoongArchPCHPIC),
+        VMSTATE_UINT64(intisr, KVMLoongArchPCHPIC),
+        VMSTATE_UINT64(int_polarity, KVMLoongArchPCHPIC),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+
+static void kvm_loongarch_pch_pic_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    KVMLoongArchPCHPICClass *pch_pic_class = KVM_LOONGARCH_PCH_PIC_CLASS(oc);
+
+    pch_pic_class->parent_realize = dc->realize;
+    dc->realize = kvm_loongarch_pch_pic_realize;
+    pch_pic_class->is_created = false;
+    dc->vmsd = &vmstate_kvm_loongarch_pch_pic;
+
+}
+
+static const TypeInfo kvm_loongarch_pch_pic_info = {
+    .name = TYPE_KVM_LOONGARCH_PCH_PIC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(KVMLoongArchPCHPIC),
+    .class_size = sizeof(KVMLoongArchPCHPICClass),
+    .class_init = kvm_loongarch_pch_pic_class_init,
+};
+
+static void kvm_loongarch_pch_pic_register_types(void)
+{
+    type_register_static(&kvm_loongarch_pch_pic_info);
+}
+
+type_init(kvm_loongarch_pch_pic_register_types)
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 3f29b3f5fd..4fddc80383 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -75,3 +75,4 @@ specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI_KVM', if_true: files('loongarch_extioi_kvm.c'))
+specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC_KVM', if_true: files('loongarch_pch_pic_kvm.c'))
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 288aac5822..9e9e8f5d14 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -862,40 +862,45 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     /* Add Extend I/O Interrupt Controller node */
     fdt_add_eiointc_node(lvms, &cpuintc_phandle, &eiointc_phandle);
 
-    pch_pic = qdev_new(TYPE_LOONGARCH_PCH_PIC);
-    num = VIRT_PCH_PIC_IRQ_NUM;
-    qdev_prop_set_uint32(pch_pic, "pch_pic_irq_num", num);
-    d = SYS_BUS_DEVICE(pch_pic);
-    sysbus_realize_and_unref(d, &error_fatal);
-    memory_region_add_subregion(get_system_memory(), VIRT_IOAPIC_REG_BASE,
-                            sysbus_mmio_get_region(d, 0));
-    memory_region_add_subregion(get_system_memory(),
+    if (kvm_kernel_irqchip_allowed()) {
+        pch_pic = qdev_new(TYPE_KVM_LOONGARCH_PCH_PIC);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(pch_pic), &error_fatal);
+    } else {
+        pch_pic = qdev_new(TYPE_LOONGARCH_PCH_PIC);
+        num = VIRT_PCH_PIC_IRQ_NUM;
+        qdev_prop_set_uint32(pch_pic, "pch_pic_irq_num", num);
+        d = SYS_BUS_DEVICE(pch_pic);
+        sysbus_realize_and_unref(d, &error_fatal);
+        memory_region_add_subregion(get_system_memory(), VIRT_IOAPIC_REG_BASE,
+                                sysbus_mmio_get_region(d, 0));
+        memory_region_add_subregion(get_system_memory(),
                             VIRT_IOAPIC_REG_BASE + PCH_PIC_ROUTE_ENTRY_OFFSET,
                             sysbus_mmio_get_region(d, 1));
-    memory_region_add_subregion(get_system_memory(),
-                            VIRT_IOAPIC_REG_BASE + PCH_PIC_INT_STATUS_LO,
-                            sysbus_mmio_get_region(d, 2));
-
-    /* Connect pch_pic irqs to extioi */
-    for (i = 0; i < num; i++) {
-        qdev_connect_gpio_out(DEVICE(d), i, qdev_get_gpio_in(extioi, i));
-    }
+        memory_region_add_subregion(get_system_memory(),
+                                VIRT_IOAPIC_REG_BASE + PCH_PIC_INT_STATUS_LO,
+                                sysbus_mmio_get_region(d, 2));
 
-    /* Add PCH PIC node */
-    fdt_add_pch_pic_node(lvms, &eiointc_phandle, &pch_pic_phandle);
+        /* Connect pch_pic irqs to extioi */
+        for (i = 0; i < num; i++) {
+            qdev_connect_gpio_out(DEVICE(d), i, qdev_get_gpio_in(extioi, i));
+        }
 
-    pch_msi = qdev_new(TYPE_LOONGARCH_PCH_MSI);
-    start   =  num;
-    num = EXTIOI_IRQS - start;
-    qdev_prop_set_uint32(pch_msi, "msi_irq_base", start);
-    qdev_prop_set_uint32(pch_msi, "msi_irq_num", num);
-    d = SYS_BUS_DEVICE(pch_msi);
-    sysbus_realize_and_unref(d, &error_fatal);
-    sysbus_mmio_map(d, 0, VIRT_PCH_MSI_ADDR_LOW);
-    for (i = 0; i < num; i++) {
-        /* Connect pch_msi irqs to extioi */
-        qdev_connect_gpio_out(DEVICE(d), i,
-                              qdev_get_gpio_in(extioi, i + start));
+        /* Add PCH PIC node */
+        fdt_add_pch_pic_node(lvms, &eiointc_phandle, &pch_pic_phandle);
+
+        pch_msi = qdev_new(TYPE_LOONGARCH_PCH_MSI);
+        start   =  num;
+        num = EXTIOI_IRQS - start;
+        qdev_prop_set_uint32(pch_msi, "msi_irq_base", start);
+        qdev_prop_set_uint32(pch_msi, "msi_irq_num", num);
+        d = SYS_BUS_DEVICE(pch_msi);
+        sysbus_realize_and_unref(d, &error_fatal);
+        sysbus_mmio_map(d, 0, VIRT_PCH_MSI_ADDR_LOW);
+        for (i = 0; i < num; i++) {
+            /* Connect pch_msi irqs to extioi */
+            qdev_connect_gpio_out(DEVICE(d), i,
+                                  qdev_get_gpio_in(extioi, i + start));
+        }
     }
 
     /* Add PCH MSI node */
diff --git a/include/hw/intc/loongarch_pch_pic.h b/include/hw/intc/loongarch_pch_pic.h
index d5437e88f2..77f4cd74a1 100644
--- a/include/hw/intc/loongarch_pch_pic.h
+++ b/include/hw/intc/loongarch_pch_pic.h
@@ -7,7 +7,8 @@
 
 #include "hw/sysbus.h"
 
-#define TYPE_LOONGARCH_PCH_PIC "loongarch_pch_pic"
+#define TYPE_LOONGARCH_PCH_PIC          "loongarch_pch_pic"
+#define TYPE_KVM_LOONGARCH_PCH_PIC      "loongarch_kvm_pch_pic"
 #define PCH_PIC_NAME(name) TYPE_LOONGARCH_PCH_PIC#name
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchPCHPIC, LOONGARCH_PCH_PIC)
 
@@ -37,6 +38,19 @@ OBJECT_DECLARE_SIMPLE_TYPE(LoongArchPCHPIC, LOONGARCH_PCH_PIC)
 #define PCH_PIC_INT_POL_LO              0x3e0
 #define PCH_PIC_INT_POL_HI              0x3e4
 
+#define PCH_PIC_INT_ID_START            PCH_PIC_INT_ID_LO
+#define PCH_PIC_MASK_START              PCH_PIC_INT_MASK_LO
+#define PCH_PIC_HTMSI_EN_START          PCH_PIC_HTMSI_EN_LO
+#define PCH_PIC_EDGE_START              PCH_PIC_INT_EDGE_LO
+#define PCH_PIC_CLEAR_START             PCH_PIC_INT_CLEAR_LO
+#define PCH_PIC_AUTO_CTRL0_START        PCH_PIC_AUTO_CTRL0_LO
+#define PCH_PIC_AUTO_CTRL1_START        PCH_PIC_AUTO_CTRL1_LO
+#define PCH_PIC_ROUTE_ENTRY_START       PCH_PIC_ROUTE_ENTRY_OFFSET
+#define PCH_PIC_HTMSI_VEC_START         PCH_PIC_HTMSI_VEC_OFFSET
+#define PCH_PIC_INT_IRR_START           0x380
+#define PCH_PIC_INT_ISR_START           PCH_PIC_INT_STATUS_LO
+#define PCH_PIC_POLARITY_START          PCH_PIC_INT_POL_LO
+
 #define STATUS_LO_START                 0
 #define STATUS_HI_START                 0x4
 #define POL_LO_START                    0x40
@@ -67,3 +81,38 @@ struct LoongArchPCHPIC {
     MemoryRegion iomem8;
     unsigned int irq_num;
 };
+
+struct KVMLoongArchPCHPIC {
+    SysBusDevice parent_obj;
+    uint64_t int_mask; /*0x020 interrupt mask register*/
+    uint64_t htmsi_en; /*0x040 1=msi*/
+    uint64_t intedge; /*0x060 edge=1 level  =0*/
+    uint64_t intclr; /*0x080 for clean edge int,set 1 clean,set 0 is noused*/
+    uint64_t auto_crtl0; /*0x0c0*/
+    uint64_t auto_crtl1; /*0x0e0*/
+    uint64_t last_intirr;    /* edge detection */
+    uint64_t intirr; /* 0x380 interrupt request register */
+    uint64_t intisr; /* 0x3a0 interrupt service register */
+    /*
+     * 0x3e0 interrupt level polarity selection
+     * register 0 for high level trigger
+     */
+    uint64_t int_polarity;
+
+    uint8_t route_entry[64]; /*0x100 - 0x138*/
+    uint8_t htmsi_vector[64]; /*0x200 - 0x238*/
+};
+typedef struct KVMLoongArchPCHPIC KVMLoongArchPCHPIC;
+DECLARE_INSTANCE_CHECKER(KVMLoongArchPCHPIC, KVM_LOONGARCH_PCH_PIC,
+                         TYPE_KVM_LOONGARCH_PCH_PIC)
+
+struct KVMLoongArchPCHPICClass {
+    SysBusDeviceClass parent_class;
+    DeviceRealize parent_realize;
+
+    bool is_created;
+    int dev_fd;
+};
+typedef struct KVMLoongArchPCHPICClass KVMLoongArchPCHPICClass;
+DECLARE_CLASS_CHECKERS(KVMLoongArchPCHPICClass, KVM_LOONGARCH_PCH_PIC,
+                       TYPE_KVM_LOONGARCH_PCH_PIC)
diff --git a/linux-headers/asm-loongarch/kvm.h b/linux-headers/asm-loongarch/kvm.h
index c71221d1b0..cd0aebd805 100644
--- a/linux-headers/asm-loongarch/kvm.h
+++ b/linux-headers/asm-loongarch/kvm.h
@@ -110,4 +110,9 @@ struct kvm_iocsr_entry {
 
 #define KVM_DEV_LOONGARCH_IPI_GRP_REGS		1
 #define KVM_DEV_LOONGARCH_EXTIOI_GRP_REGS	1
+
+#define KVM_DEV_LOONGARCH_PCH_PIC_GRP_CTRL	0
+#define KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT	0
+
+#define KVM_DEV_LOONGARCH_PCH_PIC_GRP_REGS	1
 #endif /* __UAPI_ASM_LOONGARCH_KVM_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 1dca283ecd..48eaeb91f2 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1138,6 +1138,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_ARM_PV_TIME	KVM_DEV_TYPE_ARM_PV_TIME
 	KVM_DEV_TYPE_RISCV_AIA,
 #define KVM_DEV_TYPE_RISCV_AIA		KVM_DEV_TYPE_RISCV_AIA
+	KVM_DEV_TYPE_LA_PCH_PIC,
+#define KVM_DEV_TYPE_LA_PCH_PIC		KVM_DEV_TYPE_LA_PCH_PIC
 	KVM_DEV_TYPE_LA_IPI,
 #define KVM_DEV_TYPE_LA_IPI		KVM_DEV_TYPE_LA_IPI
 	KVM_DEV_TYPE_LA_EXTIOI,
-- 
2.39.1


