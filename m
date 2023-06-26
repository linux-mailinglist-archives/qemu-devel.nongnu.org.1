Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 847E473D89F
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 09:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDgkf-0003Hi-ID; Mon, 26 Jun 2023 03:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qDgkO-0003Gy-Ca
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qDgkM-0007Bt-K7
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687764890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQ20tqluCUPiBweXBreptWK4nKIzY34W/6VGJH4xikg=;
 b=K/n+Q9gxLJy5juuRi3t9CcoeVWsEDNRO1SZQiik6u0XWdxfELakL4W1roHnYDXhxe7VQSc
 0P7p16APfLBRkfkjIFGFYWTcjGucWILWMiw8nSnG4FOjwNdVVy9Mt0neA8zC5ZdRUuHiuS
 KR/arsT3Mr/zQgJ8gS6B4EBtps39eKo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-47_6e2b2N-2oKOY1nX8bkQ-1; Mon, 26 Jun 2023 03:34:43 -0400
X-MC-Unique: 47_6e2b2N-2oKOY1nX8bkQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7A6A80027F;
 Mon, 26 Jun 2023 07:34:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64EC3492B03;
 Mon, 26 Jun 2023 07:34:41 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
 cohuck@redhat.com, Albert Esteve <aesteve@redhat.com>,
 Fam Zheng <fam@euphon.net>, kraxel@redhat.com
Subject: [PATCH v4 4/4] vhost-user: refactor send_resp code
Date: Mon, 26 Jun 2023 09:34:26 +0200
Message-Id: <20230626073426.285659-5-aesteve@redhat.com>
In-Reply-To: <20230626073426.285659-1-aesteve@redhat.com>
References: <20230626073426.285659-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Refactor code to send response message so that
all common parts both for the common REPLY_ACK
case, and other data responses, can call it and
avoid code repetition.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c | 44 ++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e340c39a19..f2b224b5a3 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1612,32 +1612,34 @@ vhost_user_backend_handle_shared_object_remove(VhostUserShared *object)
     return virtio_remove_resource(&uuid);
 }
 
-static bool
-vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
-                                  VhostUserPayload *payload)
+static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
+                                 VhostUserPayload *payload)
 {
     Error *local_err = NULL;
-    struct iovec iov[2];
+    struct iovec iov[] = {
+        { .iov_base = hdr,      .iov_len = VHOST_USER_HDR_SIZE },
+        { .iov_base = payload,  .iov_len = hdr->size },
+    };
 
-    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
-        hdr->flags &= ~VHOST_USER_NEED_REPLY_MASK;
-    }
+    hdr->flags &= ~VHOST_USER_NEED_REPLY_MASK;
     hdr->flags |= VHOST_USER_REPLY_MASK;
 
-    hdr->size = sizeof(payload->u64);
-
-    iov[0].iov_base = hdr;
-    iov[0].iov_len = VHOST_USER_HDR_SIZE;
-    iov[1].iov_base = payload;
-    iov[1].iov_len = hdr->size;
-
     if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), &local_err)) {
         error_report_err(local_err);
         return false;
     }
+
     return true;
 }
 
+static bool
+vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
+                                  VhostUserPayload *payload)
+{
+    hdr->size = sizeof(payload->u64);
+    return vhost_user_send_resp(ioc, hdr, payload);
+}
+
 static int
 vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
                                                QIOChannel *ioc,
@@ -1748,22 +1750,10 @@ static gboolean slave_read(QIOChannel *ioc, GIOCondition condition,
      * directly in their request handlers.
      */
     if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
-        struct iovec iovec[2];
-
-
-        hdr.flags &= ~VHOST_USER_NEED_REPLY_MASK;
-        hdr.flags |= VHOST_USER_REPLY_MASK;
-
         payload.u64 = !!ret;
         hdr.size = sizeof(payload.u64);
 
-        iovec[0].iov_base = &hdr;
-        iovec[0].iov_len = VHOST_USER_HDR_SIZE;
-        iovec[1].iov_base = &payload;
-        iovec[1].iov_len = hdr.size;
-
-        if (qio_channel_writev_all(ioc, iovec, ARRAY_SIZE(iovec), &local_err)) {
-            error_report_err(local_err);
+        if (!vhost_user_send_resp(ioc, &hdr, &payload)) {
             goto err;
         }
     }
-- 
2.40.0


