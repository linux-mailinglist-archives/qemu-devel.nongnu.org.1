Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A05B276C906
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 11:10:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR7qe-0006kR-QX; Wed, 02 Aug 2023 05:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qR7qc-0006jy-Ns
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 05:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qR7qb-00033n-Av
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 05:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690967328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JkiqsKylIZlvXh3kaYOpYtJxuBz1KH8YHaezHvWOck=;
 b=DhKT8PrecGanGTGyQqnXdEfPevAfnnGzsxByudh24qOxSDRfVm70a0v4VOadxyx6Gq62YL
 8SE4DNaT7QxSeNBNQap9K14UfCaWTMQJ9yYrpHF8NWePNSkZfW4J6Fbpz6IGt6Z4ta2QIN
 jzAGNyIxYXa4TO7c68am4Qo2OZMj58g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-xf6tPGNwPhuQuh6I-d9lYQ-1; Wed, 02 Aug 2023 05:08:44 -0400
X-MC-Unique: xf6tPGNwPhuQuh6I-d9lYQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9976830EEA;
 Wed,  2 Aug 2023 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.226.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2184F40C2063;
 Wed,  2 Aug 2023 09:08:41 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, kraxel@redhat.com, cohuck@redhat.com,
 Albert Esteve <aesteve@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 4/4] vhost-user: refactor send_resp code
Date: Wed,  2 Aug 2023 11:08:24 +0200
Message-Id: <20230802090824.91688-5-aesteve@redhat.com>
In-Reply-To: <20230802090824.91688-1-aesteve@redhat.com>
References: <20230802090824.91688-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
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

Refactor code to send response message so that
all common parts both for the common REPLY_ACK
case, and other data responses, can call it and
avoid code repetition.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c | 36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 104a56a48d..28fa0ace42 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1632,29 +1632,23 @@ vhost_user_backend_handle_shared_object_remove(VhostUserShared *object)
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
 
@@ -1834,22 +1828,10 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
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


