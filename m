Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D65AE7B7AF5
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:01:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxV1-0006Jf-Va; Wed, 04 Oct 2023 04:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUr-00052Y-KU
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUp-0001rB-SU
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AiQdNTqnxtFGOSvcL+3vuh6UZ0oYWIGWZgVDW5tnk0Q=;
 b=OsKCOSzgC8zADHEu3H5s8rcdlO7I29Rv9pBomOfRdjNigL/6w9EljAA/Zdzx0ZYqr/eCqh
 JzvwoFMD4xDnR3xf+j8x4GaOVzQlCSKKWwAxIjHOOU4mkN2apg46QEL7sNPKnk3AYxe3+3
 iyFrZsaLPp0unHnBZeYMmoU29NNEJn0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-cMKywzE9PhO2IAeqHLJtxw-1; Wed, 04 Oct 2023 04:44:41 -0400
X-MC-Unique: cMKywzE9PhO2IAeqHLJtxw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40524bc3c5cso12743345e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409080; x=1697013880;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AiQdNTqnxtFGOSvcL+3vuh6UZ0oYWIGWZgVDW5tnk0Q=;
 b=U4DGjIndXuO6RiAAOYcU6zNTtPgLKL0pKYrM3bwiGPYnKkHGClT3MbFUJ/UvnsE2RF
 36RrKtjtW58lozgqKZHVmpRPWSeTh+OiCOgqMe/J4Unocje3oX0CUEnUDil+ahL7aRGH
 SK/SpvrC573UYrFXZvGZKSe7ubr97Ps1+LC/fos99VswC/kJGO8lWe1wN9yLW8p87Hac
 Mw69sR1kfImqB6vmHCW3BiKFo3W/rRtLFHMqq6QzwKpe4cYkKKVFyhw6FpBfM1U13b17
 XbsNSh9sknyvp0qWnJVgxGCl5wc3p86cWfIOY7SEXmjphIujLAmB9mESOEHgspiPTyUI
 y4/A==
X-Gm-Message-State: AOJu0YxQ8fv9NafycTDOMhm6OD8rcfPRXNR3Kk8IFnEViQPf/maaDg8s
 gruLq4zneHzbv6xNDdLD72t8N7ZqLRS562PBGbCOqSNPgH95m0jVGyu7bAQWac20b/WATRNtSXB
 fQRl3d01E177HVGBx00t3YZ5VbcnKNqd66pdAuU+dbZncfFLHeqrvLLdfNQraPtqyHi1X
X-Received: by 2002:a05:600c:3786:b0:3fe:2b8c:9f0b with SMTP id
 o6-20020a05600c378600b003fe2b8c9f0bmr1601366wmr.23.1696409080020; 
 Wed, 04 Oct 2023 01:44:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG31TjtZybSfdTH5Ec2j8C+diJOOfeYRmv8xX8mMq2tSWqdJwM9TVahced0XvnkbU3Dogvf3Q==
X-Received: by 2002:a05:600c:3786:b0:3fe:2b8c:9f0b with SMTP id
 o6-20020a05600c378600b003fe2b8c9f0bmr1601349wmr.23.1696409079627; 
 Wed, 04 Oct 2023 01:44:39 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 k10-20020a7bc40a000000b003fc06169ab3sm944594wmi.20.2023.10.04.01.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:38 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/63] vhost-user: hoist "write_sync", "get_features", "get_u64"
Message-ID: <188a3b60841696ce0dbc59866bfa53295ad7fc02.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
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
Message-Id: <20230830134055.106812-6-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-user.c | 170 ++++++++++++++++++++---------------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b2213f024c..ccb60da007 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1062,6 +1062,91 @@ static int vhost_user_set_vring_endian(struct vhost_dev *dev,
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
@@ -1234,91 +1319,6 @@ static int vhost_user_set_vring_err(struct vhost_dev *dev,
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


