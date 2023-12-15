Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDDC814EBB
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 18:30:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEBzd-00062e-1t; Fri, 15 Dec 2023 12:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rEBzb-00061a-5L
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:28:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rEBzZ-00013C-87
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702661332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djrPUeyzY1LqStlZltfm/nexviMVFCU+NbuO5MY9L4Y=;
 b=UgOH8oAhh9MVSwERTIgk6nHf74yDcR6IZM4PFG92jQvy5uYMflpIPOekPtKr7VlOrRGu9G
 gFo322L8oHpduQPq7janNV9M8HTe6uz4Mq2JHJRHj94j3VVuT0DB+VY8gSL6IsclJyx5+T
 y6T2kjLZ3tWIUlUkfY3hCrCvdB8XMgQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369--UG4hZ1dMem1rT4vxgZeKQ-1; Fri,
 15 Dec 2023 12:28:51 -0500
X-MC-Unique: -UG4hZ1dMem1rT4vxgZeKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDDB33C025C9;
 Fri, 15 Dec 2023 17:28:50 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.194.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2077D40C6EB9;
 Fri, 15 Dec 2023 17:28:49 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, si-wei.liu@oracle.com,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH for 9.0 09/12] vdpa: approve switchover after memory map in
 the migration destination
Date: Fri, 15 Dec 2023 18:28:27 +0100
Message-Id: <20231215172830.2540987-10-eperezma@redhat.com>
In-Reply-To: <20231215172830.2540987-1-eperezma@redhat.com>
References: <20231215172830.2540987-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

If the VM migrates before finishing all the maps, the source will stop
but the destination is still not ready to continue, and it will wait
until all guest RAM is mapped.  The destination can use switchover_ack
to prevent source to stop until all the memory is mapped at the
destination.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  4 ++++
 hw/virtio/vhost-vdpa.c         | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index b49286b327..1c7e3fbd24 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -34,6 +34,7 @@ typedef struct VhostVDPAHostNotifier {
 typedef struct VhostVDPAMapThread {
     QemuThread thread;
     GAsyncQueue *queue;
+    QEMUBH *bh;
     bool map_thread_enabled;
 } VhostVDPAMapThread;
 
@@ -60,6 +61,9 @@ typedef struct vhost_vdpa_shared {
      * To solve it, offload the first listener operations until the first
      * listener commit from the main thread.  Once these are served, join the
      * map thread.
+     *
+     * This map thread is joined by join_map_thread BH if
+     * migrate_switchover_ack is supported, or by vhost_vdpa_dev_start if not.
      */
     VhostVDPAMapThread *map_thread;
 
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 339e11c58a..7d31f4a30e 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -22,6 +22,8 @@
 #include "hw/virtio/vhost-vdpa.h"
 #include "exec/address-spaces.h"
 #include "migration/blocker.h"
+#include "migration/options.h"
+#include "migration/savevm.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
 #include "trace.h"
@@ -1372,13 +1374,26 @@ static void *vhost_vdpa_load_map_worker(void *opaque)
     }
 
 end:
+    if (shared->map_thread->bh) {
+        qemu_bh_schedule(shared->map_thread->bh);
+    }
+
     return ret;
 }
 
+static void vhost_vdpa_load_map_switchover_ack(void *opaque)
+{
+    qemu_loadvm_approve_switchover();
+}
+
 static void vhost_vdpa_spawn_maps_thread(VhostVDPAShared *shared)
 {
     shared->map_thread = g_new0(VhostVDPAMapThread, 1);
     shared->map_thread->queue = g_async_queue_new();
+    if (migrate_switchover_ack()) {
+        shared->map_thread->bh = qemu_bh_new(vhost_vdpa_load_map_switchover_ack,
+                                             NULL);
+    }
     qemu_thread_create(&shared->map_thread->thread, "vdpa map thread",
                        vhost_vdpa_load_map_worker, shared,
                        QEMU_THREAD_JOINABLE);
@@ -1390,6 +1405,9 @@ static bool vhost_vdpa_join_maps_thread(VhostVDPAShared *shared)
     g_autoptr(GPtrArray) failed_iova = NULL;
 
     failed_iova = qemu_thread_join(&shared->map_thread->thread);
+    if (shared->map_thread->bh) {
+        qemu_bh_delete(shared->map_thread->bh);
+    }
     g_async_queue_unref(shared->map_thread->queue);
     g_clear_pointer(&shared->map_thread, g_free);
 
-- 
2.39.3


