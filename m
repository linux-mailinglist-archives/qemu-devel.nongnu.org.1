Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3332481E655
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:25:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3gI-0002Te-LF; Tue, 26 Dec 2023 04:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gG-0002Sy-Fw
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gE-0008Jd-Og
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aQNgFux+8fYn065Bfp8ZbzNtSl4MOxXJa+zOn6c9qNY=;
 b=NFAdqbtFwrWD1vJwLcYdSjkdESoMoVxRlbBl0dzAW0jPxcc/M3GRSYjFnNFc5fwts307uW
 e1VJitVZSeq37qHWqsYHq53Opcj8SeHeRCHdA7FIaP7zq9ptILbDajLchZRIqzsW47of2h
 7bkqRWB6d94olxB59rOx4YJfzb2RWKA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-0n131OKaPFyiuz7mv5qYNQ-1; Tue, 26 Dec 2023 04:24:52 -0500
X-MC-Unique: 0n131OKaPFyiuz7mv5qYNQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3367657a290so3237815f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582689; x=1704187489;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aQNgFux+8fYn065Bfp8ZbzNtSl4MOxXJa+zOn6c9qNY=;
 b=BR7Sz7Eg9s5BgqnyrCBM35/v+L8q17f+5181wotFcJM/JzfOShi6VVtrj6wElC8kc5
 wJ/Cwemic6PbhN2KE+TzSc0UVMsFIJJDi/QvP0MIHyx/YlrDvUrDX+sWY+2mmu6yvDj1
 AU/jsDgBf1rzlyJxvERf30UUp9NXFtbOaLkrF54tS4vifXHtb/S0wcozpCgBFV2ZYdyM
 W4EtW37i0H/yErX7fn7QaLXvaASUo9JM8lCgj1aoJ+QCWoUsNKzIaEZSOOSBQ1EkKUrl
 y1Dnw/uwbwE5qjWSbZGofFngzP7zc6kzMrbo0dTaXKE8VHNnwCvR1RgReL9HjG6XlO+J
 6RaA==
X-Gm-Message-State: AOJu0YwhfB78NRnnT+DA/WlAi6H5u6BKuz0IlC7TJ0BT35ffL3LrAtf6
 MHPfXgxGPP7d1V6lvi0eoRueqByAPlWd7Te8ZydU1sCRYrFc29QlkoWH5bUiq5c7znFt4gZSefM
 oVnEDgDrBSRZxbcWv8TQHY5fUUdRu7lUXUusq2iB2GFw3pyrtYCeXMuFSZCOLj/1F/YLcVZvylz
 i7
X-Received: by 2002:a5d:6052:0:b0:336:79df:a706 with SMTP id
 j18-20020a5d6052000000b0033679dfa706mr4263384wrt.99.1703582689575; 
 Tue, 26 Dec 2023 01:24:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9ViuaKOgbAufJfYGgo5oT+d2RG+tMce109y86/fRLzw4VZJFE8rnm4jdDJ06qmknWSMDL+g==
X-Received: by 2002:a5d:6052:0:b0:336:79df:a706 with SMTP id
 j18-20020a5d6052000000b0033679dfa706mr4263375wrt.99.1703582689298; 
 Tue, 26 Dec 2023 01:24:49 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 cg13-20020a5d5ccd000000b00336e6014263sm840030wrb.98.2023.12.26.01.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:24:46 -0800 (PST)
Date: Tue, 26 Dec 2023 04:24:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 11/21] vdpa: move iova_range to vhost_vdpa_shared
Message-ID: <191c3b0284586495b5aa47a2bb97987565ccba55.1703582625.git.mst@redhat.com>
References: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1703582625.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Move the iova range to VhostVDPAShared so all vhost_vdpa can use it,
rather than always in the first or last vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20231221174322.3130442-4-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  3 ++-
 hw/virtio/vdpa-dev.c           |  5 ++++-
 hw/virtio/vhost-vdpa.c         | 16 ++++++++++------
 net/vhost-vdpa.c               | 10 +++++-----
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index ac036055d3..8d52a7e498 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -32,6 +32,8 @@ typedef struct VhostVDPAHostNotifier {
 
 /* Info shared by all vhost_vdpa device models */
 typedef struct vhost_vdpa_shared {
+    struct vhost_vdpa_iova_range iova_range;
+
     /* IOVA mapping used by the Shadow Virtqueue */
     VhostIOVATree *iova_tree;
 } VhostVDPAShared;
@@ -43,7 +45,6 @@ typedef struct vhost_vdpa {
     bool iotlb_batch_begin_sent;
     uint32_t address_space_id;
     MemoryListener listener;
-    struct vhost_vdpa_iova_range iova_range;
     uint64_t acked_features;
     bool shadow_vqs_enabled;
     /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index f22d5d5bc0..457960d28a 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -114,7 +114,8 @@ static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp)
                    strerror(-ret));
         goto free_vqs;
     }
-    v->vdpa.iova_range = iova_range;
+    v->vdpa.shared = g_new0(VhostVDPAShared, 1);
+    v->vdpa.shared->iova_range = iova_range;
 
     ret = vhost_dev_init(&v->dev, &v->vdpa, VHOST_BACKEND_TYPE_VDPA, 0, NULL);
     if (ret < 0) {
@@ -162,6 +163,7 @@ vhost_cleanup:
     vhost_dev_cleanup(&v->dev);
 free_vqs:
     g_free(vqs);
+    g_free(v->vdpa.shared);
 out:
     qemu_close(v->vhostfd);
     v->vhostfd = -1;
@@ -184,6 +186,7 @@ static void vhost_vdpa_device_unrealize(DeviceState *dev)
     g_free(s->config);
     g_free(s->dev.vqs);
     vhost_dev_cleanup(&s->dev);
+    g_free(s->vdpa.shared);
     qemu_close(s->vhostfd);
     s->vhostfd = -1;
 }
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 95a179a082..5ff1d43ba9 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -213,10 +213,10 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     RCU_READ_LOCK_GUARD();
     /* check if RAM section out of device range */
     llend = int128_add(int128_makes64(iotlb->addr_mask), int128_makes64(iova));
-    if (int128_gt(llend, int128_make64(v->iova_range.last))) {
+    if (int128_gt(llend, int128_make64(v->shared->iova_range.last))) {
         error_report("RAM section out of device range (max=0x%" PRIx64
                      ", end addr=0x%" PRIx64 ")",
-                     v->iova_range.last, int128_get64(llend));
+                     v->shared->iova_range.last, int128_get64(llend));
         return;
     }
 
@@ -316,8 +316,10 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     int page_size = qemu_target_page_size();
     int page_mask = -page_size;
 
-    if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
-                                            v->iova_range.last, page_mask)) {
+    if (vhost_vdpa_listener_skipped_section(section,
+                                            v->shared->iova_range.first,
+                                            v->shared->iova_range.last,
+                                            page_mask)) {
         return;
     }
     if (memory_region_is_iommu(section->mr)) {
@@ -403,8 +405,10 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     int page_size = qemu_target_page_size();
     int page_mask = -page_size;
 
-    if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
-                                            v->iova_range.last, page_mask)) {
+    if (vhost_vdpa_listener_skipped_section(section,
+                                            v->shared->iova_range.first,
+                                            v->shared->iova_range.last,
+                                            page_mask)) {
         return;
     }
     if (memory_region_is_iommu(section->mr)) {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 10703e5833..7be2c30ad3 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -354,8 +354,8 @@ static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
     migration_add_notifier(&s->migration_state,
                            vdpa_net_migration_state_notifier);
     if (v->shadow_vqs_enabled) {
-        v->shared->iova_tree = vhost_iova_tree_new(v->iova_range.first,
-                                                   v->iova_range.last);
+        v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
+                                                   v->shared->iova_range.last);
     }
 }
 
@@ -591,8 +591,8 @@ out:
      * and it is not worth it for the moment.
      */
     if (!v->shared->iova_tree) {
-        v->shared->iova_tree = vhost_iova_tree_new(v->iova_range.first,
-                                                   v->iova_range.last);
+        v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
+                                                   v->shared->iova_range.last);
     }
 
     r = vhost_vdpa_cvq_map_buf(&s->vhost_vdpa, s->cvq_cmd_out_buffer,
@@ -1688,12 +1688,12 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
     s->always_svq = svq;
     s->migration_state.notify = NULL;
     s->vhost_vdpa.shadow_vqs_enabled = svq;
-    s->vhost_vdpa.iova_range = iova_range;
     s->vhost_vdpa.shadow_data = svq;
     if (queue_pair_index == 0) {
         vhost_vdpa_net_valid_svq_features(features,
                                           &s->vhost_vdpa.migration_blocker);
         s->vhost_vdpa.shared = g_new0(VhostVDPAShared, 1);
+        s->vhost_vdpa.shared->iova_range = iova_range;
     } else if (!is_datapath) {
         s->cvq_cmd_out_buffer = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
                                      PROT_READ | PROT_WRITE,
-- 
MST


