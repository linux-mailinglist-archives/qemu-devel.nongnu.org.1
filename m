Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7BF728218
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:03:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7G8v-0004Al-GP; Thu, 08 Jun 2023 09:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8h-0003zD-30
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8W-0004ij-3j
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686232631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3DYKItSwWR3iyEC+tg0viVd+KWSPt5/xGn1VBX3nNAk=;
 b=AjPwdGaclFCJ9SA2lYVfCPdhLGeIU1F9DHBr3J7Xo2BP0919LCNHchPkPK0JbUdMtuUr33
 mDmeMd/TN2vRn0emqg0HH5INBQH+yVbj3OwmJ/2Qld+HvtyxpnmXwSK9mLWl3fcb79npUa
 pefCeuhWYmh+G/YmoLPsX9LnfOQbaGk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-M1TeW60WNMGZFsCPIhZM-w-1; Thu, 08 Jun 2023 09:57:08 -0400
X-MC-Unique: M1TeW60WNMGZFsCPIhZM-w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CCA43C1C4DF;
 Thu,  8 Jun 2023 13:57:07 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 350A7492B00;
 Thu,  8 Jun 2023 13:57:07 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	libguestfs@redhat.com,
	vsementsov@yandex-team.ru
Subject: [PATCH v4 15/24] nbd/server: Prepare to send extended header replies
Date: Thu,  8 Jun 2023 08:56:44 -0500
Message-Id: <20230608135653.2918540-16-eblake@redhat.com>
In-Reply-To: <20230608135653.2918540-1-eblake@redhat.com>
References: <20230608135653.2918540-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Although extended mode is not yet enabled, once we do turn it on, we
need to reply with extended headers to all messages.  Update the low
level entry points necessary so that all other callers automatically
get the right header based on the current mode.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v4: new patch, split out from v3 9/14
---
 nbd/server.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 119ac765f09..84c848a31d3 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1947,8 +1947,6 @@ static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
                                 size_t niov, uint16_t flags, uint16_t type,
                                 NBDRequest *request)
 {
-    /* TODO - handle structured vs. extended replies */
-    NBDStructuredReplyChunk *chunk = iov->iov_base;
     size_t i, length = 0;

     for (i = 1; i < niov; i++) {
@@ -1956,12 +1954,26 @@ static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
     }
     assert(length <= NBD_MAX_BUFFER_SIZE + sizeof(NBDStructuredReadData));

-    iov[0].iov_len = sizeof(*chunk);
-    stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
-    stw_be_p(&chunk->flags, flags);
-    stw_be_p(&chunk->type, type);
-    stq_be_p(&chunk->cookie, request->cookie);
-    stl_be_p(&chunk->length, length);
+    if (client->mode >= NBD_MODE_EXTENDED) {
+        NBDExtendedReplyChunk *chunk = iov->iov_base;
+
+        iov->iov_len = sizeof(*chunk);
+        stl_be_p(&chunk->magic, NBD_EXTENDED_REPLY_MAGIC);
+        stw_be_p(&chunk->flags, flags);
+        stw_be_p(&chunk->type, type);
+        stq_be_p(&chunk->cookie, request->cookie);
+        stq_be_p(&chunk->offset, request->from);
+        stq_be_p(&chunk->length, length);
+    } else {
+        NBDStructuredReplyChunk *chunk = iov->iov_base;
+
+        iov->iov_len = sizeof(*chunk);
+        stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
+        stw_be_p(&chunk->flags, flags);
+        stw_be_p(&chunk->type, type);
+        stq_be_p(&chunk->cookie, request->cookie);
+        stl_be_p(&chunk->length, length);
+    }
 }

 static int coroutine_fn nbd_co_send_chunk_done(NBDClient *client,
@@ -2478,6 +2490,8 @@ static coroutine_fn int nbd_send_generic_reply(NBDClient *client,
 {
     if (client->mode >= NBD_MODE_STRUCTURED && ret < 0) {
         return nbd_co_send_chunk_error(client, request, -ret, error_msg, errp);
+    } else if (client->mode >= NBD_MODE_EXTENDED) {
+        return nbd_co_send_chunk_done(client, request, errp);
     } else {
         return nbd_co_send_simple_reply(client, request, ret < 0 ? -ret : 0,
                                         NULL, 0, errp);
-- 
2.40.1


