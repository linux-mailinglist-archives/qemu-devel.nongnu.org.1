Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0406BB09E66
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Jul 2025 10:53:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgqe-0001ST-FO; Fri, 18 Jul 2025 04:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ucgqb-0001LN-9M
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ucgqY-0001AD-Va
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752828818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JTfQZjUV4wVtS/Z0swl737oNnNKTWMly/RkEX4hAeuA=;
 b=fc9jdUQdZnwE7fJkvih2XmOO2WF4AmyCeQ2YZu417tLPZ6kM5yFafu7kgh+KkzZnMXXehl
 HWeFIkYGc9MwwiRuskpE2oOwomVvwNcpYujLaU5+Mtij3QV1b4QyjYRhnTTVMx1V113G0I
 Fq0VDbJik3gof/OfdiFBBBBDOgN1ik0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-YYynmkIzMP6h75XrUrHtHw-1; Fri,
 18 Jul 2025 04:53:35 -0400
X-MC-Unique: YYynmkIzMP6h75XrUrHtHw-1
X-Mimecast-MFC-AGG-ID: YYynmkIzMP6h75XrUrHtHw_1752828813
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65F591956087; Fri, 18 Jul 2025 08:53:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.19])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFFB31956089; Fri, 18 Jul 2025 08:53:28 +0000 (UTC)
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
Subject: [PATCH RFC v3 04/13] virtio: serialize extended features state
Date: Fri, 18 Jul 2025 10:52:30 +0200
Message-ID: <88978e62d3eb7a58d7d647c7ee29f074ccc99bc0.1752828082.git.pabeni@redhat.com>
In-Reply-To: <cover.1752828082.git.pabeni@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

If the driver uses any of the extended features (i.e. 64 or above),
store the extended features range (64-127 bits).

At load time, let legacy features initialize the full features range
and pass it to the set helper; sub-states loading will have filled-up
the extended part as needed.

This is one of the few spots that need explicitly to know and set
in stone the extended features array size; add a build bug to prevent
breaking the migration should such size change again in the future:
more serialization plumbing will be needed.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - 128bit_features state load/stores only the high bits
 - consolidate the load implementation to use a single set
   helper for 128/64/32 bits features
 - _array -> _ex

v1 -> v2:
 - uint128_t -> u64[2]
---
 hw/virtio/virtio.c | 88 ++++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2ab1d20769..2817d3a893 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2954,6 +2954,24 @@ static const VMStateDescription vmstate_virtio_disabled = {
     }
 };
 
+static bool virtio_128bit_features_needed(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+
+    return virtio_features_use_extended(vdev->host_features_ex);
+}
+
+static const VMStateDescription vmstate_virtio_128bit_features = {
+    .name = "virtio/128bit_features",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = &virtio_128bit_features_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(guest_features_ex[1], VirtIODevice),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio = {
     .name = "virtio",
     .version_id = 1,
@@ -2963,6 +2981,7 @@ static const VMStateDescription vmstate_virtio = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_virtio_device_endian,
+        &vmstate_virtio_128bit_features,
         &vmstate_virtio_64bit_features,
         &vmstate_virtio_virtqueues,
         &vmstate_virtio_ringsize,
@@ -3059,23 +3078,28 @@ const VMStateInfo  virtio_vmstate_info = {
     .put = virtio_device_put,
 };
 
-static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
+static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
-    bool bad = (val & ~(vdev->host_features)) != 0;
+    uint64_t tmp[VIRTIO_FEATURES_DWORDS];
+    bool bad;
+
+    bad = virtio_features_andnot(tmp, val, vdev->host_features_ex);
+    virtio_features_and(tmp, val, vdev->host_features_ex);
 
-    val &= vdev->host_features;
     if (k->set_features) {
-        k->set_features(vdev, val);
+        bad = bad || virtio_features_use_extended(tmp);
+        k->set_features(vdev, tmp[0]);
     }
-    vdev->guest_features = val;
+
+    virtio_features_copy(vdev->guest_features_ex, tmp);
     return bad ? -1 : 0;
 }
 
 typedef struct VirtioSetFeaturesNocheckData {
     Coroutine *co;
     VirtIODevice *vdev;
-    uint64_t val;
+    uint64_t val[VIRTIO_FEATURES_DWORDS];
     int ret;
 } VirtioSetFeaturesNocheckData;
 
@@ -3088,14 +3112,15 @@ static void virtio_set_features_nocheck_bh(void *opaque)
 }
 
 static int coroutine_mixed_fn
-virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev, uint64_t val)
+virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev,
+                                     const uint64_t *val)
 {
     if (qemu_in_coroutine()) {
         VirtioSetFeaturesNocheckData data = {
             .co = qemu_coroutine_self(),
             .vdev = vdev,
-            .val = val,
         };
+        virtio_features_copy(data.val, val);
         aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
                                 virtio_set_features_nocheck_bh, &data);
         qemu_coroutine_yield();
@@ -3107,6 +3132,7 @@ virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev, uint64_t val)
 
 int virtio_set_features(VirtIODevice *vdev, uint64_t val)
 {
+    uint64_t features[VIRTIO_FEATURES_DWORDS];
     int ret;
     /*
      * The driver must not attempt to set features after feature negotiation
@@ -3122,7 +3148,8 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
                       __func__, vdev->name);
     }
 
-    ret = virtio_set_features_nocheck(vdev, val);
+    virtio_features_from_u64(features, val);
+    ret = virtio_set_features_nocheck(vdev, features);
     if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
         /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
         int i;
@@ -3145,6 +3172,7 @@ void virtio_reset(void *opaque)
 {
     VirtIODevice *vdev = opaque;
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    uint64_t features[VIRTIO_FEATURES_DWORDS];
     int i;
 
     virtio_set_status(vdev, 0);
@@ -3171,7 +3199,8 @@ void virtio_reset(void *opaque)
     vdev->start_on_kick = false;
     vdev->started = false;
     vdev->broken = false;
-    virtio_set_features_nocheck(vdev, 0);
+    virtio_features_clear(features);
+    virtio_set_features_nocheck(vdev, features);
     vdev->queue_sel = 0;
     vdev->status = 0;
     vdev->disabled = false;
@@ -3254,7 +3283,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
      * Note: devices should always test host features in future - don't create
      * new dependencies like this.
      */
-    vdev->guest_features = features;
+    virtio_features_from_u64(vdev->guest_features_ex, features);
 
     config_len = qemu_get_be32(f);
 
@@ -3333,26 +3362,23 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         vdev->device_endian = virtio_default_endian();
     }
 
-    if (virtio_64bit_features_needed(vdev)) {
-        /*
-         * Subsection load filled vdev->guest_features.  Run them
-         * through virtio_set_features to sanity-check them against
-         * host_features.
-         */
-        uint64_t features64 = vdev->guest_features;
-        if (virtio_set_features_nocheck_maybe_co(vdev, features64) < 0) {
-            error_report("Features 0x%" PRIx64 " unsupported. "
-                         "Allowed features: 0x%" PRIx64,
-                         features64, vdev->host_features);
-            return -1;
-        }
-    } else {
-        if (virtio_set_features_nocheck_maybe_co(vdev, features) < 0) {
-            error_report("Features 0x%x unsupported. "
-                         "Allowed features: 0x%" PRIx64,
-                         features, vdev->host_features);
-            return -1;
-        }
+    /*
+     * Avoid silently breaking migration should the feature space increase
+     * even more in the (far away) future
+     */
+    QEMU_BUILD_BUG_ON(VIRTIO_FEATURES_DWORDS != 2);
+
+    /*
+     * guest_features_ex is fully initialized with u32 features and upper
+     * bits have been filled as needed by the later load.
+     */
+    if (virtio_set_features_nocheck_maybe_co(vdev,
+                                             vdev->guest_features_ex) < 0) {
+        error_report("Features 0x" VIRTIO_FEATURES_FMT " unsupported. "
+                     "Allowed features: 0x" VIRTIO_FEATURES_FMT,
+                     VIRTIO_FEATURES_PR(vdev->guest_features_ex),
+                     VIRTIO_FEATURES_PR(vdev->host_features_ex));
+        return -1;
     }
 
     if (!virtio_device_started(vdev, vdev->status) &&
-- 
2.50.0


