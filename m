Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AA272C6D3
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 16:03:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8i7z-0005ar-Jb; Mon, 12 Jun 2023 10:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1q8i7r-0005Z0-2z
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 10:02:32 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1q8i7m-0000u7-01
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 10:02:30 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1q8i6e-0008UE-4Y; Mon, 12 Jun 2023 16:01:16 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH][RESEND v5 3/3] Add a Hyper-V Dynamic Memory Protocol driver
 (hv-balloon)
Date: Mon, 12 Jun 2023 16:00:54 +0200
Message-Id: <896327748bde906826e24ce7cc45301e325e14a7.1686577753.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686577753.git.maciej.szmigiero@oracle.com>
References: <cover.1686577753.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This driver is like virtio-balloon on steroids: it allows both changing the
guest memory allocation via ballooning and inserting pieces of extra RAM
into it on demand from a provided memory backend.

One of advantages of these over ACPI-based PC DIMM hotplug is that such
memory can be hotplugged in much smaller granularity because the ACPI DIMM
slot limit does not apply.

In order to enable hot-adding additional memory a new memory backend needs
to be created and provided to the driver via the "memdev" parameter.
This can be achieved by, for example, adding
"-object memory-backend-ram,id=mem1,size=32G" to the QEMU command line and
then instantiating the driver with "memdev=mem1" parameter.

In contrast with ACPI DIMM hotplug where one can only request to unplug a
whole DIMM stick this driver allows removing memory from guest in single
page (4k) units via ballooning.

The actual resizing is done via ballooning interface (for example, via
the "balloon" HMP command)
This includes resizing the guest past its boot size - that is, hot-adding
additional memory in granularity limited only by the guest alignment
requirements.

After a VM reboot the guest is back to its original (boot) size.

In the future, the guest boot memory size might be changed on reboot
instead, taking into account the effective size that VM had before that
reboot (much like Hyper-V does).

For performance reasons, the guest-released memory is tracked in a few
range trees, as a series of (start, count) ranges.
Each time a new page range is inserted into such tree its neighbors are
checked as candidates for possible merging with it.

Besides performance reasons, the Dynamic Memory protocol itself uses page
ranges as the data structure in its messages, so relevant pages need to be
merged into such ranges anyway.

One has to be careful when tracking the guest-released pages, since the
guest can maliciously report returning pages outside its current address
space, which later clash with the address range of newly added memory.
Similarly, the guest can report freeing the same page twice.

The above design results in much better ballooning performance than when
using virtio-balloon with the same guest: 230 GB / minute with this driver
versus 70 GB / minute with virtio-balloon.

During a ballooning operation most of time is spent waiting for the guest
to come up with newly freed page ranges, processing the received ranges on
the host side (in QEMU and KVM) is nearly instantaneous.

The unballoon operation is also pretty much instantaneous:
thanks to the merging of the ballooned out page ranges 200 GB of memory can
be returned to the guest in about 1 second.
With virtio-balloon this operation takes about 2.5 minutes.

These tests were done against a Windows Server 2019 guest running on a
Xeon E5-2699, after dirtying the whole memory inside guest before each
balloon operation.

Using a range tree instead of a bitmap to track the removed memory also
means that the solution scales well with the guest size: even a 1 TB range
takes just a few bytes of such metadata.

Since the required GTree operations aren't present in every Glib version
a check for them was added to the meson build script, together with new
"--enable-hv-balloon" and "--disable-hv-balloon" configure arguments.
If these GTree operations are missing in the system's Glib version this
driver will be skipped during QEMU build.

An optional "status-report=on" device parameter requests memory status
events from the guest (typically sent every second), which allow the host
to learn both the guest memory available and the guest memory in use
counts.
They are emitted externally as "HV_BALLOON_STATUS_REPORT" QMP events.

The driver is named hv-balloon since the Linux kernel client driver for
the Dynamic Memory Protocol is named as such and to follow the naming
pattern established by the virtio-balloon driver.
The whole protocol runs over Hyper-V VMBus.

The driver was tested against Windows Server 2012 R2, Windows Server 2016
and Windows Server 2019 guests and obeys the guest alignment requirements
reported to the host via DM_CAPABILITIES_REPORT message.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 Kconfig.host                  |    3 +
 hw/hyperv/Kconfig             |    5 +
 hw/hyperv/hv-balloon.c        | 2040 +++++++++++++++++++++++++++++++++
 hw/hyperv/meson.build         |    1 +
 hw/hyperv/trace-events        |   16 +
 meson.build                   |   28 +-
 meson_options.txt             |    2 +
 qapi/machine.json             |   25 +
 scripts/meson-buildoptions.sh |    3 +
 9 files changed, 2122 insertions(+), 1 deletion(-)
 create mode 100644 hw/hyperv/hv-balloon.c

diff --git a/Kconfig.host b/Kconfig.host
index d763d892693c..2ee71578f38f 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -46,3 +46,6 @@ config FUZZ
 config VFIO_USER_SERVER_ALLOWED
     bool
     imply VFIO_USER_SERVER
+
+config HV_BALLOON_POSSIBLE
+    bool
diff --git a/hw/hyperv/Kconfig b/hw/hyperv/Kconfig
index fcf65903bd05..3db31f4f4b40 100644
--- a/hw/hyperv/Kconfig
+++ b/hw/hyperv/Kconfig
@@ -16,3 +16,8 @@ config SYNDBG
     bool
     default y
     depends on VMBUS
+
+config HV_BALLOON
+    bool
+    default y
+    depends on HV_BALLOON_POSSIBLE && VMBUS
diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
new file mode 100644
index 000000000000..076ac9a8bd90
--- /dev/null
+++ b/hw/hyperv/hv-balloon.c
@@ -0,0 +1,2040 @@
+/*
+ * QEMU Hyper-V Dynamic Memory Protocol driver
+ *
+ * Copyright (C) 2020-2023 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "exec/address-spaces.h"
+#include "exec/cpu-common.h"
+#include "exec/memory.h"
+#include "exec/ramblock.h"
+#include "hw/boards.h"
+#include "hw/hyperv/dynmem-proto.h"
+#include "hw/hyperv/vmbus.h"
+#include "hw/mem/memory-device.h"
+#include "hw/mem/pc-dimm.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
+#include "monitor/qdev.h"
+#include "qapi/error.h"
+#include "qapi/qapi-events-machine.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/visitor.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "qemu/timer.h"
+#include "sysemu/balloon.h"
+#include "sysemu/hostmem.h"
+#include "sysemu/reset.h"
+#include "trace.h"
+
+/*
+ * temporarily avoid warnings about enhanced GTree API usage requiring a
+ * too recent Glib version until GLIB_VERSION_MAX_ALLOWED finally reaches
+ * the Glib version with this API
+ */
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+
+#define TYPE_HV_BALLOON "hv-balloon"
+#define HV_BALLOON_ADDR_PROP "addr"
+#define HV_BALLOON_MEMDEV_PROP "memdev"
+#define HV_BALLOON_GUID "525074DC-8985-46e2-8057-A307DC18A502"
+#define HV_BALLOON_PFN_SHIFT 12
+#define HV_BALLOON_PAGE_SIZE (1 << HV_BALLOON_PFN_SHIFT)
+
+/*
+ * Some Windows versions (at least Server 2019) will crash with various
+ * error codes when receiving DM protocol requests (at least
+ * DM_MEM_HOT_ADD_REQUEST) immediately after boot.
+ *
+ * It looks like Hyper-V from Server 2016 uses a 50-second after-boot
+ * delay, probably to workaround this issue, so we'll use this value, too.
+ */
+#define HV_BALLOON_POST_INIT_WAIT (50 * 1000)
+
+#define HV_BALLOON_HA_CHUNK_SIZE (2 * GiB)
+#define HV_BALLOON_HA_CHUNK_PAGES (HV_BALLOON_HA_CHUNK_SIZE / HV_BALLOON_PAGE_SIZE)
+
+#define HV_BALLOON_HR_CHUNK_PAGES 585728
+/*
+ *                                ^ that's the maximum number of pages
+ * that Windows returns in one hot remove response
+ *
+ * If the number requested is too high Windows will no longer honor
+ * these requests
+ */
+
+typedef enum State {
+    /* not a real state */
+    S_NO_CHANGE = 0,
+
+    S_WAIT_RESET,
+    S_POST_RESET_CLOSED,
+
+    /* init flow */
+    S_VERSION,
+    S_CAPS,
+    S_POST_INIT_WAIT,
+
+    S_IDLE,
+
+    /* balloon op flow */
+    S_BALLOON_POSTING,
+    S_BALLOON_RB_WAIT,
+    S_BALLOON_REPLY_WAIT,
+
+    /* unballoon + hot add ops flow */
+    S_UNBALLOON_POSTING,
+    S_UNBALLOON_RB_WAIT,
+    S_UNBALLOON_REPLY_WAIT,
+    S_HOT_ADD_SETUP,
+    S_HOT_ADD_RB_WAIT,
+    S_HOT_ADD_POSTING,
+    S_HOT_ADD_REPLY_WAIT,
+} State;
+
+typedef struct StateDesc {
+    State state;
+    const char *desc;
+} StateDesc;
+
+typedef struct PageRange {
+    uint64_t start;
+    uint64_t count;
+} PageRange;
+
+/* type safety */
+typedef struct PageRangeTree {
+    GTree *t;
+} PageRangeTree;
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
+typedef struct OurRangePlugged {
+    OurRange range;
+    MemoryDeviceState *md;
+    HostMemoryBackend *hostmem;
+} OurRangePlugged;
+
+typedef struct HvBalloon {
+    VMBusDevice parent;
+    State state;
+    bool status_reports;
+
+    union dm_version version;
+    union dm_caps caps;
+
+    QEMUTimer post_init_timer;
+
+    unsigned int trans_id;
+
+    /* Guest target size */
+    uint64_t target;
+    bool target_changed;
+
+    /* Current (un)balloon / hot-add operation parameters */
+    union {
+        uint64_t balloon_diff;
+
+        struct {
+            uint64_t unballoon_diff;
+            uint64_t hot_add_diff;
+        };
+
+        struct {
+            PageRange hot_add_range;
+            uint64_t ha_current_count;
+        };
+    };
+
+    OurRangePlugged *our_range;
+
+    /* Non-ours removed memory */
+    PageRangeTree removed_guest, removed_both;
+
+    /* Grand totals of removed memory (both ours and non-ours) */
+    uint64_t removed_guest_ctr, removed_both_ctr;
+
+    /* MEMORY_DEVICE props */
+    uint64_t addr;
+    HostMemoryBackend *hostmem;
+} HvBalloon;
+
+#define HV_BALLOON(obj) OBJECT_CHECK(HvBalloon, (obj), TYPE_HV_BALLOON)
+
+#define HV_BALLOON_SET_STATE(hvb, news)             \
+    do {                                            \
+        assert(news != S_NO_CHANGE);                \
+        hv_balloon_state_set(hvb, news, # news);    \
+    } while (0)
+
+#define HV_BALLOON_STATE_DESC_SET(stdesc, news)         \
+    _hv_balloon_state_desc_set(stdesc, news, # news)
+
+#define HV_BALLOON_STATE_DESC_INIT \
+    {                              \
+        .state = S_NO_CHANGE,      \
+    }
+
+#define SUM_OVERFLOW_U64(in1, in2) ((in1) > UINT64_MAX - (in2))
+#define SUM_SATURATE_U64(in1, in2)              \
+    ({                                          \
+        uint64_t _in1 = (in1), _in2 = (in2);    \
+        uint64_t _result;                       \
+                                                \
+        if (!SUM_OVERFLOW_U64(_in1, _in2)) {    \
+            _result = _in1 + _in2;              \
+        } else {                                \
+            _result = UINT64_MAX;               \
+        }                                       \
+                                                \
+        _result;                                \
+    })
+
+typedef struct HvBalloonReq {
+    VMBusChanReq vmreq;
+} HvBalloonReq;
+
+/* PageRange */
+static void page_range_intersect(const PageRange *range,
+                                 uint64_t start, uint64_t count,
+                                 PageRange *out)
+{
+    uint64_t end1 = range->start + range->count;
+    uint64_t end2 = start + count;
+    uint64_t end = MIN(end1, end2);
+
+    out->start = MAX(range->start, start);
+    out->count = out->start < end ? end - out->start : 0;
+}
+
+static uint64_t page_range_intersection_size(const PageRange *range,
+                                             uint64_t start, uint64_t count)
+{
+    PageRange trange;
+
+    page_range_intersect(range, start, count, &trange);
+    return trange.count;
+}
+
+/* return just the part of range before (start) */
+static void page_range_part_before(const PageRange *range,
+                                   uint64_t start, PageRange *out)
+{
+    uint64_t endr = range->start + range->count;
+    uint64_t end = MIN(endr, start);
+
+    out->start = range->start;
+    if (end > out->start) {
+        out->count = end - out->start;
+    } else {
+        out->count = 0;
+    }
+}
+
+/* return just the part of range after (start, count) */
+static void page_range_part_after(const PageRange *range,
+                                  uint64_t start, uint64_t count,
+                                  PageRange *out)
+{
+    uint64_t end = range->start + range->count;
+    uint64_t ends = start + count;
+
+    out->start = MAX(range->start, ends);
+    if (end > out->start) {
+        out->count = end - out->start;
+    } else {
+        out->count = 0;
+    }
+}
+
+static bool page_range_joinable_left(const PageRange *range,
+                                     uint64_t start, uint64_t count)
+{
+    return start + count == range->start;
+}
+
+static bool page_range_joinable_right(const PageRange *range,
+                                      uint64_t start, uint64_t count)
+{
+    return range->start + range->count == start;
+}
+
+static bool page_range_joinable(const PageRange *range,
+                                uint64_t start, uint64_t count)
+{
+    return page_range_joinable_left(range, start, count) ||
+        page_range_joinable_right(range, start, count);
+}
+
+/* PageRangeTree */
+static gint page_range_tree_key_compare(gconstpointer leftp,
+                                        gconstpointer rightp,
+                                        gpointer user_data)
+{
+    const uint64_t *left = leftp, *right = rightp;
+
+    if (*left < *right) {
+        return -1;
+    } else if (*left > *right) {
+        return 1;
+    } else { /* *left == *right */
+        return 0;
+    }
+}
+
+static GTreeNode *page_range_tree_insert_new(PageRangeTree tree,
+                                             uint64_t start, uint64_t count)
+{
+    uint64_t *key = g_malloc(sizeof(*key));
+    PageRange *range = g_malloc(sizeof(*range));
+
+    assert(count > 0);
+
+    *key = range->start = start;
+    range->count = count;
+
+    return g_tree_insert_node(tree.t, key, range);
+}
+
+static void page_range_tree_insert(PageRangeTree tree,
+                                   uint64_t start, uint64_t count,
+                                   uint64_t *dupcount)
+{
+    GTreeNode *node;
+    bool joinable;
+    uint64_t intersection;
+    PageRange *range;
+
+    assert(!SUM_OVERFLOW_U64(start, count));
+    if (count == 0) {
+        return;
+    }
+
+    node = g_tree_upper_bound(tree.t, &start);
+    if (node) {
+        node = g_tree_node_previous(node);
+    } else {
+        node = g_tree_node_last(tree.t);
+    }
+
+    if (node) {
+        range = g_tree_node_value(node);
+        assert(range);
+        intersection = page_range_intersection_size(range, start, count);
+        joinable = page_range_joinable_right(range, start, count);
+    }
+
+    if (!node ||
+        (!intersection && !joinable)) {
+        /*
+         * !node case: the tree is empty or the very first node in the tree
+         * already has a higher key (the start of its range).
+         * the other case: there is a gap in the tree between the new range
+         * and the previous one.
+         * anyway, let's just insert the new range into the tree.
+         */
+        node = page_range_tree_insert_new(tree, start, count);
+        assert(node);
+        range = g_tree_node_value(node);
+        assert(range);
+    } else {
+        /*
+         * the previous range in the tree either partially covers the new
+         * range or ends just at its beginning - extend it
+         */
+        if (dupcount) {
+            *dupcount += intersection;
+        }
+
+        count += start - range->start;
+        range->count = MAX(range->count, count);
+    }
+
+    /* check next nodes for possible merging */
+    for (node = g_tree_node_next(node); node; ) {
+        PageRange *rangecur;
+
+        rangecur = g_tree_node_value(node);
+        assert(rangecur);
+
+        intersection = page_range_intersection_size(rangecur,
+                                                    range->start, range->count);
+        joinable = page_range_joinable_left(rangecur,
+                                            range->start, range->count);
+        if (!intersection && !joinable) {
+            /* the current node is disjoint */
+            break;
+        }
+
+        if (dupcount) {
+            *dupcount += intersection;
+        }
+
+        count = rangecur->count + (rangecur->start - range->start);
+        range->count = MAX(range->count, count);
+
+        /* the current node was merged in, remove it */
+        start = rangecur->start;
+        node = g_tree_node_next(node);
+        /* no hinted removal in GTree... */
+        g_tree_remove(tree.t, &start);
+    }
+}
+
+static bool page_range_tree_pop(PageRangeTree tree, PageRange *out,
+                                uint64_t maxcount)
+{
+    GTreeNode *node;
+    PageRange *range;
+
+    node = g_tree_node_last(tree.t);
+    if (!node) {
+        return false;
+    }
+
+    range = g_tree_node_value(node);
+    assert(range);
+
+    out->start = range->start;
+
+    /* can't modify range->start as it is the node key */
+    if (range->count > maxcount) {
+        out->start += range->count - maxcount;
+        out->count = maxcount;
+        range->count -= maxcount;
+    } else {
+        out->count = range->count;
+        /* no hinted removal in GTree... */
+        g_tree_remove(tree.t, &out->start);
+    }
+
+    return true;
+}
+
+static bool page_range_tree_intree_any(PageRangeTree tree,
+                                       uint64_t start, uint64_t count)
+{
+    GTreeNode *node;
+
+    if (count == 0) {
+        return false;
+    }
+
+    /* find the first node that can possibly intersect our range */
+    node = g_tree_upper_bound(tree.t, &start);
+    if (node) {
+        /*
+         * a NULL node below means that the very first node in the tree
+         * already has a higher key (the start of its range).
+         */
+        node = g_tree_node_previous(node);
+    } else {
+        /* a NULL node below means that the tree is empty */
+        node = g_tree_node_last(tree.t);
+    }
+    /* node range start <= range start */
+
+    if (!node) {
+        /* node range start > range start */
+        node = g_tree_node_first(tree.t);
+    }
+
+    for ( ; node; node = g_tree_node_next(node)) {
+        PageRange *range = g_tree_node_value(node);
+
+        assert(range);
+        /*
+         * if this node starts beyond or at the end of our range so does
+         * every next one
+         */
+        if (range->start >= start + count) {
+            break;
+        }
+
+        if (page_range_intersection_size(range, start, count) > 0) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static void page_range_tree_init(PageRangeTree *tree)
+{
+    tree->t = g_tree_new_full(page_range_tree_key_compare, NULL,
+                              g_free, g_free);
+}
+
+static void page_range_tree_destroy(PageRangeTree *tree)
+{
+    /* g_tree_destroy() is not NULL-safe */
+    if (!tree->t) {
+        return;
+    }
+
+    g_tree_destroy(tree->t);
+    tree->t = NULL;
+}
+
+/* OurRange */
+#define OUR_RANGE(ptr) ((OurRange *)(ptr))
+
+static void our_range_init(OurRange *our_range, uint64_t start, uint64_t count)
+{
+    our_range->range.start = start;
+    our_range->range.count = count;
+
+    page_range_tree_init(&our_range->removed_guest);
+    page_range_tree_init(&our_range->removed_both);
+
+    /* mark the whole range as unused but for potential use */
+    our_range->added = 0;
+    our_range->unusable_tail = 0;
+}
+
+static void our_range_destroy(OurRange *our_range)
+{
+    page_range_tree_destroy(&our_range->removed_guest);
+    page_range_tree_destroy(&our_range->removed_both);
+}
+
+/* OurRangePlugged */
+static OurRangePlugged *our_range_plugged_new(MemoryDeviceState *md,
+                                              HostMemoryBackend *hostmem,
+                                              uint64_t align,
+                                              Error **errp)
+{
+    ERRP_GUARD();
+    OurRangePlugged *our_range;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    uint64_t addr, count;
+
+    if (!align) {
+        align = HV_BALLOON_PAGE_SIZE;
+    }
+
+    if (host_memory_backend_is_mapped(hostmem)) {
+        error_setg(errp, "memory backend already mapped");
+        return NULL;
+    }
+
+    count = memory_device_get_region_size(md, &error_abort) / HV_BALLOON_PAGE_SIZE;
+    if (!count) {
+        error_setg(errp, "memory backend too small to be usable");
+        return NULL;
+    }
+
+    memory_device_pre_plug(md, ms, &align, errp);
+    if (*errp) {
+        return NULL;
+    }
+
+    host_memory_backend_set_mapped(hostmem, true);
+
+    memory_device_plug(md, ms);
+    vmstate_register_ram(host_memory_backend_get_memory(hostmem), DEVICE(md));
+
+    addr = mdc->get_addr(md);
+    assert(QEMU_IS_ALIGNED(addr, align));
+
+    our_range = g_malloc(sizeof(*our_range));
+    our_range_init(&our_range->range, addr / HV_BALLOON_PAGE_SIZE, count);
+    our_range->md = md;
+    our_range->hostmem = hostmem;
+
+    return our_range;
+}
+
+static void our_range_plugged_free(OurRangePlugged *our_range)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MemoryRegion *mr;
+    RAMBlock *rb;
+    MemoryDeviceClass *mdc;
+
+    mr = host_memory_backend_get_memory(our_range->hostmem);
+    assert(mr);
+
+    rb = mr->ram_block;
+    ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb));
+
+    memory_device_unplug(our_range->md, ms);
+    vmstate_unregister_ram(mr, DEVICE(our_range->md));
+
+    host_memory_backend_set_mapped(our_range->hostmem, false);
+
+    mdc = MEMORY_DEVICE_GET_CLASS(our_range->md);
+    mdc->set_addr(our_range->md, 0, &error_abort);
+
+    our_range_destroy(&our_range->range);
+    g_free(our_range);
+}
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(OurRangePlugged, our_range_plugged_free)
+
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
+/* TODO: unify the code below with virtio-balloon and cache the value */
+static int build_dimm_list(Object *obj, void *opaque)
+{
+    GSList **list = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
+        DeviceState *dev = DEVICE(obj);
+        if (dev->realized) { /* only realized DIMMs matter */
+            *list = g_slist_prepend(*list, dev);
+        }
+    }
+
+    object_child_foreach(obj, build_dimm_list, opaque);
+    return 0;
+}
+
+static ram_addr_t get_current_ram_size(void)
+{
+    GSList *list = NULL, *item;
+    ram_addr_t size = current_machine->ram_size;
+
+    build_dimm_list(qdev_get_machine(), &list);
+    for (item = list; item; item = g_slist_next(item)) {
+        Object *obj = OBJECT(item->data);
+        if (!strcmp(object_get_typename(obj), TYPE_PC_DIMM))
+            size += object_property_get_int(obj, PC_DIMM_SIZE_PROP,
+                                            &error_abort);
+    }
+    g_slist_free(list);
+
+    return size;
+}
+
+/* total RAM includes memory currently removed from the guest */
+static uint64_t hv_balloon_total_ram(HvBalloon *balloon)
+{
+    ram_addr_t ram_size = get_current_ram_size();
+    uint64_t ram_size_pages = ram_size >> HV_BALLOON_PFN_SHIFT;
+    uint64_t our_ram_size_pages = hv_balloon_total_our_ram(balloon);
+
+    assert(ram_size_pages > 0);
+
+    return SUM_SATURATE_U64(ram_size_pages, our_ram_size_pages);
+}
+
+/*
+ * calculating the total RAM size is a slow operation,
+ * avoid it as much as possible
+ */
+static uint64_t hv_balloon_total_removed_rs(HvBalloon *balloon,
+                                            uint64_t ram_size_pages)
+{
+    uint64_t total_removed;
+
+    total_removed = SUM_SATURATE_U64(balloon->removed_guest_ctr,
+                                     balloon->removed_both_ctr);
+
+    /* possible if guest returns pages outside actual RAM */
+    if (total_removed > ram_size_pages) {
+        total_removed = ram_size_pages;
+    }
+
+    return total_removed;
+}
+
+/* Returns whether the state has actually changed */
+static bool hv_balloon_state_set(HvBalloon *balloon,
+                                 State newst, const char *newststr)
+{
+    if (newst == S_NO_CHANGE || balloon->state == newst) {
+        return false;
+    }
+
+    balloon->state = newst;
+    trace_hv_balloon_state_change(newststr);
+    return true;
+}
+
+static void _hv_balloon_state_desc_set(StateDesc *stdesc,
+                                       State newst, const char *newststr)
+{
+    /* state setting is only permitted on a freshly init desc */
+    assert(stdesc->state == S_NO_CHANGE);
+
+    assert(newst != S_NO_CHANGE);
+
+    stdesc->state = newst;
+    stdesc->desc = newststr;
+}
+
+static VMBusChannel *hv_balloon_get_channel_maybe(HvBalloon *balloon)
+{
+    return vmbus_device_channel(&balloon->parent, 0);
+}
+
+static VMBusChannel *hv_balloon_get_channel(HvBalloon *balloon)
+{
+    VMBusChannel *chan;
+
+    chan = hv_balloon_get_channel_maybe(balloon);
+    assert(chan != NULL);
+    return chan;
+}
+
+static ssize_t hv_balloon_send_packet(VMBusChannel *chan,
+                                      struct dm_message *msg)
+{
+    int ret;
+
+    ret = vmbus_channel_reserve(chan, 0, msg->hdr.size);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return vmbus_channel_send(chan, VMBUS_PACKET_DATA_INBAND,
+                              NULL, 0, msg, msg->hdr.size, false,
+                              msg->hdr.trans_id);
+}
+
+static bool hv_balloon_unballoon_get_source(HvBalloon *balloon,
+                                            PageRangeTree *dtree,
+                                            uint64_t **dctr,
+                                            bool *is_our_range)
+{
+    OurRange *our_range = OUR_RANGE(balloon->our_range);
+
+    /* Try the boot memory first */
+    if (g_tree_nnodes(balloon->removed_guest.t) > 0) {
+        *dtree = balloon->removed_guest;
+        *dctr = &balloon->removed_guest_ctr;
+        *is_our_range = false;
+    } else if (g_tree_nnodes(balloon->removed_both.t) > 0) {
+        *dtree = balloon->removed_both;
+        *dctr = &balloon->removed_both_ctr;
+        *is_our_range = false;
+    } else if (!our_range) {
+        return false;
+    } else if (g_tree_nnodes(our_range->removed_guest.t) > 0) {
+        *dtree = our_range->removed_guest;
+        *dctr = &balloon->removed_guest_ctr;
+        *is_our_range = true;
+    } else if (g_tree_nnodes(our_range->removed_both.t) > 0) {
+        *dtree = our_range->removed_both;
+        *dctr = &balloon->removed_both_ctr;
+        *is_our_range = true;
+    } else {
+        return false;
+    }
+
+    return true;
+}
+
+static void hv_balloon_unballoon_rb_wait(HvBalloon *balloon, StateDesc *stdesc)
+{
+    VMBusChannel *chan = hv_balloon_get_channel(balloon);
+    struct dm_unballoon_request *ur;
+    size_t ur_size = sizeof(*ur) + sizeof(ur->range_array[0]);
+
+    assert(balloon->state == S_UNBALLOON_RB_WAIT);
+
+    if (vmbus_channel_reserve(chan, 0, ur_size) < 0) {
+        return;
+    }
+
+    HV_BALLOON_STATE_DESC_SET(stdesc, S_UNBALLOON_POSTING);
+}
+
+static void hv_balloon_unballoon_posting(HvBalloon *balloon, StateDesc *stdesc)
+{
+    VMBusChannel *chan = hv_balloon_get_channel(balloon);
+    PageRangeTree dtree;
+    uint64_t *dctr;
+    bool our_range;
+    struct dm_unballoon_request *ur;
+    size_t ur_size = sizeof(*ur) + sizeof(ur->range_array[0]);
+    PageRange range;
+    bool bret;
+    ssize_t ret;
+
+    assert(balloon->state == S_UNBALLOON_POSTING);
+    assert(balloon->unballoon_diff > 0);
+
+    if (!hv_balloon_unballoon_get_source(balloon, &dtree, &dctr, &our_range)) {
+        error_report("trying to unballoon but nothing seems to be ballooned");
+        /*
+         * there is little we can do as we might have already
+         * sent the guest a partial request we can't cancel
+         */
+        return;
+    }
+
+    assert(balloon->our_range || !our_range);
+    assert(dtree.t);
+    assert(dctr);
+
+    ur = alloca(ur_size);
+    memset(ur, 0, ur_size);
+    ur->hdr.type = DM_UNBALLOON_REQUEST;
+    ur->hdr.size = ur_size;
+    ur->hdr.trans_id = balloon->trans_id;
+
+    bret = page_range_tree_pop(dtree, &range, MIN(balloon->unballoon_diff,
+                                                  HV_BALLOON_HA_CHUNK_PAGES));
+    assert(bret);
+    /* TODO: madvise? */
+
+    *dctr -= range.count;
+    balloon->unballoon_diff -= range.count;
+
+    ur->range_count = 1;
+    ur->range_array[0].finfo.start_page = range.start;
+    ur->range_array[0].finfo.page_cnt = range.count;
+    ur->more_pages = balloon->unballoon_diff > 0;
+
+    trace_hv_balloon_outgoing_unballoon(ur->hdr.trans_id,
+                                        range.count, range.start,
+                                        balloon->unballoon_diff);
+
+    if (ur->more_pages) {
+        HV_BALLOON_STATE_DESC_SET(stdesc, S_UNBALLOON_RB_WAIT);
+    } else {
+        HV_BALLOON_STATE_DESC_SET(stdesc, S_UNBALLOON_REPLY_WAIT);
+    }
+
+    ret = vmbus_channel_send(chan, VMBUS_PACKET_DATA_INBAND,
+                             NULL, 0, ur, ur_size, false,
+                             ur->hdr.trans_id);
+    if (ret <= 0) {
+        error_report("error %zd when posting unballoon msg, expect problems",
+                     ret);
+    }
+}
+
+static bool hv_balloon_our_range_ensure(HvBalloon *balloon)
+{
+    uint64_t align;
+    g_autoptr(OurRangePlugged) our_range_plugged = NULL;
+    g_autoptr(Error) our_range_error = NULL;
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
+    our_range_plugged = our_range_plugged_new(MEMORY_DEVICE(balloon), balloon->hostmem,
+                                              align, &our_range_error);
+    if (our_range_error) {
+        error_reportf_err(g_steal_pointer(&our_range_error),
+                          "cannot create our range from memory backend: ");
+        return false;
+    }
+
+    our_range = OUR_RANGE(our_range_plugged);
+    if (page_range_tree_intree_any(balloon->removed_guest,
+                                   our_range->range.start, our_range->range.count) ||
+        page_range_tree_intree_any(balloon->removed_both,
+                                   our_range->range.start, our_range->range.count)) {
+        error_report("some parts of the memory backend were already returned by the guest. this should not happen, please reboot the guest and try again");
+        return false;
+    }
+
+    trace_hv_balloon_our_range_add(our_range->range.count, our_range->range.start);
+
+    balloon->our_range = g_steal_pointer(&our_range_plugged);
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
+    align = (1 << balloon->caps.cap_bits.hot_add_alignment) *
+        (MiB / HV_BALLOON_PAGE_SIZE);
+
+    if (!hv_balloon_our_range_ensure(balloon)) {
+        goto ret_idle;
+    }
+
+    our_range = OUR_RANGE(balloon->our_range);
+
+    hot_add_range->start = our_range->range.start + our_range->added;
+    assert(QEMU_IS_ALIGNED(hot_add_range->start, align));
+
+    our_range_remaining = our_range->range.count - our_range->added -
+        our_range->unusable_tail;
+    hot_add_range->count = MIN(our_range_remaining, hot_add_diff);
+    hot_add_range->count = QEMU_ALIGN_DOWN(hot_add_range->count, align);
+    if (hot_add_range->count == 0) {
+        goto ret_idle;
+    }
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
+static void hv_balloon_balloon_rb_wait(HvBalloon *balloon, StateDesc *stdesc)
+{
+    VMBusChannel *chan = hv_balloon_get_channel(balloon);
+    size_t bl_size = sizeof(struct dm_balloon);
+
+    assert(balloon->state == S_BALLOON_RB_WAIT);
+
+    if (vmbus_channel_reserve(chan, 0, bl_size) < 0) {
+        return;
+    }
+
+    HV_BALLOON_STATE_DESC_SET(stdesc, S_BALLOON_POSTING);
+}
+
+static void hv_balloon_balloon_posting(HvBalloon *balloon, StateDesc *stdesc)
+{
+    VMBusChannel *chan = hv_balloon_get_channel(balloon);
+    struct dm_balloon bl;
+    size_t bl_size = sizeof(bl);
+    ssize_t ret;
+
+    assert(balloon->state == S_BALLOON_POSTING);
+    assert(balloon->balloon_diff > 0);
+
+    memset(&bl, 0, sizeof(bl));
+    bl.hdr.type = DM_BALLOON_REQUEST;
+    bl.hdr.size = bl_size;
+    bl.hdr.trans_id = balloon->trans_id;
+    bl.num_pages = MIN(balloon->balloon_diff, HV_BALLOON_HR_CHUNK_PAGES);
+
+    trace_hv_balloon_outgoing_balloon(bl.hdr.trans_id, bl.num_pages,
+                                      balloon->balloon_diff);
+
+    ret = vmbus_channel_send(chan, VMBUS_PACKET_DATA_INBAND,
+                             NULL, 0, &bl, bl_size, false,
+                             bl.hdr.trans_id);
+    if (ret <= 0) {
+        error_report("error %zd when posting balloon msg, expect problems",
+                     ret);
+    }
+
+    HV_BALLOON_STATE_DESC_SET(stdesc, S_BALLOON_REPLY_WAIT);
+}
+
+static void hv_balloon_idle_state_process_target(HvBalloon *balloon,
+                                                 StateDesc *stdesc)
+{
+    bool can_balloon = balloon->caps.cap_bits.balloon;
+    uint64_t ram_size_pages, total_removed;
+
+    ram_size_pages = hv_balloon_total_ram(balloon);
+    total_removed = hv_balloon_total_removed_rs(balloon, ram_size_pages);
+
+    /*
+     * we need to cache the values computed from the balloon target value when
+     * starting the adjustment procedure in case someone changes the target when
+     * the procedure is in progress
+     */
+    if (balloon->target > ram_size_pages - total_removed) {
+        bool can_hot_add = balloon->caps.cap_bits.hot_add;
+        uint64_t target_diff = balloon->target -
+            (ram_size_pages - total_removed);
+
+        balloon->unballoon_diff = MIN(target_diff, total_removed);
+
+        if (can_hot_add) {
+            balloon->hot_add_diff = target_diff - balloon->unballoon_diff;
+        } else {
+            balloon->hot_add_diff = 0;
+        }
+
+        if (balloon->unballoon_diff > 0) {
+            assert(can_balloon);
+            HV_BALLOON_STATE_DESC_SET(stdesc, S_UNBALLOON_RB_WAIT);
+        } else if (balloon->hot_add_diff > 0) {
+            HV_BALLOON_STATE_DESC_SET(stdesc, S_HOT_ADD_SETUP);
+        }
+    } else if (can_balloon &&
+               balloon->target < ram_size_pages - total_removed) {
+        balloon->balloon_diff = ram_size_pages - total_removed - balloon->target;
+        HV_BALLOON_STATE_DESC_SET(stdesc, S_BALLOON_RB_WAIT);
+    }
+}
+
+static void hv_balloon_idle_state(HvBalloon *balloon,
+                                  StateDesc *stdesc)
+{
+    assert(balloon->state == S_IDLE);
+
+    if (balloon->target_changed) {
+        balloon->target_changed = false;
+        hv_balloon_idle_state_process_target(balloon, stdesc);
+        return;
+    }
+}
+
+static const struct {
+    void (*handler)(HvBalloon *balloon, StateDesc *stdesc);
+} state_handlers[] = {
+    [S_IDLE].handler = hv_balloon_idle_state,
+    [S_BALLOON_POSTING].handler = hv_balloon_balloon_posting,
+    [S_BALLOON_RB_WAIT].handler = hv_balloon_balloon_rb_wait,
+    [S_UNBALLOON_POSTING].handler = hv_balloon_unballoon_posting,
+    [S_UNBALLOON_RB_WAIT].handler = hv_balloon_unballoon_rb_wait,
+    [S_HOT_ADD_SETUP].handler = hv_balloon_hot_add_setup,
+    [S_HOT_ADD_RB_WAIT].handler = hv_balloon_hot_add_rb_wait,
+    [S_HOT_ADD_POSTING].handler = hv_balloon_hot_add_posting,
+};
+
+static void hv_balloon_handle_state(HvBalloon *balloon, StateDesc *stdesc)
+{
+    if (balloon->state >= ARRAY_SIZE(state_handlers) ||
+        !state_handlers[balloon->state].handler) {
+        return;
+    }
+
+    state_handlers[balloon->state].handler(balloon, stdesc);
+}
+
+static void hv_balloon_remove_response_insert_range(PageRangeTree tree,
+                                                    const PageRange *range,
+                                                    uint64_t *ctr1,
+                                                    uint64_t *ctr2,
+                                                    uint64_t *ctr3)
+{
+    uint64_t dupcount, effcount;
+
+    if (range->count == 0) {
+        return;
+    }
+
+    dupcount = 0;
+    page_range_tree_insert(tree, range->start, range->count, &dupcount);
+
+    assert(dupcount <= range->count);
+    effcount = range->count - dupcount;
+
+    *ctr1 += effcount;
+    *ctr2 += effcount;
+    if (ctr3) {
+        *ctr3 += effcount;
+    }
+}
+
+static void hv_balloon_remove_response_handle_range(HvBalloon *balloon,
+                                                    PageRange *range,
+                                                    bool both,
+                                                    uint64_t *removedctr)
+{
+    OurRange *our_range = OUR_RANGE(balloon->our_range);
+    PageRangeTree globaltree =
+        both ? balloon->removed_both : balloon->removed_guest;
+    uint64_t *globalctr =
+        both ? &balloon->removed_both_ctr : &balloon->removed_guest_ctr;
+    PageRange rangeeff;
+
+    if (range->count == 0) {
+        return;
+    }
+
+    trace_hv_balloon_remove_response(range->count, range->start, both);
+
+    if (our_range) {
+        /* Includes the not-yet-hot-added and unusable parts. */
+        rangeeff = our_range->range;
+    } else {
+        rangeeff.start = rangeeff.count = 0;
+    }
+
+    if (page_range_intersection_size(range, rangeeff.start, rangeeff.count) > 0) {
+        PageRangeTree ourtree =
+            both ? our_range->removed_both : our_range->removed_guest;
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
+    if (range->count > 0) {
+        hv_balloon_remove_response_insert_range(globaltree, range,
+                                                globalctr, removedctr, NULL);
+        trace_hv_balloon_remove_response_remainder(range->count, range->start,
+                                                   both);
+        range->count = 0;
+    }
+}
+
+static void hv_balloon_remove_response_handle_pages(HvBalloon *balloon,
+                                                    PageRange *range,
+                                                    uint64_t start,
+                                                    uint64_t count,
+                                                    bool both,
+                                                    uint64_t *removedctr)
+{
+    assert(count > 0);
+
+    /*
+     * if there is an existing range that the new range can't be joined to
+     * dump it into tree(s)
+     */
+    if (range->count > 0 && !page_range_joinable(range, start, count)) {
+        hv_balloon_remove_response_handle_range(balloon, range, both,
+                                                removedctr);
+    }
+
+    if (range->count == 0) {
+        range->start = start;
+        range->count = count;
+    } else if (page_range_joinable_left(range, start, count)) {
+        range->start = start;
+        range->count += count;
+    } else { /* page_range_joinable_right() */
+        range->count += count;
+    }
+}
+
+static gboolean hv_balloon_handle_remove_host_addr_node(gpointer key,
+                                                        gpointer value,
+                                                        gpointer data)
+{
+    PageRange *range = value;
+    uint64_t pageoff;
+
+    for (pageoff = 0; pageoff < range->count; ) {
+        void *addr = (void *)((range->start + pageoff) * HV_BALLOON_PAGE_SIZE);
+        RAMBlock *rb;
+        ram_addr_t rb_offset;
+        size_t rb_page_size;
+        size_t discard_size;
+
+        rb = qemu_ram_block_from_host(addr, false, &rb_offset);
+        rb_page_size = qemu_ram_pagesize(rb);
+
+        if (rb_page_size != HV_BALLOON_PAGE_SIZE) {
+            /* TODO: these should end in "removed_guest" */
+            warn_report("guest reported removed page backed by unsupported page size %zu",
+                        rb_page_size);
+            pageoff++;
+            continue;
+        }
+
+        discard_size = MIN(range->count - pageoff,
+                           (rb->max_length - rb_offset) /
+                           HV_BALLOON_PAGE_SIZE);
+        discard_size = MAX(discard_size, 1);
+
+        if (ram_block_discard_range(rb, rb_offset, discard_size *
+                                    HV_BALLOON_PAGE_SIZE) != 0) {
+            warn_report("guest reported removed page failed discard");
+        }
+
+        pageoff += discard_size;
+    }
+
+    return false;
+}
+
+static void hv_balloon_handle_remove_host_addr_tree(PageRangeTree tree)
+{
+    g_tree_foreach(tree.t, hv_balloon_handle_remove_host_addr_node, NULL);
+}
+
+static int hv_balloon_handle_remove_section(PageRangeTree tree,
+                                            const MemoryRegionSection *section,
+                                            uint64_t count)
+{
+    void *addr = memory_region_get_ram_ptr(section->mr) +
+        section->offset_within_region;
+    uint64_t addr_page;
+
+    assert(count > 0);
+
+    if ((uintptr_t)addr % HV_BALLOON_PAGE_SIZE) {
+        warn_report("guest reported removed pages at an unaligned host addr %p",
+                    addr);
+        return -EINVAL;
+    }
+
+    addr_page = (uintptr_t)addr / HV_BALLOON_PAGE_SIZE;
+    page_range_tree_insert(tree, addr_page, count, NULL);
+
+    return 0;
+}
+
+static void hv_balloon_handle_remove_ranges(HvBalloon *balloon,
+                                            union dm_mem_page_range ranges[],
+                                            uint32_t count)
+{
+    uint64_t removedcnt;
+    PageRangeTree removed_host_addr;
+    PageRange range_guest, range_both;
+
+    page_range_tree_init(&removed_host_addr);
+    range_guest.count = range_both.count = removedcnt = 0;
+    for (unsigned int ctr = 0; ctr < count; ctr++) {
+        union dm_mem_page_range *mr = &ranges[ctr];
+        hwaddr pa;
+        MemoryRegionSection section;
+
+        for (unsigned int offset = 0; offset < mr->finfo.page_cnt; ) {
+            int ret;
+            uint64_t pageno = mr->finfo.start_page + offset;
+            uint64_t pagecnt = 1;
+
+            pa = (hwaddr)pageno << HV_BALLOON_PFN_SHIFT;
+            section = memory_region_find(get_system_memory(), pa,
+                                         (mr->finfo.page_cnt - offset) *
+                                         HV_BALLOON_PAGE_SIZE);
+            if (!section.mr) {
+                warn_report("guest reported removed page %"PRIu64" not found in RAM",
+                            pageno);
+                ret = -EINVAL;
+                goto finish_page;
+            }
+
+            pagecnt = section.size / HV_BALLOON_PAGE_SIZE;
+            if (pagecnt <= 0) {
+                warn_report("guest reported removed page %"PRIu64" in a section smaller than page size",
+                            pageno);
+                pagecnt = 1; /* skip the whole page */
+                ret = -EINVAL;
+                goto finish_page;
+            }
+
+            if (!memory_region_is_ram(section.mr) ||
+                memory_region_is_rom(section.mr) ||
+                memory_region_is_romd(section.mr)) {
+                warn_report("guest reported removed page %"PRIu64" in a section that is not an ordinary RAM",
+                            pageno);
+                ret = -EINVAL;
+                goto finish_page;
+            }
+
+            ret = hv_balloon_handle_remove_section(removed_host_addr, &section,
+                                                   pagecnt);
+
+        finish_page:
+            if (ret == 0) {
+                hv_balloon_remove_response_handle_pages(balloon,
+                                                        &range_both,
+                                                        pageno, pagecnt,
+                                                        true, &removedcnt);
+            } else {
+                hv_balloon_remove_response_handle_pages(balloon,
+                                                        &range_guest,
+                                                        pageno, pagecnt,
+                                                        false, &removedcnt);
+            }
+
+            if (section.mr) {
+                memory_region_unref(section.mr);
+            }
+
+            offset += pagecnt;
+        }
+    }
+
+    hv_balloon_remove_response_handle_range(balloon, &range_both, true,
+                                            &removedcnt);
+    hv_balloon_remove_response_handle_range(balloon, &range_guest, false,
+                                            &removedcnt);
+
+    hv_balloon_handle_remove_host_addr_tree(removed_host_addr);
+    page_range_tree_destroy(&removed_host_addr);
+
+    if (removedcnt > balloon->balloon_diff) {
+        warn_report("guest reported more pages removed than currently pending (%"PRIu64" vs %"PRIu64")",
+                    removedcnt, balloon->balloon_diff);
+        balloon->balloon_diff = 0;
+    } else {
+        balloon->balloon_diff -= removedcnt;
+    }
+}
+
+static bool hv_balloon_handle_msg_size(HvBalloonReq *req, size_t minsize,
+                                       const char *msgname)
+{
+    VMBusChanReq *vmreq = &req->vmreq;
+    uint32_t msglen = vmreq->msglen;
+
+    if (msglen >= minsize) {
+        return true;
+    }
+
+    warn_report("%s message too short (%u vs %zu), ignoring", msgname,
+                (unsigned int)msglen, minsize);
+    return false;
+}
+
+static void hv_balloon_handle_version_request(HvBalloon *balloon,
+                                              HvBalloonReq *req,
+                                              StateDesc *stdesc)
+{
+    VMBusChanReq *vmreq = &req->vmreq;
+    struct dm_version_request *msgVr = vmreq->msg;
+    struct dm_version_response respVr;
+
+    if (balloon->state != S_VERSION) {
+        warn_report("unexpected DM_VERSION_REQUEST in %d state",
+                    balloon->state);
+        return;
+    }
+
+    if (!hv_balloon_handle_msg_size(req, sizeof(*msgVr),
+                                    "DM_VERSION_REQUEST")) {
+        return;
+    }
+
+    trace_hv_balloon_incoming_version(msgVr->version.major_version,
+                                      msgVr->version.minor_version);
+
+    memset(&respVr, 0, sizeof(respVr));
+    respVr.hdr.type = DM_VERSION_RESPONSE;
+    respVr.hdr.size = sizeof(respVr);
+    respVr.hdr.trans_id = msgVr->hdr.trans_id;
+    respVr.is_accepted = msgVr->version.version >= DYNMEM_PROTOCOL_VERSION_1 &&
+        msgVr->version.version <= DYNMEM_PROTOCOL_VERSION_3;
+
+    hv_balloon_send_packet(vmreq->chan, (struct dm_message *)&respVr);
+
+    if (respVr.is_accepted) {
+        HV_BALLOON_STATE_DESC_SET(stdesc, S_CAPS);
+    }
+}
+
+static void hv_balloon_handle_caps_report(HvBalloon *balloon,
+                                          HvBalloonReq *req,
+                                          StateDesc *stdesc)
+{
+    VMBusChanReq *vmreq = &req->vmreq;
+    struct dm_capabilities *msgCap = vmreq->msg;
+    struct dm_capabilities_resp_msg respCap;
+
+    if (balloon->state != S_CAPS) {
+        warn_report("unexpected DM_CAPABILITIES_REPORT in %d state",
+                    balloon->state);
+        return;
+    }
+
+    if (!hv_balloon_handle_msg_size(req, sizeof(*msgCap),
+                                    "DM_CAPABILITIES_REPORT")) {
+        return;
+    }
+
+    trace_hv_balloon_incoming_caps(msgCap->caps.caps);
+    balloon->caps = msgCap->caps;
+
+    memset(&respCap, 0, sizeof(respCap));
+    respCap.hdr.type = DM_CAPABILITIES_RESPONSE;
+    respCap.hdr.size = sizeof(respCap);
+    respCap.hdr.trans_id = msgCap->hdr.trans_id;
+    respCap.is_accepted = 1;
+    respCap.hot_remove = 1;
+    respCap.suppress_pressure_reports = !balloon->status_reports;
+    hv_balloon_send_packet(vmreq->chan, (struct dm_message *)&respCap);
+
+    timer_mod(&balloon->post_init_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+              HV_BALLOON_POST_INIT_WAIT);
+
+    HV_BALLOON_STATE_DESC_SET(stdesc, S_POST_INIT_WAIT);
+}
+
+static void hv_balloon_handle_status_report(HvBalloon *balloon,
+                                            HvBalloonReq *req)
+{
+    VMBusChanReq *vmreq = &req->vmreq;
+    struct dm_status *msgStatus = vmreq->msg;
+
+    if (!hv_balloon_handle_msg_size(req, sizeof(*msgStatus),
+                                    "DM_STATUS_REPORT")) {
+        return;
+    }
+
+    if (!balloon->status_reports) {
+        return;
+    }
+
+    qapi_event_send_hv_balloon_status_report((uint64_t)msgStatus->num_committed *
+                                             HV_BALLOON_PAGE_SIZE,
+                                             (uint64_t)msgStatus->num_avail *
+                                             HV_BALLOON_PAGE_SIZE);
+}
+
+static void hv_balloon_handle_unballoon_response(HvBalloon *balloon,
+                                                 HvBalloonReq *req,
+                                                 StateDesc *stdesc)
+{
+    VMBusChanReq *vmreq = &req->vmreq;
+    struct dm_unballoon_response *msgUrR = vmreq->msg;
+
+    if (balloon->state != S_UNBALLOON_REPLY_WAIT) {
+        warn_report("unexpected DM_UNBALLOON_RESPONSE in %d state",
+                    balloon->state);
+        return;
+    }
+
+    if (!hv_balloon_handle_msg_size(req, sizeof(*msgUrR),
+                                    "DM_UNBALLOON_RESPONSE"))
+        return;
+
+    trace_hv_balloon_incoming_unballoon(msgUrR->hdr.trans_id);
+
+    balloon->trans_id++;
+
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
+        our_range->added += msgHaR->page_count;
+        hot_add_range->start += msgHaR->page_count;
+        hot_add_range->count -= msgHaR->page_count;
+    }
+
+    if (!msgHaR->result || msgHaR->page_count < balloon->ha_current_count) {
+        /*
+         * the current planned range was only partially hot-added, take note
+         * how much of it remains and don't attempt any further hot adds
+         */
+        our_range->unusable_tail = our_range->range.count - our_range->added;
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
+    HV_BALLOON_STATE_DESC_SET(stdesc, S_IDLE);
+}
+
+static void hv_balloon_handle_balloon_response(HvBalloon *balloon,
+                                               HvBalloonReq *req,
+                                               StateDesc *stdesc)
+{
+    VMBusChanReq *vmreq = &req->vmreq;
+    struct dm_balloon_response *msgBR = vmreq->msg;
+
+    if (balloon->state != S_BALLOON_REPLY_WAIT) {
+        warn_report("unexpected DM_BALLOON_RESPONSE in %d state",
+                    balloon->state);
+        return;
+    }
+
+    if (!hv_balloon_handle_msg_size(req, sizeof(*msgBR),
+                                    "DM_BALLOON_RESPONSE"))
+        return;
+
+    trace_hv_balloon_incoming_balloon(msgBR->hdr.trans_id, msgBR->range_count,
+                                      msgBR->more_pages);
+
+    if (vmreq->msglen < sizeof(*msgBR) +
+        (uint64_t)sizeof(msgBR->range_array[0]) * msgBR->range_count) {
+        warn_report("DM_BALLOON_RESPONSE too short for the range count");
+        return;
+    }
+
+    if (msgBR->range_count == 0) {
+        /* The guest is already at its minimum size */
+        balloon->balloon_diff = 0;
+        goto ret_end_trans;
+    } else {
+        hv_balloon_handle_remove_ranges(balloon,
+                                        msgBR->range_array,
+                                        msgBR->range_count);
+    }
+
+    /* More responses expected? */
+    if (msgBR->more_pages) {
+        return;
+    }
+
+ret_end_trans:
+    balloon->trans_id++;
+
+    if (balloon->balloon_diff > 0) {
+        HV_BALLOON_STATE_DESC_SET(stdesc, S_BALLOON_RB_WAIT);
+    } else {
+        HV_BALLOON_STATE_DESC_SET(stdesc, S_IDLE);
+    }
+}
+
+static void hv_balloon_handle_packet(HvBalloon *balloon, HvBalloonReq *req,
+                                     StateDesc *stdesc)
+{
+    VMBusChanReq *vmreq = &req->vmreq;
+    struct dm_message *msg = vmreq->msg;
+
+    if (vmreq->msglen < sizeof(msg->hdr)) {
+        return;
+    }
+
+    switch (msg->hdr.type) {
+    case DM_VERSION_REQUEST:
+        hv_balloon_handle_version_request(balloon, req, stdesc);
+        break;
+
+    case DM_CAPABILITIES_REPORT:
+        hv_balloon_handle_caps_report(balloon, req, stdesc);
+        break;
+
+    case DM_STATUS_REPORT:
+        hv_balloon_handle_status_report(balloon, req);
+        break;
+
+    case DM_MEM_HOT_ADD_RESPONSE:
+        hv_balloon_handle_hot_add_response(balloon, req, stdesc);
+        break;
+
+    case DM_UNBALLOON_RESPONSE:
+        hv_balloon_handle_unballoon_response(balloon, req, stdesc);
+        break;
+
+    case DM_BALLOON_RESPONSE:
+        hv_balloon_handle_balloon_response(balloon, req, stdesc);
+        break;
+
+    default:
+        warn_report("unknown DM message %u", msg->hdr.type);
+        break;
+    }
+}
+
+static bool hv_balloon_recv_channel(HvBalloon *balloon, StateDesc *stdesc)
+{
+    VMBusChannel *chan;
+    HvBalloonReq *req;
+
+    if (balloon->state == S_WAIT_RESET ||
+        balloon->state == S_POST_RESET_CLOSED) {
+        return false;
+    }
+
+    chan = hv_balloon_get_channel(balloon);
+    if (vmbus_channel_recv_start(chan)) {
+        return false;
+    }
+
+    while ((req = vmbus_channel_recv_peek(chan, sizeof(*req)))) {
+        hv_balloon_handle_packet(balloon, req, stdesc);
+        vmbus_free_req(req);
+        vmbus_channel_recv_pop(chan);
+
+        if (stdesc->state != S_NO_CHANGE) {
+            break;
+        }
+    }
+
+    return vmbus_channel_recv_done(chan) > 0;
+}
+
+/* old state handler -> new state transition (potential) */
+static bool hv_balloon_event_loop_state(HvBalloon *balloon)
+{
+    StateDesc state_new = HV_BALLOON_STATE_DESC_INIT;
+
+    hv_balloon_handle_state(balloon, &state_new);
+    return hv_balloon_state_set(balloon, state_new.state, state_new.desc);
+}
+
+/* VMBus message -> new state transition (potential) */
+static bool hv_balloon_event_loop_recv(HvBalloon *balloon)
+{
+    StateDesc state_new = HV_BALLOON_STATE_DESC_INIT;
+    bool any_recv, state_changed;
+
+    any_recv = hv_balloon_recv_channel(balloon, &state_new);
+    state_changed = hv_balloon_state_set(balloon,
+                                         state_new.state, state_new.desc);
+
+    return state_changed || any_recv;
+}
+
+static void hv_balloon_event_loop(HvBalloon *balloon)
+{
+    bool state_repeat, recv_repeat;
+
+    do {
+        state_repeat = hv_balloon_event_loop_state(balloon);
+        recv_repeat = hv_balloon_event_loop_recv(balloon);
+    } while (state_repeat || recv_repeat);
+}
+
+static void hv_balloon_vmdev_chan_notify(VMBusChannel *chan)
+{
+    HvBalloon *balloon = HV_BALLOON(vmbus_channel_device(chan));
+
+    hv_balloon_event_loop(balloon);
+}
+
+static void hv_balloon_stat(void *opaque, BalloonInfo *info)
+{
+    HvBalloon *balloon = opaque;
+    info->actual = (hv_balloon_total_ram(balloon) - balloon->removed_both_ctr)
+        << HV_BALLOON_PFN_SHIFT;
+}
+
+static void hv_balloon_to_target(void *opaque, ram_addr_t target)
+{
+    HvBalloon *balloon = opaque;
+    uint64_t target_pages = target >> HV_BALLOON_PFN_SHIFT;
+
+    if (!target_pages) {
+        return;
+    }
+
+    /*
+     * always set target_changed, even with unchanged target, as the user
+     * might be asking us to try again reaching it
+     */
+    balloon->target = target_pages;
+    balloon->target_changed = true;
+
+    hv_balloon_event_loop(balloon);
+}
+
+static int hv_balloon_vmdev_open_channel(VMBusChannel *chan)
+{
+    HvBalloon *balloon = HV_BALLOON(vmbus_channel_device(chan));
+
+    if (balloon->state != S_POST_RESET_CLOSED) {
+        warn_report("guest trying to open a DM channel in invalid %d state",
+                    balloon->state);
+        return -EINVAL;
+    }
+
+    HV_BALLOON_SET_STATE(balloon, S_VERSION);
+    hv_balloon_event_loop(balloon);
+
+    return 0;
+}
+
+static void hv_balloon_vmdev_close_channel(VMBusChannel *chan)
+{
+    HvBalloon *balloon = HV_BALLOON(vmbus_channel_device(chan));
+
+    timer_del(&balloon->post_init_timer);
+
+    HV_BALLOON_SET_STATE(balloon, S_WAIT_RESET);
+    hv_balloon_event_loop(balloon);
+}
+
+static void hv_balloon_post_init_timer(void *opaque)
+{
+    HvBalloon *balloon = opaque;
+
+    if (balloon->state != S_POST_INIT_WAIT) {
+        return;
+    }
+
+    HV_BALLOON_SET_STATE(balloon, S_IDLE);
+    hv_balloon_event_loop(balloon);
+}
+
+static void hv_balloon_system_reset_unrealize_common(HvBalloon *balloon)
+{
+    g_clear_pointer(&balloon->our_range, our_range_plugged_free);
+}
+
+static void hv_balloon_system_reset(void *opaque)
+{
+    HvBalloon *balloon = HV_BALLOON(opaque);
+
+    hv_balloon_system_reset_unrealize_common(balloon);
+}
+
+static void hv_balloon_vmdev_realize(VMBusDevice *vdev, Error **errp)
+{
+    ERRP_GUARD();
+    HvBalloon *balloon = HV_BALLOON(vdev);
+    int ret;
+
+    balloon->state = S_WAIT_RESET;
+
+    ret = qemu_add_balloon_handler(hv_balloon_to_target, hv_balloon_stat,
+                                   balloon);
+    if (ret < 0) {
+        /* This also protects against having multiple hv-balloon instances */
+        error_setg(errp, "Only one balloon device is supported");
+        return;
+    }
+
+    timer_init_ms(&balloon->post_init_timer, QEMU_CLOCK_VIRTUAL,
+                  hv_balloon_post_init_timer, balloon);
+
+    qemu_register_reset(hv_balloon_system_reset, balloon);
+}
+
+/*
+ * VMBus device reset has to be implemented in case the guest decides to
+ * disconnect and reconnect to the VMBus without rebooting the whole system.
+ *
+ * However, the hot-added memory can't be removed here as Windows keeps on using
+ * it until the system is restarted, even after disconnecting from the VMBus.
+ */
+static void hv_balloon_vmdev_reset(VMBusDevice *vdev)
+{
+    HvBalloon *balloon = HV_BALLOON(vdev);
+
+    if (balloon->state == S_POST_RESET_CLOSED) {
+        return;
+    }
+
+    if (balloon->our_range) {
+        OurRange *our_range = OUR_RANGE(balloon->our_range);
+
+        page_range_tree_destroy(&our_range->removed_guest);
+        page_range_tree_destroy(&our_range->removed_both);
+        page_range_tree_init(&our_range->removed_guest);
+        page_range_tree_init(&our_range->removed_both);
+    }
+
+    page_range_tree_destroy(&balloon->removed_guest);
+    page_range_tree_destroy(&balloon->removed_both);
+    page_range_tree_init(&balloon->removed_guest);
+    page_range_tree_init(&balloon->removed_both);
+
+    balloon->trans_id = 0;
+    balloon->removed_guest_ctr = 0;
+    balloon->removed_both_ctr = 0;
+
+    HV_BALLOON_SET_STATE(balloon, S_POST_RESET_CLOSED);
+    hv_balloon_event_loop(balloon);
+}
+
+static void hv_balloon_vmdev_unrealize(VMBusDevice *vdev)
+{
+    HvBalloon *balloon = HV_BALLOON(vdev);
+
+    qemu_unregister_reset(hv_balloon_system_reset, balloon);
+
+    hv_balloon_system_reset_unrealize_common(balloon);
+
+    qemu_remove_balloon_handler(balloon);
+
+    page_range_tree_destroy(&balloon->removed_guest);
+    page_range_tree_destroy(&balloon->removed_both);
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
+        error_setg(errp, "'" HV_BALLOON_MEMDEV_PROP "' property must be set");
+        return NULL;
+    }
+
+    return host_memory_backend_get_memory(balloon->hostmem);
+}
+
+static void hv_balloon_md_fill_device_info(const MemoryDeviceState *md,
+                                           MemoryDeviceInfo *info)
+{
+    PCDIMMDeviceInfo *di = g_new0(PCDIMMDeviceInfo, 1);
+    const DeviceClass *dc = DEVICE_GET_CLASS(md);
+    const HvBalloon *balloon = HV_BALLOON(md);
+    const DeviceState *dev = DEVICE(md);
+
+    if (dev->id) {
+        di->id = g_strdup(dev->id);
+    }
+    di->hotplugged = dev->hotplugged;
+    di->hotpluggable = dc->hotpluggable;
+    di->addr = balloon->addr;
+    di->slot = -1;
+    di->node = 0; /* FIXME: report proper node */
+
+    if (balloon->hostmem) {
+        di->memdev = object_get_canonical_path(OBJECT(balloon->hostmem));
+    } else {
+        di->memdev = g_strdup("");
+    }
+
+    if (balloon->our_range) {
+        g_autoptr(Error) size_error = NULL;
+
+        di->size = memory_device_get_region_size(md, &size_error);
+        if (size_error) {
+            di->size = 0;
+        }
+    } else {
+        di->size = 0;
+    }
+
+    info->u.dimm.data = di;
+    info->type = MEMORY_DEVICE_INFO_KIND_DIMM;
+}
+
+static void hv_balloon_get_addr(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    HvBalloon *balloon = HV_BALLOON(obj);
+
+    visit_type_uint64(v, name, &balloon->addr, errp);
+}
+
+static void hv_balloon_set_addr(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    HvBalloon *balloon = HV_BALLOON(obj);
+
+    visit_type_uint64(v, name, &balloon->addr, errp);
+}
+
+static void hv_balloon_init(Object *obj)
+{
+    object_property_add(obj, HV_BALLOON_ADDR_PROP, "uint64",
+                        hv_balloon_get_addr, hv_balloon_set_addr, NULL, NULL);
+}
+
+static Property hv_balloon_properties[] = {
+    DEFINE_PROP_BOOL("status-report", HvBalloon,
+                     status_reports, false),
+
+    /* MEMORY_DEVICE props */
+    DEFINE_PROP_LINK(HV_BALLOON_MEMDEV_PROP, HvBalloon, hostmem,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void hv_balloon_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VMBusDeviceClass *vdc = VMBUS_DEVICE_CLASS(klass);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, hv_balloon_properties);
+    qemu_uuid_parse(HV_BALLOON_GUID, &vdc->classid);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+
+    vdc->vmdev_realize = hv_balloon_vmdev_realize;
+    vdc->vmdev_unrealize = hv_balloon_vmdev_unrealize;
+    vdc->vmdev_reset = hv_balloon_vmdev_reset;
+    vdc->open_channel = hv_balloon_vmdev_open_channel;
+    vdc->close_channel = hv_balloon_vmdev_close_channel;
+    vdc->chan_notify_cb = hv_balloon_vmdev_chan_notify;
+
+    mdc->get_addr = hv_balloon_md_get_addr;
+    mdc->set_addr = hv_balloon_md_set_addr;
+    mdc->get_plugged_size = memory_device_get_region_size;
+    mdc->get_memory_region = hv_balloon_md_get_memory_region;
+    mdc->fill_device_info = hv_balloon_md_fill_device_info;
+}
+
+static const TypeInfo hv_balloon_type_info = {
+    .name = TYPE_HV_BALLOON,
+    .parent = TYPE_VMBUS_DEVICE,
+    .instance_size = sizeof(HvBalloon),
+    .instance_init = hv_balloon_init,
+    .class_init = hv_balloon_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_MEMORY_DEVICE },
+        { }
+    },
+
+};
+
+static void hv_balloon_register_types(void)
+{
+    type_register_static(&hv_balloon_type_info);
+}
+
+type_init(hv_balloon_register_types)
diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index b43f119ea56c..212e0ce51ef3 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -2,3 +2,4 @@ specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 specific_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
+specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c'))
diff --git a/hw/hyperv/trace-events b/hw/hyperv/trace-events
index b4c35ca8e377..9559bf8d1884 100644
--- a/hw/hyperv/trace-events
+++ b/hw/hyperv/trace-events
@@ -16,3 +16,19 @@ vmbus_gpadl_torndown(uint32_t gpadl_id) "gpadl #%d"
 vmbus_open_channel(uint32_t chan_id, uint32_t gpadl_id, uint32_t target_vp) "channel #%d gpadl #%d target vp %d"
 vmbus_channel_open(uint32_t chan_id, uint32_t status) "channel #%d status %d"
 vmbus_close_channel(uint32_t chan_id) "channel #%d"
+
+# hv-balloon
+hv_balloon_state_change(const char *tostr) "-> %s"
+hv_balloon_incoming_version(uint16_t major, uint16_t minor) "incoming proto version %u.%u"
+hv_balloon_incoming_caps(uint32_t caps) "incoming caps 0x%x"
+hv_balloon_outgoing_unballoon(uint32_t trans_id, uint64_t count, uint64_t start, uint64_t rempages) "posting unballoon %"PRIu32" for %"PRIu64" @ 0x%"PRIx64", remaining %"PRIu64
+hv_balloon_incoming_unballoon(uint32_t trans_id) "incoming unballoon response %"PRIu32
+hv_balloon_outgoing_hot_add(uint32_t trans_id, uint64_t count, uint64_t start) "posting hot add %"PRIu32" for %"PRIu64" @ 0x%"PRIx64
+hv_balloon_incoming_hot_add(uint32_t trans_id, uint32_t result, uint32_t count) "incoming hot add response %"PRIu32", result %"PRIu32", count %"PRIu32
+hv_balloon_outgoing_balloon(uint32_t trans_id, uint64_t count, uint64_t rempages) "posting balloon %"PRIu32" for %"PRIu64", remaining %"PRIu64
+hv_balloon_incoming_balloon(uint32_t trans_id, uint32_t range_count, uint32_t more_pages) "incoming balloon response %"PRIu32", ranges %"PRIu32", more %"PRIu32
+hv_balloon_our_range_add(uint64_t count, uint64_t start) "adding our range %"PRIu64" @ 0x%"PRIx64
+hv_balloon_remove_response(uint64_t count, uint64_t start, unsigned int both) "processing remove response range %"PRIu64" @ 0x%"PRIx64", both %u"
+hv_balloon_remove_response_hole(uint64_t counthole, uint64_t starthole, uint64_t countrange, uint64_t startrange, uint64_t starthpr, unsigned int both) "response range hole %"PRIu64" @ 0x%"PRIx64" from range %"PRIu64" @ 0x%"PRIx64", before our start 0x%"PRIx64", both %u"
+hv_balloon_remove_response_common(uint64_t countcommon, uint64_t startcommon, uint64_t countrange, uint64_t startrange, uint64_t counthpr, uint64_t starthpr, uint64_t removed, unsigned int both) "response common range %"PRIu64" @ 0x%"PRIx64" from range %"PRIu64" @ 0x%"PRIx64" with our %"PRIu64" @ 0x%"PRIx64", removed %"PRIu64", both %u"
+hv_balloon_remove_response_remainder(uint64_t count, uint64_t start, unsigned int both) "remove response remaining range %"PRIu64" @ 0x%"PRIx64", both %u"
diff --git a/meson.build b/meson.build
index 34306a6205ba..f0587c531fe1 100644
--- a/meson.build
+++ b/meson.build
@@ -1342,6 +1342,30 @@ if not get_option('glusterfs').auto() or have_block
   endif
 endif
 
+hv_balloon = false
+if get_option('hv_balloon').allowed() and have_system
+  if cc.links('''
+    #include <string.h>
+    #include <gmodule.h>
+    int main(void) {
+        GTree *tree;
+
+        tree = g_tree_new((GCompareFunc)strcmp);
+        (void)g_tree_node_first(tree);
+        g_tree_destroy(tree);
+        return 0;
+    }
+  ''', dependencies: glib)
+    hv_balloon = true
+  else
+    if get_option('hv_balloon').enabled()
+      error('could not enable hv-balloon, update your glib')
+    else
+      warning('could not find glib support for hv-balloon, disabling')
+    endif
+  endif
+endif
+
 libssh = not_found
 if not get_option('libssh').auto() or have_block
   libssh = dependency('libssh', version: '>=0.8.7',
@@ -2836,7 +2860,8 @@ host_kconfig = \
   ('CONFIG_LINUX' in config_host ? ['CONFIG_LINUX=y'] : []) + \
   (have_pvrdma ? ['CONFIG_PVRDMA=y'] : []) + \
   (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
-  (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : [])
+  (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : []) + \
+  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : [])
 
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
 
@@ -4292,6 +4317,7 @@ if targetos == 'windows'
 endif
 summary_info += {'seccomp support':   seccomp}
 summary_info += {'GlusterFS support': glusterfs}
+summary_info += {'hv-balloon support': hv_balloon}
 summary_info += {'TPM support':       have_tpm}
 summary_info += {'libssh support':    libssh}
 summary_info += {'lzo support':       lzo}
diff --git a/meson_options.txt b/meson_options.txt
index 90237389e2aa..24aea8a0f062 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -142,6 +142,8 @@ option('gio', type : 'feature', value : 'auto',
        description: 'use libgio for D-Bus support')
 option('glusterfs', type : 'feature', value : 'auto',
        description: 'Glusterfs block device driver')
+option('hv_balloon', type : 'feature', value : 'auto',
+       description: 'hv-balloon driver (requires Glib 2.68+ GTree API)')
 option('libdw', type : 'feature', value : 'auto',
        description: 'debuginfo support')
 option('libiscsi', type : 'feature', value : 'auto',
diff --git a/qapi/machine.json b/qapi/machine.json
index 37660d8f2a1d..00e6ce7df940 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1113,6 +1113,31 @@
 { 'event': 'BALLOON_CHANGE',
   'data': { 'actual': 'int' } }
 
+##
+# @HV_BALLOON_STATUS_REPORT:
+#
+# Emitted when the hv-balloon driver receives a "STATUS" message from
+# the guest.
+#
+# @commited: the amount of memory in use inside the guest plus the amount
+#            of the memory unusable inside the guest (ballooned out,
+#            offline, etc.)
+#
+# @available: the amount of the memory inside the guest available for new
+#             allocations ("free")
+#
+# Since: TBD
+#
+# Example:
+#
+# <- { "event": "HV_BALLOON_STATUS_REPORT",
+#      "data": { "commited": 816640000, "available": 3333054464 },
+#      "timestamp": { "seconds": 1600295492, "microseconds": 661044 } }
+#
+##
+{ 'event': 'HV_BALLOON_STATUS_REPORT',
+  'data': { 'commited': 'size', 'available': 'size' } }
+
 ##
 # @MemoryInfo:
 #
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 5714fd93d90e..34403326d860 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -112,6 +112,7 @@ meson_options_help() {
   printf "%s\n" '  guest-agent     Build QEMU Guest Agent'
   printf "%s\n" '  guest-agent-msi Build MSI package for the QEMU Guest Agent'
   printf "%s\n" '  hax             HAX acceleration support'
+  printf "%s\n" '  hv-balloon      hv-balloon driver (requires Glib 2.68+ GTree API)'
   printf "%s\n" '  hvf             HVF acceleration support'
   printf "%s\n" '  iconv           Font glyph conversion support'
   printf "%s\n" '  jack            JACK sound support'
@@ -317,6 +318,8 @@ _meson_option_parse() {
     --disable-hax) printf "%s" -Dhax=disabled ;;
     --enable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=true ;;
     --disable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=false ;;
+    --enable-hv-balloon) printf "%s" -Dhv_balloon=enabled ;;
+    --disable-hv-balloon) printf "%s" -Dhv_balloon=disabled ;;
     --enable-hvf) printf "%s" -Dhvf=enabled ;;
     --disable-hvf) printf "%s" -Dhvf=disabled ;;
     --iasl=*) quote_sh "-Diasl=$2" ;;

