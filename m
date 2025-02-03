Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79475A26180
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Feb 2025 18:32:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf0IH-0008QH-TC; Mon, 03 Feb 2025 12:31:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tf0I2-0008EU-Pz; Mon, 03 Feb 2025 12:31:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tf0Hz-0005ZP-Kf; Mon, 03 Feb 2025 12:31:17 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ymtkw1zCCz6L4yq;
 Tue,  4 Feb 2025 01:28:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id D32F61400CA;
 Tue,  4 Feb 2025 01:31:12 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 18:31:12 +0100
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
 <peter.maydell@linaro.org>
CC: <mst@redhat.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
 <qemu-arm@nongnu.org>, Yuquan Wang <wangyuquan1236@phytium.com.cn>, Itaru
 Kitayama <itaru.kitayama@linux.dev>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v12 qemu 1/2] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
Date: Mon, 3 Feb 2025 17:30:39 +0000
Message-ID: <20250203173040.145763-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203173040.145763-1-Jonathan.Cameron@huawei.com>
References: <20250203173040.145763-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Code based on i386/pc enablement.
The memory layout places space for 16 host bridge register regions after
the GIC_REDIST2 in the extended memmap. Note this is in a hole, so
nothing should move.

The CFMWs are placed above the extended memmap.

Only create the CEDT table if cxl=on set for the machine.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
 include/hw/arm/virt.h    |  4 +++
 hw/arm/virt-acpi-build.c | 34 +++++++++++++++++++++++++
 hw/arm/virt.c            | 54 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c8e94e6aed..3e83d9e06b 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -36,6 +36,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
 #include "hw/block/flash.h"
+#include "hw/cxl/cxl.h"
 #include "system/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "qom/object.h"
@@ -85,6 +86,7 @@ enum {
 /* indices of IO regions located after the RAM */
 enum {
     VIRT_HIGH_GIC_REDIST2 =  VIRT_LOWMEMMAP_LAST,
+    VIRT_CXL_HOST,
     VIRT_HIGH_PCIE_ECAM,
     VIRT_HIGH_PCIE_MMIO,
 };
@@ -146,6 +148,7 @@ struct VirtMachineState {
     bool secure;
     bool highmem;
     bool highmem_compact;
+    bool highmem_cxl;
     bool highmem_ecam;
     bool highmem_mmio;
     bool highmem_redists;
@@ -180,6 +183,7 @@ struct VirtMachineState {
     char *oem_id;
     char *oem_table_id;
     bool ns_el2_virt_timer_irq;
+    CXLState cxl_devices_state;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3ac8f8e178..339aa60ce5 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -39,10 +39,12 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
+#include "hw/acpi/cxl.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/hmat.h"
+#include "hw/cxl/cxl.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
@@ -119,10 +121,29 @@ static void acpi_dsdt_add_flash(Aml *scope, const MemMapEntry *flash_memmap)
     aml_append(scope, dev);
 }
 
+static void build_acpi0017(Aml *table)
+{
+    Aml *dev, *scope, *method;
+
+    scope =  aml_scope("_SB");
+    dev = aml_device("CXLM");
+    aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0017")));
+
+    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_return(aml_int(0x0B)));
+    aml_append(dev, method);
+    build_cxl_dsm_method(dev);
+
+    aml_append(scope, dev);
+    aml_append(table, scope);
+}
+
 static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
                               uint32_t irq, VirtMachineState *vms)
 {
     int ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
+    bool cxl_present = false;
+    PCIBus *bus = vms->bus;
     struct GPEXConfig cfg = {
         .mmio32 = memmap[VIRT_PCIE_MMIO],
         .pio    = memmap[VIRT_PCIE_PIO],
@@ -136,6 +157,14 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     }
 
     acpi_dsdt_add_gpex(scope, &cfg);
+    QLIST_FOREACH(bus, &vms->bus->child, sibling) {
+        if (pci_bus_is_cxl(bus)) {
+            cxl_present = true;
+        }
+    }
+    if (cxl_present) {
+        build_acpi0017(scope);
+    }
 }
 
 static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
@@ -967,6 +996,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
         }
     }
 
+    if (vms->cxl_devices_state.is_enabled) {
+        cxl_build_cedt(table_offsets, tables_blob, tables->linker,
+                       vms->oem_id, vms->oem_table_id, &vms->cxl_devices_state);
+    }
+
     if (ms->nvdimms_state->is_enabled) {
         nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
                           ms->nvdimms_state, ms->ram_slots, vms->oem_id,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99e0a68b6c..cc16a5750d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -56,6 +56,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/core/sysbus-fdt.h"
 #include "hw/platform-bus.h"
@@ -84,6 +85,8 @@
 #include "hw/virtio/virtio-md-pci.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 
 static GlobalProperty arm_virt_compat[] = {
@@ -211,6 +214,7 @@ static const MemMapEntry base_memmap[] = {
 static MemMapEntry extended_memmap[] = {
     /* Additional 64 MB redist region (can contain up to 512 redistributors) */
     [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
+    [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */
     [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
     /* Second PCIe window */
     [VIRT_HIGH_PCIE_MMIO] =     { 0x0, 512 * GiB },
@@ -1615,6 +1619,17 @@ static void create_pcie(VirtMachineState *vms)
     }
 }
 
+static void create_cxl_host_reg_region(VirtMachineState *vms)
+{
+    MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *mr = &vms->cxl_devices_state.host_mr;
+
+    memory_region_init(mr, OBJECT(vms), "cxl_host_reg",
+                       vms->memmap[VIRT_CXL_HOST].size);
+    memory_region_add_subregion(sysmem, vms->memmap[VIRT_CXL_HOST].base, mr);
+    vms->highmem_cxl = true;
+}
+
 static void create_platform_bus(VirtMachineState *vms)
 {
     DeviceState *dev;
@@ -1733,6 +1748,12 @@ void virt_machine_done(Notifier *notifier, void *data)
     struct arm_boot_info *info = &vms->bootinfo;
     AddressSpace *as = arm_boot_address_space(cpu, info);
 
+    cxl_hook_up_pxb_registers(vms->bus, &vms->cxl_devices_state,
+                              &error_fatal);
+
+    if (vms->cxl_devices_state.is_enabled) {
+        cxl_fmws_link_targets(&vms->cxl_devices_state, &error_fatal);
+    }
     /*
      * If the user provided a dtb, we assume the dynamic sysbus nodes
      * already are integrated there. This corresponds to a use case where
@@ -1785,6 +1806,7 @@ static inline bool *virt_get_high_memmap_enabled(VirtMachineState *vms,
 {
     bool *enabled_array[] = {
         &vms->highmem_redists,
+        &vms->highmem_cxl,
         &vms->highmem_ecam,
         &vms->highmem_mmio,
     };
@@ -1892,6 +1914,27 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
     if (device_memory_size > 0) {
         machine_memory_devices_init(ms, device_memory_base, device_memory_size);
     }
+
+    if (vms->cxl_devices_state.fixed_windows) {
+        GList *it;
+
+        base = ROUND_UP(vms->highest_gpa + 1, 256 * MiB);
+        for (it = vms->cxl_devices_state.fixed_windows; it; it = it->next) {
+            CXLFixedWindow *fw = it->data;
+
+            if (base + fw->size <= BIT_ULL(pa_bits)) {
+                vms->highest_gpa = base + fw->size - 1;
+            } else {
+                error_report("CFMWS does not fit under PA limit");
+                exit(EXIT_FAILURE);
+            }
+
+            fw->base = base;
+            memory_region_init_io(&fw->mr, OBJECT(vms), &cfmws_ops, fw,
+                                  "cxl-fixed-memory-region", fw->size);
+            base += fw->size;
+        }
+    }
 }
 
 static VirtGICType finalize_gic_version_do(const char *accel_name,
@@ -2346,6 +2389,15 @@ static void machvirt_init(MachineState *machine)
     memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
                                 machine->ram);
 
+    if (vms->cxl_devices_state.fixed_windows) {
+        GList *it;
+        for (it = vms->cxl_devices_state.fixed_windows; it; it = it->next) {
+            CXLFixedWindow *fw = it->data;
+
+            memory_region_add_subregion(sysmem, fw->base, &fw->mr);
+        }
+    }
+
     virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
 
     create_gic(vms, sysmem);
@@ -2401,6 +2453,7 @@ static void machvirt_init(MachineState *machine)
     create_rtc(vms);
 
     create_pcie(vms);
+    create_cxl_host_reg_region(vms);
 
     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
@@ -3332,6 +3385,7 @@ static void virt_instance_init(Object *obj)
 
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
+    cxl_machine_init(obj, &vms->cxl_devices_state);
 }
 
 static const TypeInfo virt_machine_info = {
-- 
2.43.0


