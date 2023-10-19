Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6497D0184
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:30:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhK-0000Na-Qr; Thu, 19 Oct 2023 14:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfF-0006RH-MH
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfD-0000m5-TI
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qncmj8VSAhzCwEfF1DriYWvIMpvnvvg3uBD5Ms2hZSs=;
 b=BUiSalRmBH02w9+AWmgozKdDwWHVln5oSgl0pntszY95wL+WHG6YqRqz0/VIb8p2pk2ptS
 lQVXj47ORaBLpNoUtuLJJpM+tZv8E5epc0Ti9SCOwND2mAxCTXYvltqbzi0/38XyzlZl/Q
 Pk0Q1l7LgzIOCEFtd7NWf4eIjBQMnS4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-w6hrCDrjPfOy4pnqogc5vQ-1; Thu, 19 Oct 2023 14:22:30 -0400
X-MC-Unique: w6hrCDrjPfOy4pnqogc5vQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32dd782e2d1so2214f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739748; x=1698344548;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qncmj8VSAhzCwEfF1DriYWvIMpvnvvg3uBD5Ms2hZSs=;
 b=lYkM3im0vPq9xpDx7jLyaOpPPx0gQWZCDpzIYpc28E/NF4+LFrtFxi2IF0R2rlBoy9
 3OFGn6YhWEtyLaCBfIA6k4rcw3Mui8p8/XxwB31Cv0CZZQvSjXsmLmkydoq0ySaW8EQz
 vlmMMNiE7nuZpVA6uMvZKOGMCXZbvFxb8i7D8XXNsaw2EuoykXgLO3xTQI2Qwiky1598
 uQl+LcUwBF3tI2nmhUfcqrylyVkbXY1jKm1cUl6uyfbybIz/DzNeMXTSrwNTxlM+upXU
 7An/vd7ovi/vEX/E7svy2gCQ6ug5Yi/YV1zhH7QUgsPkjiCtzzTFChZf+zgp3JWfchVY
 saTg==
X-Gm-Message-State: AOJu0YyezEMbgSijW9vfXP5AQ+jJKdOL/3JvU4rtGgH0Tq1qYecZFaE8
 DEQtChHmBCnVNdSZiG/YBXoOMg9QoX5/QPQRlyl/JWvS+RBPBsD6HG1qAlW+QEbJmwVEBSlrra7
 qHFbgQ5hJDSJae7evoGut64qbSkW6nqqgROL/1ABUV99UYt6wx8As/CLtb7b9+kLxzwGq
X-Received: by 2002:adf:e38d:0:b0:32d:701b:a585 with SMTP id
 e13-20020adfe38d000000b0032d701ba585mr1899599wrm.69.1697739748609; 
 Thu, 19 Oct 2023 11:22:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXeOi1VRtVHkr3ieSYgb9uskZndH+kEQhPljDLKDJ+ZcpzTYl5tnZJbTUSytX0YS//sUkLVg==
X-Received: by 2002:adf:e38d:0:b0:32d:701b:a585 with SMTP id
 e13-20020adfe38d000000b0032d701ba585mr1899576wrm.69.1697739748179; 
 Thu, 19 Oct 2023 11:22:28 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d50c5000000b003140f47224csm5025222wrt.15.2023.10.19.11.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:27 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Albert Esteve <aesteve@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 28/78] vhost-user: hoist "write_sync", "get_features",
 "get_u64"
Message-ID: <c932ddb7f2f61ea27b3114d5adc3f06002cf119c.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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


