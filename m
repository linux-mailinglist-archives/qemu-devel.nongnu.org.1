Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D03482E7F5
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 03:43:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPZOO-00082O-6B; Mon, 15 Jan 2024 21:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rPZOL-00080M-AV
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 21:41:29 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rPZOI-0005T6-3f
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 21:41:29 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxifDQ7KVlaY0AAA--.2914S3;
 Tue, 16 Jan 2024 10:41:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxHs_P7KVlcSIDAA--.16487S2; 
 Tue, 16 Jan 2024 10:41:19 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 maobibo@loongson.cn, zhaotianrui@loongson.cn, lixianglai@loongson.cn
Subject: [RFC PATCH 1/1] hw/intc/loongarch_extioi: Add virt extension support
Date: Tue, 16 Jan 2024 10:25:26 +0800
Message-Id: <20240116022526.498613-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxHs_P7KVlcSIDAA--.16487S2
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

With hardware extioi, irq can be routed to four vcpus with hardware
extioi. This patch adds virt extension support, sot that irq can
be routed to 256 vcpus.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 include/hw/intc/loongarch_extioi.h |  24 +++++-
 include/hw/loongarch/virt.h        |   6 ++
 target/loongarch/cpu.h             |   1 +
 hw/intc/loongarch_extioi.c         | 100 +++++++++++++++++++++++-
 hw/loongarch/virt.c                | 119 ++++++++++++++++++++++++++---
 5 files changed, 233 insertions(+), 17 deletions(-)

diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index a0a46b888c..1044e8911a 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -36,10 +36,29 @@
 #define EXTIOI_ISR_START             (0x700 - APIC_OFFSET)
 #define EXTIOI_ISR_END               (0x720 - APIC_OFFSET)
 #define EXTIOI_COREISR_START         (0x800 - APIC_OFFSET)
-#define EXTIOI_COREISR_END           (0xB20 - APIC_OFFSET)
+#define EXTIOI_COREISR_END           (0x820 - APIC_OFFSET)
 #define EXTIOI_COREMAP_START         (0xC00 - APIC_OFFSET)
 #define EXTIOI_COREMAP_END           (0xD00 - APIC_OFFSET)
 
+#define EXTIOI_VIRT_BASE             (0x40000000)
+#define EXTIOI_VIRT_SIZE             (0x1000)
+#define EXTIOI_VIRT_FEATURES         (0x0)
+#define  EXTIOI_HAS_VIRT_EXTENSION     (0)
+#define  EXTIOI_HAS_ENABLE_OPTION      (1)
+#define  EXTIOI_HAS_INT_ENCODE         (2)
+#define  EXTIOI_HAS_IRQ_ENCODE         (3)
+#define  EXTIOI_HAS_CPUID_ENCODE       (4)
+#define  EXTIOI_VIRT_HAS_FEATURES      (BIT(EXTIOI_HAS_VIRT_EXTENSION) \
+                                        | BIT(EXTIOI_HAS_INT_ENCODE)   \
+                                        | BIT(EXTIOI_HAS_IRQ_ENCODE))
+#define EXTIOI_VIRT_CONFIG           (0x4)
+#define  EXTIOI_ENABLE                 (1)
+#define  EXTIOI_ENABLE_INT_ENCODE      (2)
+#define  EXTIOI_ENABLE_IRQ_ENCODE      (3)
+#define  EXTIOI_ENABLE_CPUID_ENCODE    (4)
+#define EXTIOI_VIRT_COREMAP_START    (0x40)
+#define EXTIOI_VIRT_COREMAP_END      (0x240)
+
 typedef struct ExtIOICore {
     uint32_t coreisr[EXTIOI_IRQS_GROUP_COUNT];
     DECLARE_BITMAP(sw_isr[LS3A_INTC_IP], EXTIOI_IRQS);
@@ -51,6 +70,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(LoongArchExtIOI, LOONGARCH_EXTIOI)
 struct LoongArchExtIOI {
     SysBusDevice parent_obj;
     uint32_t num_cpu;
+    uint32_t features;
+    uint32_t status;
     /* hardware state */
     uint32_t nodetype[EXTIOI_IRQS_NODETYPE_COUNT / 2];
     uint32_t bounce[EXTIOI_IRQS_GROUP_COUNT];
@@ -64,5 +85,6 @@ struct LoongArchExtIOI {
     qemu_irq irq[EXTIOI_IRQS];
     ExtIOICore *cpu;
     MemoryRegion extioi_system_mem;
+    MemoryRegion virt_extend;
 };
 #endif /* LOONGARCH_EXTIOI_H */
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 6ef9a92394..afd63cfd5e 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -30,6 +30,9 @@
 #define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN)
 #define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN)
 
+/* board device features */
+#define VIRT_HAS_V_EIOINTC        BIT(0)
+
 struct LoongArchMachineState {
     /*< private >*/
     MachineState parent_obj;
@@ -38,6 +41,7 @@ struct LoongArchMachineState {
     MemoryRegion highmem;
     MemoryRegion bios;
     bool         bios_loaded;
+    bool         v_eiointc;
     /* State for other subsystems/APIs: */
     FWCfgState  *fw_cfg;
     Notifier     machine_done;
@@ -48,11 +52,13 @@ struct LoongArchMachineState {
     DeviceState  *acpi_ged;
     int          fdt_size;
     DeviceState *platform_bus_dev;
+    DeviceState *extioi;
     PCIBus       *pci_bus;
     PFlashCFI01  *flash;
     MemoryRegion system_iocsr;
     MemoryRegion iocsr_mem;
     AddressSpace as_iocsr;
+    int          features;
 };
 
 #define TYPE_LOONGARCH_MACHINE  MACHINE_TYPE_NAME("virt")
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 0fa5e0ca93..339a4832f0 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -36,6 +36,7 @@
 #define CPUNAME_REG             0x20
 #define MISC_FUNC_REG           0x420
 #define IOCSRM_EXTIOI_EN        48
+#define IOCSRM_EXTIOI_INT_ENCODE  49
 
 #define IOCSR_MEM_SIZE          0x428
 
diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index bdfa3b481e..a22a33b849 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -55,6 +55,11 @@ static void extioi_update_irq(LoongArchExtIOI *s, int irq, int level)
 static void extioi_setirq(void *opaque, int irq, int level)
 {
     LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
+
+    if (s->status & BIT(EXTIOI_ENABLE)) {
+        return;
+    }
+
     trace_loongarch_extioi_setirq(irq, level);
     if (level) {
         /*
@@ -143,10 +148,13 @@ static inline void extioi_update_sw_coremap(LoongArchExtIOI *s, int irq,
 
     for (i = 0; i < 4; i++) {
         cpu = val & 0xff;
-        cpu = ctz32(cpu);
-        cpu = (cpu >= 4) ? 0 : cpu;
         val = val >> 8;
 
+        if (!(s->status & BIT(EXTIOI_ENABLE_IRQ_ENCODE))) {
+            cpu = ctz32(cpu);
+            cpu = (cpu >= 4) ? 0 : cpu;
+        }
+
         if (s->sw_coremap[irq + i] == cpu) {
             continue;
         }
@@ -177,8 +185,12 @@ static inline void extioi_update_sw_ipmap(LoongArchExtIOI *s, int index,
     val = cpu_to_le64(val);
     for (i = 0; i < 4; i++) {
         ipnum = val & 0xff;
-        ipnum = ctz32(ipnum);
-        ipnum = (ipnum >= 4) ? 0 : ipnum;
+        if (s->status & EXTIOI_ENABLE_INT_ENCODE) {
+            ipnum = (ipnum >= 8) ? 0 : ipnum;
+        } else {
+            ipnum = ctz32(ipnum);
+            ipnum = (ipnum >= 4) ? 0 : ipnum;
+        }
         s->sw_ipmap[index * 4 + i] = ipnum;
         val = val >> 8;
     }
@@ -265,6 +277,63 @@ static const MemoryRegionOps extioi_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static MemTxResult extioi_virt_readw(void *opaque, hwaddr addr, uint64_t *data,
+                                     unsigned size, MemTxAttrs attrs)
+{
+    LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
+
+    switch (addr) {
+    case EXTIOI_VIRT_FEATURES:
+        *data = s->features;
+        break;
+    case EXTIOI_VIRT_CONFIG:
+        *data = s->status;
+        break;
+    default:
+        break;
+    }
+
+    return MEMTX_OK;
+}
+
+static MemTxResult extioi_virt_writew(void *opaque, hwaddr addr,
+                          uint64_t val, unsigned size,
+                          MemTxAttrs attrs)
+{
+    LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
+
+    switch (addr) {
+    case EXTIOI_VIRT_FEATURES:
+        return MEMTX_ACCESS_ERROR;
+
+    case EXTIOI_VIRT_CONFIG:
+        val &= s->features & ~s->status;
+
+        /*
+         * extioi features can only be set at disabled status
+         */
+        if ((s->status & BIT(EXTIOI_ENABLE)) && val) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        s->status |= val;
+        break;
+    default:
+        break;
+    }
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps extioi_virt_ops = {
+    .read_with_attrs = extioi_virt_readw,
+    .write_with_attrs = extioi_virt_writew,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 8,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
 static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
 {
     LoongArchExtIOI *s = LOONGARCH_EXTIOI(dev);
@@ -284,6 +353,16 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->extioi_system_mem, OBJECT(s), &extioi_ops,
                           s, "extioi_system_mem", 0x900);
     sysbus_init_mmio(sbd, &s->extioi_system_mem);
+
+    if (s->features & BIT(EXTIOI_HAS_VIRT_EXTENSION)) {
+        memory_region_init_io(&s->virt_extend, OBJECT(s), &extioi_virt_ops,
+                              s, "extioi_virt", EXTIOI_VIRT_SIZE);
+        sysbus_init_mmio(sbd, &s->virt_extend);
+        s->features |= EXTIOI_VIRT_HAS_FEATURES;
+    } else {
+        s->status |= BIT(EXTIOI_ENABLE);
+    }
+
     s->cpu = g_new0(ExtIOICore, s->num_cpu);
     if (s->cpu == NULL) {
         error_setg(errp, "Memory allocation for ExtIOICore faile");
@@ -304,6 +383,14 @@ static void loongarch_extioi_finalize(Object *obj)
     g_free(s->cpu);
 }
 
+static void loongarch_extioi_reset(DeviceState *d)
+{
+    LoongArchExtIOI *s = LOONGARCH_EXTIOI(d);
+
+    /* use legacy interrupt routing method by default */
+    s->status = 0;
+}
+
 static int vmstate_extioi_post_load(void *opaque, int version_id)
 {
     LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
@@ -347,12 +434,16 @@ static const VMStateDescription vmstate_loongarch_extioi = {
 
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchExtIOI, num_cpu,
                          vmstate_extioi_core, ExtIOICore),
+        VMSTATE_UINT32(features, LoongArchExtIOI),
+        VMSTATE_UINT32(status, LoongArchExtIOI),
         VMSTATE_END_OF_LIST()
     }
 };
 
 static Property extioi_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", LoongArchExtIOI, num_cpu, 1),
+    DEFINE_PROP_BIT("has-virtualization-extension", LoongArchExtIOI, features,
+                    EXTIOI_HAS_VIRT_EXTENSION, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -361,6 +452,7 @@ static void loongarch_extioi_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = loongarch_extioi_realize;
+    dc->reset   = loongarch_extioi_reset;
     device_class_set_props(dc, extioi_properties);
     dc->vmsd = &vmstate_loongarch_extioi;
 }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index c9a680e61a..3cfab2cf86 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -15,6 +15,7 @@
 #include "sysemu/runstate.h"
 #include "sysemu/reset.h"
 #include "sysemu/rtc.h"
+#include "sysemu/kvm.h"
 #include "hw/loongarch/virt.h"
 #include "exec/address-spaces.h"
 #include "hw/irq.h"
@@ -581,11 +582,21 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
     }
 
     /* Create EXTIOI device */
+    lams->features = lams->v_eiointc ? VIRT_HAS_V_EIOINTC : 0 ;
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
     qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
+    if (lams->features & VIRT_HAS_V_EIOINTC) {
+        qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
+    }
     sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
+
     memory_region_add_subregion(&lams->system_iocsr, APIC_BASE,
                    sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
+    if (lams->features & VIRT_HAS_V_EIOINTC) {
+        memory_region_add_subregion(&lams->system_iocsr, EXTIOI_VIRT_BASE,
+                   sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 1));
+    }
+    lams->extioi = extioi;
 
     /*
      * connect ext irq to the cpu irq
@@ -731,32 +742,87 @@ static void loongarch_direct_kernel_boot(LoongArchMachineState *lams,
     }
 }
 
-static void loongarch_qemu_write(void *opaque, hwaddr addr,
-                                 uint64_t val, unsigned size)
+static MemTxResult loongarch_qemu_write(void *opaque, hwaddr addr, uint64_t val,
+                                        unsigned size, MemTxAttrs attrs)
 {
+    LoongArchMachineState *lams = LOONGARCH_MACHINE(opaque);
+    uint64_t features;
+
+    switch (addr) {
+    case MISC_FUNC_REG:
+        if (!(lams->features & 1)) {
+            return MEMTX_OK;
+        }
+
+        features = address_space_ldl(&lams->as_iocsr,
+                                     EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
+                                     attrs, NULL);
+        if (val & BIT_ULL(IOCSRM_EXTIOI_EN)) {
+            features |= BIT(EXTIOI_ENABLE);
+        }
+        if (val & BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE)) {
+            features |= BIT(EXTIOI_ENABLE_INT_ENCODE);
+        }
+
+        address_space_stl(&lams->as_iocsr,
+                          EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
+                          features, attrs, NULL);
+    }
+
+    return MEMTX_OK;
 }
 
-static uint64_t loongarch_qemu_read(void *opaque, hwaddr addr, unsigned size)
+static MemTxResult loongarch_qemu_read(void *opaque, hwaddr addr,
+                                       uint64_t *data,
+                                       unsigned size, MemTxAttrs attrs)
 {
+    LoongArchMachineState *lams = LOONGARCH_MACHINE(opaque);
+    uint64_t ret = 0;
+    int features;
+
     switch (addr) {
     case VERSION_REG:
-        return 0x11ULL;
+        ret = 0x11ULL;
+        break;
     case FEATURE_REG:
-        return 1ULL << IOCSRF_MSI | 1ULL << IOCSRF_EXTIOI |
-               1ULL << IOCSRF_CSRIPI;
+        ret = 1ULL << IOCSRF_MSI | 1ULL << IOCSRF_EXTIOI |
+              1ULL << IOCSRF_CSRIPI;
+        if (kvm_enabled()) {
+            ret |= 1ULL << IOCSRF_VM;
+        }
+        break;
     case VENDOR_REG:
-        return 0x6e6f73676e6f6f4cULL; /* "Loongson" */
+        ret = 0x6e6f73676e6f6f4cULL; /* "Loongson" */
+        break;
     case CPUNAME_REG:
-        return 0x303030354133ULL;     /* "3A5000" */
+        ret = 0x303030354133ULL;     /* "3A5000" */
+        break;
     case MISC_FUNC_REG:
-        return 1ULL << IOCSRM_EXTIOI_EN;
+        if (!(lams->features & 1)) {
+            ret |= BIT_ULL(IOCSRM_EXTIOI_EN);
+            break;
+        }
+
+        features = address_space_ldl(&lams->as_iocsr,
+                                     EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
+                                     attrs, NULL);
+        if (features & BIT(EXTIOI_ENABLE)) {
+            ret |= BIT_ULL(IOCSRM_EXTIOI_EN);
+        }
+
+        if (features & BIT(EXTIOI_ENABLE_INT_ENCODE)) {
+            ret |= BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE);
+        }
+        break;
     }
-    return 0ULL;
+
+    *data = ret;
+    return MEMTX_OK;
 }
 
 static const MemoryRegionOps loongarch_qemu_ops = {
-    .read = loongarch_qemu_read,
-    .write = loongarch_qemu_write,
+    .read_with_attrs  = loongarch_qemu_read,
+    .write_with_attrs = loongarch_qemu_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
@@ -791,6 +857,14 @@ static void loongarch_init(MachineState *machine)
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
     }
 
+    if (lams->v_eiointc && !kvm_enabled()) {
+        error_report("loongarch_init: %s does not support providing "
+                     "v-eiointc to the guest CPU",
+                     current_accel_name());
+        exit(1);
+    }
+
+
     if (ram_size < 1 * GiB) {
         error_report("ram_size must be greater than 1G.");
         exit(1);
@@ -961,6 +1035,7 @@ static void loongarch_machine_initfn(Object *obj)
 {
     LoongArchMachineState *lams = LOONGARCH_MACHINE(obj);
 
+    lams->v_eiointc = false;
     lams->acpi = ON_OFF_AUTO_AUTO;
     lams->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     lams->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
@@ -1114,6 +1189,20 @@ static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
     return nidx;
 }
 
+static bool virt_get_v_eiointc(Object *obj, Error **errp)
+{
+    LoongArchMachineState *lams = LOONGARCH_MACHINE(obj);
+
+    return lams->v_eiointc;
+}
+
+static void virt_set_v_eiointc(Object *obj, bool value, Error **errp)
+{
+    LoongArchMachineState *lams = LOONGARCH_MACHINE(obj);
+
+    lams->v_eiointc = value;
+}
+
 static void loongarch_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1152,6 +1241,12 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
+
+    object_class_property_add_bool(oc, "v-eiointc", virt_get_v_eiointc,
+                               virt_set_v_eiointc);
+    object_class_property_set_description(oc, "v-eiointc",
+                            "Set on/off to enable/disable The virt"
+                            "LoongArch Extend I/O Interrupt Controller. ");
 }
 
 static const TypeInfo loongarch_machine_types[] = {
-- 
2.25.1


