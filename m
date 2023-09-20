Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A85A17A7E51
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:17:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiw7j-000234-Jn; Wed, 20 Sep 2023 08:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiw7e-0001wN-7J; Wed, 20 Sep 2023 08:16:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qiw7b-0005Ej-4m; Wed, 20 Sep 2023 08:16:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 88CC6239FA;
 Wed, 20 Sep 2023 15:16:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DD0BA296F1;
 Wed, 20 Sep 2023 15:15:53 +0300 (MSK)
Received: (nullmailer pid 105874 invoked by uid 1000);
 Wed, 20 Sep 2023 12:15:53 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 52/63] virtio: Drop out of coroutine context in
 virtio_load()
Date: Wed, 20 Sep 2023 15:15:37 +0300
Message-Id: <20230920121553.105832-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230920151401@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230920151401@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kevin Wolf <kwolf@redhat.com>

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
Message-ID: <20230905145002.46391-3-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 92e2e6a867334a990f8d29f07ca34e3162fdd6ec)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: remove coroutine_mixed_fn markings introduced in v7.2.0-909-g0f3de970fe)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 384c8f0f08..b7da7f074d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3451,6 +3451,39 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
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
+static int
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
@@ -3621,14 +3654,14 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
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
2.39.2


