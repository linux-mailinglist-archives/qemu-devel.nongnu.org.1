Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75776832EB5
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 19:14:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQtNL-0001hx-Jy; Fri, 19 Jan 2024 13:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtNF-0001eJ-3U
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtN9-0007dd-9Z
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705688022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IwwHTMDaIvfbN2XEyE+dY4HI0Y8yIrmO6PzexM9ZEBE=;
 b=W3Y4R/uGUgYTK4/PhogO7QIJX23gYwe9/iXFFk7+WRREFfz7FpL6y+3LtsaBTksQMJnQcZ
 66ayrtvHjQvUbWvSyQ4JuBNnUsVAZaR/pxeYxbfClz0150sUobP0XSe7nEDRbJcFiwQagI
 Q0Ydo9jQBpCoR7VdG0f+UGSReI5sEzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-490Nlc-oMgCJ2YxqfcF5xw-1; Fri, 19 Jan 2024 13:13:40 -0500
X-MC-Unique: 490Nlc-oMgCJ2YxqfcF5xw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E208A867942;
 Fri, 19 Jan 2024 18:13:39 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AE422877;
 Fri, 19 Jan 2024 18:13:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 08/14] virtio-blk: move dataplane code into virtio-blk.c
Date: Fri, 19 Jan 2024 19:13:21 +0100
Message-ID: <20240119181327.236745-9-kwolf@redhat.com>
In-Reply-To: <20240119181327.236745-1-kwolf@redhat.com>
References: <20240119181327.236745-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The dataplane code used to be significantly different from the
non-dataplane code and therefore had a separate source file.

Over time the difference has gotten smaller because the I/O code paths
were unified. Nowadays the distinction between the VirtIOBlock and
VirtIOBlockDataPlane structs is more of an inconvenience that hinders
code simplification.

Move hw/block/dataplane/virtio-blk.c into hw/block/virtio-blk.c, merging
VirtIOBlockDataPlane's fields into VirtIOBlock.

hw/block/virtio-blk.c used VirtIOBlock->dataplane to check if
virtio_blk_data_plane_create() was successful. This is not necessary
because ->dataplane_started and ->dataplane_disabled can be used
instead. This patch makes those changes in order to drop
VirtIOBlock->dataplane.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240119135748.270944-2-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/dataplane/trace.h      |   1 -
 hw/block/dataplane/virtio-blk.h |  34 ---
 include/hw/virtio/virtio-blk.h  |  12 +-
 hw/block/dataplane/virtio-blk.c | 404 --------------------------------
 hw/block/virtio-blk.c           | 362 ++++++++++++++++++++++++++--
 hw/block/dataplane/meson.build  |   1 -
 hw/block/dataplane/trace-events |   5 -
 meson.build                     |   1 -
 8 files changed, 357 insertions(+), 463 deletions(-)
 delete mode 100644 hw/block/dataplane/trace.h
 delete mode 100644 hw/block/dataplane/virtio-blk.h
 delete mode 100644 hw/block/dataplane/virtio-blk.c
 delete mode 100644 hw/block/dataplane/trace-events

diff --git a/hw/block/dataplane/trace.h b/hw/block/dataplane/trace.h
deleted file mode 100644
index 240cc59834..0000000000
--- a/hw/block/dataplane/trace.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "trace/trace-hw_block_dataplane.h"
diff --git a/hw/block/dataplane/virtio-blk.h b/hw/block/dataplane/virtio-blk.h
deleted file mode 100644
index 1a806fe447..0000000000
--- a/hw/block/dataplane/virtio-blk.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * Dedicated thread for virtio-blk I/O processing
- *
- * Copyright 2012 IBM, Corp.
- * Copyright 2012 Red Hat, Inc. and/or its affiliates
- *
- * Authors:
- *   Stefan Hajnoczi <stefanha@redhat.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#ifndef HW_DATAPLANE_VIRTIO_BLK_H
-#define HW_DATAPLANE_VIRTIO_BLK_H
-
-#include "hw/virtio/virtio.h"
-
-typedef struct VirtIOBlockDataPlane VirtIOBlockDataPlane;
-
-bool virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
-                                  VirtIOBlockDataPlane **dataplane,
-                                  Error **errp);
-void virtio_blk_data_plane_destroy(VirtIOBlockDataPlane *s);
-void virtio_blk_data_plane_notify(VirtIOBlockDataPlane *s, VirtQueue *vq);
-
-int virtio_blk_data_plane_start(VirtIODevice *vdev);
-void virtio_blk_data_plane_stop(VirtIODevice *vdev);
-
-void virtio_blk_data_plane_detach(VirtIOBlockDataPlane *s);
-void virtio_blk_data_plane_attach(VirtIOBlockDataPlane *s);
-
-#endif /* HW_DATAPLANE_VIRTIO_BLK_H */
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 5e4091e4da..fecffdc303 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -50,8 +50,6 @@ struct VirtIOBlkConf
     bool x_enable_wce_if_config_wce;
 };
 
-struct VirtIOBlockDataPlane;
-
 struct VirtIOBlockReq;
 struct VirtIOBlock {
     VirtIODevice parent_obj;
@@ -64,7 +62,15 @@ struct VirtIOBlock {
     VMChangeStateEntry *change;
     bool dataplane_disabled;
     bool dataplane_started;
-    struct VirtIOBlockDataPlane *dataplane;
+    bool dataplane_starting;
+    bool dataplane_stopping;
+
+    /*
+     * The AioContext for each virtqueue. The BlockDriverState will use the
+     * first element as its AioContext.
+     */
+    AioContext **vq_aio_context;
+
     uint64_t host_features;
     size_t config_size;
     BlockRAMRegistrar blk_ram_registrar;
diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
deleted file mode 100644
index ba22732497..0000000000
--- a/hw/block/dataplane/virtio-blk.c
+++ /dev/null
@@ -1,404 +0,0 @@
-/*
- * Dedicated thread for virtio-blk I/O processing
- *
- * Copyright 2012 IBM, Corp.
- * Copyright 2012 Red Hat, Inc. and/or its affiliates
- *
- * Authors:
- *   Stefan Hajnoczi <stefanha@redhat.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "trace.h"
-#include "qemu/iov.h"
-#include "qemu/main-loop.h"
-#include "qemu/thread.h"
-#include "qemu/error-report.h"
-#include "hw/virtio/virtio-blk.h"
-#include "virtio-blk.h"
-#include "block/aio.h"
-#include "hw/virtio/virtio-bus.h"
-#include "qom/object_interfaces.h"
-
-struct VirtIOBlockDataPlane {
-    bool starting;
-    bool stopping;
-
-    VirtIOBlkConf *conf;
-    VirtIODevice *vdev;
-
-    /*
-     * The AioContext for each virtqueue. The BlockDriverState will use the
-     * first element as its AioContext.
-     */
-    AioContext **vq_aio_context;
-};
-
-/* Raise an interrupt to signal guest, if necessary */
-void virtio_blk_data_plane_notify(VirtIOBlockDataPlane *s, VirtQueue *vq)
-{
-    virtio_notify_irqfd(s->vdev, vq);
-}
-
-/* Generate vq:AioContext mappings from a validated iothread-vq-mapping list */
-static void
-apply_vq_mapping(IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
-                 AioContext **vq_aio_context, uint16_t num_queues)
-{
-    IOThreadVirtQueueMappingList *node;
-    size_t num_iothreads = 0;
-    size_t cur_iothread = 0;
-
-    for (node = iothread_vq_mapping_list; node; node = node->next) {
-        num_iothreads++;
-    }
-
-    for (node = iothread_vq_mapping_list; node; node = node->next) {
-        IOThread *iothread = iothread_by_id(node->value->iothread);
-        AioContext *ctx = iothread_get_aio_context(iothread);
-
-        /* Released in virtio_blk_data_plane_destroy() */
-        object_ref(OBJECT(iothread));
-
-        if (node->value->vqs) {
-            uint16List *vq;
-
-            /* Explicit vq:IOThread assignment */
-            for (vq = node->value->vqs; vq; vq = vq->next) {
-                vq_aio_context[vq->value] = ctx;
-            }
-        } else {
-            /* Round-robin vq:IOThread assignment */
-            for (unsigned i = cur_iothread; i < num_queues;
-                 i += num_iothreads) {
-                vq_aio_context[i] = ctx;
-            }
-        }
-
-        cur_iothread++;
-    }
-}
-
-/* Context: BQL held */
-bool virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
-                                  VirtIOBlockDataPlane **dataplane,
-                                  Error **errp)
-{
-    VirtIOBlockDataPlane *s;
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-
-    *dataplane = NULL;
-
-    if (conf->iothread || conf->iothread_vq_mapping_list) {
-        if (!k->set_guest_notifiers || !k->ioeventfd_assign) {
-            error_setg(errp,
-                       "device is incompatible with iothread "
-                       "(transport does not support notifiers)");
-            return false;
-        }
-        if (!virtio_device_ioeventfd_enabled(vdev)) {
-            error_setg(errp, "ioeventfd is required for iothread");
-            return false;
-        }
-
-        /* If dataplane is (re-)enabled while the guest is running there could
-         * be block jobs that can conflict.
-         */
-        if (blk_op_is_blocked(conf->conf.blk, BLOCK_OP_TYPE_DATAPLANE, errp)) {
-            error_prepend(errp, "cannot start virtio-blk dataplane: ");
-            return false;
-        }
-    }
-    /* Don't try if transport does not support notifiers. */
-    if (!virtio_device_ioeventfd_enabled(vdev)) {
-        return false;
-    }
-
-    s = g_new0(VirtIOBlockDataPlane, 1);
-    s->vdev = vdev;
-    s->conf = conf;
-    s->vq_aio_context = g_new(AioContext *, conf->num_queues);
-
-    if (conf->iothread_vq_mapping_list) {
-        apply_vq_mapping(conf->iothread_vq_mapping_list, s->vq_aio_context,
-                         conf->num_queues);
-    } else if (conf->iothread) {
-        AioContext *ctx = iothread_get_aio_context(conf->iothread);
-        for (unsigned i = 0; i < conf->num_queues; i++) {
-            s->vq_aio_context[i] = ctx;
-        }
-
-        /* Released in virtio_blk_data_plane_destroy() */
-        object_ref(OBJECT(conf->iothread));
-    } else {
-        AioContext *ctx = qemu_get_aio_context();
-        for (unsigned i = 0; i < conf->num_queues; i++) {
-            s->vq_aio_context[i] = ctx;
-        }
-    }
-
-    *dataplane = s;
-
-    return true;
-}
-
-/* Context: BQL held */
-void virtio_blk_data_plane_destroy(VirtIOBlockDataPlane *s)
-{
-    VirtIOBlock *vblk;
-    VirtIOBlkConf *conf;
-
-    if (!s) {
-        return;
-    }
-
-    vblk = VIRTIO_BLK(s->vdev);
-    assert(!vblk->dataplane_started);
-    conf = s->conf;
-
-    if (conf->iothread_vq_mapping_list) {
-        IOThreadVirtQueueMappingList *node;
-
-        for (node = conf->iothread_vq_mapping_list; node; node = node->next) {
-            IOThread *iothread = iothread_by_id(node->value->iothread);
-            object_unref(OBJECT(iothread));
-        }
-    }
-
-    if (conf->iothread) {
-        object_unref(OBJECT(conf->iothread));
-    }
-
-    g_free(s->vq_aio_context);
-    g_free(s);
-}
-
-/* Context: BQL held */
-int virtio_blk_data_plane_start(VirtIODevice *vdev)
-{
-    VirtIOBlock *vblk = VIRTIO_BLK(vdev);
-    VirtIOBlockDataPlane *s = vblk->dataplane;
-    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vblk)));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    unsigned i;
-    unsigned nvqs = s->conf->num_queues;
-    Error *local_err = NULL;
-    int r;
-
-    if (vblk->dataplane_started || s->starting) {
-        return 0;
-    }
-
-    s->starting = true;
-
-    /* Set up guest notifier (irq) */
-    r = k->set_guest_notifiers(qbus->parent, nvqs, true);
-    if (r != 0) {
-        error_report("virtio-blk failed to set guest notifier (%d), "
-                     "ensure -accel kvm is set.", r);
-        goto fail_guest_notifiers;
-    }
-
-    /*
-     * Batch all the host notifiers in a single transaction to avoid
-     * quadratic time complexity in address_space_update_ioeventfds().
-     */
-    memory_region_transaction_begin();
-
-    /* Set up virtqueue notify */
-    for (i = 0; i < nvqs; i++) {
-        r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, true);
-        if (r != 0) {
-            int j = i;
-
-            fprintf(stderr, "virtio-blk failed to set host notifier (%d)\n", r);
-            while (i--) {
-                virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
-            }
-
-            /*
-             * The transaction expects the ioeventfds to be open when it
-             * commits. Do it now, before the cleanup loop.
-             */
-            memory_region_transaction_commit();
-
-            while (j--) {
-                virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), j);
-            }
-            goto fail_host_notifiers;
-        }
-    }
-
-    memory_region_transaction_commit();
-
-    trace_virtio_blk_data_plane_start(s);
-
-    r = blk_set_aio_context(s->conf->conf.blk, s->vq_aio_context[0],
-                            &local_err);
-    if (r < 0) {
-        error_report_err(local_err);
-        goto fail_aio_context;
-    }
-
-    /*
-     * These fields must be visible to the IOThread when it processes the
-     * virtqueue, otherwise it will think dataplane has not started yet.
-     *
-     * Make sure ->dataplane_started is false when blk_set_aio_context() is
-     * called above so that draining does not cause the host notifier to be
-     * detached/attached prematurely.
-     */
-    s->starting = false;
-    vblk->dataplane_started = true;
-    smp_wmb(); /* paired with aio_notify_accept() on the read side */
-
-    /* Get this show started by hooking up our callbacks */
-    if (!blk_in_drain(s->conf->conf.blk)) {
-        for (i = 0; i < nvqs; i++) {
-            VirtQueue *vq = virtio_get_queue(s->vdev, i);
-            AioContext *ctx = s->vq_aio_context[i];
-
-            /* Kick right away to begin processing requests already in vring */
-            event_notifier_set(virtio_queue_get_host_notifier(vq));
-
-            virtio_queue_aio_attach_host_notifier(vq, ctx);
-        }
-    }
-    return 0;
-
-  fail_aio_context:
-    memory_region_transaction_begin();
-
-    for (i = 0; i < nvqs; i++) {
-        virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
-    }
-
-    memory_region_transaction_commit();
-
-    for (i = 0; i < nvqs; i++) {
-        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
-    }
-  fail_host_notifiers:
-    k->set_guest_notifiers(qbus->parent, nvqs, false);
-  fail_guest_notifiers:
-    vblk->dataplane_disabled = true;
-    s->starting = false;
-    return -ENOSYS;
-}
-
-/* Stop notifications for new requests from guest.
- *
- * Context: BH in IOThread
- */
-static void virtio_blk_data_plane_stop_vq_bh(void *opaque)
-{
-    VirtQueue *vq = opaque;
-    EventNotifier *host_notifier = virtio_queue_get_host_notifier(vq);
-
-    virtio_queue_aio_detach_host_notifier(vq, qemu_get_current_aio_context());
-
-    /*
-     * Test and clear notifier after disabling event, in case poll callback
-     * didn't have time to run.
-     */
-    virtio_queue_host_notifier_read(host_notifier);
-}
-
-/* Context: BQL held */
-void virtio_blk_data_plane_stop(VirtIODevice *vdev)
-{
-    VirtIOBlock *vblk = VIRTIO_BLK(vdev);
-    VirtIOBlockDataPlane *s = vblk->dataplane;
-    BusState *qbus = qdev_get_parent_bus(DEVICE(vblk));
-    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    unsigned i;
-    unsigned nvqs = s->conf->num_queues;
-
-    if (!vblk->dataplane_started || s->stopping) {
-        return;
-    }
-
-    /* Better luck next time. */
-    if (vblk->dataplane_disabled) {
-        vblk->dataplane_disabled = false;
-        vblk->dataplane_started = false;
-        return;
-    }
-    s->stopping = true;
-    trace_virtio_blk_data_plane_stop(s);
-
-    if (!blk_in_drain(s->conf->conf.blk)) {
-        for (i = 0; i < nvqs; i++) {
-            VirtQueue *vq = virtio_get_queue(s->vdev, i);
-            AioContext *ctx = s->vq_aio_context[i];
-
-            aio_wait_bh_oneshot(ctx, virtio_blk_data_plane_stop_vq_bh, vq);
-        }
-    }
-
-    /*
-     * Batch all the host notifiers in a single transaction to avoid
-     * quadratic time complexity in address_space_update_ioeventfds().
-     */
-    memory_region_transaction_begin();
-
-    for (i = 0; i < nvqs; i++) {
-        virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
-    }
-
-    /*
-     * The transaction expects the ioeventfds to be open when it
-     * commits. Do it now, before the cleanup loop.
-     */
-    memory_region_transaction_commit();
-
-    for (i = 0; i < nvqs; i++) {
-        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
-    }
-
-    /*
-     * Set ->dataplane_started to false before draining so that host notifiers
-     * are not detached/attached anymore.
-     */
-    vblk->dataplane_started = false;
-
-    /* Wait for virtio_blk_dma_restart_bh() and in flight I/O to complete */
-    blk_drain(s->conf->conf.blk);
-
-    /*
-     * Try to switch bs back to the QEMU main loop. If other users keep the
-     * BlockBackend in the iothread, that's ok
-     */
-    blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context(), NULL);
-
-    /* Clean up guest notifier (irq) */
-    k->set_guest_notifiers(qbus->parent, nvqs, false);
-
-    s->stopping = false;
-}
-
-void virtio_blk_data_plane_detach(VirtIOBlockDataPlane *s)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(s->vdev);
-
-    for (uint16_t i = 0; i < s->conf->num_queues; i++) {
-        VirtQueue *vq = virtio_get_queue(vdev, i);
-        virtio_queue_aio_detach_host_notifier(vq, s->vq_aio_context[i]);
-    }
-}
-
-void virtio_blk_data_plane_attach(VirtIOBlockDataPlane *s)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(s->vdev);
-
-    for (uint16_t i = 0; i < s->conf->num_queues; i++) {
-        VirtQueue *vq = virtio_get_queue(vdev, i);
-        virtio_queue_aio_attach_host_notifier(vq, s->vq_aio_context[i]);
-    }
-}
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b7a344ca97..510cb4248d 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -27,7 +27,6 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/runstate.h"
 #include "hw/virtio/virtio-blk.h"
-#include "dataplane/virtio-blk.h"
 #include "scsi/constants.h"
 #ifdef __linux__
 # include <scsi/sg.h>
@@ -66,7 +65,7 @@ static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
     iov_discard_undo(&req->outhdr_undo);
     virtqueue_push(req->vq, &req->elem, req->in_len);
     if (s->dataplane_started && !s->dataplane_disabled) {
-        virtio_blk_data_plane_notify(s->dataplane, req->vq);
+        virtio_notify_irqfd(vdev, req->vq);
     } else {
         virtio_notify(vdev, req->vq);
     }
@@ -1142,7 +1141,7 @@ static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOBlock *s = (VirtIOBlock *)vdev;
 
-    if (s->dataplane && !s->dataplane_started) {
+    if (!s->dataplane_disabled && !s->dataplane_started) {
         /* Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
          * dataplane here instead of waiting for .set_status().
          */
@@ -1546,16 +1545,34 @@ static void virtio_blk_resize(void *opaque)
     aio_bh_schedule_oneshot(qemu_get_aio_context(), virtio_resize_cb, vdev);
 }
 
+static void virtio_blk_data_plane_detach(VirtIOBlock *s)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    for (uint16_t i = 0; i < s->conf.num_queues; i++) {
+        VirtQueue *vq = virtio_get_queue(vdev, i);
+        virtio_queue_aio_detach_host_notifier(vq, s->vq_aio_context[i]);
+    }
+}
+
+static void virtio_blk_data_plane_attach(VirtIOBlock *s)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    for (uint16_t i = 0; i < s->conf.num_queues; i++) {
+        VirtQueue *vq = virtio_get_queue(vdev, i);
+        virtio_queue_aio_attach_host_notifier(vq, s->vq_aio_context[i]);
+    }
+}
+
 /* Suspend virtqueue ioeventfd processing during drain */
 static void virtio_blk_drained_begin(void *opaque)
 {
     VirtIOBlock *s = opaque;
 
-    if (!s->dataplane || !s->dataplane_started) {
-        return;
+    if (s->dataplane_started) {
+        virtio_blk_data_plane_detach(s);
     }
-
-    virtio_blk_data_plane_detach(s->dataplane);
 }
 
 /* Resume virtqueue ioeventfd processing after drain */
@@ -1563,11 +1580,9 @@ static void virtio_blk_drained_end(void *opaque)
 {
     VirtIOBlock *s = opaque;
 
-    if (!s->dataplane || !s->dataplane_started) {
-        return;
+    if (s->dataplane_started) {
+        virtio_blk_data_plane_attach(s);
     }
-
-    virtio_blk_data_plane_attach(s->dataplane);
 }
 
 static const BlockDevOps virtio_block_ops = {
@@ -1576,6 +1591,326 @@ static const BlockDevOps virtio_block_ops = {
     .drained_end   = virtio_blk_drained_end,
 };
 
+/* Generate vq:AioContext mappings from a validated iothread-vq-mapping list */
+static void
+apply_vq_mapping(IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
+                 AioContext **vq_aio_context, uint16_t num_queues)
+{
+    IOThreadVirtQueueMappingList *node;
+    size_t num_iothreads = 0;
+    size_t cur_iothread = 0;
+
+    for (node = iothread_vq_mapping_list; node; node = node->next) {
+        num_iothreads++;
+    }
+
+    for (node = iothread_vq_mapping_list; node; node = node->next) {
+        IOThread *iothread = iothread_by_id(node->value->iothread);
+        AioContext *ctx = iothread_get_aio_context(iothread);
+
+        /* Released in virtio_blk_data_plane_destroy() */
+        object_ref(OBJECT(iothread));
+
+        if (node->value->vqs) {
+            uint16List *vq;
+
+            /* Explicit vq:IOThread assignment */
+            for (vq = node->value->vqs; vq; vq = vq->next) {
+                vq_aio_context[vq->value] = ctx;
+            }
+        } else {
+            /* Round-robin vq:IOThread assignment */
+            for (unsigned i = cur_iothread; i < num_queues;
+                 i += num_iothreads) {
+                vq_aio_context[i] = ctx;
+            }
+        }
+
+        cur_iothread++;
+    }
+}
+
+/* Context: BQL held */
+static bool virtio_blk_data_plane_create(VirtIOBlock *s, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+    VirtIOBlkConf *conf = &s->conf;
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+
+    if (conf->iothread || conf->iothread_vq_mapping_list) {
+        if (!k->set_guest_notifiers || !k->ioeventfd_assign) {
+            error_setg(errp,
+                       "device is incompatible with iothread "
+                       "(transport does not support notifiers)");
+            return false;
+        }
+        if (!virtio_device_ioeventfd_enabled(vdev)) {
+            error_setg(errp, "ioeventfd is required for iothread");
+            return false;
+        }
+
+        /*
+         * If dataplane is (re-)enabled while the guest is running there could
+         * be block jobs that can conflict.
+         */
+        if (blk_op_is_blocked(conf->conf.blk, BLOCK_OP_TYPE_DATAPLANE, errp)) {
+            error_prepend(errp, "cannot start virtio-blk dataplane: ");
+            return false;
+        }
+    }
+    /* Don't try if transport does not support notifiers. */
+    if (!virtio_device_ioeventfd_enabled(vdev)) {
+        s->dataplane_disabled = true;
+        return false;
+    }
+
+    s->vq_aio_context = g_new(AioContext *, conf->num_queues);
+
+    if (conf->iothread_vq_mapping_list) {
+        apply_vq_mapping(conf->iothread_vq_mapping_list, s->vq_aio_context,
+                         conf->num_queues);
+    } else if (conf->iothread) {
+        AioContext *ctx = iothread_get_aio_context(conf->iothread);
+        for (unsigned i = 0; i < conf->num_queues; i++) {
+            s->vq_aio_context[i] = ctx;
+        }
+
+        /* Released in virtio_blk_data_plane_destroy() */
+        object_ref(OBJECT(conf->iothread));
+    } else {
+        AioContext *ctx = qemu_get_aio_context();
+        for (unsigned i = 0; i < conf->num_queues; i++) {
+            s->vq_aio_context[i] = ctx;
+        }
+    }
+
+    return true;
+}
+
+/* Context: BQL held */
+static void virtio_blk_data_plane_destroy(VirtIOBlock *s)
+{
+    VirtIOBlkConf *conf = &s->conf;
+
+    assert(!s->dataplane_started);
+
+    if (conf->iothread_vq_mapping_list) {
+        IOThreadVirtQueueMappingList *node;
+
+        for (node = conf->iothread_vq_mapping_list; node; node = node->next) {
+            IOThread *iothread = iothread_by_id(node->value->iothread);
+            object_unref(OBJECT(iothread));
+        }
+    }
+
+    if (conf->iothread) {
+        object_unref(OBJECT(conf->iothread));
+    }
+
+    g_free(s->vq_aio_context);
+    s->vq_aio_context = NULL;
+}
+
+/* Context: BQL held */
+static int virtio_blk_data_plane_start(VirtIODevice *vdev)
+{
+    VirtIOBlock *s = VIRTIO_BLK(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(s)));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    unsigned i;
+    unsigned nvqs = s->conf.num_queues;
+    Error *local_err = NULL;
+    int r;
+
+    if (s->dataplane_started || s->dataplane_starting) {
+        return 0;
+    }
+
+    s->dataplane_starting = true;
+
+    /* Set up guest notifier (irq) */
+    r = k->set_guest_notifiers(qbus->parent, nvqs, true);
+    if (r != 0) {
+        error_report("virtio-blk failed to set guest notifier (%d), "
+                     "ensure -accel kvm is set.", r);
+        goto fail_guest_notifiers;
+    }
+
+    /*
+     * Batch all the host notifiers in a single transaction to avoid
+     * quadratic time complexity in address_space_update_ioeventfds().
+     */
+    memory_region_transaction_begin();
+
+    /* Set up virtqueue notify */
+    for (i = 0; i < nvqs; i++) {
+        r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, true);
+        if (r != 0) {
+            int j = i;
+
+            fprintf(stderr, "virtio-blk failed to set host notifier (%d)\n", r);
+            while (i--) {
+                virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
+            }
+
+            /*
+             * The transaction expects the ioeventfds to be open when it
+             * commits. Do it now, before the cleanup loop.
+             */
+            memory_region_transaction_commit();
+
+            while (j--) {
+                virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), j);
+            }
+            goto fail_host_notifiers;
+        }
+    }
+
+    memory_region_transaction_commit();
+
+    r = blk_set_aio_context(s->conf.conf.blk, s->vq_aio_context[0],
+                            &local_err);
+    if (r < 0) {
+        error_report_err(local_err);
+        goto fail_aio_context;
+    }
+
+    /*
+     * These fields must be visible to the IOThread when it processes the
+     * virtqueue, otherwise it will think dataplane has not started yet.
+     *
+     * Make sure ->dataplane_started is false when blk_set_aio_context() is
+     * called above so that draining does not cause the host notifier to be
+     * detached/attached prematurely.
+     */
+    s->dataplane_starting = false;
+    s->dataplane_started = true;
+    smp_wmb(); /* paired with aio_notify_accept() on the read side */
+
+    /* Get this show started by hooking up our callbacks */
+    if (!blk_in_drain(s->conf.conf.blk)) {
+        for (i = 0; i < nvqs; i++) {
+            VirtQueue *vq = virtio_get_queue(vdev, i);
+            AioContext *ctx = s->vq_aio_context[i];
+
+            /* Kick right away to begin processing requests already in vring */
+            event_notifier_set(virtio_queue_get_host_notifier(vq));
+
+            virtio_queue_aio_attach_host_notifier(vq, ctx);
+        }
+    }
+    return 0;
+
+  fail_aio_context:
+    memory_region_transaction_begin();
+
+    for (i = 0; i < nvqs; i++) {
+        virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
+    }
+
+    memory_region_transaction_commit();
+
+    for (i = 0; i < nvqs; i++) {
+        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
+    }
+  fail_host_notifiers:
+    k->set_guest_notifiers(qbus->parent, nvqs, false);
+  fail_guest_notifiers:
+    s->dataplane_disabled = true;
+    s->dataplane_starting = false;
+    return -ENOSYS;
+}
+
+/* Stop notifications for new requests from guest.
+ *
+ * Context: BH in IOThread
+ */
+static void virtio_blk_data_plane_stop_vq_bh(void *opaque)
+{
+    VirtQueue *vq = opaque;
+    EventNotifier *host_notifier = virtio_queue_get_host_notifier(vq);
+
+    virtio_queue_aio_detach_host_notifier(vq, qemu_get_current_aio_context());
+
+    /*
+     * Test and clear notifier after disabling event, in case poll callback
+     * didn't have time to run.
+     */
+    virtio_queue_host_notifier_read(host_notifier);
+}
+
+/* Context: BQL held */
+static void virtio_blk_data_plane_stop(VirtIODevice *vdev)
+{
+    VirtIOBlock *s = VIRTIO_BLK(vdev);
+    BusState *qbus = qdev_get_parent_bus(DEVICE(s));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    unsigned i;
+    unsigned nvqs = s->conf.num_queues;
+
+    if (!s->dataplane_started || s->dataplane_stopping) {
+        return;
+    }
+
+    /* Better luck next time. */
+    if (s->dataplane_disabled) {
+        s->dataplane_disabled = false;
+        s->dataplane_started = false;
+        return;
+    }
+    s->dataplane_stopping = true;
+
+    if (!blk_in_drain(s->conf.conf.blk)) {
+        for (i = 0; i < nvqs; i++) {
+            VirtQueue *vq = virtio_get_queue(vdev, i);
+            AioContext *ctx = s->vq_aio_context[i];
+
+            aio_wait_bh_oneshot(ctx, virtio_blk_data_plane_stop_vq_bh, vq);
+        }
+    }
+
+    /*
+     * Batch all the host notifiers in a single transaction to avoid
+     * quadratic time complexity in address_space_update_ioeventfds().
+     */
+    memory_region_transaction_begin();
+
+    for (i = 0; i < nvqs; i++) {
+        virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
+    }
+
+    /*
+     * The transaction expects the ioeventfds to be open when it
+     * commits. Do it now, before the cleanup loop.
+     */
+    memory_region_transaction_commit();
+
+    for (i = 0; i < nvqs; i++) {
+        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
+    }
+
+    /*
+     * Set ->dataplane_started to false before draining so that host notifiers
+     * are not detached/attached anymore.
+     */
+    s->dataplane_started = false;
+
+    /* Wait for virtio_blk_dma_restart_bh() and in flight I/O to complete */
+    blk_drain(s->conf.conf.blk);
+
+    /*
+     * Try to switch bs back to the QEMU main loop. If other users keep the
+     * BlockBackend in the iothread, that's ok
+     */
+    blk_set_aio_context(s->conf.conf.blk, qemu_get_aio_context(), NULL);
+
+    /* Clean up guest notifier (irq) */
+    k->set_guest_notifiers(qbus->parent, nvqs, false);
+
+    s->dataplane_stopping = false;
+}
+
 static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1680,7 +2015,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         virtio_add_queue(vdev, conf->queue_size, virtio_blk_handle_output);
     }
     qemu_coroutine_inc_pool_size(conf->num_queues * conf->queue_size / 2);
-    virtio_blk_data_plane_create(vdev, conf, &s->dataplane, &err);
+    virtio_blk_data_plane_create(s, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         for (i = 0; i < conf->num_queues; i++) {
@@ -1717,8 +2052,7 @@ static void virtio_blk_device_unrealize(DeviceState *dev)
 
     blk_drain(s->blk);
     del_boot_device_lchs(dev, "/disk@0,0");
-    virtio_blk_data_plane_destroy(s->dataplane);
-    s->dataplane = NULL;
+    virtio_blk_data_plane_destroy(s);
     for (i = 0; i < conf->num_queues; i++) {
         virtio_del_queue(vdev, i);
     }
diff --git a/hw/block/dataplane/meson.build b/hw/block/dataplane/meson.build
index 025b3b061b..11a5eba2f4 100644
--- a/hw/block/dataplane/meson.build
+++ b/hw/block/dataplane/meson.build
@@ -1,2 +1 @@
-system_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
 specific_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-block.c'))
diff --git a/hw/block/dataplane/trace-events b/hw/block/dataplane/trace-events
deleted file mode 100644
index 38fc3e7507..0000000000
--- a/hw/block/dataplane/trace-events
+++ /dev/null
@@ -1,5 +0,0 @@
-# See docs/devel/tracing.rst for syntax documentation.
-
-# virtio-blk.c
-virtio_blk_data_plane_start(void *s) "dataplane %p"
-virtio_blk_data_plane_stop(void *s) "dataplane %p"
diff --git a/meson.build b/meson.build
index d0329966f1..5ffa8c9716 100644
--- a/meson.build
+++ b/meson.build
@@ -3286,7 +3286,6 @@ if have_system
     'hw/arm',
     'hw/audio',
     'hw/block',
-    'hw/block/dataplane',
     'hw/char',
     'hw/display',
     'hw/dma',
-- 
2.43.0


