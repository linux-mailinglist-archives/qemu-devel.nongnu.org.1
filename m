Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDF17C706C
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:38:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwoX-0002sB-24; Thu, 12 Oct 2023 10:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoT-0002qq-Gs
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qqwoQ-0005hT-Ie
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697121438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4JL9yewyPhZVyMbbl7Oy8HHKpMZgaC+EF/9LBbpPy1g=;
 b=I0eycr3aHiws165dpanKyW6KydKSAysU8ih9FxDr+P3vranDIlzWJ6GD6h41I0WR+FpXRG
 /1KCDf9zCbHddVXz7YCuwMfMmU72wwskz0o5Xj1kmAE1iGs4o/j4zLjJu3NbJi8hj/Ku/T
 2NBG/btFKPyr/US0Tzr9+hdVKgkEGAg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-6g599-NbPCWjOfHhWD9nfg-1; Thu, 12 Oct 2023 10:37:16 -0400
X-MC-Unique: 6g599-NbPCWjOfHhWD9nfg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E99EF81D9ED;
 Thu, 12 Oct 2023 14:37:15 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 291F11C060DF;
 Thu, 12 Oct 2023 14:37:15 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [GIT PULL 17/18] memory,
 vhost: Allow for marking memory device memory regions unmergeable
Date: Thu, 12 Oct 2023 16:36:54 +0200
Message-ID: <20231012143655.114631-18-david@redhat.com>
In-Reply-To: <20231012143655.114631-1-david@redhat.com>
References: <20231012143655.114631-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Let's allow for marking memory regions unmergeable, to teach
flatview code and vhost to not merge adjacent aliases to the same memory
region into a larger memory section; instead, we want separate aliases to
stay separate such that we can atomically map/unmap aliases without
affecting other aliases.

This is desired for virtio-mem mapping device memory located on a RAM
memory region via multiple aliases into a memory region container,
resulting in separate memslots that can get (un)mapped atomically.

As an example with virtio-mem, the layout would look something like this:
  [...]
  0000000240000000-00000020bfffffff (prio 0, i/o): device-memory
    0000000240000000-000000043fffffff (prio 0, i/o): virtio-mem
      0000000240000000-000000027fffffff (prio 0, ram): alias memslot-0 @mem2 0000000000000000-000000003fffffff
      0000000280000000-00000002bfffffff (prio 0, ram): alias memslot-1 @mem2 0000000040000000-000000007fffffff
      00000002c0000000-00000002ffffffff (prio 0, ram): alias memslot-2 @mem2 0000000080000000-00000000bfffffff
  [...]

Without unmergable memory regions, all three memslots would get merged into
a single memory section. For example, when mapping another alias (e.g.,
virtio-mem-memslot-3) or when unmapping any of the mapped aliases,
memory listeners will first get notified about the removal of the big
memory section to then get notified about re-adding of the new
(differently merged) memory section(s).

In an ideal world, memory listeners would be able to deal with that
atomically, like KVM nowadays does. However, (a) supporting this for other
memory listeners (vhost-user, vfio) is fairly hard: temporary removal
can result in all kinds of issues on concurrent access to guest memory;
and (b) this handling is undesired, because temporarily removing+readding
can consume quite some time on bigger memslots and is not efficient
(e.g., vfio unpinning and repinning pages ...).

Let's allow for marking a memory region unmergeable, such that we
can atomically (un)map aliases to the same memory region, similar to
(un)mapping individual DIMMs.

Similarly, teach vhost code to not redo what flatview core stopped doing:
don't merge such sections. Merging in vhost code is really only relevant
for handling random holes in boot memory where; without this merging,
the vhost-user backend wouldn't be able to mmap() some boot memory
backed on hugetlb.

We'll use this for virtio-mem next.

Message-ID: <20230926185738.277351-18-david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/vhost.c     |  4 ++--
 include/exec/memory.h | 22 ++++++++++++++++++++++
 system/memory.c       | 31 +++++++++++++++++++++++++------
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index a546a585da..9f37206ba0 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -707,7 +707,7 @@ static void vhost_region_add_section(struct vhost_dev *dev,
                                                mrs_size, mrs_host);
     }
 
-    if (dev->n_tmp_sections) {
+    if (dev->n_tmp_sections && !section->unmergeable) {
         /* Since we already have at least one section, lets see if
          * this extends it; since we're scanning in order, we only
          * have to look at the last one, and the FlatView that calls
@@ -740,7 +740,7 @@ static void vhost_region_add_section(struct vhost_dev *dev,
             size_t offset = mrs_gpa - prev_gpa_start;
 
             if (prev_host_start + offset == mrs_host &&
-                section->mr == prev_sec->mr) {
+                section->mr == prev_sec->mr && !prev_sec->unmergeable) {
                 uint64_t max_end = MAX(prev_host_end, mrs_host + mrs_size);
                 need_add = false;
                 prev_sec->offset_within_address_space =
diff --git a/include/exec/memory.h b/include/exec/memory.h
index cf7c7dde91..653a32ea10 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -95,6 +95,7 @@ struct ReservedRegion {
  *     relative to the region's address space
  * @readonly: writes to this section are ignored
  * @nonvolatile: this section is non-volatile
+ * @unmergeable: this section should not get merged with adjacent sections
  */
 struct MemoryRegionSection {
     Int128 size;
@@ -104,6 +105,7 @@ struct MemoryRegionSection {
     hwaddr offset_within_address_space;
     bool readonly;
     bool nonvolatile;
+    bool unmergeable;
 };
 
 typedef struct IOMMUTLBEntry IOMMUTLBEntry;
@@ -773,6 +775,7 @@ struct MemoryRegion {
     bool nonvolatile;
     bool rom_device;
     bool flush_coalesced_mmio;
+    bool unmergeable;
     uint8_t dirty_log_mask;
     bool is_iommu;
     RAMBlock *ram_block;
@@ -2351,6 +2354,25 @@ void memory_region_set_size(MemoryRegion *mr, uint64_t size);
 void memory_region_set_alias_offset(MemoryRegion *mr,
                                     hwaddr offset);
 
+/*
+ * memory_region_set_unmergeable: Set a memory region unmergeable
+ *
+ * Mark a memory region unmergeable, resulting in the memory region (or
+ * everything contained in a memory region container) not getting merged when
+ * simplifying the address space and notifying memory listeners. Consequently,
+ * memory listeners will never get notified about ranges that are larger than
+ * the original memory regions.
+ *
+ * This is primarily useful when multiple aliases to a RAM memory region are
+ * mapped into a memory region container, and updates (e.g., enable/disable or
+ * map/unmap) of individual memory region aliases are not supposed to affect
+ * other memory regions in the same container.
+ *
+ * @mr: the #MemoryRegion to be updated
+ * @unmergeable: whether to mark the #MemoryRegion unmergeable
+ */
+void memory_region_set_unmergeable(MemoryRegion *mr, bool unmergeable);
+
 /**
  * memory_region_present: checks if an address relative to a @container
  * translates into #MemoryRegion within @container
diff --git a/system/memory.c b/system/memory.c
index e11bce5991..a800fbc9e5 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -224,6 +224,7 @@ struct FlatRange {
     bool romd_mode;
     bool readonly;
     bool nonvolatile;
+    bool unmergeable;
 };
 
 #define FOR_EACH_FLAT_RANGE(var, view)          \
@@ -240,6 +241,7 @@ section_from_flat_range(FlatRange *fr, FlatView *fv)
         .offset_within_address_space = int128_get64(fr->addr.start),
         .readonly = fr->readonly,
         .nonvolatile = fr->nonvolatile,
+        .unmergeable = fr->unmergeable,
     };
 }
 
@@ -250,7 +252,8 @@ static bool flatrange_equal(FlatRange *a, FlatRange *b)
         && a->offset_in_region == b->offset_in_region
         && a->romd_mode == b->romd_mode
         && a->readonly == b->readonly
-        && a->nonvolatile == b->nonvolatile;
+        && a->nonvolatile == b->nonvolatile
+        && a->unmergeable == b->unmergeable;
 }
 
 static FlatView *flatview_new(MemoryRegion *mr_root)
@@ -323,7 +326,8 @@ static bool can_merge(FlatRange *r1, FlatRange *r2)
         && r1->dirty_log_mask == r2->dirty_log_mask
         && r1->romd_mode == r2->romd_mode
         && r1->readonly == r2->readonly
-        && r1->nonvolatile == r2->nonvolatile;
+        && r1->nonvolatile == r2->nonvolatile
+        && !r1->unmergeable && !r2->unmergeable;
 }
 
 /* Attempt to simplify a view by merging adjacent ranges */
@@ -599,7 +603,8 @@ static void render_memory_region(FlatView *view,
                                  Int128 base,
                                  AddrRange clip,
                                  bool readonly,
-                                 bool nonvolatile)
+                                 bool nonvolatile,
+                                 bool unmergeable)
 {
     MemoryRegion *subregion;
     unsigned i;
@@ -616,6 +621,7 @@ static void render_memory_region(FlatView *view,
     int128_addto(&base, int128_make64(mr->addr));
     readonly |= mr->readonly;
     nonvolatile |= mr->nonvolatile;
+    unmergeable |= mr->unmergeable;
 
     tmp = addrrange_make(base, mr->size);
 
@@ -629,14 +635,14 @@ static void render_memory_region(FlatView *view,
         int128_subfrom(&base, int128_make64(mr->alias->addr));
         int128_subfrom(&base, int128_make64(mr->alias_offset));
         render_memory_region(view, mr->alias, base, clip,
-                             readonly, nonvolatile);
+                             readonly, nonvolatile, unmergeable);
         return;
     }
 
     /* Render subregions in priority order. */
     QTAILQ_FOREACH(subregion, &mr->subregions, subregions_link) {
         render_memory_region(view, subregion, base, clip,
-                             readonly, nonvolatile);
+                             readonly, nonvolatile, unmergeable);
     }
 
     if (!mr->terminates) {
@@ -652,6 +658,7 @@ static void render_memory_region(FlatView *view,
     fr.romd_mode = mr->romd_mode;
     fr.readonly = readonly;
     fr.nonvolatile = nonvolatile;
+    fr.unmergeable = unmergeable;
 
     /* Render the region itself into any gaps left by the current view. */
     for (i = 0; i < view->nr && int128_nz(remain); ++i) {
@@ -753,7 +760,7 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
     if (mr) {
         render_memory_region(view, mr, int128_zero(),
                              addrrange_make(int128_zero(), int128_2_64()),
-                             false, false);
+                             false, false, false);
     }
     flatview_simplify(view);
 
@@ -2755,6 +2762,18 @@ void memory_region_set_alias_offset(MemoryRegion *mr, hwaddr offset)
     memory_region_transaction_commit();
 }
 
+void memory_region_set_unmergeable(MemoryRegion *mr, bool unmergeable)
+{
+    if (unmergeable == mr->unmergeable) {
+        return;
+    }
+
+    memory_region_transaction_begin();
+    mr->unmergeable = unmergeable;
+    memory_region_update_pending |= mr->enabled;
+    memory_region_transaction_commit();
+}
+
 uint64_t memory_region_get_alignment(const MemoryRegion *mr)
 {
     return mr->align;
-- 
2.41.0


