Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1267681E656
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:25:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3gP-0002nP-Ow; Tue, 26 Dec 2023 04:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gM-0002f8-Si
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3gI-0008K3-Vb
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kho8Kn81JXFBrbbnbKhrQXI3g7g8qDF5iaK2v9gtOs0=;
 b=ZR+dNu6oTG+V/eotmO7qBAtkFEY90HAa3e4a7lS4UkWFXBj8OpyiyPPUjoEAMRTjM9LNAP
 HnRjmueRTlJFcuGQdWeKVZftHttXmemhsIhr7sIHBPDatU7I7sZXK1HDJ6F730byAFo0H7
 c5JLcsiTqWO4xY9JWWOY6pP3NVEhmNI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-P0-2xfzVN7ijvjKc_3oHGw-1; Tue, 26 Dec 2023 04:24:56 -0500
X-MC-Unique: P0-2xfzVN7ijvjKc_3oHGw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33688a38636so3151679f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582694; x=1704187494;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kho8Kn81JXFBrbbnbKhrQXI3g7g8qDF5iaK2v9gtOs0=;
 b=dMOf8vxj8qrpjcZqKr/lUQfvcWeCKCSfZJ1zkoANYzA8rwMlMHKQ8bkgHynGRudxrS
 9kT/QV5RKBotu4LgAY/hsB5uev/709t1TKCBMGjH8BmbsXrLH+Tdcvri/hYdxLJVIs8A
 4jJWUmz3k/WRw82pw35olK3RxZNPQqSHcsCE1XXH/8uK27Ff0TCiIcOizdmzUnmc3GZk
 VuPsev1Nb1heSLufyLF5RYmyqeMu/IR52PrtOj0LxXlE/MF405VnD+7CMrgwGpuCkV4q
 REkvNVyx1SQTarUyXfdSNkEWk67Tt96d7HhPOpUtfzZt/Kqs51n5HaSgJTYIomoiHcO2
 Hh9Q==
X-Gm-Message-State: AOJu0YyB9y1dL0yxN+W/sVt9CiNisc2ve4w+oXB9r3Xi0fToo0z/EvXv
 pveIBR4lElUd8AXMVrgxOit1244TxnktGOlH7YCIH7BByRfI9elHoNnyEdHMSms10xV8HFZq6pJ
 V9TjSucC2sZ/k56aRIP68VPD5LivDo4Gvwx/iDNOBq7aKVJeZCIWF+aJkS5iro786LmAAMluC/k
 6O
X-Received: by 2002:a05:600c:1987:b0:40d:5798:1797 with SMTP id
 t7-20020a05600c198700b0040d57981797mr1036205wmq.63.1703582694037; 
 Tue, 26 Dec 2023 01:24:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAWmUvPxc4Je98bTMHxr/II4hAz93qZvI+rO3dt2AgTAIBQQ99PHYcgWzVXK8axzSKfUm5jw==
X-Received: by 2002:a05:600c:1987:b0:40d:5798:1797 with SMTP id
 t7-20020a05600c198700b0040d57981797mr1036197wmq.63.1703582693724; 
 Tue, 26 Dec 2023 01:24:53 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 e25-20020adfa459000000b003365951cef9sm12261228wra.55.2023.12.26.01.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:24:51 -0800 (PST)
Date: Tue, 26 Dec 2023 04:24:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 12/21] vdpa: move shadow_data to vhost_vdpa_shared
Message-ID: <787ac82bcea98139204c26ccf2a488d2f9b54003.1703582625.git.mst@redhat.com>
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

Move the shadow_data member to VhostVDPAShared so all vhost_vdpa can use
it, rather than always in the first or last vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20231221174322.3130442-5-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
index 5ff1d43ba9..97588848fc 100644
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
MST


