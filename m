Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 316AEB0506E
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 06:42:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubXPN-0001tf-AV; Tue, 15 Jul 2025 00:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOL-0001K8-2u
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubXOJ-0005zL-1l
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 00:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752554142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=781Vd1RCDVNzKBhruVItGkuo2QXETHPOcYRirLtEix0=;
 b=Tzb1lSwyt8Mwl3iqScY/RxHMYThjrr1d3ZZUKTJpf3DBVTzqpQ7XOAZx0qmFt6pPAU4QPr
 lKB3lBow++q8y83XFAK9cTblqGOrqo3fsFrHq7FQ3Y7ieGaBX70h3lLlUsrTxjOr2Uqryi
 JfL4RWeDXla9qbMQbefO7mWoXjzrA2U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-1u7LW3FBOymmOLJB2bMHoQ-1; Tue,
 15 Jul 2025 00:35:38 -0400
X-MC-Unique: 1u7LW3FBOymmOLJB2bMHoQ-1
X-Mimecast-MFC-AGG-ID: 1u7LW3FBOymmOLJB2bMHoQ_1752554137
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 852C818002E4; Tue, 15 Jul 2025 04:35:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.42])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 92EF21977000; Tue, 15 Jul 2025 04:35:34 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Lei Yang <leiyang@redhat.com>,
 qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: [PULL V2 02/16] virtio-net: Add queues for RSS during migration
Date: Tue, 15 Jul 2025 12:35:10 +0800
Message-ID: <20250715043524.21719-3-jasowang@redhat.com>
In-Reply-To: <20250715043524.21719-1-jasowang@redhat.com>
References: <20250715043524.21719-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

virtio_net_pre_load_queues() inspects vdev->guest_features to tell if
VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the required
number of queues. This works for VIRTIO_NET_F_MQ but it doesn't for
VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_features
is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
VIRTIO_NET_F_MQ uses bit 22.

Instead of inferring the required number of queues from
vdev->guest_features, use the number loaded from the vm state. This
change also has a nice side effect to remove a duplicate peer queue
pair change by circumventing virtio_net_set_multiqueue().

Also update the comment in include/hw/virtio/virtio.h to prevent an
implementation of pre_load_queues() from refering to any fields being
loaded during migration by accident in the future.

Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizing")

Tested-by: Lei Yang <leiyang@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c        | 11 ++++-------
 hw/virtio/virtio.c         | 14 +++++++-------
 include/hw/virtio/virtio.h | 10 ++++++++--
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index eb93607b8c..351377c025 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3022,11 +3022,10 @@ static void virtio_net_del_queue(VirtIONet *n, int index)
     virtio_del_queue(vdev, index * 2 + 1);
 }
 
-static void virtio_net_change_num_queue_pairs(VirtIONet *n, int new_max_queue_pairs)
+static void virtio_net_change_num_queues(VirtIONet *n, int new_num_queues)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     int old_num_queues = virtio_get_num_queues(vdev);
-    int new_num_queues = new_max_queue_pairs * 2 + 1;
     int i;
 
     assert(old_num_queues >= 3);
@@ -3062,16 +3061,14 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
     int max = multiqueue ? n->max_queue_pairs : 1;
 
     n->multiqueue = multiqueue;
-    virtio_net_change_num_queue_pairs(n, max);
+    virtio_net_change_num_queues(n, max * 2 + 1);
 
     virtio_net_set_queue_pairs(n);
 }
 
-static int virtio_net_pre_load_queues(VirtIODevice *vdev)
+static int virtio_net_pre_load_queues(VirtIODevice *vdev, uint32_t n)
 {
-    virtio_net_set_multiqueue(VIRTIO_NET(vdev),
-                              virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_RSS) ||
-                              virtio_has_feature(vdev->guest_features, VIRTIO_NET_F_MQ));
+    virtio_net_change_num_queues(VIRTIO_NET(vdev), n);
 
     return 0;
 }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 82a285a31d..7e38b1ca97 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3270,13 +3270,6 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         config_len--;
     }
 
-    if (vdc->pre_load_queues) {
-        ret = vdc->pre_load_queues(vdev);
-        if (ret) {
-            return ret;
-        }
-    }
-
     num = qemu_get_be32(f);
 
     if (num > VIRTIO_QUEUE_MAX) {
@@ -3284,6 +3277,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         return -1;
     }
 
+    if (vdc->pre_load_queues) {
+        ret = vdc->pre_load_queues(vdev, num);
+        if (ret) {
+            return ret;
+        }
+    }
+
     for (i = 0; i < num; i++) {
         vdev->vq[i].vring.num = qemu_get_be32(f);
         if (k->has_variable_vring_alignment) {
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 214d4a77e9..c594764f23 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -210,8 +210,14 @@ struct VirtioDeviceClass {
     void (*guest_notifier_mask)(VirtIODevice *vdev, int n, bool mask);
     int (*start_ioeventfd)(VirtIODevice *vdev);
     void (*stop_ioeventfd)(VirtIODevice *vdev);
-    /* Called before loading queues. Useful to add queues before loading. */
-    int (*pre_load_queues)(VirtIODevice *vdev);
+    /*
+     * Called before loading queues.
+     * If the number of queues change at runtime, use @n to know the
+     * number and add or remove queues accordingly.
+     * Note that this function is called in the middle of loading vmsd;
+     * no assumption should be made on states being loaded from vmsd.
+     */
+    int (*pre_load_queues)(VirtIODevice *vdev, uint32_t n);
     /* Saving and loading of a device; trying to deprecate save/load
      * use vmsd for new devices.
      */
-- 
2.42.0


