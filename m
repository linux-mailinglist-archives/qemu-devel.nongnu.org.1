Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2D88FDDA8
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jun 2024 06:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF4KM-0007Vo-KE; Thu, 06 Jun 2024 00:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sF4KF-0007Tf-KF
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:02:07 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sF4KC-00013k-JX
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:02:07 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dx2Om3NGFmABIEAA--.4537S3;
 Thu, 06 Jun 2024 12:01:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxVcWzNGFmgHQWAA--.45267S7; 
 Thu, 06 Jun 2024 12:01:59 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 5/6] hw/loongarch/virt: Enable extioi virt extension
Date: Thu,  6 Jun 2024 12:01:54 +0800
Message-Id: <20240606040155.2607422-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240606040155.2607422-1-gaosong@loongson.cn>
References: <20240606040155.2607422-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxVcWzNGFmgHQWAA--.45267S7
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

This patch adds a new board attribute 'v-eiointc'.
A value of true enables the virt extended I/O interrupt controller.
VMs working in kvm mode have 'v-eiointc' enabled by default.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20240528083855.1912757-4-gaosong@loongson.cn>
---
 hw/loongarch/virt.c         | 88 +++++++++++++++++++++++++++++++++++--
 include/hw/loongarch/virt.h |  1 +
 target/loongarch/cpu.h      |  1 +
 3 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 0cef33a904..66cef201ab 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -11,6 +11,7 @@
 #include "hw/boards.h"
 #include "hw/char/serial.h"
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
 #include "sysemu/runstate.h"
@@ -48,6 +49,31 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "qemu/error-report.h"
 
+static bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
+{
+    if (lvms->veiointc == ON_OFF_AUTO_OFF) {
+        return false;
+    }
+    return true;
+}
+
+static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+    OnOffAuto veiointc = lvms->veiointc;
+
+    visit_type_OnOffAuto(v, name, &veiointc, errp);
+}
+
+static void virt_set_veiointc(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+
+    visit_type_OnOffAuto(v, name, &lvms->veiointc, errp);
+}
+
 static PFlashCFI01 *virt_flash_create1(LoongArchVirtMachineState *lvms,
                                        const char *name,
                                        const char *alias_prop_name)
@@ -790,9 +816,16 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     /* Create EXTIOI device */
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
     qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
+    if (virt_is_veiointc_enabled(lvms)) {
+        qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
+    }
     sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
     memory_region_add_subregion(&lvms->system_iocsr, APIC_BASE,
-                   sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
+                    sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
+    if (virt_is_veiointc_enabled(lvms)) {
+        memory_region_add_subregion(&lvms->system_iocsr, EXTIOI_VIRT_BASE,
+                    sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 1));
+    }
 
     /*
      * connect ext irq to the cpu irq
@@ -899,11 +932,37 @@ static void virt_firmware_init(LoongArchVirtMachineState *lvms)
     }
 }
 
-
 static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
                                          uint64_t val, unsigned size,
                                          MemTxAttrs attrs)
 {
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(opaque);
+    uint64_t features;
+
+    switch (addr) {
+    case MISC_FUNC_REG:
+        if (!virt_is_veiointc_enabled(lvms)) {
+            return MEMTX_OK;
+        }
+
+        features = address_space_ldl(&lvms->as_iocsr,
+                                     EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
+                                     attrs, NULL);
+        if (val & BIT_ULL(IOCSRM_EXTIOI_EN)) {
+            features |= BIT(EXTIOI_ENABLE);
+        }
+        if (val & BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE)) {
+            features |= BIT(EXTIOI_ENABLE_INT_ENCODE);
+        }
+
+        address_space_stl(&lvms->as_iocsr,
+                          EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
+                          features, attrs, NULL);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
     return MEMTX_OK;
 }
 
@@ -911,7 +970,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
                                         uint64_t *data,
                                         unsigned size, MemTxAttrs attrs)
 {
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(opaque);
     uint64_t ret = 0;
+    int features;
 
     switch (addr) {
     case VERSION_REG:
@@ -930,7 +991,20 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
         ret = 0x303030354133ULL;     /* "3A5000" */
         break;
     case MISC_FUNC_REG:
-        ret = BIT_ULL(IOCSRM_EXTIOI_EN);
+        if (!virt_is_veiointc_enabled(lvms)) {
+            ret |= BIT_ULL(IOCSRM_EXTIOI_EN);
+            break;
+        }
+
+        features = address_space_ldl(&lvms->as_iocsr,
+                                     EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
+                                     attrs, NULL);
+        if (features & BIT(EXTIOI_ENABLE)) {
+            ret |= BIT_ULL(IOCSRM_EXTIOI_EN);
+        }
+        if (features & BIT(EXTIOI_ENABLE_INT_ENCODE)) {
+            ret |= BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE);
+        }
         break;
     default:
         g_assert_not_reached();
@@ -1152,6 +1226,9 @@ static void virt_initfn(Object *obj)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
 
+    if (tcg_enabled()) {
+        lvms->veiointc = ON_OFF_AUTO_OFF;
+    }
     lvms->acpi = ON_OFF_AUTO_AUTO;
     lvms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     lvms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
@@ -1338,6 +1415,11 @@ static void virt_class_init(ObjectClass *oc, void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "acpi",
         "Enable ACPI");
+    object_class_property_add(oc, "v-eiointc", "OnOffAuto",
+        virt_get_veiointc, virt_set_veiointc,
+        NULL, NULL);
+    object_class_property_set_description(oc, "v-eiointc",
+                            "Enable Virt Extend I/O Interrupt Controller.");
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 2c4f5cf9c8..8fdfacf268 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -50,6 +50,7 @@ struct LoongArchVirtMachineState {
     Notifier     machine_done;
     Notifier     powerdown_notifier;
     OnOffAuto    acpi;
+    OnOffAuto    veiointc;
     char         *oem_id;
     char         *oem_table_id;
     DeviceState  *acpi_ged;
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 41b8e6d96d..6c41fafb70 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -36,6 +36,7 @@
 #define CPUNAME_REG             0x20
 #define MISC_FUNC_REG           0x420
 #define IOCSRM_EXTIOI_EN        48
+#define IOCSRM_EXTIOI_INT_ENCODE 49
 
 #define IOCSR_MEM_SIZE          0x428
 
-- 
2.34.1


