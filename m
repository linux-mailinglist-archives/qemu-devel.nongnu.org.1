Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 928DB7923A9
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 16:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXO3-0006lR-5d; Tue, 05 Sep 2023 10:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdXO1-0006ja-U0
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdXNx-0004a6-Vr
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693925433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1cBct2M5bi4XJf7Jy2dSFiLcImzGX3D4bnaCCQAnho=;
 b=I7btzfkXxg1M0IiAYjCll2Vc5AUKCATjGksml5jtSYqDdXTS2oEz7g4mRlWJdAqGLfOViY
 PQDzjSQ1y6a+vHUvUk1CV3UZoXamgH76UhwJV3LOuX+fMRlB/hrHjVc+0TU7N+1bGwRFxJ
 pFbJhIrJQVKdS/FG+x0ueqPWN/pL4Ck=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-_1iEhDumNqSjq4oDV2LbTA-1; Tue, 05 Sep 2023 10:50:30 -0400
X-MC-Unique: _1iEhDumNqSjq4oDV2LbTA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BAE13C0DDBC;
 Tue,  5 Sep 2023 14:50:27 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB0BD46F523;
 Tue,  5 Sep 2023 14:50:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com,
 leobras@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH 2/2] virtio: Drop out of coroutine context in virtio_load()
Date: Tue,  5 Sep 2023 16:50:02 +0200
Message-ID: <20230905145002.46391-3-kwolf@redhat.com>
In-Reply-To: <20230905145002.46391-1-kwolf@redhat.com>
References: <20230905145002.46391-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

virtio_load() as a whole should run in coroutine context because it
reads from the migration stream and we don't want this to block.

However, it calls virtio_set_features_nocheck() and devices don't
expect their .set_features callback to run in a coroutine and therefore
call functions that may not be called in coroutine context. To fix this,
drop out of coroutine context for calling virtio_set_features_nocheck().

Without this fix, the following crash was reported:

  #0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
  #1  0x00007efc738c05d3 in __pthread_kill_internal (signo=6, threadid=<optimized out>) at pthread_kill.c:78
  #2  0x00007efc73873d26 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
  #3  0x00007efc738477f3 in __GI_abort () at abort.c:79
  #4  0x00007efc7384771b in __assert_fail_base (fmt=0x7efc739dbcb8 "", assertion=assertion@entry=0x560aebfbf5cf "!qemu_in_coroutine()",
     file=file@entry=0x560aebfcd2d4 "../block/graph-lock.c", line=line@entry=275, function=function@entry=0x560aebfcd34d "void bdrv_graph_rdlock_main_loop(void)") at assert.c:92
  #5  0x00007efc7386ccc6 in __assert_fail (assertion=0x560aebfbf5cf "!qemu_in_coroutine()", file=0x560aebfcd2d4 "../block/graph-lock.c", line=275,
     function=0x560aebfcd34d "void bdrv_graph_rdlock_main_loop(void)") at assert.c:101
  #6  0x0000560aebcd8dd6 in bdrv_register_buf ()
  #7  0x0000560aeb97ed97 in ram_block_added.llvm ()
  #8  0x0000560aebb8303f in ram_block_add.llvm ()
  #9  0x0000560aebb834fa in qemu_ram_alloc_internal.llvm ()
  #10 0x0000560aebb2ac98 in vfio_region_mmap ()
  #11 0x0000560aebb3ea0f in vfio_bars_register ()
  #12 0x0000560aebb3c628 in vfio_realize ()
  #13 0x0000560aeb90f0c2 in pci_qdev_realize ()
  #14 0x0000560aebc40305 in device_set_realized ()
  #15 0x0000560aebc48e07 in property_set_bool.llvm ()
  #16 0x0000560aebc46582 in object_property_set ()
  #17 0x0000560aebc4cd58 in object_property_set_qobject ()
  #18 0x0000560aebc46ba7 in object_property_set_bool ()
  #19 0x0000560aeb98b3ca in qdev_device_add_from_qdict ()
  #20 0x0000560aebb1fbaf in virtio_net_set_features ()
  #21 0x0000560aebb46b51 in virtio_set_features_nocheck ()
  #22 0x0000560aebb47107 in virtio_load ()
  #23 0x0000560aeb9ae7ce in vmstate_load_state ()
  #24 0x0000560aeb9d2ee9 in qemu_loadvm_state_main ()
  #25 0x0000560aeb9d45e1 in qemu_loadvm_state ()
  #26 0x0000560aeb9bc32c in process_incoming_migration_co.llvm ()
  #27 0x0000560aebeace56 in coroutine_trampoline.llvm ()

Cc: qemu-stable@nongnu.org
Buglink: https://issues.redhat.com/browse/RHEL-832
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/virtio/virtio.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 309038fd46..969c25f4cf 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2825,8 +2825,9 @@ static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
 }
 
 /* A wrapper for use as a VMState .get function */
-static int virtio_device_get(QEMUFile *f, void *opaque, size_t size,
-                             const VMStateField *field)
+static int coroutine_mixed_fn
+virtio_device_get(QEMUFile *f, void *opaque, size_t size,
+                  const VMStateField *field)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
     DeviceClass *dc = DEVICE_CLASS(VIRTIO_DEVICE_GET_CLASS(vdev));
@@ -2853,6 +2854,39 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
     return bad ? -1 : 0;
 }
 
+typedef struct VirtioSetFeaturesNocheckData {
+    Coroutine *co;
+    VirtIODevice *vdev;
+    uint64_t val;
+    int ret;
+} VirtioSetFeaturesNocheckData;
+
+static void virtio_set_features_nocheck_bh(void *opaque)
+{
+    VirtioSetFeaturesNocheckData *data = opaque;
+
+    data->ret = virtio_set_features_nocheck(data->vdev, data->val);
+    aio_co_wake(data->co);
+}
+
+static int coroutine_mixed_fn
+virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev, uint64_t val)
+{
+    if (qemu_in_coroutine()) {
+        VirtioSetFeaturesNocheckData data = {
+            .co = qemu_coroutine_self(),
+            .vdev = vdev,
+            .val = val,
+        };
+        aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
+                                virtio_set_features_nocheck_bh, &data);
+        qemu_coroutine_yield();
+        return data.ret;
+    } else {
+        return virtio_set_features_nocheck(vdev, val);
+    }
+}
+
 int virtio_set_features(VirtIODevice *vdev, uint64_t val)
 {
     int ret;
@@ -2906,7 +2940,8 @@ size_t virtio_get_config_size(const VirtIOConfigSizeParams *params,
     return config_size;
 }
 
-int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
+int coroutine_mixed_fn
+virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 {
     int i, ret;
     int32_t config_len;
@@ -3023,14 +3058,14 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
          * host_features.
          */
         uint64_t features64 = vdev->guest_features;
-        if (virtio_set_features_nocheck(vdev, features64) < 0) {
+        if (virtio_set_features_nocheck_maybe_co(vdev, features64) < 0) {
             error_report("Features 0x%" PRIx64 " unsupported. "
                          "Allowed features: 0x%" PRIx64,
                          features64, vdev->host_features);
             return -1;
         }
     } else {
-        if (virtio_set_features_nocheck(vdev, features) < 0) {
+        if (virtio_set_features_nocheck_maybe_co(vdev, features) < 0) {
             error_report("Features 0x%x unsupported. "
                          "Allowed features: 0x%" PRIx64,
                          features, vdev->host_features);
-- 
2.41.0


