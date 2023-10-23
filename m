Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6DE7D3D89
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 19:27:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quygL-0005re-Gx; Mon, 23 Oct 2023 13:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1quygI-0005qJ-TP
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 13:25:34 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1quygF-0007fu-14
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 13:25:34 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1quyg7-0002rM-LQ; Mon, 23 Oct 2023 19:25:23 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v8 5/9] Add Hyper-V Dynamic Memory Protocol driver
 (hv-balloon) hot-add support
Date: Mon, 23 Oct 2023 19:24:31 +0200
Message-ID: <b8d0346531f19ef379644a144e6ca3fb4542fff1.1698064312.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698064312.git.maciej.szmigiero@oracle.com>
References: <cover.1698064312.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

One of advantages of using this protocol over ACPI-based PC DIMM hotplug is
that it allows hot-adding memory in much smaller granularity because the
ACPI DIMM slot limit does not apply.

In order to enable this functionality a new memory backend needs to be
created and provided to the driver via the "memdev" parameter.

This can be achieved by, for example, adding
"-object memory-backend-ram,id=mem1,size=32G" to the QEMU command line and
then instantiating the driver with "memdev=mem1" parameter.

The device will try to use multiple memslots to cover the memory backend in
order to reduce the size of metadata for the not-yet-hot-added part of the
memory backend.

Co-developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/hyperv/hv-balloon-our_range_memslots.c | 201 ++++++++
 hw/hyperv/hv-balloon-our_range_memslots.h | 110 +++++
 hw/hyperv/hv-balloon.c                    | 566 +++++++++++++++++++++-
 hw/hyperv/meson.build                     |   2 +-
 hw/hyperv/trace-events                    |   5 +
 5 files changed, 878 insertions(+), 6 deletions(-)
 create mode 100644 hw/hyperv/hv-balloon-our_range_memslots.c
 create mode 100644 hw/hyperv/hv-balloon-our_range_memslots.h

diff --git a/hw/hyperv/hv-balloon-our_range_memslots.c b/hw/hyperv/hv-balloon-our_range_memslots.c
new file mode 100644
index 000000000000..99bae870f371
--- /dev/null
+++ b/hw/hyperv/hv-balloon-our_range_memslots.c
@@ -0,0 +1,201 @@
+/*
+ * QEMU Hyper-V Dynamic Memory Protocol driver
+ *
+ * Copyright (C) 2020-2023 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "hv-balloon-internal.h"
+#include "hv-balloon-our_range_memslots.h"
+#include "trace.h"
+
+/* OurRange */
+static void our_range_init(OurRange *our_range, uint64_t start, uint64_t count)
+{
+    assert(count <= UINT64_MAX - start);
+    our_range->range.start = start;
+    our_range->range.count = count;
+
+    hvb_page_range_tree_init(&our_range->removed_guest);
+    hvb_page_range_tree_init(&our_range->removed_both);
+
+    /* mark the whole range as unused but for potential use */
+    our_range->added = 0;
+    our_range->unusable_tail = 0;
+}
+
+static void our_range_destroy(OurRange *our_range)
+{
+    hvb_page_range_tree_destroy(&our_range->removed_guest);
+    hvb_page_range_tree_destroy(&our_range->removed_both);
+}
+
+void hvb_our_range_clear_removed_trees(OurRange *our_range)
+{
+    hvb_page_range_tree_destroy(&our_range->removed_guest);
+    hvb_page_range_tree_destroy(&our_range->removed_both);
+    hvb_page_range_tree_init(&our_range->removed_guest);
+    hvb_page_range_tree_init(&our_range->removed_both);
+}
+
+void hvb_our_range_mark_added(OurRange *our_range, uint64_t additional_size)
+{
+    assert(additional_size <= UINT64_MAX - our_range->added);
+
+    our_range->added += additional_size;
+
+    assert(our_range->added <= UINT64_MAX - our_range->unusable_tail);
+    assert(our_range->added + our_range->unusable_tail <=
+           our_range->range.count);
+}
+
+/* OurRangeMemslots */
+static void our_range_memslots_init_slots(OurRangeMemslots *our_range,
+                                          MemoryRegion *backing_mr,
+                                          Object *memslot_owner)
+{
+    OurRangeMemslotsSlots *memslots = &our_range->slots;
+    unsigned int idx;
+    uint64_t memslot_offset;
+
+    assert(memslots->count > 0);
+    memslots->slots = g_new0(MemoryRegion, memslots->count);
+
+    /* Initialize our memslots, but don't map them yet. */
+    assert(memslots->size_each > 0);
+    for (idx = 0, memslot_offset = 0; idx < memslots->count;
+         idx++, memslot_offset += memslots->size_each) {
+        uint64_t memslot_size;
+        g_autofree char *name = NULL;
+
+        /* The size of the last memslot might be smaller. */
+        if (idx == memslots->count - 1) {
+            uint64_t region_size;
+
+            assert(our_range->mr);
+            region_size = memory_region_size(our_range->mr);
+            memslot_size = region_size - memslot_offset;
+        } else {
+            memslot_size = memslots->size_each;
+        }
+
+        name = g_strdup_printf("memslot-%u", idx);
+        memory_region_init_alias(&memslots->slots[idx], memslot_owner, name,
+                                 backing_mr, memslot_offset, memslot_size);
+        /*
+         * We want to be able to atomically and efficiently activate/deactivate
+         * individual memslots without affecting adjacent memslots in memory
+         * notifiers.
+         */
+        memory_region_set_unmergeable(&memslots->slots[idx], true);
+    }
+
+    memslots->mapped_count = 0;
+}
+
+OurRangeMemslots *hvb_our_range_memslots_new(uint64_t addr,
+                                             MemoryRegion *parent_mr,
+                                             MemoryRegion *backing_mr,
+                                             Object *memslot_owner,
+                                             unsigned int memslot_count,
+                                             uint64_t memslot_size)
+{
+    OurRangeMemslots *our_range;
+
+    our_range = g_malloc(sizeof(*our_range));
+    our_range_init(&our_range->range,
+                   addr / HV_BALLOON_PAGE_SIZE,
+                   memory_region_size(parent_mr) / HV_BALLOON_PAGE_SIZE);
+    our_range->slots.size_each = memslot_size;
+    our_range->slots.count = memslot_count;
+    our_range->mr = parent_mr;
+    our_range_memslots_init_slots(our_range, backing_mr, memslot_owner);
+
+    return our_range;
+}
+
+static void our_range_memslots_free_memslots(OurRangeMemslots *our_range)
+{
+    OurRangeMemslotsSlots *memslots = &our_range->slots;
+    unsigned int idx;
+    uint64_t offset;
+
+    memory_region_transaction_begin();
+    for (idx = 0, offset = 0; idx < memslots->mapped_count;
+         idx++, offset += memslots->size_each) {
+        trace_hv_balloon_unmap_slot(idx, memslots->count, offset);
+        assert(memory_region_is_mapped(&memslots->slots[idx]));
+        memory_region_del_subregion(our_range->mr, &memslots->slots[idx]);
+    }
+    memory_region_transaction_commit();
+
+    for (idx = 0; idx < memslots->count; idx++) {
+        object_unparent(OBJECT(&memslots->slots[idx]));
+    }
+
+    g_clear_pointer(&our_range->slots.slots, g_free);
+}
+
+void hvb_our_range_memslots_free(OurRangeMemslots *our_range)
+{
+    OurRangeMemslotsSlots *memslots = &our_range->slots;
+    MemoryRegion *hostmem_mr;
+    RAMBlock *rb;
+
+    assert(our_range->slots.count > 0);
+    assert(our_range->slots.slots);
+
+    hostmem_mr = memslots->slots[0].alias;
+    rb = hostmem_mr->ram_block;
+    ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb));
+
+    our_range_memslots_free_memslots(our_range);
+    our_range_destroy(&our_range->range);
+    g_free(our_range);
+}
+
+void hvb_our_range_memslots_ensure_mapped_additional(OurRangeMemslots *our_range,
+                                                     uint64_t additional_map_size)
+{
+    OurRangeMemslotsSlots *memslots = &our_range->slots;
+    uint64_t total_map_size;
+    unsigned int idx;
+    uint64_t offset;
+
+    total_map_size = (our_range->range.added + additional_map_size) *
+        HV_BALLOON_PAGE_SIZE;
+    idx = memslots->mapped_count;
+    assert(memslots->size_each > 0);
+    offset = idx * memslots->size_each;
+
+    /*
+     * Activate all memslots covered by the newly added region in a single
+     * transaction.
+     */
+    memory_region_transaction_begin();
+    for ( ; idx < memslots->count;
+          idx++, offset += memslots->size_each) {
+        /*
+         * If this memslot starts beyond or at the end of the range to map so
+         * does every next one.
+         */
+        if (offset >= total_map_size) {
+            break;
+        }
+
+        /*
+         * Instead of enabling/disabling memslot, we add/remove them. This
+         * should make address space updates faster, because we don't have to
+         * loop over many disabled subregions.
+         */
+        trace_hv_balloon_map_slot(idx, memslots->count, offset);
+        assert(!memory_region_is_mapped(&memslots->slots[idx]));
+        memory_region_add_subregion(our_range->mr, offset,
+                                    &memslots->slots[idx]);
+
+        memslots->mapped_count++;
+    }
+    memory_region_transaction_commit();
+}
diff --git a/hw/hyperv/hv-balloon-our_range_memslots.h b/hw/hyperv/hv-balloon-our_range_memslots.h
new file mode 100644
index 000000000000..b6f592d34b09
--- /dev/null
+++ b/hw/hyperv/hv-balloon-our_range_memslots.h
@@ -0,0 +1,110 @@
+/*
+ * QEMU Hyper-V Dynamic Memory Protocol driver
+ *
+ * Copyright (C) 2020-2023 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_HYPERV_HV_BALLOON_OUR_RANGE_MEMSLOTS_H
+#define HW_HYPERV_HV_BALLOON_OUR_RANGE_MEMSLOTS_H
+
+#include "qemu/osdep.h"
+
+#include "exec/memory.h"
+#include "qom/object.h"
+#include "hv-balloon-page_range_tree.h"
+
+/* OurRange */
+#define OUR_RANGE(ptr) ((OurRange *)(ptr))
+
+/* "our range" means the memory range owned by this driver (for hot-adding) */
+typedef struct OurRange {
+    PageRange range;
+
+    /* How many pages were hot-added to the guest */
+    uint64_t added;
+
+    /* Pages at the end not currently usable */
+    uint64_t unusable_tail;
+
+    /* Memory removed from the guest */
+    PageRangeTree removed_guest, removed_both;
+} OurRange;
+
+static inline uint64_t our_range_get_remaining_start(OurRange *our_range)
+{
+    return our_range->range.start + our_range->added;
+}
+
+static inline uint64_t our_range_get_remaining_size(OurRange *our_range)
+{
+    return our_range->range.count - our_range->added - our_range->unusable_tail;
+}
+
+void hvb_our_range_mark_added(OurRange *our_range, uint64_t additional_size);
+
+static inline void our_range_mark_remaining_unusable(OurRange *our_range)
+{
+    our_range->unusable_tail = our_range->range.count - our_range->added;
+}
+
+static inline PageRangeTree our_range_get_removed_tree(OurRange *our_range,
+                                                       bool both)
+{
+    if (both) {
+        return our_range->removed_both;
+    } else {
+        return our_range->removed_guest;
+    }
+}
+
+static inline bool our_range_is_removed_tree_empty(OurRange *our_range,
+                                                   bool both)
+{
+    if (both) {
+        return page_range_tree_is_empty(our_range->removed_both);
+    } else {
+        return page_range_tree_is_empty(our_range->removed_guest);
+    }
+}
+
+void hvb_our_range_clear_removed_trees(OurRange *our_range);
+
+/* OurRangeMemslots */
+typedef struct OurRangeMemslotsSlots {
+    /* Nominal size of each memslot (the last one might be smaller) */
+    uint64_t size_each;
+
+    /* Slots array and its element count */
+    MemoryRegion *slots;
+    unsigned int count;
+
+    /* How many slots are currently mapped */
+    unsigned int mapped_count;
+} OurRangeMemslotsSlots;
+
+typedef struct OurRangeMemslots {
+    OurRange range;
+
+    /* Memslots covering our range */
+    OurRangeMemslotsSlots slots;
+
+    MemoryRegion *mr;
+} OurRangeMemslots;
+
+OurRangeMemslots *hvb_our_range_memslots_new(uint64_t addr,
+                                             MemoryRegion *parent_mr,
+                                             MemoryRegion *backing_mr,
+                                             Object *memslot_owner,
+                                             unsigned int memslot_count,
+                                             uint64_t memslot_size);
+void hvb_our_range_memslots_free(OurRangeMemslots *our_range);
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(OurRangeMemslots, hvb_our_range_memslots_free)
+
+void hvb_our_range_memslots_ensure_mapped_additional(OurRangeMemslots *our_range,
+                                                     uint64_t additional_map_size);
+
+#endif
diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 8d49295da3a4..4d87f99375b5 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -34,9 +34,12 @@
 #include "sysemu/balloon.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/reset.h"
+#include "hv-balloon-our_range_memslots.h"
 #include "hv-balloon-page_range_tree.h"
 #include "trace.h"
 
+#define HV_BALLOON_ADDR_PROP "addr"
+#define HV_BALLOON_MEMDEV_PROP "memdev"
 #define HV_BALLOON_GUID "525074DC-8985-46e2-8057-A307DC18A502"
 
 /*
@@ -52,6 +55,8 @@
 #define HV_BALLOON_HA_CHUNK_SIZE (2 * GiB)
 #define HV_BALLOON_HA_CHUNK_PAGES (HV_BALLOON_HA_CHUNK_SIZE / HV_BALLOON_PAGE_SIZE)
 
+#define HV_BALLOON_HA_MEMSLOT_SIZE_ALIGN (128 * MiB)
+
 #define HV_BALLOON_HR_CHUNK_PAGES 585728
 /*
  *                                ^ that's the maximum number of pages
@@ -88,6 +93,10 @@ typedef enum State {
     S_UNBALLOON_POSTING,
     S_UNBALLOON_RB_WAIT,
     S_UNBALLOON_REPLY_WAIT,
+    S_HOT_ADD_SETUP,
+    S_HOT_ADD_RB_WAIT,
+    S_HOT_ADD_POSTING,
+    S_HOT_ADD_REPLY_WAIT,
 } State;
 
 typedef struct StateDesc {
@@ -117,25 +126,43 @@ typedef struct HvBalloon {
     uint64_t target;
     bool target_changed;
 
-    /* Current (un)balloon */
+    /* Current (un)balloon / hot-add operation parameters */
     union {
         uint64_t balloon_diff;
 
         struct {
             uint64_t unballoon_diff;
+            uint64_t hot_add_diff;
+        };
+
+        struct {
+            PageRange hot_add_range;
+            uint64_t ha_current_count;
         };
     };
 
+    OurRangeMemslots *our_range;
+
+    /* Count of memslots covering our memory */
+    unsigned int memslot_count;
+
     /* Nominal size of each memslot (the last one might be smaller) */
     uint64_t memslot_size;
 
+    /* Non-ours removed memory */
     PageRangeTree removed_guest, removed_both;
 
+    /* Grand totals of removed memory (both ours and non-ours) */
     uint64_t removed_guest_ctr, removed_both_ctr;
+
+    /* MEMORY_DEVICE props */
+    uint64_t addr;
+    HostMemoryBackend *hostmem;
+    MemoryRegion *mr;
 } HvBalloon;
 
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(HvBalloon, hv_balloon, HV_BALLOON, VMBUS_DEVICE, \
-                                   { })
+                                   { TYPE_MEMORY_DEVICE }, { })
 
 #define HV_BALLOON_SET_STATE(hvb, news)             \
     do {                                            \
@@ -155,6 +182,16 @@ typedef struct HvBalloonReq {
     VMBusChanReq vmreq;
 } HvBalloonReq;
 
+/* total our memory includes parts currently removed from the guest */
+static uint64_t hv_balloon_total_our_ram(HvBalloon *balloon)
+{
+    if (!balloon->our_range) {
+        return 0;
+    }
+
+    return balloon->our_range->range.added;
+}
+
 /* TODO: unify the code below with virtio-balloon and cache the value */
 static int build_dimm_list(Object *obj, void *opaque)
 {
@@ -193,10 +230,11 @@ static uint64_t hv_balloon_total_ram(HvBalloon *balloon)
 {
     ram_addr_t ram_size = get_current_ram_size();
     uint64_t ram_size_pages = ram_size >> HV_BALLOON_PFN_SHIFT;
+    uint64_t our_ram_size_pages = hv_balloon_total_our_ram(balloon);
 
     assert(ram_size_pages > 0);
 
-    return ram_size_pages;
+    return SUM_SATURATE_U64(ram_size_pages, our_ram_size_pages);
 }
 
 /*
@@ -275,14 +313,30 @@ static ssize_t hv_balloon_send_packet(VMBusChannel *chan,
 
 static bool hv_balloon_unballoon_get_source(HvBalloon *balloon,
                                             PageRangeTree *dtree,
-                                            uint64_t **dctr)
+                                            uint64_t **dctr,
+                                            bool *is_our_range)
 {
+    OurRange *our_range = OUR_RANGE(balloon->our_range);
+
+    /* Try the boot memory first */
     if (g_tree_nnodes(balloon->removed_guest.t) > 0) {
         *dtree = balloon->removed_guest;
         *dctr = &balloon->removed_guest_ctr;
+        *is_our_range = false;
     } else if (g_tree_nnodes(balloon->removed_both.t) > 0) {
         *dtree = balloon->removed_both;
         *dctr = &balloon->removed_both_ctr;
+        *is_our_range = false;
+    } else if (!our_range) {
+        return false;
+    } else if (!our_range_is_removed_tree_empty(our_range, false)) {
+        *dtree = our_range_get_removed_tree(our_range, false);
+        *dctr = &balloon->removed_guest_ctr;
+        *is_our_range = true;
+    } else if (!our_range_is_removed_tree_empty(our_range, true)) {
+        *dtree = our_range_get_removed_tree(our_range, true);
+        *dctr = &balloon->removed_both_ctr;
+        *is_our_range = true;
     } else {
         return false;
     }
@@ -310,6 +364,7 @@ static void hv_balloon_unballoon_posting(HvBalloon *balloon, StateDesc *stdesc)
     VMBusChannel *chan = hv_balloon_get_channel(balloon);
     PageRangeTree dtree;
     uint64_t *dctr;
+    bool our_range;
     struct dm_unballoon_request *ur;
     size_t ur_size = sizeof(*ur) + sizeof(ur->range_array[0]);
     PageRange range;
@@ -319,7 +374,7 @@ static void hv_balloon_unballoon_posting(HvBalloon *balloon, StateDesc *stdesc)
     assert(balloon->state == S_UNBALLOON_POSTING);
     assert(balloon->unballoon_diff > 0);
 
-    if (!hv_balloon_unballoon_get_source(balloon, &dtree, &dctr)) {
+    if (!hv_balloon_unballoon_get_source(balloon, &dtree, &dctr, &our_range)) {
         error_report("trying to unballoon but nothing seems to be ballooned");
         /*
          * there is little we can do as we might have already
@@ -328,6 +383,7 @@ static void hv_balloon_unballoon_posting(HvBalloon *balloon, StateDesc *stdesc)
         return;
     }
 
+    assert(balloon->our_range || !our_range);
     assert(dtree.t);
     assert(dctr);
 
@@ -369,6 +425,166 @@ static void hv_balloon_unballoon_posting(HvBalloon *balloon, StateDesc *stdesc)
     }
 }
 
+static bool hv_balloon_our_range_ensure(HvBalloon *balloon)
+{
+    uint64_t align;
+    MemoryRegion *hostmem_mr;
+    g_autoptr(OurRangeMemslots) our_range_memslots = NULL;
+    OurRange *our_range;
+
+    if (balloon->our_range) {
+        return true;
+    }
+
+    if (!balloon->hostmem) {
+        return false;
+    }
+
+    align = (1 << balloon->caps.cap_bits.hot_add_alignment) * MiB;
+    assert(QEMU_IS_ALIGNED(balloon->addr, align));
+
+    hostmem_mr = host_memory_backend_get_memory(balloon->hostmem);
+
+    our_range_memslots = hvb_our_range_memslots_new(balloon->addr,
+                                                    balloon->mr, hostmem_mr,
+                                                    OBJECT(balloon),
+                                                    balloon->memslot_count,
+                                                    balloon->memslot_size);
+    our_range = OUR_RANGE(our_range_memslots);
+
+    if (hvb_page_range_tree_intree_any(balloon->removed_guest,
+                                       our_range->range.start,
+                                       our_range->range.count) ||
+        hvb_page_range_tree_intree_any(balloon->removed_both,
+                                       our_range->range.start,
+                                       our_range->range.count)) {
+        error_report("some parts of the memory backend were already returned by the guest. this should not happen, please reboot the guest and try again");
+        return false;
+    }
+
+    trace_hv_balloon_our_range_add(our_range->range.count,
+                                   our_range->range.start);
+
+    balloon->our_range = g_steal_pointer(&our_range_memslots);
+    return true;
+}
+
+static void hv_balloon_hot_add_setup(HvBalloon *balloon, StateDesc *stdesc)
+{
+    /* need to make copy since it is in union with hot_add_range */
+    uint64_t hot_add_diff = balloon->hot_add_diff;
+    PageRange *hot_add_range = &balloon->hot_add_range;
+    uint64_t align, our_range_remaining;
+    OurRange *our_range;
+
+    assert(balloon->state == S_HOT_ADD_SETUP);
+    assert(hot_add_diff > 0);
+
+    if (!hv_balloon_our_range_ensure(balloon)) {
+        goto ret_idle;
+    }
+
+    our_range = OUR_RANGE(balloon->our_range);
+
+    align = (1 << balloon->caps.cap_bits.hot_add_alignment) *
+        (MiB / HV_BALLOON_PAGE_SIZE);
+
+    /* Absolute GPA in pages */
+    hot_add_range->start = our_range_get_remaining_start(our_range);
+    assert(QEMU_IS_ALIGNED(hot_add_range->start, align));
+
+    our_range_remaining = our_range_get_remaining_size(our_range);
+    hot_add_range->count = MIN(our_range_remaining, hot_add_diff);
+    hot_add_range->count = QEMU_ALIGN_DOWN(hot_add_range->count, align);
+    if (hot_add_range->count == 0) {
+        goto ret_idle;
+    }
+
+    hvb_our_range_memslots_ensure_mapped_additional(balloon->our_range,
+                                                    hot_add_range->count);
+
+    HV_BALLOON_STATE_DESC_SET(stdesc, S_HOT_ADD_RB_WAIT);
+    return;
+
+ret_idle:
+    HV_BALLOON_STATE_DESC_SET(stdesc, S_IDLE);
+}
+
+static void hv_balloon_hot_add_rb_wait(HvBalloon *balloon, StateDesc *stdesc)
+{
+    VMBusChannel *chan = hv_balloon_get_channel(balloon);
+    struct dm_hot_add *ha;
+    size_t ha_size = sizeof(*ha) + sizeof(ha->range);
+
+    assert(balloon->state == S_HOT_ADD_RB_WAIT);
+
+    if (vmbus_channel_reserve(chan, 0, ha_size) < 0) {
+        return;
+    }
+
+    HV_BALLOON_STATE_DESC_SET(stdesc, S_HOT_ADD_POSTING);
+}
+
+static void hv_balloon_hot_add_posting(HvBalloon *balloon, StateDesc *stdesc)
+{
+    PageRange *hot_add_range = &balloon->hot_add_range;
+    uint64_t *current_count = &balloon->ha_current_count;
+    VMBusChannel *chan = hv_balloon_get_channel(balloon);
+    struct dm_hot_add *ha;
+    size_t ha_size = sizeof(*ha) + sizeof(ha->range);
+    union dm_mem_page_range *ha_region;
+    uint64_t align, chunk_max_size;
+    ssize_t ret;
+
+    assert(balloon->state == S_HOT_ADD_POSTING);
+    assert(hot_add_range->count > 0);
+
+    align = (1 << balloon->caps.cap_bits.hot_add_alignment) *
+        (MiB / HV_BALLOON_PAGE_SIZE);
+    if (align >= HV_BALLOON_HA_CHUNK_PAGES) {
+        /*
+         * If the required alignment is higher than the chunk size we let it
+         * override that size.
+         */
+        chunk_max_size = align;
+    } else {
+        chunk_max_size = QEMU_ALIGN_DOWN(HV_BALLOON_HA_CHUNK_PAGES, align);
+    }
+
+    /*
+     * hot_add_range->count starts aligned in hv_balloon_hot_add_setup(),
+     * then it is either reduced by subtracting aligned current_count or
+     * further hot-adds are prevented by marking the whole remaining our range
+     * as unusable in hv_balloon_handle_hot_add_response().
+     */
+    *current_count = MIN(hot_add_range->count, chunk_max_size);
+
+    ha = alloca(ha_size);
+    ha_region = &(&ha->range)[1];
+    memset(ha, 0, ha_size);
+    ha->hdr.type = DM_MEM_HOT_ADD_REQUEST;
+    ha->hdr.size = ha_size;
+    ha->hdr.trans_id = balloon->trans_id;
+
+    ha->range.finfo.start_page = hot_add_range->start;
+    ha->range.finfo.page_cnt = *current_count;
+    ha_region->finfo.start_page = hot_add_range->start;
+    ha_region->finfo.page_cnt = ha->range.finfo.page_cnt;
+
+    trace_hv_balloon_outgoing_hot_add(ha->hdr.trans_id,
+                                      *current_count, hot_add_range->start);
+
+    ret = vmbus_channel_send(chan, VMBUS_PACKET_DATA_INBAND,
+                             NULL, 0, ha, ha_size, false,
+                             ha->hdr.trans_id);
+    if (ret <= 0) {
+        error_report("error %zd when posting hot add msg, expect problems",
+                     ret);
+    }
+
+    HV_BALLOON_STATE_DESC_SET(stdesc, S_HOT_ADD_REPLY_WAIT);
+}
+
 static void hv_balloon_balloon_rb_wait(HvBalloon *balloon, StateDesc *stdesc)
 {
     VMBusChannel *chan = hv_balloon_get_channel(balloon);
@@ -428,14 +644,23 @@ static void hv_balloon_idle_state_process_target(HvBalloon *balloon,
      * the procedure is in progress
      */
     if (balloon->target > ram_size_pages - total_removed) {
+        bool can_hot_add = balloon->caps.cap_bits.hot_add;
         uint64_t target_diff = balloon->target -
             (ram_size_pages - total_removed);
 
         balloon->unballoon_diff = MIN(target_diff, total_removed);
 
+        if (can_hot_add) {
+            balloon->hot_add_diff = target_diff - balloon->unballoon_diff;
+        } else {
+            balloon->hot_add_diff = 0;
+        }
+
         if (balloon->unballoon_diff > 0) {
             assert(can_balloon);
             HV_BALLOON_STATE_DESC_SET(stdesc, S_UNBALLOON_RB_WAIT);
+        } else if (balloon->hot_add_diff > 0) {
+            HV_BALLOON_STATE_DESC_SET(stdesc, S_HOT_ADD_SETUP);
         }
     } else if (can_balloon &&
                balloon->target < ram_size_pages - total_removed) {
@@ -465,6 +690,9 @@ static const struct {
     [S_BALLOON_RB_WAIT].handler = hv_balloon_balloon_rb_wait,
     [S_UNBALLOON_POSTING].handler = hv_balloon_unballoon_posting,
     [S_UNBALLOON_RB_WAIT].handler = hv_balloon_unballoon_rb_wait,
+    [S_HOT_ADD_SETUP].handler = hv_balloon_hot_add_setup,
+    [S_HOT_ADD_RB_WAIT].handler = hv_balloon_hot_add_rb_wait,
+    [S_HOT_ADD_POSTING].handler = hv_balloon_hot_add_posting,
 };
 
 static void hv_balloon_handle_state(HvBalloon *balloon, StateDesc *stdesc)
@@ -507,13 +735,64 @@ static void hv_balloon_remove_response_handle_range(HvBalloon *balloon,
                                                     bool both,
                                                     uint64_t *removedctr)
 {
+    OurRange *our_range = OUR_RANGE(balloon->our_range);
     PageRangeTree globaltree =
         both ? balloon->removed_both : balloon->removed_guest;
     uint64_t *globalctr =
         both ? &balloon->removed_both_ctr : &balloon->removed_guest_ctr;
+    PageRange rangeeff;
+
+    if (range->count == 0) {
+        return;
+    }
 
     trace_hv_balloon_remove_response(range->count, range->start, both);
 
+    if (our_range) {
+        /* Includes the not-yet-hot-added and unusable parts. */
+        rangeeff = our_range->range;
+    } else {
+        rangeeff.start = rangeeff.count = 0;
+    }
+
+    if (page_range_intersection_size(range, rangeeff.start, rangeeff.count) > 0) {
+        PageRangeTree ourtree = our_range_get_removed_tree(our_range, both);
+        PageRange rangehole, rangecommon;
+        uint64_t ourremoved = 0;
+
+        /* process the hole before our range, if it exists */
+        page_range_part_before(range, rangeeff.start, &rangehole);
+        hv_balloon_remove_response_insert_range(globaltree, &rangehole,
+                                                globalctr, removedctr, NULL);
+        if (rangehole.count > 0) {
+            trace_hv_balloon_remove_response_hole(rangehole.count,
+                                                  rangehole.start,
+                                                  range->count, range->start,
+                                                  rangeeff.start, both);
+        }
+
+        /* process our part */
+        page_range_intersect(range, rangeeff.start, rangeeff.count,
+                             &rangecommon);
+        hv_balloon_remove_response_insert_range(ourtree, &rangecommon,
+                                                globalctr, removedctr,
+                                                &ourremoved);
+        if (rangecommon.count > 0) {
+            trace_hv_balloon_remove_response_common(rangecommon.count,
+                                                    rangecommon.start,
+                                                    range->count, range->start,
+                                                    rangeeff.count,
+                                                    rangeeff.start, ourremoved,
+                                                    both);
+        }
+
+        /* calculate what's left after our range */
+        rangecommon = *range;
+        page_range_part_after(&rangecommon, rangeeff.start, rangeeff.count,
+                              range);
+    }
+
+    /* process the remainder of the range that lies after our range */
     if (range->count > 0) {
         hv_balloon_remove_response_insert_range(globaltree, range,
                                                 globalctr, removedctr, NULL);
@@ -844,6 +1123,72 @@ static void hv_balloon_handle_unballoon_response(HvBalloon *balloon,
 
     balloon->trans_id++;
 
+    if (balloon->hot_add_diff > 0) {
+        bool can_hot_add = balloon->caps.cap_bits.hot_add;
+
+        assert(can_hot_add);
+        HV_BALLOON_STATE_DESC_SET(stdesc, S_HOT_ADD_SETUP);
+    } else {
+        HV_BALLOON_STATE_DESC_SET(stdesc, S_IDLE);
+    }
+}
+
+static void hv_balloon_handle_hot_add_response(HvBalloon *balloon,
+                                               HvBalloonReq *req,
+                                               StateDesc *stdesc)
+{
+    PageRange *hot_add_range = &balloon->hot_add_range;
+    VMBusChanReq *vmreq = &req->vmreq;
+    struct dm_hot_add_response *msgHaR = vmreq->msg;
+    OurRange *our_range;
+
+    if (balloon->state != S_HOT_ADD_REPLY_WAIT) {
+        warn_report("unexpected DM_HOT_ADD_RESPONSE in %d state",
+                    balloon->state);
+        return;
+    }
+
+    assert(balloon->our_range);
+    our_range = OUR_RANGE(balloon->our_range);
+
+    if (!hv_balloon_handle_msg_size(req, sizeof(*msgHaR),
+                                    "DM_HOT_ADD_RESPONSE"))
+        return;
+
+    trace_hv_balloon_incoming_hot_add(msgHaR->hdr.trans_id, msgHaR->result,
+                                      msgHaR->page_count);
+
+    balloon->trans_id++;
+
+    if (msgHaR->result) {
+        if (msgHaR->page_count > balloon->ha_current_count) {
+            warn_report("DM_HOT_ADD_RESPONSE page count higher than requested (%"PRIu32" vs %"PRIu64")",
+                        msgHaR->page_count, balloon->ha_current_count);
+            msgHaR->page_count = balloon->ha_current_count;
+        }
+
+        hvb_our_range_mark_added(our_range, msgHaR->page_count);
+        hot_add_range->start += msgHaR->page_count;
+        hot_add_range->count -= msgHaR->page_count;
+    }
+
+    if (!msgHaR->result || msgHaR->page_count < balloon->ha_current_count) {
+        /*
+         * the current planned range was only partially hot-added, take note
+         * how much of it remains and don't attempt any further hot adds
+         */
+        our_range_mark_remaining_unusable(our_range);
+
+        goto ret_idle;
+    }
+
+    /* any pages remaining to hot-add in our range? */
+    if (hot_add_range->count > 0) {
+        HV_BALLOON_STATE_DESC_SET(stdesc, S_HOT_ADD_RB_WAIT);
+        return;
+    }
+
+ret_idle:
     HV_BALLOON_STATE_DESC_SET(stdesc, S_IDLE);
 }
 
@@ -921,6 +1266,10 @@ static void hv_balloon_handle_packet(HvBalloon *balloon, HvBalloonReq *req,
         hv_balloon_handle_status_report(balloon, req);
         break;
 
+    case DM_MEM_HOT_ADD_RESPONSE:
+        hv_balloon_handle_hot_add_response(balloon, req, stdesc);
+        break;
+
     case DM_UNBALLOON_RESPONSE:
         hv_balloon_handle_unballoon_response(balloon, req, stdesc);
         break;
@@ -1069,6 +1418,61 @@ static void hv_balloon_post_init_timer(void *opaque)
     hv_balloon_event_loop(balloon);
 }
 
+static void hv_balloon_system_reset_unrealize_common(HvBalloon *balloon)
+{
+    g_clear_pointer(&balloon->our_range, hvb_our_range_memslots_free);
+}
+
+static void hv_balloon_system_reset(void *opaque)
+{
+    HvBalloon *balloon = HV_BALLOON(opaque);
+
+    hv_balloon_system_reset_unrealize_common(balloon);
+}
+
+static void hv_balloon_ensure_mr(HvBalloon *balloon)
+{
+    MemoryRegion *hostmem_mr;
+
+    assert(balloon->hostmem);
+
+    if (balloon->mr) {
+        return;
+    }
+
+    hostmem_mr = host_memory_backend_get_memory(balloon->hostmem);
+
+    balloon->mr = g_new0(MemoryRegion, 1);
+    memory_region_init(balloon->mr, OBJECT(balloon), TYPE_HV_BALLOON,
+                       memory_region_size(hostmem_mr));
+
+    /*
+     * The VM can indicate an alignment up to 32 GiB. Memory device core can
+     * usually only handle/guarantee 1 GiB alignment. The user will have to
+     * specify a larger maxmem eventually.
+     *
+     * The memory device core will warn the user in case maxmem might have to be
+     * increased and will fail plugging the device if there is not sufficient
+     * space after alignment.
+     *
+     * TODO: we could do the alignment ourselves in a slightly bigger region.
+     * But this feels better, although the warning might be annoying. Maybe
+     * we can optimize that in the future (e.g., with such a device on the
+     * cmdline place/size the device memory region differently.
+     */
+    balloon->mr->align = MAX(32 * GiB, memory_region_get_alignment(hostmem_mr));
+}
+
+static void hv_balloon_free_mr(HvBalloon *balloon)
+{
+    if (!balloon->mr) {
+        return;
+    }
+
+    object_unparent(OBJECT(balloon->mr));
+    g_clear_pointer(&balloon->mr, g_free);
+}
+
 static void hv_balloon_vmdev_realize(VMBusDevice *vdev, Error **errp)
 {
     ERRP_GUARD();
@@ -1085,13 +1489,52 @@ static void hv_balloon_vmdev_realize(VMBusDevice *vdev, Error **errp)
         return;
     }
 
+    if (balloon->hostmem) {
+        if (host_memory_backend_is_mapped(balloon->hostmem)) {
+            Object *obj = OBJECT(balloon->hostmem);
+
+            error_setg(errp, "'%s' property specifies a busy memdev: %s",
+                       HV_BALLOON_MEMDEV_PROP,
+                       object_get_canonical_path_component(obj));
+            goto out_balloon_handler;
+        }
+
+        hv_balloon_ensure_mr(balloon);
+
+        /* This is rather unlikely to happen, but let's still check for it. */
+        if (!QEMU_IS_ALIGNED(memory_region_size(balloon->mr),
+                             HV_BALLOON_PAGE_SIZE)) {
+            error_setg(errp, "'%s' property memdev size has to be a multiple of 0x%" PRIx64,
+                       HV_BALLOON_MEMDEV_PROP, (uint64_t)HV_BALLOON_PAGE_SIZE);
+            goto out_balloon_handler;
+        }
+
+        host_memory_backend_set_mapped(balloon->hostmem, true);
+        vmstate_register_ram(host_memory_backend_get_memory(balloon->hostmem),
+                             DEVICE(balloon));
+    } else if (balloon->addr) {
+        error_setg(errp, "'%s' property must not be set without a memdev",
+                   HV_BALLOON_MEMDEV_PROP);
+        goto out_balloon_handler;
+    }
+
     timer_init_ms(&balloon->post_init_timer, QEMU_CLOCK_VIRTUAL,
                   hv_balloon_post_init_timer, balloon);
+
+    qemu_register_reset(hv_balloon_system_reset, balloon);
+
+    return;
+
+out_balloon_handler:
+    qemu_remove_balloon_handler(balloon);
 }
 
 /*
  * VMBus device reset has to be implemented in case the guest decides to
  * disconnect and reconnect to the VMBus without rebooting the whole system.
+ *
+ * However, the hot-added memory can't be removed here as Windows keeps on using
+ * it until the system is restarted, even after disconnecting from the VMBus.
  */
 static void hv_balloon_vmdev_reset(VMBusDevice *vdev)
 {
@@ -1101,6 +1544,10 @@ static void hv_balloon_vmdev_reset(VMBusDevice *vdev)
         return;
     }
 
+    if (balloon->our_range) {
+        hvb_our_range_clear_removed_trees(OUR_RANGE(balloon->our_range));
+    }
+
     hvb_page_range_tree_destroy(&balloon->removed_guest);
     hvb_page_range_tree_destroy(&balloon->removed_both);
     hvb_page_range_tree_init(&balloon->removed_guest);
@@ -1114,14 +1561,106 @@ static void hv_balloon_vmdev_reset(VMBusDevice *vdev)
     hv_balloon_event_loop(balloon);
 }
 
+/*
+ * Clean up things that were (possibly) allocated pre-realization, for example
+ * from memory_device_pre_plug(), so we don't leak them if the device don't
+ * actually get realized in the end.
+ */
+static void hv_balloon_unrealize_finalize_common(HvBalloon *balloon)
+{
+    hv_balloon_free_mr(balloon);
+    balloon->addr = 0;
+
+    balloon->memslot_count = 0;
+}
+
 static void hv_balloon_vmdev_unrealize(VMBusDevice *vdev)
 {
     HvBalloon *balloon = HV_BALLOON(vdev);
 
+    qemu_unregister_reset(hv_balloon_system_reset, balloon);
+
+    hv_balloon_system_reset_unrealize_common(balloon);
+
     qemu_remove_balloon_handler(balloon);
 
+    if (balloon->hostmem) {
+        vmstate_unregister_ram(host_memory_backend_get_memory(balloon->hostmem),
+                               DEVICE(balloon));
+        host_memory_backend_set_mapped(balloon->hostmem, false);
+    }
+
     hvb_page_range_tree_destroy(&balloon->removed_guest);
     hvb_page_range_tree_destroy(&balloon->removed_both);
+
+    hv_balloon_unrealize_finalize_common(balloon);
+}
+
+static uint64_t hv_balloon_md_get_addr(const MemoryDeviceState *md)
+{
+    return object_property_get_uint(OBJECT(md), HV_BALLOON_ADDR_PROP,
+                                    &error_abort);
+}
+
+static void hv_balloon_md_set_addr(MemoryDeviceState *md, uint64_t addr,
+                                   Error **errp)
+{
+    object_property_set_uint(OBJECT(md), HV_BALLOON_ADDR_PROP, addr, errp);
+}
+
+static MemoryRegion *hv_balloon_md_get_memory_region(MemoryDeviceState *md,
+                                                     Error **errp)
+{
+    HvBalloon *balloon = HV_BALLOON(md);
+
+    if (!balloon->hostmem) {
+        return NULL;
+    }
+
+    hv_balloon_ensure_mr(balloon);
+
+    return balloon->mr;
+}
+
+static void hv_balloon_decide_memslots(MemoryDeviceState *md,
+                                       unsigned int limit)
+{
+    HvBalloon *balloon = HV_BALLOON(md);
+    MemoryRegion *hostmem_mr;
+    uint64_t region_size, memslot_size, memslots;
+
+    /* We're called exactly once, before realizing the device. */
+    assert(!balloon->memslot_count);
+
+    /* We should not be called if we don't have a memory backend */
+    assert(balloon->hostmem);
+
+    hostmem_mr = host_memory_backend_get_memory(balloon->hostmem);
+    region_size = memory_region_size(hostmem_mr);
+
+    assert(region_size > 0);
+    memslot_size = QEMU_ALIGN_UP(region_size / limit,
+                                 HV_BALLOON_HA_MEMSLOT_SIZE_ALIGN);
+    memslots = QEMU_ALIGN_UP(region_size, memslot_size) / memslot_size;
+
+    if (memslots > 1) {
+        balloon->memslot_size = memslot_size;
+    } else {
+        balloon->memslot_size = region_size;
+    }
+
+    assert(memslots <= UINT_MAX);
+    balloon->memslot_count = memslots;
+}
+
+static unsigned int hv_balloon_get_memslots(MemoryDeviceState *md)
+{
+    const HvBalloon *balloon = HV_BALLOON(md);
+
+    /* We're called after setting the suggested limit. */
+    assert(balloon->memslot_count > 0);
+
+    return balloon->memslot_count;
 }
 
 static void hv_balloon_init(Object *obj)
@@ -1130,12 +1669,20 @@ static void hv_balloon_init(Object *obj)
 
 static void hv_balloon_finalize(Object *obj)
 {
+    HvBalloon *balloon = HV_BALLOON(obj);
+
+    hv_balloon_unrealize_finalize_common(balloon);
 }
 
 static Property hv_balloon_properties[] = {
     DEFINE_PROP_BOOL("status-report", HvBalloon,
                      status_report.enabled, false),
 
+    /* MEMORY_DEVICE props */
+    DEFINE_PROP_LINK(HV_BALLOON_MEMDEV_PROP, HvBalloon, hostmem,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_UINT64(HV_BALLOON_ADDR_PROP, HvBalloon, addr, 0),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1143,6 +1690,7 @@ static void hv_balloon_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VMBusDeviceClass *vdc = VMBUS_DEVICE_CLASS(klass);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(klass);
 
     device_class_set_props(dc, hv_balloon_properties);
     qemu_uuid_parse(HV_BALLOON_GUID, &vdc->classid);
@@ -1154,4 +1702,12 @@ static void hv_balloon_class_init(ObjectClass *klass, void *data)
     vdc->open_channel = hv_balloon_vmdev_open_channel;
     vdc->close_channel = hv_balloon_vmdev_close_channel;
     vdc->chan_notify_cb = hv_balloon_vmdev_chan_notify;
+
+    mdc->get_addr = hv_balloon_md_get_addr;
+    mdc->set_addr = hv_balloon_md_set_addr;
+    mdc->get_plugged_size = memory_device_get_region_size;
+    mdc->get_memory_region = hv_balloon_md_get_memory_region;
+    mdc->decide_memslots = hv_balloon_decide_memslots;
+    mdc->get_memslots = hv_balloon_get_memslots;
+    /* implement fill_device_info */
 }
diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index b5be1cbb1a96..852d4f4a2ee2 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -2,4 +2,4 @@ specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 specific_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
-specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c'))
+specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
diff --git a/hw/hyperv/trace-events b/hw/hyperv/trace-events
index 86c724ba661b..7963c215b1c5 100644
--- a/hw/hyperv/trace-events
+++ b/hw/hyperv/trace-events
@@ -23,9 +23,14 @@ hv_balloon_incoming_version(uint16_t major, uint16_t minor) "incoming proto vers
 hv_balloon_incoming_caps(uint32_t caps) "incoming caps 0x%x"
 hv_balloon_outgoing_unballoon(uint32_t trans_id, uint64_t count, uint64_t start, uint64_t rempages) "posting unballoon %"PRIu32" for %"PRIu64" @ 0x%"PRIx64", remaining %"PRIu64
 hv_balloon_incoming_unballoon(uint32_t trans_id) "incoming unballoon response %"PRIu32
+hv_balloon_outgoing_hot_add(uint32_t trans_id, uint64_t count, uint64_t start) "posting hot add %"PRIu32" for %"PRIu64" @ 0x%"PRIx64
+hv_balloon_incoming_hot_add(uint32_t trans_id, uint32_t result, uint32_t count) "incoming hot add response %"PRIu32", result %"PRIu32", count %"PRIu32
 hv_balloon_outgoing_balloon(uint32_t trans_id, uint64_t count, uint64_t rempages) "posting balloon %"PRIu32" for %"PRIu64", remaining %"PRIu64
 hv_balloon_incoming_balloon(uint32_t trans_id, uint32_t range_count, uint32_t more_pages) "incoming balloon response %"PRIu32", ranges %"PRIu32", more %"PRIu32
+hv_balloon_our_range_add(uint64_t count, uint64_t start) "adding our range %"PRIu64" @ 0x%"PRIx64
 hv_balloon_remove_response(uint64_t count, uint64_t start, unsigned int both) "processing remove response range %"PRIu64" @ 0x%"PRIx64", both %u"
 hv_balloon_remove_response_hole(uint64_t counthole, uint64_t starthole, uint64_t countrange, uint64_t startrange, uint64_t starthpr, unsigned int both) "response range hole %"PRIu64" @ 0x%"PRIx64" from range %"PRIu64" @ 0x%"PRIx64", before our start 0x%"PRIx64", both %u"
 hv_balloon_remove_response_common(uint64_t countcommon, uint64_t startcommon, uint64_t countrange, uint64_t startrange, uint64_t counthpr, uint64_t starthpr, uint64_t removed, unsigned int both) "response common range %"PRIu64" @ 0x%"PRIx64" from range %"PRIu64" @ 0x%"PRIx64" with our %"PRIu64" @ 0x%"PRIx64", removed %"PRIu64", both %u"
 hv_balloon_remove_response_remainder(uint64_t count, uint64_t start, unsigned int both) "remove response remaining range %"PRIu64" @ 0x%"PRIx64", both %u"
+hv_balloon_map_slot(unsigned int idx, unsigned int total_slots, uint64_t offset) "mapping memslot %u / %u @ 0x%"PRIx64
+hv_balloon_unmap_slot(unsigned int idx, unsigned int total_slots, uint64_t offset) "unmapping memslot %u / %u @ 0x%"PRIx64

