Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A36C7D01DC
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:37:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhI-0000J9-N5; Thu, 19 Oct 2023 14:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfD-0006Ol-2F
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfA-0000lB-1i
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFZkemHVKMpqq9uyVp58jnRD/h5a0Rr9UNCxOcsmGpE=;
 b=JQC7bAnfRwWQSEkMvFeEL0qGTVETn2WF9D+VhYsZGrN+h2Az70RHb8+zEHi6adWBoAjre+
 HteSQPDEwp1SDyVKY0isrPAp/u4GkiGWJtWKQjnrRINkFqAlbGkJpCCBHfsA1Iyn6M0aWg
 HNHDhHpWLkhQ5MD1dIpadgZUNqIPfl4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-7Bqu0No4PTOf0E223IdTIw-1; Thu, 19 Oct 2023 14:22:24 -0400
X-MC-Unique: 7Bqu0No4PTOf0E223IdTIw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32d83fd3765so4899147f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739743; x=1698344543;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BFZkemHVKMpqq9uyVp58jnRD/h5a0Rr9UNCxOcsmGpE=;
 b=FmikO6thDzeYfYv3hu5QzJ+zoDSOf2t5RLuWckc0IS86qPF1tY+5U92tIYdlQfMaYm
 JJ0a59IjXaM/Q1QqbyeW8peqNNgq39eAiAlupUJCdk1fhpKgOfIk9PKq7+X4A32+2IlF
 /RLd5I4KiHQORQ3AgJ9rqVvVfjsY1SdgWbF3t/0XLCNyc2o9srd4jYQ4uKg13f9wLNyp
 UlC6iaZq5G9oePcg0UcFMKq+QRPd/puLlsS1wcD3JilYokf/1OOn32ijiilrLshEVi6y
 Qwp0PXA28+3K0zNt+WLl6ZDNY2v+c63WvIlLQfETM1BuMKQHlC6+6SJpbSuRuiLc6hP0
 Xz7Q==
X-Gm-Message-State: AOJu0YwtQbi9sUbZkfWbvj9e4P0K5ZXqu038u/nxI6i9Ig1ZpoLVm7u7
 U9ZlS7gvjma+u9SAS9KXudUtWfLA2AuDHmypxOuwzoMLd3+HKtEu1J4lgehQaL5YXAy70eYQCU2
 TfdKX34tPUCM99/kgDpJMB2UPn/fyBsccFYkT/CVJ4hc63mLfRDaQnFUocSfhZtxxg6Ku
X-Received: by 2002:adf:f2c6:0:b0:32d:ccde:73a0 with SMTP id
 d6-20020adff2c6000000b0032dccde73a0mr2102919wrp.33.1697739742864; 
 Thu, 19 Oct 2023 11:22:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZI+mq0ZKtX0zYOF388GOcD9VpjKIrKCcGNiHRBMALhajjnkgJlG3C3pJFVTcgo061P0JpnA==
X-Received: by 2002:adf:f2c6:0:b0:32d:ccde:73a0 with SMTP id
 d6-20020adff2c6000000b0032dccde73a0mr2102901wrp.33.1697739742541; 
 Thu, 19 Oct 2023 11:22:22 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a5d614f000000b003142e438e8csm4986748wrt.26.2023.10.19.11.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:22 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PULL v2 26/78] vhost-user: factor out "vhost_user_write_sync"
Message-ID: <7c8be448c483f01c32021ccee4ba09ef0a69ff3e.1697739629.git.mst@redhat.com>
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


