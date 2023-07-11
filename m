Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D766174F41A
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 17:53:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJFfU-0000eU-Jt; Tue, 11 Jul 2023 11:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJFfS-0000eG-7V
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:52:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJFfQ-0001iB-JV
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689090763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQY1+7pNd7WKWB3DHdDVAKASn6XKPkZ2JsIn2e2HbKY=;
 b=IikO5Qug3VqSORfuGNELb/iAXVn3iE9bhQ2BzEAqgMC9is0GEPm+jdYGhvpe/a0seSV/eZ
 KxT9kAcHdDGmT7WuZLTEr69uJrbxgB+RkS41OJUlXckBbzC28KRoYWWlm//7ZqL/decLKP
 YbjO8sY6v6ZAPEH8O95OCqP3tAiv6LM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-eBxz59roNvyg0S7wfcptXQ-1; Tue, 11 Jul 2023 11:52:41 -0400
X-MC-Unique: eBxz59roNvyg0S7wfcptXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4AB2809F8F
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 15:52:40 +0000 (UTC)
Received: from localhost (unknown [10.39.192.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C3C81401C2E;
 Tue, 11 Jul 2023 15:52:40 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: [PATCH 4/6] vhost-user: Implement suspend/resume
Date: Tue, 11 Jul 2023 17:52:26 +0200
Message-ID: <20230711155230.64277-5-hreitz@redhat.com>
In-Reply-To: <20230711155230.64277-1-hreitz@redhat.com>
References: <20230711155230.64277-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

Implement SUSPEND/RESUME like vDPA does, by automatically using it in
vhost_user_dev_start().  (Though our vDPA code does not implement RESUME
yet, so there, the device is reset when it is to be resumed.)

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/virtio/vhost-user.c | 99 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8dcf049d42..4507de5a92 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -74,6 +74,8 @@ enum VhostUserProtocolFeature {
     /* Feature 14 reserved for VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS. */
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
     VHOST_USER_PROTOCOL_F_STATUS = 16,
+    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
+    VHOST_USER_PROTOCOL_F_SUSPEND = 18,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -121,6 +123,8 @@ typedef enum VhostUserRequest {
     VHOST_USER_REM_MEM_REG = 38,
     VHOST_USER_SET_STATUS = 39,
     VHOST_USER_GET_STATUS = 40,
+    VHOST_USER_SUSPEND = 41,
+    VHOST_USER_RESUME = 42,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -1389,7 +1393,19 @@ static int vhost_user_set_u64(struct vhost_dev *dev, int request, uint64_t u64,
 
 static int vhost_user_set_status(struct vhost_dev *dev, uint8_t status)
 {
-    return vhost_user_set_u64(dev, VHOST_USER_SET_STATUS, status, false);
+    int ret;
+
+    ret = vhost_user_set_u64(dev, VHOST_USER_SET_STATUS, status, false);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (!status) {
+        /* reset */
+        dev->suspended = false;
+    }
+
+    return 0;
 }
 
 static int vhost_user_get_status(struct vhost_dev *dev, uint8_t *status)
@@ -1490,6 +1506,7 @@ static int vhost_user_get_max_memslots(struct vhost_dev *dev,
 
 static int vhost_user_reset_device(struct vhost_dev *dev)
 {
+    int ret;
     VhostUserMsg msg = {
         .hdr.flags = VHOST_USER_VERSION,
     };
@@ -1499,7 +1516,13 @@ static int vhost_user_reset_device(struct vhost_dev *dev)
         ? VHOST_USER_RESET_DEVICE
         : VHOST_USER_RESET_OWNER;
 
-    return vhost_user_write(dev, &msg, NULL, 0);
+    ret = vhost_user_write(dev, &msg, NULL, 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    dev->suspended = false;
+    return 0;
 }
 
 static int vhost_user_backend_handle_config_change(struct vhost_dev *dev)
@@ -2707,8 +2730,80 @@ void vhost_user_async_close(DeviceState *d,
     }
 }
 
+static bool vhost_user_supports_suspend(struct vhost_dev *dev)
+{
+    return virtio_has_feature(dev->protocol_features,
+                              VHOST_USER_PROTOCOL_F_SUSPEND);
+}
+
+static int vhost_user_do_suspend_resume(struct vhost_dev *dev, bool suspend)
+{
+    VhostUserMsg msg;
+    bool reply_supported = virtio_has_feature(dev->protocol_features,
+                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
+    VhostUserRequest request = suspend ? VHOST_USER_SUSPEND : VHOST_USER_RESUME;
+    int ret;
+
+    if (dev->suspended == suspend) {
+        /* Nothing to do */
+        return 0;
+    }
+
+    if (!vhost_user_supports_suspend(dev)) {
+        return -ENOTSUP;
+    }
+
+    msg = (VhostUserMsg) {
+        .hdr = {
+            .request = request,
+            .size = 0,
+            .flags = VHOST_USER_VERSION,
+        },
+    };
+    if (reply_supported) {
+        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
+    }
+
+    ret = vhost_user_write(dev, &msg, NULL, 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (reply_supported) {
+        ret = process_message_reply(dev, &msg);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    dev->suspended = suspend;
+    return 0;
+}
+
+static int vhost_user_suspend(struct vhost_dev *dev)
+{
+    return vhost_user_do_suspend_resume(dev, true);
+}
+
+static int vhost_user_resume(struct vhost_dev *dev)
+{
+    return vhost_user_do_suspend_resume(dev, false);
+}
+
 static int vhost_user_dev_start(struct vhost_dev *dev, bool started)
 {
+    /*
+     * Ignore results.  If the central vhost code cares, it will check
+     * dev->suspended.  (These calls will fail if the back-end does not
+     * support suspend/resume, which callers that just want to start the
+     * device do not care about.)
+     */
+    if (started) {
+        vhost_user_resume(dev);
+    } else {
+        vhost_user_suspend(dev);
+    }
+
     if (!virtio_has_feature(dev->protocol_features,
                             VHOST_USER_PROTOCOL_F_STATUS)) {
         return 0;
-- 
2.41.0


