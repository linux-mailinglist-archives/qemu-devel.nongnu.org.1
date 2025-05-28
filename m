Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C78BAAC6825
	for <lists+qemu-devel@lfdr.de>; Wed, 28 May 2025 13:09:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKEea-0004WF-Sn; Wed, 28 May 2025 07:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uKEeD-0004Aa-Et; Wed, 28 May 2025 07:08:40 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uKEeA-0001V0-9k; Wed, 28 May 2025 07:08:36 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b6mvb3Kxgz6M4t6;
 Wed, 28 May 2025 19:08:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id EFBEC1404F4;
 Wed, 28 May 2025 19:08:29 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 May 2025 13:08:29 +0200
To: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
 <peter.maydell@linaro.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, 
 Yuquan Wang <wangyuquan1236@phytium.com.cn>, Itaru Kitayama
 <itaru.kitayama@linux.dev>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>
Subject: [PATCH v14 2/5] hw/cxl: Make the CXL fixed memory windows devices.
Date: Wed, 28 May 2025 12:07:23 +0100
Message-ID: <20250528110726.226389-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
References: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

Previously these somewhat device like structures were tracked using a list
in the CXLState in each machine.  This is proving restrictive in a few
cases where we need to iterate through these without being aware of the
machine type. Just make them sysbus devices.

Restrict them to not user created as they need to be visible to early
stages of machine init given effects on the memory map.

This change both simplifies state tracking and enables features needed
for performance optimization and hotness tracking by making it possible
to retrieve the fixed memory window on actions elsewhere in the topology.

In some cases the ordering of the Fixed Memory Windows matters.
For those utility functions provide a GSList sorted by the window index.
This ensures that we get consistency across:
- ordering in the command line
- ordering of the host PA ranges
- ordering of ACPI CEDT structures describing the CFMWS.

Other aspects don't have this constraint. For those direct iteration
of the underlying hash structures is fine.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v14: Drop some unnecessary checks on device type. (Zhijian)
     Use explicit pointer types given we know what they are at the caller.
     - cedt_build_cfmws
     - cxl_fmws_update
     Cleanup a few things that are left overs from earlier approaches:
     - Don't return unnecessarily at end of functions.
     - Drop return values that are unused and always zero.

I think Peter Maydell suggested this a long time back when
the original CXL support series was under review but not 100% sure.
---
 include/hw/cxl/cxl.h      |   3 +
 include/hw/cxl/cxl_host.h |   4 +-
 hw/acpi/cxl.c             |  76 ++++++++++----------
 hw/cxl/cxl-host-stubs.c   |   6 +-
 hw/cxl/cxl-host.c         | 148 ++++++++++++++++++++++++++++++--------
 hw/i386/pc.c              |  51 ++++++-------
 6 files changed, 194 insertions(+), 94 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index b2bcce7ed6..a610795c87 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -27,6 +27,7 @@
 typedef struct PXBCXLDev PXBCXLDev;
 
 typedef struct CXLFixedWindow {
+    SysBusDevice parent_obj;
     int index;
     uint64_t size;
     char **targets;
@@ -38,6 +39,8 @@ typedef struct CXLFixedWindow {
     MemoryRegion mr;
     hwaddr base;
 } CXLFixedWindow;
+#define TYPE_CXL_FMW "cxl-fmw"
+OBJECT_DECLARE_SIMPLE_TYPE(CXLFixedWindow, CXL_FMW)
 
 typedef struct CXLState {
     bool is_enabled;
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index c9bc9c7c50..6dce2cde07 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -14,8 +14,10 @@
 #define CXL_HOST_H
 
 void cxl_machine_init(Object *obj, CXLState *state);
-void cxl_fmws_link_targets(CXLState *stat, Error **errp);
+void cxl_fmws_link_targets(Error **errp);
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
+hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr);
+GSList *cxl_fmws_get_all_sorted(void);
 
 extern const MemoryRegionOps cfmws_ops;
 
diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 9cd7905ea2..75d5b30bb8 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -22,6 +22,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 #include "hw/mem/memory-device.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
@@ -135,55 +136,52 @@ static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
  * Interleave ways encoding in CXL 2.0 ECN: 3, 6, 12 and 16-way memory
  * interleaving.
  */
-static void cedt_build_cfmws(GArray *table_data, CXLState *cxls)
+static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
 {
-    GList *it;
+    GArray *table_data = cedt->buf;
+    int i;
 
-    for (it = cxls->fixed_windows; it; it = it->next) {
-        CXLFixedWindow *fw = it->data;
-        int i;
-
-        /* Type */
-        build_append_int_noprefix(table_data, 1, 1);
+    /* Type */
+    build_append_int_noprefix(table_data, 1, 1);
 
-        /* Reserved */
-        build_append_int_noprefix(table_data, 0, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 1);
 
-        /* Record Length */
-        build_append_int_noprefix(table_data, 36 + 4 * fw->num_targets, 2);
+    /* Record Length */
+    build_append_int_noprefix(table_data, 36 + 4 * fw->num_targets, 2);
 
-        /* Reserved */
-        build_append_int_noprefix(table_data, 0, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
 
-        /* Base HPA */
-        build_append_int_noprefix(table_data, fw->mr.addr, 8);
+    /* Base HPA */
+    build_append_int_noprefix(table_data, fw->mr.addr, 8);
 
-        /* Window Size */
-        build_append_int_noprefix(table_data, fw->size, 8);
+    /* Window Size */
+    build_append_int_noprefix(table_data, fw->size, 8);
 
-        /* Host Bridge Interleave Ways */
-        build_append_int_noprefix(table_data, fw->enc_int_ways, 1);
+    /* Host Bridge Interleave Ways */
+    build_append_int_noprefix(table_data, fw->enc_int_ways, 1);
 
-        /* Host Bridge Interleave Arithmetic */
-        build_append_int_noprefix(table_data, 0, 1);
+    /* Host Bridge Interleave Arithmetic */
+    build_append_int_noprefix(table_data, 0, 1);
 
-        /* Reserved */
-        build_append_int_noprefix(table_data, 0, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
 
-        /* Host Bridge Interleave Granularity */
-        build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
+    /* Host Bridge Interleave Granularity */
+    build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
 
-        /* Window Restrictions */
-        build_append_int_noprefix(table_data, 0x0f, 2); /* No restrictions */
+    /* Window Restrictions */
+    build_append_int_noprefix(table_data, 0x0f, 2);
 
-        /* QTG ID */
-        build_append_int_noprefix(table_data, 0, 2);
+    /* QTG ID */
+    build_append_int_noprefix(table_data, 0, 2);
 
-        /* Host Bridge List (list of UIDs - currently bus_nr) */
-        for (i = 0; i < fw->num_targets; i++) {
-            g_assert(fw->target_hbs[i]);
-            build_append_int_noprefix(table_data, PXB_DEV(fw->target_hbs[i])->bus_nr, 4);
-        }
+    /* Host Bridge List (list of UIDs - currently bus_nr) */
+    for (i = 0; i < fw->num_targets; i++) {
+        g_assert(fw->target_hbs[i]);
+        build_append_int_noprefix(table_data,
+                                  PXB_DEV(fw->target_hbs[i])->bus_nr, 4);
     }
 }
 
@@ -202,6 +200,7 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
                     BIOSLinker *linker, const char *oem_id,
                     const char *oem_table_id, CXLState *cxl_state)
 {
+    GSList *cfmws_list, *iter;
     Aml *cedt;
     AcpiTable table = { .sig = "CEDT", .rev = 1, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
@@ -213,7 +212,12 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
     /* reserve space for CEDT header */
 
     object_child_foreach_recursive(object_get_root(), cxl_foreach_pxb_hb, cedt);
-    cedt_build_cfmws(cedt->buf, cxl_state);
+
+    cfmws_list = cxl_fmws_get_all_sorted();
+    for (iter = cfmws_list; iter; iter = iter->next) {
+        cedt_build_cfmws(CXL_FMW(iter->data), cedt);
+    }
+    g_slist_free(cfmws_list);
 
     /* copy AML table into ACPI tables blob and patch header there */
     g_array_append_vals(table_data, cedt->buf->data, cedt->buf->len);
diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index cae4afcdde..13eb6bf6a4 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -8,8 +8,12 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
 
-void cxl_fmws_link_targets(CXLState *stat, Error **errp) {};
+void cxl_fmws_link_targets(Error **errp) {};
 void cxl_machine_init(Object *obj, CXLState *state) {};
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
+hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
+{
+    return base;
+};
 
 const MemoryRegionOps cfmws_ops;
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index b7aa429ddf..016a4fdc6a 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -22,12 +22,12 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
 
-static void cxl_fixed_memory_window_config(CXLState *cxl_state,
-                                           CXLFixedMemoryWindowOptions *object,
+static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
                                            int index, Error **errp)
 {
     ERRP_GUARD();
-    g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
+    DeviceState *dev = qdev_new(TYPE_CXL_FMW);
+    CXLFixedWindow *fw = CXL_FMW(dev);
     strList *target;
     int i;
 
@@ -67,35 +67,39 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
         fw->targets[i] = g_strdup(target->value);
     }
 
-    cxl_state->fixed_windows = g_list_append(cxl_state->fixed_windows,
-                                             g_steal_pointer(&fw));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);
 }
 
-void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
+static int cxl_fmws_link(Object *obj, void *opaque)
 {
-    if (cxl_state && cxl_state->fixed_windows) {
-        GList *it;
-
-        for (it = cxl_state->fixed_windows; it; it = it->next) {
-            CXLFixedWindow *fw = it->data;
-            int i;
-
-            for (i = 0; i < fw->num_targets; i++) {
-                Object *o;
-                bool ambig;
-
-                o = object_resolve_path_type(fw->targets[i],
-                                             TYPE_PXB_CXL_DEV,
-                                             &ambig);
-                if (!o) {
-                    error_setg(errp, "Could not resolve CXLFM target %s",
-                               fw->targets[i]);
-                    return;
-                }
-                fw->target_hbs[i] = PXB_CXL_DEV(o);
-            }
+    struct CXLFixedWindow *fw;
+    int i;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
+    }
+    fw = CXL_FMW(obj);
+
+    for (i = 0; i < fw->num_targets; i++) {
+        Object *o;
+        bool ambig;
+
+        o = object_resolve_path_type(fw->targets[i], TYPE_PXB_CXL_DEV,
+                                     &ambig);
+        if (!o) {
+            error_setg(&error_fatal, "Could not resolve CXLFM target %s",
+                       fw->targets[i]);
+            return 1;
         }
+        fw->target_hbs[i] = PXB_CXL_DEV(o);
     }
+    return 0;
+}
+
+void cxl_fmws_link_targets(Error **errp)
+{
+    /* Order doesn't matter for this, so no need to build list */
+    object_child_foreach_recursive(object_get_root(), cxl_fmws_link, NULL);
 }
 
 static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
@@ -335,7 +339,7 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
     }
 
     for (it = cfmw_list, index = 0; it; it = it->next, index++) {
-        cxl_fixed_memory_window_config(state, it->value, index, errp);
+        cxl_fixed_memory_window_config(it->value, index, errp);
     }
     state->cfmw_list = cfmw_list;
 }
@@ -373,3 +377,91 @@ void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp)
         }
     }
 }
+
+static void cxl_fmws_update(CXLFixedWindow *fw, hwaddr *base, hwaddr max_addr)
+{
+    if (*base + fw->size <= max_addr) {
+        fw->base = *base;
+        sysbus_mmio_map(SYS_BUS_DEVICE(fw), 0, fw->base);
+        *base += fw->size;
+    }
+}
+
+static int cxl_fmws_find(Object *obj, void *opaque)
+{
+    GSList **list = opaque;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
+    }
+    *list = g_slist_prepend(*list, obj);
+
+    return 0;
+}
+
+static GSList *cxl_fmws_get_all(void)
+{
+    GSList *list = NULL;
+
+    object_child_foreach_recursive(object_get_root(), cxl_fmws_find, &list);
+
+    return list;
+}
+
+static gint cfmws_cmp(gconstpointer a, gconstpointer b, gpointer d)
+{
+    const struct CXLFixedWindow *ap = a;
+    const struct CXLFixedWindow *bp = b;
+
+    return ap->index > bp->index;
+}
+
+GSList *cxl_fmws_get_all_sorted(void)
+{
+    return g_slist_sort_with_data(cxl_fmws_get_all(), cfmws_cmp, NULL);
+}
+
+hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
+{
+    GSList *cfmws_list, *iter;
+
+    cfmws_list = cxl_fmws_get_all_sorted();
+    for (iter = cfmws_list; iter; iter = iter->next) {
+        cxl_fmws_update(CXL_FMW(iter->data), &base, max_addr);
+    }
+    g_slist_free(cfmws_list);
+
+    return base;
+}
+
+static void cxl_fmw_realize(DeviceState *dev, Error **errp)
+{
+    CXLFixedWindow *fw = CXL_FMW(dev);
+
+    memory_region_init_io(&fw->mr, OBJECT(dev), &cfmws_ops, fw,
+                          "cxl-fixed-memory-region", fw->size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &fw->mr);
+}
+
+static void cxl_fmw_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "CXL Fixed Memory Window";
+    dc->realize = cxl_fmw_realize;
+    /* Reason - created by machines as tightly coupled to machine memory map */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo cxl_fmw_info = {
+    .name = TYPE_CXL_FMW,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(CXLFixedWindow),
+    .class_init = cxl_fmw_class_init,
+};
+
+static void cxl_host_register_types(void)
+{
+    type_register_static(&cxl_fmw_info);
+}
+type_init(cxl_host_register_types)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 70656157ca..9978398876 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -630,7 +630,7 @@ void pc_machine_done(Notifier *notifier, void *data)
                               &error_fatal);
 
     if (pcms->cxl_devices_state.is_enabled) {
-        cxl_fmws_link_targets(&pcms->cxl_devices_state, &error_fatal);
+        cxl_fmws_link_targets(&error_fatal);
     }
 
     /* set the number of CPUs */
@@ -739,20 +739,28 @@ static uint64_t pc_get_cxl_range_start(PCMachineState *pcms)
     return cxl_base;
 }
 
-static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
+static int cxl_get_fmw_end(Object *obj, void *opaque)
 {
-    uint64_t start = pc_get_cxl_range_start(pcms) + MiB;
+    struct CXLFixedWindow *fw;
+    uint64_t *start = opaque;
 
-    if (pcms->cxl_devices_state.fixed_windows) {
-        GList *it;
-
-        start = ROUND_UP(start, 256 * MiB);
-        for (it = pcms->cxl_devices_state.fixed_windows; it; it = it->next) {
-            CXLFixedWindow *fw = it->data;
-            start += fw->size;
-        }
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
     }
+    fw = CXL_FMW(obj);
+
+    *start += fw->size;
 
+    return 0;
+}
+
+static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
+{
+    uint64_t start = pc_get_cxl_range_start(pcms) + MiB;
+
+    /* Ordering doesn't matter so no need to build a sorted list */
+    object_child_foreach_recursive(object_get_root(), cxl_get_fmw_end,
+                                   &start);
     return start;
 }
 
@@ -954,23 +962,10 @@ void pc_memory_init(PCMachineState *pcms,
         cxl_base = pc_get_cxl_range_start(pcms);
         memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
         memory_region_add_subregion(system_memory, cxl_base, mr);
-        cxl_resv_end = cxl_base + cxl_size;
-        if (pcms->cxl_devices_state.fixed_windows) {
-            hwaddr cxl_fmw_base;
-            GList *it;
-
-            cxl_fmw_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
-            for (it = pcms->cxl_devices_state.fixed_windows; it; it = it->next) {
-                CXLFixedWindow *fw = it->data;
-
-                fw->base = cxl_fmw_base;
-                memory_region_init_io(&fw->mr, OBJECT(machine), &cfmws_ops, fw,
-                                      "cxl-fixed-memory-region", fw->size);
-                memory_region_add_subregion(system_memory, fw->base, &fw->mr);
-                cxl_fmw_base += fw->size;
-                cxl_resv_end = cxl_fmw_base;
-            }
-        }
+        cxl_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
+
+        cxl_resv_end = cxl_fmws_set_memmap_and_update_mmio(cxl_base,
+                                                           maxphysaddr);
     }
 
     /* Initialize PC system firmware */
-- 
2.48.1


