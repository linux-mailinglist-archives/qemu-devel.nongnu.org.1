Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E93F381E661
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:27:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3gt-0005Hy-7D; Tue, 26 Dec 2023 04:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gq-00058h-Qy
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3go-0000ID-GA
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iZD0hIOPiOh7X8EWN/o0sE45YFCMEYAc6xIQsbTilnU=;
 b=QEkCwJzEgaEbiV7MbxRPXEljoboTMul1HfmVmS/J537tFjKMVsRQNDZHHI4scsjF/ggHO9
 rE5PEYSlYjGTVMiR6Nafx7tibzqfkf/75iGRV0FRPKVGMo67B+Op3Cf+ePgFBaLudEGlns
 tQVbzoeS12enR0oEi2xwFIo67TfV/SU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-hadQ1UxbMoWRVRpGyaWHjw-1; Tue, 26 Dec 2023 04:25:28 -0500
X-MC-Unique: hadQ1UxbMoWRVRpGyaWHjw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d51c3997fso17602715e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582726; x=1704187526;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iZD0hIOPiOh7X8EWN/o0sE45YFCMEYAc6xIQsbTilnU=;
 b=eSE/eUvDcCBL5Znu70luaFpthUYQyvehNN5WhvFNzz9VRolDQY20ZySDlB2Wp8ghSV
 9wgn8ODVdtDWHXLj6kYPuwoYGum7i4S1n2lF4ukxn0SwLU2C2h/biX/7XaxOGAUJKQYJ
 LLOcS6GRwoQ+cAanoqobeBhzsW4g5wEmRSRhnk38GXCX2DGExsVhMz5bxiQ1JY6IXysS
 hJBvg6+LmrOU7SmB584UFanxwA8aPCWsvLxsV07YtNZ3cO26zL6BvUKYKXHk/KC0C/gS
 5cJhAM7HlcCynqUcTLbijoGfGuAm/Qh5bRnvNhhfzUa0Kpxo99EQNuO5S6p+7qoEsXQu
 dwFA==
X-Gm-Message-State: AOJu0YxT23JuDGDe1vDTsq07m7OGqE3FVlXlzRc44pLdv/vhQyiHV/I8
 iE9Bp2Cuao2bZj/9U/GixqyFs9elWIuc7lYp5DjP4taMKTrf3IgiJNzf/vBwV1uE/cI48Ssks0Z
 3FO9lUXkGkMxlt6VJuVKfrcjUfJlTCVVfn4IcjBGETahe3n+wKChpg3tsIZtLQDBiCS8W6OUd5N
 sd
X-Received: by 2002:a05:600c:154c:b0:40c:3f2b:bbbb with SMTP id
 f12-20020a05600c154c00b0040c3f2bbbbbmr5071211wmg.75.1703582726057; 
 Tue, 26 Dec 2023 01:25:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUdZDqhfNDBel115mfZWm10Gb3hyveCwW7HiCvNAlaQ/i5inkbSlAo+lIPaU3LW0Y0w5Wz4g==
X-Received: by 2002:a05:600c:154c:b0:40c:3f2b:bbbb with SMTP id
 f12-20020a05600c154c00b0040c3f2bbbbbmr5071199wmg.75.1703582725694; 
 Tue, 26 Dec 2023 01:25:25 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 l4-20020a05600c1d0400b0040d3276ba19sm20022118wms.25.2023.12.26.01.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:25:25 -0800 (PST)
Date: Tue, 26 Dec 2023 04:25:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 21/21] vdpa: move memory listener to vhost_vdpa_shared
Message-ID: <7b67b2f0f4f7c5ec888a331af599d9daff735d60.1703582625.git.mst@redhat.com>
References: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1703582625.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Eugenio Pérez <eperezma@redhat.com>

Next patches will register the vhost_vdpa memory listener while the VM
is migrating at the destination, so we can map the memory to the device
before stopping the VM at the source.  The main goal is to reduce the
downtime.

However, the destination QEMU is unaware of which vhost_vdpa device will
register its memory_listener.  If the source guest has CVQ enabled, it
will be the CVQ device.  Otherwise, it  will be the first one.

Move the memory listener to a common place rather than always in the
first / last vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20231221174322.3130442-14-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  2 +-
 hw/virtio/vhost-vdpa.c         | 84 ++++++++++++++++------------------
 2 files changed, 40 insertions(+), 46 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 2abee2164a..8f54e5edd4 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -33,6 +33,7 @@ typedef struct VhostVDPAHostNotifier {
 /* Info shared by all vhost_vdpa device models */
 typedef struct vhost_vdpa_shared {
     int device_fd;
+    MemoryListener listener;
     struct vhost_vdpa_iova_range iova_range;
     QLIST_HEAD(, vdpa_iommu) iommu_list;
 
@@ -51,7 +52,6 @@ typedef struct vhost_vdpa_shared {
 typedef struct vhost_vdpa {
     int index;
     uint32_t address_space_id;
-    MemoryListener listener;
     uint64_t acked_features;
     bool shadow_vqs_enabled;
     /* Device suspended successfully */
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index e6276fb1e4..ddae494ca8 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -170,28 +170,28 @@ static void vhost_vdpa_iotlb_batch_begin_once(VhostVDPAShared *s)
 
 static void vhost_vdpa_listener_commit(MemoryListener *listener)
 {
-    struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
+    VhostVDPAShared *s = container_of(listener, VhostVDPAShared, listener);
     struct vhost_msg_v2 msg = {};
-    int fd = v->shared->device_fd;
+    int fd = s->device_fd;
 
-    if (!(v->shared->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
+    if (!(s->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
         return;
     }
 
-    if (!v->shared->iotlb_batch_begin_sent) {
+    if (!s->iotlb_batch_begin_sent) {
         return;
     }
 
     msg.type = VHOST_IOTLB_MSG_V2;
     msg.iotlb.type = VHOST_IOTLB_BATCH_END;
 
-    trace_vhost_vdpa_listener_commit(v->shared, fd, msg.type, msg.iotlb.type);
+    trace_vhost_vdpa_listener_commit(s, fd, msg.type, msg.iotlb.type);
     if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
         error_report("failed to write, fd=%d, errno=%d (%s)",
                      fd, errno, strerror(errno));
     }
 
-    v->shared->iotlb_batch_begin_sent = false;
+    s->iotlb_batch_begin_sent = false;
 }
 
 static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
@@ -246,7 +246,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 static void vhost_vdpa_iommu_region_add(MemoryListener *listener,
                                         MemoryRegionSection *section)
 {
-    struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
+    VhostVDPAShared *s = container_of(listener, VhostVDPAShared, listener);
 
     struct vdpa_iommu *iommu;
     Int128 end;
@@ -270,7 +270,7 @@ static void vhost_vdpa_iommu_region_add(MemoryListener *listener,
                         iommu_idx);
     iommu->iommu_offset = section->offset_within_address_space -
                           section->offset_within_region;
-    iommu->dev_shared = v->shared;
+    iommu->dev_shared = s;
 
     ret = memory_region_register_iommu_notifier(section->mr, &iommu->n, NULL);
     if (ret) {
@@ -278,7 +278,7 @@ static void vhost_vdpa_iommu_region_add(MemoryListener *listener,
         return;
     }
 
-    QLIST_INSERT_HEAD(&v->shared->iommu_list, iommu, iommu_next);
+    QLIST_INSERT_HEAD(&s->iommu_list, iommu, iommu_next);
     memory_region_iommu_replay(iommu->iommu_mr, &iommu->n);
 
     return;
@@ -287,11 +287,11 @@ static void vhost_vdpa_iommu_region_add(MemoryListener *listener,
 static void vhost_vdpa_iommu_region_del(MemoryListener *listener,
                                         MemoryRegionSection *section)
 {
-    struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
+    VhostVDPAShared *s = container_of(listener, VhostVDPAShared, listener);
 
     struct vdpa_iommu *iommu;
 
-    QLIST_FOREACH(iommu, &v->shared->iommu_list, iommu_next)
+    QLIST_FOREACH(iommu, &s->iommu_list, iommu_next)
     {
         if (MEMORY_REGION(iommu->iommu_mr) == section->mr &&
             iommu->n.start == section->offset_within_region) {
@@ -307,7 +307,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
                                            MemoryRegionSection *section)
 {
     DMAMap mem_region = {};
-    struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
+    VhostVDPAShared *s = container_of(listener, VhostVDPAShared, listener);
     hwaddr iova;
     Int128 llend, llsize;
     void *vaddr;
@@ -315,10 +315,8 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     int page_size = qemu_target_page_size();
     int page_mask = -page_size;
 
-    if (vhost_vdpa_listener_skipped_section(section,
-                                            v->shared->iova_range.first,
-                                            v->shared->iova_range.last,
-                                            page_mask)) {
+    if (vhost_vdpa_listener_skipped_section(section, s->iova_range.first,
+                                            s->iova_range.last, page_mask)) {
         return;
     }
     if (memory_region_is_iommu(section->mr)) {
@@ -328,8 +326,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
 
     if (unlikely((section->offset_within_address_space & ~page_mask) !=
                  (section->offset_within_region & ~page_mask))) {
-        trace_vhost_vdpa_listener_region_add_unaligned(v->shared,
-                       section->mr->name,
+        trace_vhost_vdpa_listener_region_add_unaligned(s, section->mr->name,
                        section->offset_within_address_space & ~page_mask,
                        section->offset_within_region & ~page_mask);
         return;
@@ -349,18 +346,18 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
             section->offset_within_region +
             (iova - section->offset_within_address_space);
 
-    trace_vhost_vdpa_listener_region_add(v->shared, iova, int128_get64(llend),
+    trace_vhost_vdpa_listener_region_add(s, iova, int128_get64(llend),
                                          vaddr, section->readonly);
 
     llsize = int128_sub(llend, int128_make64(iova));
-    if (v->shared->shadow_data) {
+    if (s->shadow_data) {
         int r;
 
         mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr,
         mem_region.size = int128_get64(llsize) - 1,
         mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
 
-        r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &mem_region);
+        r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
         if (unlikely(r != IOVA_OK)) {
             error_report("Can't allocate a mapping (%d)", r);
             goto fail;
@@ -369,8 +366,8 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         iova = mem_region.iova;
     }
 
-    vhost_vdpa_iotlb_batch_begin_once(v->shared);
-    ret = vhost_vdpa_dma_map(v->shared, VHOST_VDPA_GUEST_PA_ASID, iova,
+    vhost_vdpa_iotlb_batch_begin_once(s);
+    ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
                              int128_get64(llsize), vaddr, section->readonly);
     if (ret) {
         error_report("vhost vdpa map fail!");
@@ -380,8 +377,8 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     return;
 
 fail_map:
-    if (v->shared->shadow_data) {
-        vhost_iova_tree_remove(v->shared->iova_tree, mem_region);
+    if (s->shadow_data) {
+        vhost_iova_tree_remove(s->iova_tree, mem_region);
     }
 
 fail:
@@ -398,17 +395,15 @@ fail:
 static void vhost_vdpa_listener_region_del(MemoryListener *listener,
                                            MemoryRegionSection *section)
 {
-    struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
+    VhostVDPAShared *s = container_of(listener, VhostVDPAShared, listener);
     hwaddr iova;
     Int128 llend, llsize;
     int ret;
     int page_size = qemu_target_page_size();
     int page_mask = -page_size;
 
-    if (vhost_vdpa_listener_skipped_section(section,
-                                            v->shared->iova_range.first,
-                                            v->shared->iova_range.last,
-                                            page_mask)) {
+    if (vhost_vdpa_listener_skipped_section(section, s->iova_range.first,
+                                            s->iova_range.last, page_mask)) {
         return;
     }
     if (memory_region_is_iommu(section->mr)) {
@@ -417,8 +412,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
 
     if (unlikely((section->offset_within_address_space & ~page_mask) !=
                  (section->offset_within_region & ~page_mask))) {
-        trace_vhost_vdpa_listener_region_del_unaligned(v->shared,
-                       section->mr->name,
+        trace_vhost_vdpa_listener_region_del_unaligned(s, section->mr->name,
                        section->offset_within_address_space & ~page_mask,
                        section->offset_within_region & ~page_mask);
         return;
@@ -427,7 +421,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     iova = ROUND_UP(section->offset_within_address_space, page_size);
     llend = vhost_vdpa_section_end(section, page_mask);
 
-    trace_vhost_vdpa_listener_region_del(v->shared, iova,
+    trace_vhost_vdpa_listener_region_del(s, iova,
         int128_get64(int128_sub(llend, int128_one())));
 
     if (int128_ge(int128_make64(iova), llend)) {
@@ -436,7 +430,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
 
     llsize = int128_sub(llend, int128_make64(iova));
 
-    if (v->shared->shadow_data) {
+    if (s->shadow_data) {
         const DMAMap *result;
         const void *vaddr = memory_region_get_ram_ptr(section->mr) +
             section->offset_within_region +
@@ -446,37 +440,37 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
             .size = int128_get64(llsize) - 1,
         };
 
-        result = vhost_iova_tree_find_iova(v->shared->iova_tree, &mem_region);
+        result = vhost_iova_tree_find_iova(s->iova_tree, &mem_region);
         if (!result) {
             /* The memory listener map wasn't mapped */
             return;
         }
         iova = result->iova;
-        vhost_iova_tree_remove(v->shared->iova_tree, *result);
+        vhost_iova_tree_remove(s->iova_tree, *result);
     }
-    vhost_vdpa_iotlb_batch_begin_once(v->shared);
+    vhost_vdpa_iotlb_batch_begin_once(s);
     /*
      * The unmap ioctl doesn't accept a full 64-bit. need to check it
      */
     if (int128_eq(llsize, int128_2_64())) {
         llsize = int128_rshift(llsize, 1);
-        ret = vhost_vdpa_dma_unmap(v->shared, VHOST_VDPA_GUEST_PA_ASID, iova,
+        ret = vhost_vdpa_dma_unmap(s, VHOST_VDPA_GUEST_PA_ASID, iova,
                                    int128_get64(llsize));
 
         if (ret) {
             error_report("vhost_vdpa_dma_unmap(%p, 0x%" HWADDR_PRIx ", "
                          "0x%" HWADDR_PRIx ") = %d (%m)",
-                         v, iova, int128_get64(llsize), ret);
+                         s, iova, int128_get64(llsize), ret);
         }
         iova += int128_get64(llsize);
     }
-    ret = vhost_vdpa_dma_unmap(v->shared, VHOST_VDPA_GUEST_PA_ASID, iova,
+    ret = vhost_vdpa_dma_unmap(s, VHOST_VDPA_GUEST_PA_ASID, iova,
                                int128_get64(llsize));
 
     if (ret) {
         error_report("vhost_vdpa_dma_unmap(%p, 0x%" HWADDR_PRIx ", "
                      "0x%" HWADDR_PRIx ") = %d (%m)",
-                     v, iova, int128_get64(llsize), ret);
+                     s, iova, int128_get64(llsize), ret);
     }
 
     memory_region_unref(section->mr);
@@ -595,7 +589,7 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque, Error **errp)
 
     v->dev = dev;
     dev->opaque =  opaque ;
-    v->listener = vhost_vdpa_memory_listener;
+    v->shared->listener = vhost_vdpa_memory_listener;
     vhost_vdpa_init_svq(dev, v);
 
     error_propagate(&dev->migration_blocker, v->migration_blocker);
@@ -755,10 +749,10 @@ static int vhost_vdpa_cleanup(struct vhost_dev *dev)
     trace_vhost_vdpa_cleanup(dev, v);
     if (vhost_vdpa_first_dev(dev)) {
         ram_block_discard_disable(false);
+        memory_listener_unregister(&v->shared->listener);
     }
 
     vhost_vdpa_host_notifiers_uninit(dev, dev->nvqs);
-    memory_listener_unregister(&v->listener);
     vhost_vdpa_svq_cleanup(dev);
 
     dev->opaque = NULL;
@@ -1331,7 +1325,7 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
                          "IOMMU and try again");
             return -1;
         }
-        memory_listener_register(&v->listener, dev->vdev->dma_as);
+        memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
 
         return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
     }
@@ -1350,7 +1344,7 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
     vhost_vdpa_reset_device(dev);
     vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                                VIRTIO_CONFIG_S_DRIVER);
-    memory_listener_unregister(&v->listener);
+    memory_listener_unregister(&v->shared->listener);
 }
 
 static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
-- 
MST


