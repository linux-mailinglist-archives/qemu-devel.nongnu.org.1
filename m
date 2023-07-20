Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C075B663
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 20:16:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMYBl-00057w-CU; Thu, 20 Jul 2023 14:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBX-0004N6-Np
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMYBU-0003Mi-9t
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689876927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6AnXRkfbPBY2lKGkgKhB/5jrIYEC5iVGXI+KaHqNwxg=;
 b=MhbzljXydb+rrAXm9U3hOvXibuYddf1KfW/R4bhWc+29+4oYV3I9MKlI+PDi42oTVocWxN
 +6KoWU9wqsJr394Ah9peIDGoFWs0+if997n+llzWIyHp7ufNIlJKbhdn5Qy1VjZCI91alW
 ZZI4CbF7anyEk2IpC6meO1Gpz0tZU0s=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-HN_1A3gbP9Ok9goyrbYUbQ-1; Thu, 20 Jul 2023 14:15:21 -0400
X-MC-Unique: HN_1A3gbP9Ok9goyrbYUbQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF80E38025EA;
 Thu, 20 Jul 2023 18:15:20 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E3B32166B25;
 Thu, 20 Jul 2023 18:15:19 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: yvugenfi@redhat.com,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 si-wei.liu@oracle.com, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Shannon Nelson <snelson@pensando.io>
Subject: [RFC PATCH 11/12] vdpa: use SVQ to stall dataplane while NIC state is
 being restored
Date: Thu, 20 Jul 2023 20:14:58 +0200
Message-Id: <20230720181459.607008-12-eperezma@redhat.com>
In-Reply-To: <20230720181459.607008-1-eperezma@redhat.com>
References: <20230720181459.607008-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Some dynamic state of a virtio-net vDPA devices is restored from CVQ in
the event of a live migration.  However, dataplane needs to be disabled
so the NIC does not receive buffers in the invalid ring.

As a default method to achieve it, let's offer a shadow vring with 0
avail idx.  As a fallback method, we will enable dataplane vqs later, as
proposed previously.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/vhost-vdpa.c | 49 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index af83de92f8..e14ae48f23 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -338,10 +338,25 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
     struct vhost_vdpa *v = &s->vhost_vdpa;
+    bool has_cvq = v->dev->vq_index_end % 2;
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
-    if (s->always_svq ||
+    if (has_cvq && (v->dev->features & VIRTIO_F_RING_RESET)) {
+        /*
+         * Offer a fake vring to the device while the state is restored
+         * through CVQ.  That way, the guest will not see packets in unexpected
+         * queues.
+         *
+         * This will be undone after loading all state through CVQ, at
+         * vhost_vdpa_net_load.
+         *
+         * TODO: Future optimizations may skip some SVQ setup and teardown,
+         * like set the right kick and call fd or doorbell maps directly, and
+         * the iova tree.
+         */
+        v->shadow_vqs_enabled = true;
+    } else if (s->always_svq ||
         migration_is_setup_or_active(migrate_get_current()->state)) {
         v->shadow_vqs_enabled = true;
         v->shadow_data = true;
@@ -738,10 +753,34 @@ static int vhost_vdpa_net_load(NetClientState *nc)
         return r;
     }
 
-    for (int i = 0; i < v->dev->vq_index; ++i) {
-        r = vhost_vdpa_set_vring_ready(v, i);
-        if (unlikely(r)) {
-            return r;
+    if (v->dev->features & VIRTIO_F_RING_RESET && !s->always_svq &&
+        !migration_is_setup_or_active(migrate_get_current()->state)) {
+        NICState *nic = qemu_get_nic(s->nc.peer);
+        int queue_pairs = n->multiqueue ? n->max_queue_pairs : 1;
+
+        for (int i = 0; i < queue_pairs; ++i) {
+            NetClientState *ncs = qemu_get_peer(nic->ncs, i);
+            VhostVDPAState *s_i = DO_UPCAST(VhostVDPAState, nc, ncs);
+
+            for (int j = 0; j < 2; ++j) {
+                vhost_net_virtqueue_reset(v->dev->vdev, ncs->peer, j);
+            }
+
+            s_i->vhost_vdpa.shadow_vqs_enabled = false;
+
+            for (int j = 0; j < 2; ++j) {
+                r = vhost_net_virtqueue_restart(v->dev->vdev, ncs->peer, j);
+                if (unlikely(r < 0)) {
+                    return r;
+                }
+            }
+        }
+    } else {
+        for (int i = 0; i < v->dev->vq_index; ++i) {
+            r = vhost_vdpa_set_vring_ready(v, i);
+            if (unlikely(r)) {
+                return r;
+            }
         }
     }
 
-- 
2.39.3


