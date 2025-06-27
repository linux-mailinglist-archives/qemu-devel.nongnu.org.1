Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA146AEAD46
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Jun 2025 05:26:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUzhe-0005Fh-PC; Thu, 26 Jun 2025 23:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uUzhb-0005EE-0l
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:24:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uUzhX-00065R-US
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:24:34 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Ax3eLoDl5ooAgeAQ--.28373S3;
 Fri, 27 Jun 2025 11:24:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxn8XiDl5oz10sAQ--.3598S4;
 Fri, 27 Jun 2025 11:24:23 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v3 2/9] hw/loongarch: add virt feature avecintc support
Date: Fri, 27 Jun 2025 11:01:31 +0800
Message-Id: <20250627030138.2482055-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250627030138.2482055-1-gaosong@loongson.cn>
References: <20250627030138.2482055-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8XiDl5oz10sAQ--.3598S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

LoongArchVirtMachinState adds avecintc features, and
it use to check whether virt machine support advance interrupt controller
and default set avecintc = ON_OFF_AUTO_ON.
LoongArchVirtMachineState adds misc_feature and misc_status for
misc fetures and status. and set default avec feture bit.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c         | 43 +++++++++++++++++++++++++++++++++----
 include/hw/loongarch/virt.h | 15 +++++++++++++
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 6a169d4824..426eaaef84 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -47,6 +47,28 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "qemu/error-report.h"
 
+static void virt_get_avecintc(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+    OnOffAuto avecintc = lvms->avecintc;
+
+    visit_type_OnOffAuto(v, name, &avecintc, errp);
+
+}
+static void virt_set_avecintc(Object *obj, Visitor *v, const char *name,
+                              void *opaque, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+
+    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
+        lvms->misc_feature &= ~BIT(IOCSRF_AVEC);
+        lvms->misc_status &= ~BIT(IOCSRM_AVEC_EN);
+    }
+
+    visit_type_OnOffAuto(v, name, &lvms->avecintc, errp);
+}
+
 static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -539,6 +561,10 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
             return MEMTX_OK;
         }
 
+        if (val & BIT(IOCSRM_AVEC_EN)) {
+            lvms->misc_status |= BIT(IOCSRM_AVEC_EN);
+        }
+
         features = address_space_ldl(&lvms->as_iocsr,
                                      EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
                                      attrs, NULL);
@@ -574,8 +600,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
         break;
     case FEATURE_REG:
         ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | BIT(IOCSRF_CSRIPI);
-        /*TODO: check bit IOCSRF_AVEC with virt_is_avec_enabled */
-        ret |= BIT(IOCSRF_AVEC);
+        if (virt_is_avecintc_enabled(lvms)) {
+            ret |= BIT(IOCSRF_AVEC);
+        }
         if (kvm_enabled()) {
             ret |= BIT(IOCSRF_VM);
         }
@@ -605,8 +632,10 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
         if (features & BIT(EXTIOI_ENABLE_INT_ENCODE)) {
             ret |= BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE);
         }
-        /* enable avec default */
-        ret |= BIT_ULL(IOCSRM_AVEC_EN);
+        if (virt_is_avecintc_enabled(lvms) &&
+            (lvms->misc_status & BIT(IOCSRM_AVEC_EN))) {
+            ret |= BIT_ULL(IOCSRM_AVEC_EN);
+        }
         break;
     default:
         g_assert_not_reached();
@@ -850,6 +879,8 @@ static void virt_initfn(Object *obj)
     if (tcg_enabled()) {
         lvms->veiointc = ON_OFF_AUTO_OFF;
     }
+    lvms->misc_feature = BIT(IOCSRF_AVEC);
+    lvms->avecintc = ON_OFF_AUTO_ON;
     lvms->acpi = ON_OFF_AUTO_AUTO;
     lvms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     lvms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
@@ -1242,6 +1273,10 @@ static void virt_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "v-eiointc",
                             "Enable Virt Extend I/O Interrupt Controller.");
+    object_class_property_add(oc, "avecintc", "OnOffAuto",
+        virt_get_avecintc, virt_set_avecintc, NULL, NULL);
+    object_class_property_set_description(oc, "avecintc",
+                            "Enable Advance Interrupt Controller.");
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
 #ifdef CONFIG_TPM
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index cc6656619d..44504e5501 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -70,6 +70,7 @@ struct LoongArchVirtMachineState {
     Notifier     powerdown_notifier;
     OnOffAuto    acpi;
     OnOffAuto    veiointc;
+    OnOffAuto    avecintc;
     char         *oem_id;
     char         *oem_table_id;
     DeviceState  *acpi_ged;
@@ -85,6 +86,8 @@ struct LoongArchVirtMachineState {
     DeviceState *extioi;
     struct memmap_entry *memmap_table;
     unsigned int memmap_entries;
+    uint64_t misc_feature;
+    uint64_t misc_status;
 };
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
@@ -92,6 +95,18 @@ OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
 void virt_acpi_setup(LoongArchVirtMachineState *lvms);
 void virt_fdt_setup(LoongArchVirtMachineState *lvms);
 
+static inline bool virt_is_avecintc_enabled(LoongArchVirtMachineState *lvms)
+{
+    if (!(lvms->misc_feature & BIT(IOCSRF_AVEC))) {
+        return false;
+    }
+
+    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
+        return false;
+    }
+    return true;
+}
+
 static inline bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
 {
     if (lvms->veiointc == ON_OFF_AUTO_OFF) {
-- 
2.34.1


