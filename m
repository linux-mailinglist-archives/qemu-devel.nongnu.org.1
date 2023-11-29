Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 772F47FE094
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 20:57:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8QfT-0006yb-0B; Wed, 29 Nov 2023 14:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8QfH-0006u7-VZ
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8QfF-0004Ga-EZ
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701287764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ocMGkaWO2UNgH6BeGysPHsaortxgu0jbKcgqrLTfAY=;
 b=WxEah5ybIxF1auAc71amCHvsHc0S9aaNKwdjJN1UwZhOD+ooYP0ZMUUgYHAycr7unWuzNd
 6OEc/NDD6AdUOj7WOKuRTVTV7bTpYLv1FWpugPU5ghjuI2pvRbFGn35CPsLH9DsA6JW44a
 OAH+3PqvF2TjfzbeBjp/fUkmkoYjixs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-7PZf8UtzMqq7ue5HK1SifQ-1; Wed,
 29 Nov 2023 14:56:01 -0500
X-MC-Unique: 7PZf8UtzMqq7ue5HK1SifQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF60E29AA2CA;
 Wed, 29 Nov 2023 19:56:00 +0000 (UTC)
Received: from localhost (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22DFA1121308;
 Wed, 29 Nov 2023 19:55:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 <qemu-block@nongnu.org>, xen-devel@lists.xenproject.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Xie Changlong <xiechanglong.d@gmail.com>, Ari Sundholm <ari@tuxera.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Cleber Rosa <crosa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhang Chen <chen.zhang@intel.com>, Peter Xu <peterx@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Leonardo Bras <leobras@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 01/12] virtio-scsi: replace AioContext lock with tmf_bh_lock
Date: Wed, 29 Nov 2023 14:55:42 -0500
Message-ID: <20231129195553.942921-2-stefanha@redhat.com>
In-Reply-To: <20231129195553.942921-1-stefanha@redhat.com>
References: <20231129195553.942921-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Protect the Task Management Function BH state with a lock. The TMF BH
runs in the main loop thread. An IOThread might process a TMF at the
same time as the TMF BH is running. Therefore tmf_bh_list and tmf_bh
must be protected by a lock.

Run TMF request completion in the IOThread using aio_wait_bh_oneshot().
This avoids more locking to protect the virtqueue and SCSI layer state.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/virtio/virtio-scsi.h |  3 +-
 hw/scsi/virtio-scsi.c           | 62 ++++++++++++++++++++++-----------
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 779568ab5d..da8cb928d9 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -85,8 +85,9 @@ struct VirtIOSCSI {
 
     /*
      * TMFs deferred to main loop BH. These fields are protected by
-     * virtio_scsi_acquire().
+     * tmf_bh_lock.
      */
+    QemuMutex tmf_bh_lock;
     QEMUBH *tmf_bh;
     QTAILQ_HEAD(, VirtIOSCSIReq) tmf_bh_list;
 
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 9c751bf296..4f8d35facc 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -123,6 +123,30 @@ static void virtio_scsi_complete_req(VirtIOSCSIReq *req)
     virtio_scsi_free_req(req);
 }
 
+static void virtio_scsi_complete_req_bh(void *opaque)
+{
+    VirtIOSCSIReq *req = opaque;
+
+    virtio_scsi_complete_req(req);
+}
+
+/*
+ * Called from virtio_scsi_do_one_tmf_bh() in main loop thread. The main loop
+ * thread cannot touch the virtqueue since that could race with an IOThread.
+ */
+static void virtio_scsi_complete_req_from_main_loop(VirtIOSCSIReq *req)
+{
+    VirtIOSCSI *s = req->dev;
+
+    if (!s->ctx || s->ctx == qemu_get_aio_context()) {
+        /* No need to schedule a BH when there is no IOThread */
+        virtio_scsi_complete_req(req);
+    } else {
+        /* Run request completion in the IOThread */
+        aio_wait_bh_oneshot(s->ctx, virtio_scsi_complete_req_bh, req);
+    }
+}
+
 static void virtio_scsi_bad_req(VirtIOSCSIReq *req)
 {
     virtio_error(VIRTIO_DEVICE(req->dev), "wrong size for virtio-scsi headers");
@@ -338,10 +362,7 @@ static void virtio_scsi_do_one_tmf_bh(VirtIOSCSIReq *req)
 
 out:
     object_unref(OBJECT(d));
-
-    virtio_scsi_acquire(s);
-    virtio_scsi_complete_req(req);
-    virtio_scsi_release(s);
+    virtio_scsi_complete_req_from_main_loop(req);
 }
 
 /* Some TMFs must be processed from the main loop thread */
@@ -354,18 +375,16 @@ static void virtio_scsi_do_tmf_bh(void *opaque)
 
     GLOBAL_STATE_CODE();
 
-    virtio_scsi_acquire(s);
+    WITH_QEMU_LOCK_GUARD(&s->tmf_bh_lock) {
+        QTAILQ_FOREACH_SAFE(req, &s->tmf_bh_list, next, tmp) {
+            QTAILQ_REMOVE(&s->tmf_bh_list, req, next);
+            QTAILQ_INSERT_TAIL(&reqs, req, next);
+        }
 
-    QTAILQ_FOREACH_SAFE(req, &s->tmf_bh_list, next, tmp) {
-        QTAILQ_REMOVE(&s->tmf_bh_list, req, next);
-        QTAILQ_INSERT_TAIL(&reqs, req, next);
+        qemu_bh_delete(s->tmf_bh);
+        s->tmf_bh = NULL;
     }
 
-    qemu_bh_delete(s->tmf_bh);
-    s->tmf_bh = NULL;
-
-    virtio_scsi_release(s);
-
     QTAILQ_FOREACH_SAFE(req, &reqs, next, tmp) {
         QTAILQ_REMOVE(&reqs, req, next);
         virtio_scsi_do_one_tmf_bh(req);
@@ -379,8 +398,7 @@ static void virtio_scsi_reset_tmf_bh(VirtIOSCSI *s)
 
     GLOBAL_STATE_CODE();
 
-    virtio_scsi_acquire(s);
-
+    /* Called after ioeventfd has been stopped, so tmf_bh_lock is not needed */
     if (s->tmf_bh) {
         qemu_bh_delete(s->tmf_bh);
         s->tmf_bh = NULL;
@@ -393,19 +411,19 @@ static void virtio_scsi_reset_tmf_bh(VirtIOSCSI *s)
         req->resp.tmf.response = VIRTIO_SCSI_S_TARGET_FAILURE;
         virtio_scsi_complete_req(req);
     }
-
-    virtio_scsi_release(s);
 }
 
 static void virtio_scsi_defer_tmf_to_bh(VirtIOSCSIReq *req)
 {
     VirtIOSCSI *s = req->dev;
 
-    QTAILQ_INSERT_TAIL(&s->tmf_bh_list, req, next);
+    WITH_QEMU_LOCK_GUARD(&s->tmf_bh_lock) {
+        QTAILQ_INSERT_TAIL(&s->tmf_bh_list, req, next);
 
-    if (!s->tmf_bh) {
-        s->tmf_bh = qemu_bh_new(virtio_scsi_do_tmf_bh, s);
-        qemu_bh_schedule(s->tmf_bh);
+        if (!s->tmf_bh) {
+            s->tmf_bh = qemu_bh_new(virtio_scsi_do_tmf_bh, s);
+            qemu_bh_schedule(s->tmf_bh);
+        }
     }
 }
 
@@ -1235,6 +1253,7 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
     Error *err = NULL;
 
     QTAILQ_INIT(&s->tmf_bh_list);
+    qemu_mutex_init(&s->tmf_bh_lock);
 
     virtio_scsi_common_realize(dev,
                                virtio_scsi_handle_ctrl,
@@ -1277,6 +1296,7 @@ static void virtio_scsi_device_unrealize(DeviceState *dev)
 
     qbus_set_hotplug_handler(BUS(&s->bus), NULL);
     virtio_scsi_common_unrealize(dev);
+    qemu_mutex_destroy(&s->tmf_bh_lock);
 }
 
 static Property virtio_scsi_properties[] = {
-- 
2.42.0


