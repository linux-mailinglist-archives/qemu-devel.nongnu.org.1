Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D44C97B7AB4
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:52:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxUw-0005JT-B1; Wed, 04 Oct 2023 04:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUj-0004uV-T7
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxUi-0001kh-3P
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWu3uXKqBq1F/Sv+u1gdviuIqzdA2COq3OTo91Q7s5w=;
 b=abHTbc3Z+BGfvf/4sFXs1nyULDqpiXhjF3qHhxaXBeTjjK6/0veJW1K6Zf6Y27pV1UGztK
 WQecDLg02HzRA7rjA7DJjYopLyJYEugi6CELLBCjJC67RnINmKZSkdqWZI2/AxLCO3Y5Sb
 JsUagiYuN7QjnmzG8A4XOeH/h6zy1fY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-0wAeV9HaNSW7KNBhScrXnA-1; Wed, 04 Oct 2023 04:44:34 -0400
X-MC-Unique: 0wAeV9HaNSW7KNBhScrXnA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso12562865e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409072; x=1697013872;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SWu3uXKqBq1F/Sv+u1gdviuIqzdA2COq3OTo91Q7s5w=;
 b=TJcWWAZ0nmixwFJid9rMEgk2I6pHjhiaA/gNoZfDYQG0C0t74AmJAt9eLkT+a98YZM
 DRevLeGkdU567FqYEjWlXi162Xk+7eHdmBMUOVxEdBHvnk0bSmN/zKqotyFnADcki9Ti
 K/hyJENzM8a28K5p45jsKxC0mPDtT0iI2fI4UdScuSpXYg3wKNdw1+YzJi/lkIAmdnHa
 uuQBVJjQ5CA2V8gNxNwxyfw2k1Q5QehOW1e565ToL35XMAQWzU9mNzj6Yuyo3HTpturt
 SalZCW8m7YHIJt49lF6UhBbFQMB0cmPSbw9JgevgWof/E3/h93q4HxK2u5dH1MklnpUX
 6LUg==
X-Gm-Message-State: AOJu0YzuawDas6keLtisBmaJKCLru/qKDnNj5dWB00+glqZMt8yOVHmW
 c9RaE13u0/YE11Dw1pbAcSeKUxiuU86wSe303+2lTtg/xqXL5H+uBDvp82RoxtUUiyzjohIXHp3
 Ubw8d+pi7zNmsEHIOuHnq+q7YOqi46Secl9HWM6J6x59InyzkaGNe3ZXzFuZiMq28ziHV
X-Received: by 2002:a5d:4fc1:0:b0:31a:ddf0:93b with SMTP id
 h1-20020a5d4fc1000000b0031addf0093bmr1424531wrw.33.1696409072665; 
 Wed, 04 Oct 2023 01:44:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0QGzYVNEv8Vv8LqwDqfv24FM99LuDIuhMs7bVBfh95we/O8XDpFVQL82SkVwt2M1j1pnTMA==
X-Received: by 2002:a5d:4fc1:0:b0:31a:ddf0:93b with SMTP id
 h1-20020a5d4fc1000000b0031addf0093bmr1424511wrw.33.1696409072320; 
 Wed, 04 Oct 2023 01:44:32 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 o3-20020a5d6843000000b003143867d2ebsm3442865wrw.63.2023.10.04.01.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:31 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/63] vhost-user: factor out "vhost_user_write_sync"
Message-ID: <b5a22daf4123e589caa9e64955094bae6b8e4057.1696408966.git.mst@redhat.com>
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
Message-Id: <20230830134055.106812-4-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-user.c | 66 ++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 38 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index dae16d3b33..06d6df3a98 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1299,10 +1299,35 @@ static int enforce_reply(struct vhost_dev *dev,
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
@@ -1316,24 +1341,7 @@ static int vhost_user_set_vring_addr(struct vhost_dev *dev,
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
@@ -1345,26 +1353,8 @@ static int vhost_user_set_u64(struct vhost_dev *dev, int request, uint64_t u64,
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


