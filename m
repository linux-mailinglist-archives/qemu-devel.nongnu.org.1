Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F587D2216
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:22:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUfY-0000yk-Kj; Sun, 22 Oct 2023 05:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfW-0000sz-Cd
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfU-0000FU-3e
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFZkemHVKMpqq9uyVp58jnRD/h5a0Rr9UNCxOcsmGpE=;
 b=Vya3HYSYpLfMIoeoXd9gxEdQktlkKjyqF+KS6R9l6pvfADZLLUWpIxkeN9c8jppXSdBr+6
 nNMrqkQcZcndDO23xhStCboYfi0WDjoH972De87xYRlamqx685nMqYzAGjawFyiC4ccYR2
 Ub+CyUpi+WUBj8rvrUvA9makokh1BBc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-KD4BUunIPLizbgR9ROgXrQ-1; Sun, 22 Oct 2023 05:22:35 -0400
X-MC-Unique: KD4BUunIPLizbgR9ROgXrQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-407f9d07b41so14236135e9.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966554; x=1698571354;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BFZkemHVKMpqq9uyVp58jnRD/h5a0Rr9UNCxOcsmGpE=;
 b=moHqma4YIXDPPofq5MGEZph1bfGAFFJCs65T+N2AE6D5oh2qX5sLtbf4vkh2Cmhq+F
 mtX3o8e6fyEmMuo6n+Uzy8psUBzwu95IbWl5SXJ0feuFUUNXdD+Bx+OwJpbJeYm36dJ8
 nlbvswGWT/yGa30M6XWnhDCqApqJvNJhIYSoNC9igWG70b0NXS5sxpKEmMz3Ze/M2ALd
 Jy4IeEUrtyPz/wqXzklYgcpoeGm5JEpZ2g9nW5D2hUVzt840Qj9lgi/x7Tmodn9Dh5aP
 tYrcOrxn1axppR8FO+jUKmZQ0v8Mn/9OixSEiGIOTRAV4qL2AyCngWlfczhDlfKvSdHV
 p2Vw==
X-Gm-Message-State: AOJu0YyxZeknu+M1aIKwHH4QeuuB+KkIAi+nZFtrEwiAmF5ctHOjmf5N
 7vxEgh0q4RCHoKVXb/fM/kazwdIIuJyCmahenR4Bm37Mhf5uYRzc7zNOFbDs7C+yQCU3rHMBSAS
 lu74e4QCPQvMUChnC4PA68WzrLZUmSHyJVLCn9GI/eknZbBe972s1ymdBEI+vJMpIsFuc
X-Received: by 2002:a5d:5011:0:b0:324:e284:fac2 with SMTP id
 e17-20020a5d5011000000b00324e284fac2mr5010902wrt.5.1697966553943; 
 Sun, 22 Oct 2023 02:22:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNQNF7xknMUNpqezcoYnmrD863f3qFexmXtBk2RFd9Eh7skm3U3Hrbh8lIFLjM0hvM6ZedNw==
X-Received: by 2002:a5d:5011:0:b0:324:e284:fac2 with SMTP id
 e17-20020a5d5011000000b00324e284fac2mr5010884wrt.5.1697966553557; 
 Sun, 22 Oct 2023 02:22:33 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 r3-20020adff103000000b0032d9337e7d1sm5309531wro.11.2023.10.22.02.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:22:32 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:22:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PULL v3 10/62] vhost-user: factor out "vhost_user_write_sync"
Message-ID: <54ae36822f6f14603ed117b09fd1b59d6ebfb963.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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

The tails of the "vhost_user_set_vring_addr" and "vhost_user_set_u64"
functions are now byte-for-byte identical. Factor the common tail out to a
new function called "vhost_user_write_sync".

This is purely refactoring -- no observable change.

Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
Cc: Eugenio Perez Martin <eperezma@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Liu Jiang <gerry@linux.alibaba.com>
Cc: Sergio Lopez Pascual <slp@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20231002203221.17241-4-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 66 ++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 38 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 6c7b4cc75c..95dbf9880c 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1310,10 +1310,35 @@ static int enforce_reply(struct vhost_dev *dev,
     return vhost_user_get_features(dev, &dummy);
 }
 
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
+        return enforce_reply(dev, msg);
+    }
+
+    return 0;
+}
+
 static int vhost_user_set_vring_addr(struct vhost_dev *dev,
                                      struct vhost_vring_addr *addr)
 {
-    int ret;
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_SET_VRING_ADDR,
         .hdr.flags = VHOST_USER_VERSION,
@@ -1327,24 +1352,7 @@ static int vhost_user_set_vring_addr(struct vhost_dev *dev,
      */
     bool wait_for_reply = addr->flags & (1 << VHOST_VRING_F_LOG);
 
-    if (wait_for_reply) {
-        bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                          VHOST_USER_PROTOCOL_F_REPLY_ACK);
-        if (reply_supported) {
-            msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
-        }
-    }
-
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    if (wait_for_reply) {
-        return enforce_reply(dev, &msg);
-    }
-
-    return 0;
+    return vhost_user_write_sync(dev, &msg, wait_for_reply);
 }
 
 static int vhost_user_set_u64(struct vhost_dev *dev, int request, uint64_t u64,
@@ -1356,26 +1364,8 @@ static int vhost_user_set_u64(struct vhost_dev *dev, int request, uint64_t u64,
         .payload.u64 = u64,
         .hdr.size = sizeof(msg.payload.u64),
     };
-    int ret;
 
-    if (wait_for_reply) {
-        bool reply_supported = virtio_has_feature(dev->protocol_features,
-                                          VHOST_USER_PROTOCOL_F_REPLY_ACK);
-        if (reply_supported) {
-            msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
-        }
-    }
-
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    if (wait_for_reply) {
-        return enforce_reply(dev, &msg);
-    }
-
-    return 0;
+    return vhost_user_write_sync(dev, &msg, wait_for_reply);
 }
 
 static int vhost_user_set_status(struct vhost_dev *dev, uint8_t status)
-- 
MST


