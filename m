Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCA77CE25E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:10:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vF-00055V-Eq; Wed, 18 Oct 2023 11:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tn-000315-BT
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tl-0006u7-HG
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qncmj8VSAhzCwEfF1DriYWvIMpvnvvg3uBD5Ms2hZSs=;
 b=B9N5+s4465yALBxU7jdoAyrDml9xkmfIdEu3LQJWVjWzUyaDikNVpyRTmwSoFAA1iuIcPV
 C7MxNytmh4J3DQFv6wKrh1xLAvM9OFWC2e3RPHNTRTEwwu212aLptcTXVxS4WxKjdIJPCc
 vd9WxuRHzQVd5W8HXFdrMRcrm4ELtfM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-AHRQeYN1Ol6Y2YlQa8ESsQ-1; Wed, 18 Oct 2023 11:55:51 -0400
X-MC-Unique: AHRQeYN1Ol6Y2YlQa8ESsQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c51d0f97e3so35963561fa.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644549; x=1698249349;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qncmj8VSAhzCwEfF1DriYWvIMpvnvvg3uBD5Ms2hZSs=;
 b=W8SfHgY4PQEeKnQ4vsRRR0XmuuGxeJxyLIAMJOsb9e3W6M0guZKNQPKjyNA/i5Ks0Z
 otezGRKjEyZTGNev8BLyES8Pdb69eha2pLOsZh2vWoI2yeDmC/iz0yceais7Cr3+kXoE
 AuMhalS/LyaTeuwbd1jTjATefSEoD3fKoo8E8bSUF7SurAzeB5W2iYSdEz7EIUjUp6QK
 9I9I6N3+iRBbMANXp5KXYFn3h454sUf0DxcRimMgJcWu81A4Emn5U41n2Hu+aRBJNUmo
 Dl2Er6l8nkNV5ALsooTVUzNv3m2vi5+wVRnH7J2OHOyQ/hoO3Jx83haetxfv8I60mY3Q
 uDqw==
X-Gm-Message-State: AOJu0YxM2d7leP1iHuN6rKTwcf1Zq3b9DSELEQXsd0HZlTWjVikOHrOg
 a7wAxIXQKLznYYxhxssYKSbE2bUTdz33wxsrGTLc1iXfzO5RFAaZexoPfYIMKsQ7pymSij7hIEl
 ImjOLpeEN8x20aFOXBnPWQ5CfnOPuT1rr+FBinWt8lwh3Q32f2dQJ/gbyyeteThEbwb4PtI4=
X-Received: by 2002:a05:651c:201a:b0:2bc:b821:84ad with SMTP id
 s26-20020a05651c201a00b002bcb82184admr3501291ljo.16.1697644549778; 
 Wed, 18 Oct 2023 08:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrs2PYUoQxYLZZjXxwrBj2p8DCYkhLmtnL5K9Hl6WH48qEzXCFxj78EZIwbpnCe55MIAQqlg==
X-Received: by 2002:a05:651c:201a:b0:2bc:b821:84ad with SMTP id
 s26-20020a05651c201a00b002bcb82184admr3501274ljo.16.1697644549398; 
 Wed, 18 Oct 2023 08:55:49 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c1c1400b004065daba6casm2029931wms.46.2023.10.18.08.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:55:48 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:55:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Albert Esteve <aesteve@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/83] vhost-user: hoist "write_sync", "get_features", "get_u64"
Message-ID: <1769f7b19207998b62e8a46b267f3ccfab6becbb.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Laszlo Ersek <lersek@redhat.com>

In order to avoid a forward-declaration for "vhost_user_write_sync" in a
subsequent patch, hoist "vhost_user_write_sync" ->
"vhost_user_get_features" -> "vhost_user_get_u64" just above
"vhost_set_vring".

This is purely code movement -- no observable change.

Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
Cc: Eugenio Perez Martin <eperezma@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Liu Jiang <gerry@linux.alibaba.com>
Cc: Sergio Lopez Pascual <slp@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20231002203221.17241-6-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 170 ++++++++++++++++++++---------------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 23e9039922..3c14947589 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1073,6 +1073,91 @@ static int vhost_user_set_vring_endian(struct vhost_dev *dev,
     return vhost_user_write(dev, &msg, NULL, 0);
 }
 
+static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
+{
+    int ret;
+    VhostUserMsg msg = {
+        .hdr.request = request,
+        .hdr.flags = VHOST_USER_VERSION,
+    };
+
+    if (vhost_user_per_device_request(request) && dev->vq_index != 0) {
+        return 0;
+    }
+
+    ret = vhost_user_write(dev, &msg, NULL, 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = vhost_user_read(dev, &msg);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (msg.hdr.request != request) {
+        error_report("Received unexpected msg type. Expected %d received %d",
+                     request, msg.hdr.request);
+        return -EPROTO;
+    }
+
+    if (msg.hdr.size != sizeof(msg.payload.u64)) {
+        error_report("Received bad msg size.");
+        return -EPROTO;
+    }
+
+    *u64 = msg.payload.u64;
+
+    return 0;
+}
+
+static int vhost_user_get_features(struct vhost_dev *dev, uint64_t *features)
+{
+    if (vhost_user_get_u64(dev, VHOST_USER_GET_FEATURES, features) < 0) {
+        return -EPROTO;
+    }
+
+    return 0;
+}
+
+/* Note: "msg->hdr.flags" may be modified. */
+static int vhost_user_write_sync(struct vhost_dev *dev, VhostUserMsg *msg,
+                                 bool wait_for_reply)
+{
+    int ret;
+
+    if (wait_for_reply) {
+        bool reply_supported = virtio_has_feature(dev->protocol_features,
+                                          VHOST_USER_PROTOCOL_F_REPLY_ACK);
+        if (reply_supported) {
+            msg->hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
+        }
+    }
+
+    ret = vhost_user_write(dev, msg, NULL, 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (wait_for_reply) {
+        uint64_t dummy;
+
+        if (msg->hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
+            return process_message_reply(dev, msg);
+        }
+
+       /*
+        * We need to wait for a reply but the backend does not
+        * support replies for the command we just sent.
+        * Send VHOST_USER_GET_FEATURES which makes all backends
+        * send a reply.
+        */
+        return vhost_user_get_features(dev, &dummy);
+    }
+
+    return 0;
+}
+
 static int vhost_set_vring(struct vhost_dev *dev,
                            unsigned long int request,
                            struct vhost_vring_state *ring)
@@ -1245,91 +1330,6 @@ static int vhost_user_set_vring_err(struct vhost_dev *dev,
     return vhost_set_vring_file(dev, VHOST_USER_SET_VRING_ERR, file);
 }
 
-static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
-{
-    int ret;
-    VhostUserMsg msg = {
-        .hdr.request = request,
-        .hdr.flags = VHOST_USER_VERSION,
-    };
-
-    if (vhost_user_per_device_request(request) && dev->vq_index != 0) {
-        return 0;
-    }
-
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    ret = vhost_user_read(dev, &msg);
-    if (ret < 0) {
-        return ret;
-    }
-
-    if (msg.hdr.request != request) {
-        error_report("Received unexpected msg type. Expected %d received %d",
-                     request, msg.hdr.request);
-        return -EPROTO;
-    }
-
-    if (msg.hdr.size != sizeof(msg.payload.u64)) {
-        error_report("Received bad msg size.");
-        return -EPROTO;
-    }
-
-    *u64 = msg.payload.u64;
-
-    return 0;
-}
-
-static int vhost_user_get_features(struct vhost_dev *dev, uint64_t *features)
-{
-    if (vhost_user_get_u64(dev, VHOST_USER_GET_FEATURES, features) < 0) {
-        return -EPROTO;
-    }
-
-    return 0;
-}
-
-/* Note: "msg->hdr.flags" may be modified. */
-static int vhost_user_write_sync(struct vhost_dev *dev, VhostUserMsg *msg,
-                                 bool wait_for_reply)
-{
-    int ret;
-
-    if (wait_for_reply) {
-        bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                          VHOST_USER_PROTOCOL_F_REPLY_ACK);
-        if (reply_supported) {
-            msg->hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
-        }
-    }
-
-    ret = vhost_user_write(dev, msg, NULL, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    if (wait_for_reply) {
-        uint64_t dummy;
-
-        if (msg->hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
-            return process_message_reply(dev, msg);
-        }
-
-       /*
-        * We need to wait for a reply but the backend does not
-        * support replies for the command we just sent.
-        * Send VHOST_USER_GET_FEATURES which makes all backends
-        * send a reply.
-        */
-        return vhost_user_get_features(dev, &dummy);
-    }
-
-    return 0;
-}
-
 static int vhost_user_set_vring_addr(struct vhost_dev *dev,
                                      struct vhost_vring_addr *addr)
 {
-- 
MST


