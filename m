Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A322EA5CA8C
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 17:15:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts2DS-0000ch-Ir; Tue, 11 Mar 2025 12:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts235-0004Ww-3Y
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts22i-0005ph-8B
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=erCvDywXkGyZsgBRt9YjSOfw93ZGtqYpmT63Q89bCRc=;
 b=iJEN3Q3CXp2+zvAdZ3byR+cEb4uT5Sria0xkWr5vMuGbbhcB3Tslz7b3w6Urw9+kOin9YQ
 YamhWUrHRV06mzXQokVkajTzaI5UR5nlKCVzSBPL8MarxAai6a7niq53aIlhwon2jqlc2+
 zENeVFDLqTYQbJuse2/KDtxcnSZ9dSI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-_VdgvvdANJmYWTcZjUYE7A-1; Tue,
 11 Mar 2025 12:01:13 -0400
X-MC-Unique: _VdgvvdANJmYWTcZjUYE7A-1
X-Mimecast-MFC-AGG-ID: _VdgvvdANJmYWTcZjUYE7A_1741708872
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7655180899B; Tue, 11 Mar 2025 16:01:12 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B8F618001E9; Tue, 11 Mar 2025 16:01:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 22/22] virtio-scsi: only expose cmd vqs via iothread-vq-mapping
Date: Tue, 11 Mar 2025 17:00:21 +0100
Message-ID: <20250311160021.349761-23-kwolf@redhat.com>
In-Reply-To: <20250311160021.349761-1-kwolf@redhat.com>
References: <20250311160021.349761-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Peter Krempa and Kevin Wolf observed that iothread-vq-mapping is
confusing to use because the control and event virtqueues have a fixed
location before the command virtqueues but need to be treated
differently.

Only expose the command virtqueues via iothread-vq-mapping so that the
command-line parameter is intuitive: it controls where SCSI requests are
processed.

The control virtqueue needs to be hardcoded to the main loop thread for
technical reasons anyway. Kevin also pointed out that it's better to
place the event virtqueue in the main loop thread since its no poll
behavior would prevent polling if assigned to an IOThread.

This change is its own commit to avoid squashing the previous commit.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20250311132616.1049687-14-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/virtio-scsi-dataplane.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 2d37fa6712..95f13fb7c2 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -28,7 +28,6 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    uint16_t num_vqs = vs->conf.num_queues + VIRTIO_SCSI_VQ_NUM_FIXED;
 
     if (vs->conf.iothread && vs->conf.iothread_vq_mapping_list) {
         error_setg(errp,
@@ -50,35 +49,43 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
         }
     }
 
-    s->vq_aio_context = g_new(AioContext *, num_vqs);
+    s->vq_aio_context = g_new(AioContext *, vs->conf.num_queues +
+                                            VIRTIO_SCSI_VQ_NUM_FIXED);
+
+    /*
+     * Handle the ctrl virtqueue in the main loop thread where device resets
+     * can be performed.
+     */
+    s->vq_aio_context[0] = qemu_get_aio_context();
+
+    /*
+     * Handle the event virtqueue in the main loop thread where its no_poll
+     * behavior won't stop IOThread polling.
+     */
+    s->vq_aio_context[1] = qemu_get_aio_context();
 
     if (vs->conf.iothread_vq_mapping_list) {
         if (!iothread_vq_mapping_apply(vs->conf.iothread_vq_mapping_list,
-                                       s->vq_aio_context, num_vqs, errp)) {
+                    &s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED],
+                    vs->conf.num_queues, errp)) {
             g_free(s->vq_aio_context);
             s->vq_aio_context = NULL;
             return;
         }
     } else if (vs->conf.iothread) {
         AioContext *ctx = iothread_get_aio_context(vs->conf.iothread);
-        for (uint16_t i = 0; i < num_vqs; i++) {
-            s->vq_aio_context[i] = ctx;
+        for (uint16_t i = 0; i < vs->conf.num_queues; i++) {
+            s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i] = ctx;
         }
 
         /* Released in virtio_scsi_dataplane_cleanup() */
         object_ref(OBJECT(vs->conf.iothread));
     } else {
         AioContext *ctx = qemu_get_aio_context();
-        for (unsigned i = 0; i < num_vqs; i++) {
-            s->vq_aio_context[i] = ctx;
+        for (unsigned i = 0; i < vs->conf.num_queues; i++) {
+            s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i] = ctx;
         }
     }
-
-    /*
-     * Always handle the ctrl virtqueue in the main loop thread where device
-     * resets can be performed.
-     */
-    s->vq_aio_context[0] = qemu_get_aio_context();
 }
 
 /* Context: BQL held */
-- 
2.48.1


