Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC6581BD7D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:44:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGN5M-00027S-PW; Thu, 21 Dec 2023 12:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGN5E-00023o-T2
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:43:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGN59-0004RP-MF
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703180618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FyxOQUcohfLV3GcvLXt2h1Qk7/Uv5b6Nb+fqdDUkLQ0=;
 b=Q3YXd9z9FBD7ODlTzCyqRbdJ80hkiMiIcbT7yKzCD3hCZA75K3X+WQw9BvVe7N8OiStkyx
 mNDjPFKkBsflsMtOjQTqbKMebKmj8bHBB9AQhlQ02KggbPKecGTVcCtfBcSk/rXKPndRaK
 f0NA/jfY4YGeRUO3Rnc0bedF57kGuIs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-x_n5s6e5Mx-QHqPz7eel7w-1; Thu, 21 Dec 2023 12:43:35 -0500
X-MC-Unique: x_n5s6e5Mx-QHqPz7eel7w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFA1783538E;
 Thu, 21 Dec 2023 17:43:34 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56B07492BC6;
 Thu, 21 Dec 2023 17:43:33 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 si-wei.liu@oracle.com, Laurent Vivier <lvivier@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PATCH v4 04/13] vdpa: move shadow_data to vhost_vdpa_shared
Date: Thu, 21 Dec 2023 18:43:13 +0100
Message-Id: <20231221174322.3130442-5-eperezma@redhat.com>
In-Reply-To: <20231221174322.3130442-1-eperezma@redhat.com>
References: <20231221174322.3130442-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

Next patches will register the vhost_vdpa memory listener while the VM
is migrating at the destination, so we can map the memory to the device
before stopping the VM at the source.  The main goal is to reduce the
downtime.

However, the destination QEMU is unaware of which vhost_vdpa device will
register its memory_listener.  If the source guest has CVQ enabled, it
will be the CVQ device.  Otherwise, it  will be the first one.

Move the shadow_data member to VhostVDPAShared so all vhost_vdpa can use
it, rather than always in the first or last vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
v1 from RFC:
* Fix vhost_vdpa_net_cvq_start checking for always_svq instead of
  shadow_data.  This could cause CVQ not being shadowed if
  vhost_vdpa_net_cvq_start was called in the middle of a migration.

v2:
* Avoid repeated setting shared->shadow_data by squashing Si-Wei's patch
  [1]

[1] https://patchwork.kernel.org/project/qemu-devel/patch/1701970793-6865-10-git-send-email-si-wei.liu@oracle.com/
---
 include/hw/virtio/vhost-vdpa.h |  5 +++--
 hw/virtio/vhost-vdpa.c         |  6 +++---
 net/vhost-vdpa.c               | 22 +++++-----------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 8d52a7e498..01e0f25e27 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -36,6 +36,9 @@ typedef struct vhost_vdpa_shared {
 
     /* IOVA mapping used by the Shadow Virtqueue */
     VhostIOVATree *iova_tree;
+
+    /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
+    bool shadow_data;
 } VhostVDPAShared;
 
 typedef struct vhost_vdpa {
@@ -47,8 +50,6 @@ typedef struct vhost_vdpa {
     MemoryListener listener;
     uint64_t acked_features;
     bool shadow_vqs_enabled;
-    /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
-    bool shadow_data;
     /* Device suspended successfully */
     bool suspended;
     VhostVDPAShared *shared;
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 2bceadd118..ec028e4c56 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -353,7 +353,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
                                          vaddr, section->readonly);
 
     llsize = int128_sub(llend, int128_make64(iova));
-    if (v->shadow_data) {
+    if (v->shared->shadow_data) {
         int r;
 
         mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr,
@@ -380,7 +380,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     return;
 
 fail_map:
-    if (v->shadow_data) {
+    if (v->shared->shadow_data) {
         vhost_iova_tree_remove(v->shared->iova_tree, mem_region);
     }
 
@@ -435,7 +435,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
 
     llsize = int128_sub(llend, int128_make64(iova));
 
-    if (v->shadow_data) {
+    if (v->shared->shadow_data) {
         const DMAMap *result;
         const void *vaddr = memory_region_get_ram_ptr(section->mr) +
             section->offset_within_region +
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 7be2c30ad3..bf8e8327da 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -290,15 +290,6 @@ static ssize_t vhost_vdpa_receive(NetClientState *nc, const uint8_t *buf,
     return size;
 }
 
-/** From any vdpa net client, get the netclient of the first queue pair */
-static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s)
-{
-    NICState *nic = qemu_get_nic(s->nc.peer);
-    NetClientState *nc0 = qemu_get_peer(nic->ncs, 0);
-
-    return DO_UPCAST(VhostVDPAState, nc, nc0);
-}
-
 static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
 {
     struct vhost_vdpa *v = &s->vhost_vdpa;
@@ -369,13 +360,12 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
     if (s->always_svq ||
         migration_is_setup_or_active(migrate_get_current()->state)) {
         v->shadow_vqs_enabled = true;
-        v->shadow_data = true;
     } else {
         v->shadow_vqs_enabled = false;
-        v->shadow_data = false;
     }
 
     if (v->index == 0) {
+        v->shared->shadow_data = v->shadow_vqs_enabled;
         vhost_vdpa_net_data_start_first(s);
         return 0;
     }
@@ -523,7 +513,7 @@ dma_map_err:
 
 static int vhost_vdpa_net_cvq_start(NetClientState *nc)
 {
-    VhostVDPAState *s, *s0;
+    VhostVDPAState *s;
     struct vhost_vdpa *v;
     int64_t cvq_group;
     int r;
@@ -534,12 +524,10 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
     s = DO_UPCAST(VhostVDPAState, nc, nc);
     v = &s->vhost_vdpa;
 
-    s0 = vhost_vdpa_net_first_nc_vdpa(s);
-    v->shadow_data = s0->vhost_vdpa.shadow_vqs_enabled;
-    v->shadow_vqs_enabled = s0->vhost_vdpa.shadow_vqs_enabled;
+    v->shadow_vqs_enabled = v->shared->shadow_data;
     s->vhost_vdpa.address_space_id = VHOST_VDPA_GUEST_PA_ASID;
 
-    if (s->vhost_vdpa.shadow_data) {
+    if (v->shared->shadow_data) {
         /* SVQ is already configured for all virtqueues */
         goto out;
     }
@@ -1688,12 +1676,12 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
     s->always_svq = svq;
     s->migration_state.notify = NULL;
     s->vhost_vdpa.shadow_vqs_enabled = svq;
-    s->vhost_vdpa.shadow_data = svq;
     if (queue_pair_index == 0) {
         vhost_vdpa_net_valid_svq_features(features,
                                           &s->vhost_vdpa.migration_blocker);
         s->vhost_vdpa.shared = g_new0(VhostVDPAShared, 1);
         s->vhost_vdpa.shared->iova_range = iova_range;
+        s->vhost_vdpa.shared->shadow_data = svq;
     } else if (!is_datapath) {
         s->cvq_cmd_out_buffer = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
                                      PROT_READ | PROT_WRITE,
-- 
2.39.3


