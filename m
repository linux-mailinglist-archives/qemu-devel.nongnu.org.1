Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D2BA77EBE
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Apr 2025 17:19:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzdO1-0005xh-9v; Tue, 01 Apr 2025 11:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tzdNz-0005x5-AZ
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:18:43 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tzdNx-0005AI-4J
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:18:43 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-225477548e1so102415745ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1743520719; x=1744125519;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqr3uR2LhGzaS3M6ZmJpQU2HECb2zzW7g8CYKFMP2vs=;
 b=FOMsgFkHPITpn3zHKVGVAsb8gO6NLnP0hcl0LQFu+oahaYy9gEfEgAOlnJPkPNlQt3
 0TzjAZONQFJmzNxfwQE1ffAd8z3QUKbPaDxboUArXwlxbpX/3Gn5QKBLOZl7/KPKzU1v
 /TYQR9CtK+5csr/dyV6P5JK/sGH1OSG6yK9zKIm1PcnDxDRCTzWwA2dbge8KtVzyEYFy
 9ImFbS5fA2CG0Fl976eplPtddvzYPK5MfZ+jrAsDUYeCjr0V+3850MFHGbfYW7JFX706
 O2AoF8UC0ZqF5U0fapbNzNkK10eHE2ctFQJKHpScbCzOkZRPECsMg0WanqMx9wS7PZkJ
 z/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743520719; x=1744125519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yqr3uR2LhGzaS3M6ZmJpQU2HECb2zzW7g8CYKFMP2vs=;
 b=sTTwmujgNlowVcH+qfmTqY80AwM+0QLFlP84SWuQBD32BEx8IvQUfx/0iAMrZa8YYj
 5lCKQpP5A2rim7HhXj0jt8tuK/j9qQ01yfYaiHVu++cv0C/xnYk3001XnWDD4i3bUVWG
 ExRPBsDayDivQcoIR/o3fUebG8tsWkoi/iB4XmH5aQvlaYAYjOpCiAL45jW2FDc6o8Dq
 WXpTa+PhzsG0V/7v+gXB6JKzvcCNO134Zb/LmqJiebvUqB6R1KInRcZ5IEmWgLu4HH8i
 QyE/4hVaUpaTtSpn4d0ZUOjTHiSH8ZPHz+pLzFrYmQ0AT6/y6YCyZVzoEN22O9OjnlwM
 54/g==
X-Gm-Message-State: AOJu0YxPB6SVyKRKD6aGwgwaHIcbv38veT6iUX/+M2Ew9FPrkOxrZFCp
 uzLlvi17IytK3BE+QPy2ymLitHpgkYqlNdWcuNuk8i5mTp5mDltiA8sOkXjcS+yJI7hyxpxKDuY
 adBGE7w==
X-Gm-Gg: ASbGncti2caqYxJ6qLR7K4KZPyXrFVru0cPfndzLqU9ZvgOyZ3Yx41VfGUGoosp905t
 Qql+iugKMuCqKrtXV0pTu/74fcXIYKi5uX7+Xi2HNZhhUUiaFb9YLqr3vt+UFogw0sE7FH5ApIW
 L3qS7sctpqKwymTxGiWzGvsZoCbB8rJN0ztv86xH7QInlu5/lkn5Ed+jYm3SQI3DLkuWmA89iXn
 HI9MZPp74dZ4grAg7vVJh8WTr2pJREY7Yi6vJpw7n5iZ9GCDiZnbPxEh5OORErKqfBOvlvg+jPD
 SevUhxUXPCY2yv4EE1nPGeHonyukZXg=
X-Google-Smtp-Source: AGHT+IGLCwIEFPWFTsXgr+b/uP3mRmZx/L6BlK/7rG7reCmcerd0GQWnFAF3Rw5ak85a306kQGmSsw==
X-Received: by 2002:a17:902:ccca:b0:225:b718:4dff with SMTP id
 d9443c01a7336-2292fa075efmr250857465ad.53.1743520719183; 
 Tue, 01 Apr 2025 08:18:39 -0700 (PDT)
Received: from fedora.smartx.com ([2001:df0:a640:1::4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eee029bsm90172195ad.62.2025.04.01.08.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 08:18:38 -0700 (PDT)
From: Haoqian He <haoqian.he@smartx.com>
To: qemu-devel@nongnu.org, sgarzare@redhat.com, mst@redhat.com,
 raphael@enfabrica.net
Cc: fengli@smartx.com, yuhua@smartx.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mzamazal@redhat.com (reviewer:vhost-user-scmi),
 David Hildenbrand <david@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Auger <eric.auger@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 virtio-fs@lists.linux.dev (open list:virtiofs)
Subject: [PATCH v4 1/3] system/runstate: add VM state change cb with return
 value
Date: Tue,  1 Apr 2025 11:18:15 -0400
Message-ID: <20250401151819.1526461-2-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250401151819.1526461-1-haoqian.he@smartx.com>
References: <20250327064348.3595732-1-haoqian.he@smartx.com>
 <20250401151819.1526461-1-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch adds the new VM state change cb type `VMChangeStateHandlerWithRet`,
which has return value for `VMChangeStateEntry`.

Thus, we can register a new VM state change cb with return value for device.
Note that `VMChangeStateHandler` and `VMChangeStateHandlerWithRet` are mutually
exclusive and cannot be provided at the same time.

This patch is the pre patch for 'vhost-user: return failure if backend crashes
when live migration', which makes the live migration aware of the loss of
connection with the vhost-user backend and aborts the live migration.

Virtio device will use VMChangeStateHandlerWithRet.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
---
 hw/block/virtio-blk.c             |  2 +-
 hw/core/vm-change-state-handler.c | 18 ++++++++++------
 hw/scsi/scsi-bus.c                |  2 +-
 hw/vfio/migration.c               |  2 +-
 hw/virtio/virtio.c                |  2 +-
 include/system/runstate.h         | 13 +++++++++---
 system/cpus.c                     |  8 +++++--
 system/runstate.c                 | 35 ++++++++++++++++++++++++++-----
 8 files changed, 62 insertions(+), 20 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 5135b4d8f1..4a48a16790 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1928,7 +1928,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
      * called after ->start_ioeventfd() has already set blk's AioContext.
      */
     s->change =
-        qdev_add_vm_change_state_handler(dev, virtio_blk_dma_restart_cb, s);
+        qdev_add_vm_change_state_handler(dev, virtio_blk_dma_restart_cb, NULL, s);
 
     blk_ram_registrar_init(&s->blk_ram_registrar, s->blk);
     blk_set_dev_ops(s->blk, &virtio_block_ops, s);
diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-handler.c
index 7064995578..99c642b558 100644
--- a/hw/core/vm-change-state-handler.c
+++ b/hw/core/vm-change-state-handler.c
@@ -40,6 +40,7 @@ static int qdev_get_dev_tree_depth(DeviceState *dev)
  * qdev_add_vm_change_state_handler:
  * @dev: the device that owns this handler
  * @cb: the callback function to be invoked
+ * @cb_ret: the callback function with return value to be invoked
  * @opaque: user data passed to the callback function
  *
  * This function works like qemu_add_vm_change_state_handler() except callbacks
@@ -50,25 +51,30 @@ static int qdev_get_dev_tree_depth(DeviceState *dev)
  * controller's callback is invoked before the children on its bus when the VM
  * starts running.  The order is reversed when the VM stops running.
  *
+ * Note that the parameter `cb` and `cb_ret` are mutually exclusive.
+ *
  * Returns: an entry to be freed with qemu_del_vm_change_state_handler()
  */
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
+                                                     VMChangeStateHandlerWithRet *cb_ret,
                                                      void *opaque)
 {
-    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, opaque);
+    assert(!cb || !cb_ret);
+    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, cb_ret, opaque);
 }
 
 /*
  * Exactly like qdev_add_vm_change_state_handler() but passes a prepare_cb
- * argument too.
+ * and the cb_ret arguments too.
  */
 VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
-    DeviceState *dev, VMChangeStateHandler *cb,
-    VMChangeStateHandler *prepare_cb, void *opaque)
+    DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler *prepare_cb,
+    VMChangeStateHandlerWithRet *cb_ret, void *opaque)
 {
     int depth = qdev_get_dev_tree_depth(dev);
 
-    return qemu_add_vm_change_state_handler_prio_full(cb, prepare_cb, opaque,
-                                                      depth);
+    assert(!cb || !cb_ret);
+    return qemu_add_vm_change_state_handler_prio_full(cb, prepare_cb, cb_ret,
+                                                      opaque, depth);
 }
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 7d4546800f..ec098f5f0a 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -356,7 +356,7 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
         return;
     }
     dev->vmsentry = qdev_add_vm_change_state_handler(DEVICE(dev),
-            scsi_dma_restart_cb, dev);
+            scsi_dma_restart_cb, NULL, dev);
 }
 
 static void scsi_qdev_unrealize(DeviceState *qdev)
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 416643ddd6..f531db83ea 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1015,7 +1015,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
                      vfio_vmstate_change_prepare :
                      NULL;
     migration->vm_state = qdev_add_vm_change_state_handler_full(
-        vbasedev->dev, vfio_vmstate_change, prepare_cb, vbasedev);
+        vbasedev->dev, vfio_vmstate_change, prepare_cb, NULL, vbasedev);
     migration_add_notifier(&migration->migration_state,
                            vfio_migration_state_notifier);
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 85110bce37..202a052053 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3489,7 +3489,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
         vdev->config = NULL;
     }
     vdev->vmstate = qdev_add_vm_change_state_handler(DEVICE(vdev),
-            virtio_vmstate_change, vdev);
+            virtio_vmstate_change, NULL, vdev);
     vdev->device_endian = virtio_default_endian();
     vdev->use_guest_notifier_mask = true;
 }
diff --git a/include/system/runstate.h b/include/system/runstate.h
index bffc3719d4..fdd5c4a517 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -12,6 +12,7 @@ bool runstate_needs_reset(void);
 void runstate_replay_enable(void);
 
 typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
+typedef int VMChangeStateHandlerWithRet(void *opaque, bool running, RunState state);
 
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
                                                      void *opaque);
@@ -20,21 +21,27 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
 VMChangeStateEntry *
 qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
                                            VMChangeStateHandler *prepare_cb,
+                                           VMChangeStateHandlerWithRet *cb_ret,
                                            void *opaque, int priority);
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
+                                                     VMChangeStateHandlerWithRet *cb_ret,
                                                      void *opaque);
 VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
-    DeviceState *dev, VMChangeStateHandler *cb,
-    VMChangeStateHandler *prepare_cb, void *opaque);
+    DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler *prepare_cb,
+    VMChangeStateHandlerWithRet *cb_ret, void *opaque);
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
 /**
  * vm_state_notify: Notify the state of the VM
  *
  * @running: whether the VM is running or not.
  * @state: the #RunState of the VM.
+ *
+ * Return the result of the callback which has return value.
+ * If no callback has return value, still return 0 and the
+ * upper layer should not do additional processing.
  */
-void vm_state_notify(bool running, RunState state);
+int vm_state_notify(bool running, RunState state);
 
 static inline bool shutdown_caused_by_guest(ShutdownCause cause)
 {
diff --git a/system/cpus.c b/system/cpus.c
index 2cc5f887ab..d16b0dff98 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -299,14 +299,18 @@ static int do_vm_stop(RunState state, bool send_stop)
         if (oldstate == RUN_STATE_RUNNING) {
             pause_all_vcpus();
         }
-        vm_state_notify(0, state);
+        ret = vm_state_notify(0, state);
         if (send_stop) {
             qapi_event_send_stop();
         }
     }
 
     bdrv_drain_all();
-    ret = bdrv_flush_all();
+    /*
+     * Even if vm_state_notify() return failure,
+     * it would be better to flush as before.
+     */
+    ret |= bdrv_flush_all();
     trace_vm_stop_flush_all(ret);
 
     return ret;
diff --git a/system/runstate.c b/system/runstate.c
index 272801d307..de74d962bc 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -297,6 +297,7 @@ void qemu_system_vmstop_request(RunState state)
 struct VMChangeStateEntry {
     VMChangeStateHandler *cb;
     VMChangeStateHandler *prepare_cb;
+    VMChangeStateHandlerWithRet *cb_ret;
     void *opaque;
     QTAILQ_ENTRY(VMChangeStateEntry) entries;
     int priority;
@@ -320,14 +321,15 @@ static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head =
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
         VMChangeStateHandler *cb, void *opaque, int priority)
 {
-    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, opaque,
-                                                      priority);
+    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, NULL,
+                                                      opaque, priority);
 }
 
 /**
  * qemu_add_vm_change_state_handler_prio_full:
  * @cb: the main callback to invoke
  * @prepare_cb: a callback to invoke before the main callback
+ * @cb_ret: the main callback to invoke with return value
  * @opaque: user data passed to the callbacks
  * @priority: low priorities execute first when the vm runs and the reverse is
  *            true when the vm stops
@@ -344,6 +346,7 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
 VMChangeStateEntry *
 qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
                                            VMChangeStateHandler *prepare_cb,
+                                           VMChangeStateHandlerWithRet *cb_ret,
                                            void *opaque, int priority)
 {
     VMChangeStateEntry *e;
@@ -352,6 +355,7 @@ qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
     e = g_malloc0(sizeof(*e));
     e->cb = cb;
     e->prepare_cb = prepare_cb;
+    e->cb_ret = cb_ret;
     e->opaque = opaque;
     e->priority = priority;
 
@@ -379,9 +383,10 @@ void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
     g_free(e);
 }
 
-void vm_state_notify(bool running, RunState state)
+int vm_state_notify(bool running, RunState state)
 {
     VMChangeStateEntry *e, *next;
+    int ret = 0;
 
     trace_vm_state_notify(running, state, RunState_str(state));
 
@@ -393,7 +398,17 @@ void vm_state_notify(bool running, RunState state)
         }
 
         QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
-            e->cb(e->opaque, running, state);
+            if (e->cb) {
+                e->cb(e->opaque, running, state);
+            } else if (e->cb_ret) {
+                /*
+                 * Here ignore the return value of cb_ret because
+                 * we only care about the stopping the device during
+                 * the VM live migration to indicate whether the
+                 * connection between qemu and backend is normal.
+                 */
+                e->cb_ret(e->opaque, running, state);
+            }
         }
     } else {
         QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
@@ -403,9 +418,19 @@ void vm_state_notify(bool running, RunState state)
         }
 
         QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
-            e->cb(e->opaque, running, state);
+            if (e->cb) {
+                e->cb(e->opaque, running, state);
+            } else if (e->cb_ret) {
+                /*
+                 * We should execute all registered callbacks even if
+                 * one of them returns failure, otherwise, some cleanup
+                 * work of the device will be skipped.
+                 */
+                ret |= e->cb_ret(e->opaque, running, state);
+            }
         }
     }
+    return ret;
 }
 
 static ShutdownCause reset_requested;
-- 
2.44.0


