Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9871FCC6
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 10:54:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q50XN-0000rY-Un; Fri, 02 Jun 2023 04:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q50XL-0000r2-9u
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 04:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q50XJ-0003gX-Jw
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 04:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685696008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ml1S3EEt3L219LDwTEF4jvTpZqPqlGMzs4Us7q4mVGQ=;
 b=Hg+qZg6ZzPtmkECq5yxsGAcpLr7Jpuf/AbhCBzoAWUfzKZtyysv24GhHgwkfEHeTxLwnEU
 gMi7rwXlYeQ9yG8x/ymAw633tL3Q3PPYr25mHLt4mDUS42BoQxslugJ7R/C0k4h3xrvBqm
 7WdtL4MSrk1PEpMBxLwZ2a9LWVM5TfI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-nTJVxpUcMa-64UZje_8ypw-1; Fri, 02 Jun 2023 04:53:27 -0400
X-MC-Unique: nTJVxpUcMa-64UZje_8ypw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F0AB800B2A
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 08:53:27 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4445440C6EC4;
 Fri,  2 Jun 2023 08:53:26 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH 2/2] vdpa: map shadow vrings with MAP_SHARED
Date: Fri,  2 Jun 2023 10:53:21 +0200
Message-Id: <20230602085321.1814165-3-eperezma@redhat.com>
In-Reply-To: <20230602085321.1814165-1-eperezma@redhat.com>
References: <20230602085321.1814165-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The vdpa devices that use va addresses neeeds these maps shared.
Otherwise, vhost_vdpa checks will refuse to accept the maps.

The mmap call will always return a page aligned address, so removing the
qemu_memalign call.  Keeping the ROUND_UP for the size as we still need
to DMA-map them in full.

Not applying fixes tag as it never worked with va devices.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 16 +++++++---------
 net/vhost-vdpa.c                   | 15 +++++++--------
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index bd7c12b6d3..1892e2cef1 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -649,7 +649,7 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd)
 void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
                      VirtQueue *vq, VhostIOVATree *iova_tree)
 {
-    size_t desc_size, driver_size, device_size;
+    size_t desc_size;
 
     event_notifier_set_handler(&svq->hdev_call, vhost_svq_handle_call);
     svq->next_guest_avail_elem = NULL;
@@ -662,14 +662,12 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
 
     svq->vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
     svq->num_free = svq->vring.num;
-    driver_size = vhost_svq_driver_area_size(svq);
-    device_size = vhost_svq_device_area_size(svq);
-    svq->vring.desc = qemu_memalign(qemu_real_host_page_size(), driver_size);
+    svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq), O_RDWR,
+                           MAP_SHARED | MAP_ANONYMOUS, -1, 0);
     desc_size = sizeof(vring_desc_t) * svq->vring.num;
     svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
-    memset(svq->vring.desc, 0, driver_size);
-    svq->vring.used = qemu_memalign(qemu_real_host_page_size(), device_size);
-    memset(svq->vring.used, 0, device_size);
+    svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq), O_RDWR,
+                           MAP_SHARED | MAP_ANONYMOUS, -1, 0);
     svq->desc_state = g_new0(SVQDescState, svq->vring.num);
     svq->desc_next = g_new0(uint16_t, svq->vring.num);
     for (unsigned i = 0; i < svq->vring.num - 1; i++) {
@@ -712,8 +710,8 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
     svq->vq = NULL;
     g_free(svq->desc_next);
     g_free(svq->desc_state);
-    qemu_vfree(svq->vring.desc);
-    qemu_vfree(svq->vring.used);
+    munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
+    munmap(svq->vring.used, vhost_svq_device_area_size(svq));
     event_notifier_set_handler(&svq->hdev_call, NULL);
 }
 
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 5fcdc05042..329b481351 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -201,8 +201,8 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
 
-    qemu_vfree(s->cvq_cmd_out_buffer);
-    qemu_vfree(s->status);
+    munmap(s->cvq_cmd_out_buffer, vhost_vdpa_net_cvq_cmd_page_len());
+    munmap(s->status, vhost_vdpa_net_cvq_cmd_page_len());
     if (s->vhost_net) {
         vhost_net_cleanup(s->vhost_net);
         g_free(s->vhost_net);
@@ -826,12 +826,11 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
         vhost_vdpa_net_valid_svq_features(features,
                                           &s->vhost_vdpa.migration_blocker);
     } else if (!is_datapath) {
-        s->cvq_cmd_out_buffer = qemu_memalign(qemu_real_host_page_size(),
-                                            vhost_vdpa_net_cvq_cmd_page_len());
-        memset(s->cvq_cmd_out_buffer, 0, vhost_vdpa_net_cvq_cmd_page_len());
-        s->status = qemu_memalign(qemu_real_host_page_size(),
-                                  vhost_vdpa_net_cvq_cmd_page_len());
-        memset(s->status, 0, vhost_vdpa_net_cvq_cmd_page_len());
+        s->cvq_cmd_out_buffer = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
+                                     O_RDWR, MAP_SHARED | MAP_ANONYMOUS, -1,
+                                     0);
+        s->status = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(), O_RDWR,
+                         MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 
         s->vhost_vdpa.shadow_vq_ops = &vhost_vdpa_net_svq_ops;
         s->vhost_vdpa.shadow_vq_ops_opaque = s;
-- 
2.31.1


