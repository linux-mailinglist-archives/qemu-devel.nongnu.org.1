Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FA274F419
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 17:53:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJFfS-0000e4-PC; Tue, 11 Jul 2023 11:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJFfP-0000db-Bz
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJFfN-0001hm-PT
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689090761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vp6pWpdnR3eKs5VasVSM9LNR1XXQyd2OrdGAiDMmfg4=;
 b=N7QVyKzNVnNHECnLHjTHNEnOh91mCwtB4oAuS4UnL7FKP/7F7s9fbcXd50TrB+SzqQVx9P
 6rVdO9/LD7+ti4Fe911vGK0Ahd3HfCoyZiB+pWx75L1v7FjIOBiSN5tleSkx02a+rYFeca
 1GuCoL7RHitGA560LfzydKiBmjizC6g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-_q7LsmWTOXOCPFEjzWZitA-1; Tue, 11 Jul 2023 11:52:39 -0400
X-MC-Unique: _q7LsmWTOXOCPFEjzWZitA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46089185A78F
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 15:52:39 +0000 (UTC)
Received: from localhost (unknown [10.39.192.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE2B92166B26;
 Tue, 11 Jul 2023 15:52:38 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: [PATCH 3/6] vhost: Do not reset suspended devices on stop
Date: Tue, 11 Jul 2023 17:52:25 +0200
Message-ID: <20230711155230.64277-4-hreitz@redhat.com>
In-Reply-To: <20230711155230.64277-1-hreitz@redhat.com>
References: <20230711155230.64277-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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

Move the `suspended` field from vhost_vdpa into the global vhost_dev
struct, so vhost_dev_stop() can check whether the back-end has been
suspended by `vhost_ops->vhost_dev_start(hdev, false)`.  If it has,
there is no need to reset it; the reset is just a fall-back to stop
device operations for back-ends that do not support suspend.

Unfortunately, for vDPA specifically, RESUME is not yet implemented, so
when the device is re-started, we still have to do the reset to have it
un-suspend.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  2 --
 include/hw/virtio/vhost.h      |  8 ++++++++
 hw/virtio/vhost-vdpa.c         | 11 +++++++----
 hw/virtio/vhost.c              |  8 +++++++-
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index e64bfc7f98..72c3686b7f 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -42,8 +42,6 @@ typedef struct vhost_vdpa {
     bool shadow_vqs_enabled;
     /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
     bool shadow_data;
-    /* Device suspended successfully */
-    bool suspended;
     /* IOVA mapping used by the Shadow Virtqueue */
     VhostIOVATree *iova_tree;
     GPtrArray *shadow_vqs;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 6a173cb9fa..69bf59d630 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -120,6 +120,14 @@ struct vhost_dev {
     uint64_t backend_cap;
     /* @started: is the vhost device started? */
     bool started;
+    /**
+     * @suspended: Whether the vhost device is currently suspended.  Set
+     * and reset by implementations (vhost-user, vhost-vdpa, ...), which
+     * are supposed to automatically suspend/resume in their
+     * vhost_dev_start handlers as required.  Must also be cleared when
+     * the device is reset.
+     */
+    bool suspended;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 7b7dee468e..f7fd19a203 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -858,13 +858,12 @@ static int vhost_vdpa_get_device_id(struct vhost_dev *dev,
 
 static int vhost_vdpa_reset_device(struct vhost_dev *dev)
 {
-    struct vhost_vdpa *v = dev->opaque;
     int ret;
     uint8_t status = 0;
 
     ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
     trace_vhost_vdpa_reset_device(dev);
-    v->suspended = false;
+    dev->suspended = false;
     return ret;
 }
 
@@ -1278,7 +1277,7 @@ static void vhost_vdpa_suspend(struct vhost_dev *dev)
         if (unlikely(r)) {
             error_report("Cannot suspend: %s(%d)", g_strerror(errno), errno);
         } else {
-            v->suspended = true;
+            dev->suspended = true;
             return;
         }
     }
@@ -1313,6 +1312,10 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
             return -1;
         }
         vhost_vdpa_set_vring_ready(dev);
+        if (dev->suspended) {
+            /* TODO: When RESUME is available, use it instead of resetting */
+            vhost_vdpa_reset_status(dev);
+        }
     } else {
         vhost_vdpa_suspend(dev);
         vhost_vdpa_svqs_stop(dev);
@@ -1400,7 +1403,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
         return 0;
     }
 
-    if (!v->suspended) {
+    if (!dev->suspended) {
         /*
          * Cannot trust in value returned by device, let vhost recover used
          * idx from guest.
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index abf0d03c8d..2e28e58da7 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2059,7 +2059,13 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
                              hdev->vqs + i,
                              hdev->vq_index + i);
     }
-    if (hdev->vhost_ops->vhost_reset_status) {
+
+    /*
+     * If we failed to successfully stop the device via SUSPEND (should have
+     * been attempted by `vhost_dev_start(hdev, false)`), reset it to stop it.
+     * Stateful devices where this would be problematic must implement SUSPEND.
+     */
+    if (!hdev->suspended && hdev->vhost_ops->vhost_reset_status) {
         hdev->vhost_ops->vhost_reset_status(hdev);
     }
 
-- 
2.41.0


