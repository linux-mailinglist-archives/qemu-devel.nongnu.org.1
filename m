Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6037CE1F7
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:59:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vJ-0005R2-2R; Wed, 18 Oct 2023 11:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tg-0002us-Bp
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tc-0006tF-8C
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFZkemHVKMpqq9uyVp58jnRD/h5a0Rr9UNCxOcsmGpE=;
 b=A0KHa+oAntlYqxuZMx3LBkstOkkxX49bS9Hu2msYlGkAZvpGI28/AflWWz2WG4zEmK1zJn
 ohRh+BSyke69+ugse0JNfFt+L+C8Yp8m1FytNbBnrMqMd9UIioX2HB61etSs/2WPN5jKIO
 x1rj+5Zj6b8Y54yotucmtLI3HDQWyvE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-CYRu11aCPhyIrvf7sk4Dkw-1; Wed, 18 Oct 2023 11:55:41 -0400
X-MC-Unique: CYRu11aCPhyIrvf7sk4Dkw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe182913c5so44442475e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644539; x=1698249339;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BFZkemHVKMpqq9uyVp58jnRD/h5a0Rr9UNCxOcsmGpE=;
 b=xRaxN0NeGcAqPKP87V5XZRxDB+gmqpcx4PsRLQNk0zBUWTyBEvbs0m8h9M2UDOhvTk
 dpPS6CFRG9L+CrnLTI0ztH2+Q033Cz17os7P/W0iQg7qP65haqkdcp3EGTR5ePO5EWVr
 3zNJwCPCQscr2EOBiY08xa7y95gtKaLN1nZcR71I0w1GbldC4kpEwT3oL695cbBHfJRQ
 4hReCQ5ogH3yETEEAC18xmhuzCLbVdNihnBp7tYLjbpsISmH8pjcnum7csINbj8rZ0Qk
 2WjV7RJ7jFjyoyn05DPKq66uo27PTMYBUfQ7Y5ZBX37gGUTeMWU3Wi5TOPCpI7pm8h91
 04CQ==
X-Gm-Message-State: AOJu0YyWRixEJw+B3tRYiEtyGPW83nGmeKFOgpJPFsHygqjPUBuPJyNH
 e7l4bvKfKvPM6Fl0VT1CIhfRu/3Pd25nzQuPwzgKkttNZoIdFXNsWz53NqezEZnjEyzMZhZX3ET
 uyICWcxQIpwcdhs/xpnfgkoJdEogKrfR//He+Q3nyHYOdd1A6viplUzogNGuKUjQvGS4ZJy0=
X-Received: by 2002:a05:600c:1ca3:b0:407:5b54:bb10 with SMTP id
 k35-20020a05600c1ca300b004075b54bb10mr4448954wms.8.1697644539649; 
 Wed, 18 Oct 2023 08:55:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9vn47qs5u2wQGVPlcEdtlfp7ssigDL5o3gKQgrl/2iQk0eh1sr8rXi1faTv6c0rdUZTpm/Q==
X-Received: by 2002:a05:600c:1ca3:b0:407:5b54:bb10 with SMTP id
 k35-20020a05600c1ca300b004075b54bb10mr4448926wms.8.1697644539202; 
 Wed, 18 Oct 2023 08:55:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a05600c4ed300b003fefaf299b6sm2053484wmq.38.2023.10.18.08.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:55:38 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:55:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PULL 31/83] vhost-user: factor out "vhost_user_write_sync"
Message-ID: <a5c395913c02a0cc2990dcda1225d3006c60190a.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


