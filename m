Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E38EB0FAFF
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Jul 2025 21:37:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uefFY-0004ds-Op; Wed, 23 Jul 2025 15:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uefD9-0002Ax-6c
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 15:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uefD7-0006JJ-4E
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 15:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753299184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3hmmFwaFtl2zU8Rtywm7GNv5VpENUaf3LxYYohHWBBA=;
 b=Len4TJ3fMrhmck0ktEIrvQ3ZBxxAvIchun7iLEAiJXB4KKzeD8XZ4Rsy5nCTsUObL5uWO3
 r7UUKRIKI+Mx5ElEkLfXQGQZMiQaGX3WiXU0wbZwhdROxiy3djuNp2EDHShjS1zxsCMhwp
 EH6054AAF2eRXfBH+uvFhN+YTFyIwdY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-QpIVhBPAMFKP9eeQgMhZGQ-1; Wed,
 23 Jul 2025 15:33:01 -0400
X-MC-Unique: QpIVhBPAMFKP9eeQgMhZGQ-1
X-Mimecast-MFC-AGG-ID: QpIVhBPAMFKP9eeQgMhZGQ_1753299179
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCF96195FCC2; Wed, 23 Jul 2025 19:32:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.60])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED79318003FC; Wed, 23 Jul 2025 19:32:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH v4 10/14] vhost-backend: implement extended features
 support
Date: Wed, 23 Jul 2025 21:31:30 +0200
Message-ID: <3d5f808f441f22cd7cafd695f86cc169e54f9d20.1753297661.git.pabeni@redhat.com>
In-Reply-To: <cover.1753297661.git.pabeni@redhat.com>
References: <cover.1753297661.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Leverage the kernel extended features manipulation ioctls(), if
available, and fallback to old ops otherwise. Error out when setting
extended features but kernel support is not available.

Note that extended support for get/set backend features is not needed,
as the only feature that can be changed belongs to the 64 bit range.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
  - use new virtio_features macro names

v1 -> v2:
  - synced with kernel ioctl changes
---
 hw/virtio/vhost-backend.c | 62 ++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 833804dd40..4367db0d95 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -20,6 +20,11 @@
 #include <linux/vhost.h>
 #include <sys/ioctl.h>
 
+struct vhost_features {
+    uint64_t count;
+    uint64_t features[VIRTIO_FEATURES_NU64S];
+};
+
 static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int request,
                              void *arg)
 {
@@ -182,12 +187,6 @@ static int vhost_kernel_get_vring_worker(struct vhost_dev *dev,
     return vhost_kernel_call(dev, VHOST_GET_VRING_WORKER, worker);
 }
 
-static int vhost_kernel_set_features(struct vhost_dev *dev,
-                                     uint64_t features)
-{
-    return vhost_kernel_call(dev, VHOST_SET_FEATURES, &features);
-}
-
 static int vhost_kernel_set_backend_cap(struct vhost_dev *dev)
 {
     uint64_t features;
@@ -210,10 +209,51 @@ static int vhost_kernel_set_backend_cap(struct vhost_dev *dev)
     return 0;
 }
 
-static int vhost_kernel_get_features(struct vhost_dev *dev,
-                                     uint64_t *features)
+static int vhost_kernel_set_features(struct vhost_dev *dev,
+                                     const uint64_t *features)
 {
-    return vhost_kernel_call(dev, VHOST_GET_FEATURES, features);
+    struct vhost_features farray;
+    bool extended_in_use;
+    int r;
+
+    farray.count = VIRTIO_FEATURES_NU64S;
+    virtio_features_copy(farray.features, features);
+    extended_in_use = virtio_features_use_ex(farray.features);
+
+    /*
+     * Can't check for ENOTTY: for unknown ioctls the kernel interprets
+     * the argument as a virtio queue id and most likely errors out validating
+     * such id, instead of reporting an unknown operation.
+     */
+    r = vhost_kernel_call(dev, VHOST_SET_FEATURES_ARRAY, &farray);
+    if (!r) {
+        return 0;
+    }
+
+    if (extended_in_use) {
+        error_report("Trying to set extended features without kernel support");
+        return -EINVAL;
+    }
+    return vhost_kernel_call(dev, VHOST_SET_FEATURES, &farray.features[0]);
+}
+
+static int vhost_kernel_get_features(struct vhost_dev *dev, uint64_t *features)
+{
+    struct vhost_features farray;
+    int r;
+
+    farray.count = VIRTIO_FEATURES_NU64S;
+    r = vhost_kernel_call(dev, VHOST_GET_FEATURES_ARRAY, &farray);
+    if (r) {
+        memset(&farray, 0, sizeof(farray));
+        r = vhost_kernel_call(dev, VHOST_GET_FEATURES, &farray.features[0]);
+    }
+    if (r) {
+        return r;
+    }
+
+    virtio_features_copy(features, farray.features);
+    return 0;
 }
 
 static int vhost_kernel_set_owner(struct vhost_dev *dev)
@@ -341,8 +381,8 @@ const VhostOps kernel_ops = {
         .vhost_attach_vring_worker = vhost_kernel_attach_vring_worker,
         .vhost_new_worker = vhost_kernel_new_worker,
         .vhost_free_worker = vhost_kernel_free_worker,
-        .vhost_set_features = vhost_kernel_set_features,
-        .vhost_get_features = vhost_kernel_get_features,
+        .vhost_set_features_ex = vhost_kernel_set_features,
+        .vhost_get_features_ex = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
-- 
2.50.0


