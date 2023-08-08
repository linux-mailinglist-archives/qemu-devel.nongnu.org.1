Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8622C7739FE
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 14:00:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTLNQ-00054G-0K; Tue, 08 Aug 2023 07:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qTLNO-0004wZ-4d
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:59:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qTLNL-0001k3-OK
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:59:49 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKs8m0cXFz6J6jD;
 Tue,  8 Aug 2023 19:56:08 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 12:59:45 +0100
To: <qemu-devel@nongnu.org>
CC: Gavin Shan <gshan@redhat.com>, <linuxarm@huawei.com>, James Morse
 <james.morse@arm.com>, "peter . maydell @ linaro . org"
 <peter.maydell@linaro.org>, <zhao1.liu@linux.intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Shameerali Kolothum
 Thodi <shameerali.kolothum.thodi@huawei.com>, Yicong Yang
 <yangyicong@huawei.com>
Subject: [RFC PATCH 5/5] hw/arm/virt: Add MPAM MSCs for memory controllers and
 caches.
Date: Tue, 8 Aug 2023 12:57:13 +0100
Message-ID: <20230808115713.2613-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808115713.2613-1-Jonathan.Cameron@huawei.com>
References: <20230808115713.2613-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Allow sharing of MSC instances (using RIS) for memory controllers.
Currently cached controllers are not using RIS (tend to be more
in a system so more clever logic needed to auto allocate them).

No DT support yet.  The kernel bindings are considered unstable
so premature to add too much on that front.

Note that for now MPAM MSC creation is dependent on having SRAT
and hence you need some numa nodes defined.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/arm/mpam.h    |   1 +
 hw/arm/virt-acpi-build.c | 197 +++++++++++++++++++++++++++++++++++++++
 hw/arm/virt.c            | 134 ++++++++++++++++++++++++++
 3 files changed, 332 insertions(+)

diff --git a/include/hw/arm/mpam.h b/include/hw/arm/mpam.h
index 7bd88d57bc..8f47c8806f 100644
--- a/include/hw/arm/mpam.h
+++ b/include/hw/arm/mpam.h
@@ -7,6 +7,7 @@
 #define TYPE_MPAM_MSC_MEM "mpam-msc-mem"
 #define TYPE_MPAM_MSC_CACHE "mpam-msc-cache"
 
+#define MPAM_SIZE 0x4000 /* Big enough for anyone ;) */
 void mpam_cache_fill_info(Object *obj, MpamCacheInfo *info);
 
 #endif /* _MPAM_H_ */
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index ec8fdcefff..b14dce3722 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -49,6 +49,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/arm/virt.h"
+#include "hw/arm/mpam.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/platform-bus.h"
@@ -515,6 +516,198 @@ build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_table_end(linker, &table);
 }
 
+static void build_msc_memory_controller(GArray *table_data, int identifier,
+                                        hwaddr base_addr, uint32_t mpam_id,
+                                        int num_ris, uint64_t *nodes)
+{
+    int length = 72 + 24 * num_ris;
+    int i;
+
+    build_append_int_noprefix(table_data, length, 2);
+    /* Interface Type */
+    build_append_int_noprefix(table_data, 0 /* MMIO */, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 1);
+    build_append_int_noprefix(table_data, identifier, 4);
+    build_append_int_noprefix(table_data, base_addr, 8);
+    build_append_int_noprefix(table_data, MPAM_SIZE, 4);
+    /* Overflow interrupt - HACK */
+    build_append_int_noprefix(table_data, 0x2C, 4);
+    /* Edge - SPI */
+    build_append_int_noprefix(table_data, 1, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Overflow Int Affinity - HACK */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Error interrupt - HACK */
+    build_append_int_noprefix(table_data, 0x2D, 4);
+    /* Edge - SPI */
+    build_append_int_noprefix(table_data, 1, 4);
+    /* More reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Error Int Affinity */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* MAX_NRDY_USEC */
+    build_append_int_noprefix(table_data, 100, 4);
+    /* Linked Device - none for now */
+    build_append_int_noprefix(table_data, 0, 8);
+    /* _UID of linked device */
+    build_append_int_noprefix(table_data, 0, 4);
+    build_append_int_noprefix(table_data, num_ris, 4);
+    /* Build a memory controller resouce */
+    for (i = 0; i < num_ris; i++) {
+        build_append_int_noprefix(table_data, mpam_id, 4);
+        build_append_int_noprefix(table_data, i, 1);
+        /* Reserved1 */
+        build_append_int_noprefix(table_data, 0, 2);
+        /* Locator type - 1 = Memory */
+        build_append_int_noprefix(table_data, 1, 1);
+        /* Locator part 1 Node */
+        build_append_int_noprefix(table_data, nodes[i], 8);
+        /* Locator part 2 reserved */
+        build_append_int_noprefix(table_data, 0, 4);
+        /* Num functional dependencies */
+        build_append_int_noprefix(table_data, 0, 4);
+    }
+}
+
+static void build_msc_cache_controller(GArray *table_data, int identifier,
+                                       hwaddr base_addr, uint32_t mpam_id,
+                                       int num_ris, uint64_t *cache_id)
+{
+    int length = 72 + 24 * num_ris;
+    int i;
+
+    build_append_int_noprefix(table_data, length, 2);
+    /* Interface Type */
+    build_append_int_noprefix(table_data, 0 /* MMIO */, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 1);
+    build_append_int_noprefix(table_data, identifier, 4);
+    build_append_int_noprefix(table_data, base_addr, 8);
+    build_append_int_noprefix(table_data, MPAM_SIZE, 4);
+    /* Overflow interrupt - HACK */
+    build_append_int_noprefix(table_data, 0x2C, 4);
+    /* Edge - SPI */
+    build_append_int_noprefix(table_data, 1, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Overflow Int Affinity */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Error interrupt - HACK */
+    build_append_int_noprefix(table_data, 0x2D, 4);
+    /* Edge - SPI */
+    build_append_int_noprefix(table_data, 1, 4);
+    /* More reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Error Int Affinity */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* MAX_NRDY_USEC */
+    build_append_int_noprefix(table_data, 100, 4);
+    /* Linked Device - none for now */
+    build_append_int_noprefix(table_data, 0, 8);
+    /* _UID of linked device */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Num resource nodes */
+    build_append_int_noprefix(table_data, num_ris, 4);
+    /* Build a memory controller resouce */
+    for (i = 0; i < num_ris; i++) {
+        /* Identifier */
+        build_append_int_noprefix(table_data, mpam_id, 4);
+        /* RIS index */
+        build_append_int_noprefix(table_data, i, 1);
+        /* Reserved1 */
+        build_append_int_noprefix(table_data, 0, 2);
+        /* Locator type - 0 = Cache */
+        build_append_int_noprefix(table_data, 0, 1);
+        /* Locator part 1 PPTT ID */
+        build_append_int_noprefix(table_data, cache_id[i], 8);
+        /* Locator part 2 reserved */
+        build_append_int_noprefix(table_data, 0, 4);
+        /* Num functional dependencies */
+        build_append_int_noprefix(table_data, 0, 4);
+    }
+}
+
+struct mpam_stat {
+    MachineState *ms;
+    GArray *table_data;
+    hwaddr base_addr;
+    int count;
+    int cpu_count;
+    uint32_t mpam_id; /* Just needs to be unique */
+};
+
+static int mpam_add_msc(Object *obj, void *opaque)
+{
+    if (object_dynamic_cast(obj, TYPE_MPAM_MSC_MEM)) {
+        struct mpam_stat *mpam_s = opaque;
+        SysBusDevice *s = SYS_BUS_DEVICE(obj);
+        int num_ris = object_property_get_uint(obj, "num-ris", &error_fatal);
+        uint64_t *ids = g_new0(uint64_t, num_ris);
+        int j = 0;
+        int i;
+
+        /* Fill them in based on which nodes have memory */
+        for (i = 0; i < mpam_s->ms->numa_state->num_nodes; i++) {
+            if (mpam_s->ms->numa_state->nodes[i].node_mem) {
+                ids[j++] = i;
+            }
+        }
+
+        build_msc_memory_controller(mpam_s->table_data, mpam_s->count,
+                                    s->mmio[0].addr, mpam_s->mpam_id++,
+                                    num_ris, ids);
+        mpam_s->count++;
+        g_free(ids);
+    }
+
+    if (object_dynamic_cast(obj, TYPE_MPAM_MSC_CACHE)) {
+        struct mpam_stat *mpam_s = opaque;
+        SysBusDevice *s = SYS_BUS_DEVICE(obj);
+        int num_ris = 1;
+        uint64_t *ids = g_new0(uint64_t, num_ris);
+        uint8_t cache_level = object_property_get_uint(obj, "cache-level",
+                                                       &error_fatal);
+        uint8_t cache_type = object_property_get_uint(obj, "cache-type",
+                                                      &error_fatal);
+        uint16_t cpu = object_property_get_uint(obj, "cpu", &error_fatal);
+
+        ids[0] = cpu | (cache_level << 16) | (cache_type << 24);
+        printf("MPAM has a cache with ID %lx\n", ids[0]);
+        build_msc_cache_controller(mpam_s->table_data, mpam_s->count,
+                                   s->mmio[0].addr, mpam_s->mpam_id++,
+                                   num_ris, ids);
+        mpam_s->count++;
+        g_free(ids);
+    }
+
+    return 0;
+}
+
+static void
+build_mpam(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
+{
+    AcpiTable table = {
+        .sig = "MPAM",
+        .rev = 1,
+        .oem_id = vms->oem_id,
+        .oem_table_id = vms->oem_table_id,
+    };
+    struct mpam_stat mpam_s = {
+        .ms = MACHINE(vms),
+        .count = 0,
+        .base_addr = vms->memmap[VIRT_MPAM_MSC].base,
+        .table_data = table_data,
+    };
+
+    acpi_table_begin(&table, table_data);
+
+    object_child_foreach_recursive(object_get_root(), mpam_add_msc, &mpam_s);
+
+    acpi_table_end(linker, &table);
+}
+
 /*
  * ACPI spec, Revision 5.1
  * 5.2.16 System Resource Affinity Table (SRAT)
@@ -1124,6 +1317,10 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
                        vms->oem_id, vms->oem_table_id);
         }
     }
+    if (vms->mpam) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_mpam(tables_blob, tables->linker, vms);
+    }
 
     if (ms->nvdimms_state->is_enabled) {
         nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7d9dbc2663..1ded7737f0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -79,6 +79,7 @@
 #include "hw/virtio/virtio-md-pci.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
+#include "hw/arm/mpam.h"
 #include "qemu/guest-random.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
@@ -156,6 +157,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
     [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
+    [VIRT_MPAM_MSC] =           { 0x0b006000, 0x00004000 * 256 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
     [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
@@ -1406,6 +1408,98 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
                            bdf + 1, vms->iommu_phandle, bdf + 1, 0xffff - bdf);
 }
 
+static void create_mpam_msc_cache(VirtMachineState *vms, int level,
+                                  hwaddr *base)
+{
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+    MachineClass *mc = MACHINE_CLASS(vmc);
+    MachineState *ms = MACHINE(vms);
+    const CPUArchIdList *cpu_list = mc->possible_cpu_arch_ids(ms);
+    DeviceState *dev;
+    int step, i;
+
+    /* First check if L2 is at socket level */
+    if (ms->smp.cache_node_start_level &&
+        ms->smp.cache_node_start_level <= level) {
+        step = cpu_list->len / ms->smp.sockets;
+        /* If not check cluster level */
+    } else if (ms->smp.cache_cluster_start_level <= level) {
+        step = cpu_list->len / ms->smp.clusters;
+        /* Must be private then (or non existent?) */
+    } else {
+        step = ms->smp.threads;
+    }
+
+    for (i = 0; i < cpu_list->len; i += step) {
+        dev = qdev_new(TYPE_MPAM_MSC_CACHE);
+        object_property_set_uint(OBJECT(dev), "num-ris", 1, &error_fatal);
+        object_property_set_uint(OBJECT(dev), "num-partid", 256, &error_fatal);
+        object_property_set_uint(OBJECT(dev), "num-int-partid", 32,
+                                 &error_fatal);
+        object_property_set_uint(OBJECT(dev), "cache-level", level,
+                                 &error_fatal);
+        object_property_set_uint(OBJECT(dev), "cache-type", UNIFIED,
+                                 &error_fatal);
+        object_property_set_uint(OBJECT(dev), "cpu", i, &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, *base);
+        *base += MPAM_SIZE;
+    }
+}
+
+static void create_mpam_msc(VirtMachineState *vms, Error **errp)
+{
+    MachineState *ms = MACHINE(vms);
+    DeviceState *dev;
+    int i, count = 0;
+    hwaddr base = vms->memmap[VIRT_MPAM_MSC].base;
+
+    if (ms->numa_state->num_nodes == 0) {
+        error_setg(errp,
+                   "MPAM support requires NUMA nodes to be specified");
+        return;
+    }
+    if (!vms->mpam_min_msc) {
+        for (i = 0; i < ms->numa_state->num_nodes; i++) {
+            if (ms->numa_state->nodes[i].node_mem > 0 && count < 16) {
+                dev = qdev_new(TYPE_MPAM_MSC_MEM);
+
+                object_property_set_uint(OBJECT(dev), "num-ris", 1,
+                                         &error_fatal);
+                object_property_set_uint(OBJECT(dev), "num-partid", 256,
+                                         &error_fatal);
+                object_property_set_uint(OBJECT(dev), "num-int-partid", 32,
+                                         &error_fatal);
+                sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+                sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+                base += MPAM_SIZE;
+            }
+        }
+    } else {
+        /* One MSC for all numa nodes with memory */
+        int count_with_mem = 0;
+
+        for (i = 0; i < ms->numa_state->num_nodes; i++) {
+            if (ms->numa_state->nodes[i].node_mem) {
+                count_with_mem++;
+            }
+        }
+        dev = qdev_new(TYPE_MPAM_MSC_MEM);
+        object_property_set_uint(OBJECT(dev), "num-ris", count_with_mem,
+                                 &error_fatal);
+        object_property_set_uint(OBJECT(dev), "num-partid", 256, &error_fatal);
+        object_property_set_uint(OBJECT(dev), "num-int-partid", 2,
+                                 &error_fatal);
+
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+        base += MPAM_SIZE;
+    }
+
+    create_mpam_msc_cache(vms, 3, &base);
+    create_mpam_msc_cache(vms, 2, &base);
+}
+
 static void create_pcie(VirtMachineState *vms)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
@@ -2280,6 +2374,10 @@ static void machvirt_init(MachineState *machine)
 
     create_pcie(vms);
 
+    if (vms->mpam) {
+        create_mpam_msc(vms, &error_fatal);
+    }
+
     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
     } else {
@@ -2457,6 +2555,34 @@ static void virt_set_dtb_randomness(Object *obj, bool value, Error **errp)
     vms->dtb_randomness = value;
 }
 
+static bool virt_get_mpam(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->mpam;
+}
+
+static void virt_set_mpam(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->mpam = value;
+}
+
+static bool virt_get_mpam_min_msc(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->mpam_min_msc;
+}
+
+static void virt_set_mpam_min_msc(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->mpam_min_msc = value;
+}
+
 static char *virt_get_oem_id(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -3053,6 +3179,14 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                           "guest CPU which implements the ARM "
                                           "Memory Tagging Extension");
 
+    object_class_property_add_bool(oc, "mpam", virt_get_mpam, virt_set_mpam);
+    object_class_property_set_description(oc, "mpam", "Enable MPAM");
+
+    object_class_property_add_bool(oc, "mpam-min-msc", virt_get_mpam_min_msc,
+                                   virt_set_mpam_min_msc);
+    object_class_property_set_description(oc, "mpam-min-msc",
+                                          "Use RIS to reduce MSCs exposed.");
+
     object_class_property_add_bool(oc, "its", virt_get_its,
                                    virt_set_its);
     object_class_property_set_description(oc, "its",
-- 
2.39.2


