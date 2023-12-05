Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59654805D36
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 19:22:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAa2W-00008I-1o; Tue, 05 Dec 2023 13:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAa23-0008V3-Au
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:20:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAa21-0002iY-Bx
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701800428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYzMzXb1PdcjP3A1qwHad/XAhWJKM4hT2cxMg6piGu4=;
 b=gyQajiLOVvkz8nhjX76wfANbdKGoMUSUTeIW2W91B/RpFazvJ5nxDhdWS2yoZ9ePdeKV47
 4dA+IaI1UiEWIw19pqF90uDSb+Ga5KK53e56f894LVWGIlYsCoU+N3M7gnqg59Am5sEnXx
 E8cweu3Npd4ztGyAuRYen95ZWCeh+Q0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-GF-QWva-Oni-7XU0aB-D9w-1; Tue, 05 Dec 2023 13:20:20 -0500
X-MC-Unique: GF-QWva-Oni-7XU0aB-D9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4226585A597;
 Tue,  5 Dec 2023 18:20:18 +0000 (UTC)
Received: from localhost (unknown [10.39.194.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99C5B51E3;
 Tue,  5 Dec 2023 18:20:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Cleber Rosa <crosa@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Paul Durrant <paul@xen.org>, Ari Sundholm <ari@tuxera.com>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Wen Congyang <wencongyang2@huawei.com>, Alberto Garcia <berto@igalia.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Peter Xu <peterx@redhat.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 Fam Zheng <fam@euphon.net>, Leonardo Bras <leobras@redhat.com>,
 David Hildenbrand <david@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 01/14] virtio-scsi: replace AioContext lock with tmf_bh_lock
Date: Tue,  5 Dec 2023 13:19:58 -0500
Message-ID: <20231205182011.1976568-2-stefanha@redhat.com>
In-Reply-To: <20231205182011.1976568-1-stefanha@redhat.com>
References: <20231205182011.1976568-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

Protect the Task Management Function BH state with a lock. The TMF BH
runs in the main loop thread. An IOThread might process a TMF at the
same time as the TMF BH is running. Therefore tmf_bh_list and tmf_bh
must be protected by a lock.

Run TMF request completion in the IOThread using aio_wait_bh_oneshot().
This avoids more locking to protect the virtqueue and SCSI layer state.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
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
2.43.0


