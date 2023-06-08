Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6702A728205
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:00:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7G8s-00046Y-P2; Thu, 08 Jun 2023 09:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8V-0003tS-PH
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8P-0004fV-Up
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686232624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IgsQCbf4Afh0t8ydIDvREGK4BuwUFiJk6zgi5cfEUZA=;
 b=AEZVtBgzPyJRSO0/VeQ+fm7qZti5+Q32By2Mx771ESPOGm2ueQa7a+Jfbh0EMMEydqBKX+
 YV5Zk6KxdKb9XRP9Z6a2FXEG0trTGN5Jtc68k0u4PDvMfOg+ZmKm1Ha7LDiCHyAZEF9oiL
 ApLVA4S7QQCGyclaYbPcRtsHlMvM3J4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-HN7QS0-BMyyU_fwBuzLeCA-1; Thu, 08 Jun 2023 09:57:00 -0400
X-MC-Unique: HN7QS0-BMyyU_fwBuzLeCA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ACAF803471;
 Thu,  8 Jun 2023 13:57:00 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D45D7515543;
 Thu,  8 Jun 2023 13:56:59 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 05/24] nbd: s/handle/cookie/ to match NBD spec
Date: Thu,  8 Jun 2023 08:56:34 -0500
Message-Id: <20230608135653.2918540-6-eblake@redhat.com>
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

Externally, libnbd exposed the 64-bit opaque marker for each client
NBD packet as the "cookie", because it was less confusing when
contrasted with 'struct nbd_handle *' holding all libnbd state.  It
also avoids confusion between the nown 'handle' as a way to identify a
packet and the verb 'handle' for reacting to things like signals.
Upstream NBD changed their spec to favor the name "cookie" based on
libnbd's recommendations[1], so we can do likewise.

[1] https://github.com/NetworkBlockDevice/nbd/commit/ca4392eb2b

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v4: new patch
---
 include/block/nbd.h | 11 +++---
 block/nbd.c         | 96 +++++++++++++++++++++++----------------------
 nbd/client.c        | 14 +++----
 nbd/server.c        | 29 +++++++-------
 nbd/trace-events    | 22 +++++------
 5 files changed, 87 insertions(+), 85 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index e563f1774b0..59db69bafa5 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -58,7 +58,7 @@ typedef struct NBDOptionReplyMetaContext {
  * request and reply!
  */
 typedef struct NBDRequest {
-    uint64_t handle;
+    uint64_t cookie;
     uint64_t from;
     uint32_t len;
     uint16_t flags; /* NBD_CMD_FLAG_* */
@@ -68,7 +68,7 @@ typedef struct NBDRequest {
 typedef struct NBDSimpleReply {
     uint32_t magic;  /* NBD_SIMPLE_REPLY_MAGIC */
     uint32_t error;
-    uint64_t handle;
+    uint64_t cookie;
 } QEMU_PACKED NBDSimpleReply;

 /* Header of all structured replies */
@@ -76,7 +76,7 @@ typedef struct NBDStructuredReplyChunk {
     uint32_t magic;  /* NBD_STRUCTURED_REPLY_MAGIC */
     uint16_t flags;  /* combination of NBD_REPLY_FLAG_* */
     uint16_t type;   /* NBD_REPLY_TYPE_* */
-    uint64_t handle; /* request handle */
+    uint64_t cookie; /* request handle */
     uint32_t length; /* length of payload */
 } QEMU_PACKED NBDStructuredReplyChunk;

@@ -84,13 +84,14 @@ typedef union NBDReply {
     NBDSimpleReply simple;
     NBDStructuredReplyChunk structured;
     struct {
-        /* @magic and @handle fields have the same offset and size both in
+        /*
+         * @magic and @cookie fields have the same offset and size both in
          * simple reply and structured reply chunk, so let them be accessible
          * without ".simple." or ".structured." specification
          */
         uint32_t magic;
         uint32_t _skip;
-        uint64_t handle;
+        uint64_t cookie;
     } QEMU_PACKED;
 } NBDReply;

diff --git a/block/nbd.c b/block/nbd.c
index 5aef5cb6bd5..be3c46c6fee 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1,8 +1,8 @@
 /*
- * QEMU Block driver for  NBD
+ * QEMU Block driver for NBD
  *
  * Copyright (c) 2019 Virtuozzo International GmbH.
- * Copyright (C) 2016 Red Hat, Inc.
+ * Copyright Red Hat
  * Copyright (C) 2008 Bull S.A.S.
  *     Author: Laurent Vivier <Laurent.Vivier@bull.net>
  *
@@ -50,8 +50,8 @@
 #define EN_OPTSTR ":exportname="
 #define MAX_NBD_REQUESTS    16

-#define HANDLE_TO_INDEX(bs, handle) ((handle) ^ (uint64_t)(intptr_t)(bs))
-#define INDEX_TO_HANDLE(bs, index)  ((index)  ^ (uint64_t)(intptr_t)(bs))
+#define COOKIE_TO_INDEX(bs, cookie) ((cookie) ^ (uint64_t)(intptr_t)(bs))
+#define INDEX_TO_COOKIE(bs, index)  ((index)  ^ (uint64_t)(intptr_t)(bs))

 typedef struct {
     Coroutine *coroutine;
@@ -417,25 +417,25 @@ static void coroutine_fn GRAPH_RDLOCK nbd_reconnect_attempt(BDRVNBDState *s)
     reconnect_delay_timer_del(s);
 }

-static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t handle)
+static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie)
 {
     int ret;
-    uint64_t ind = HANDLE_TO_INDEX(s, handle), ind2;
+    uint64_t ind = COOKIE_TO_INDEX(s, cookie), ind2;
     QEMU_LOCK_GUARD(&s->receive_mutex);

     while (true) {
-        if (s->reply.handle == handle) {
+        if (s->reply.cookie == cookie) {
             /* We are done */
             return 0;
         }

-        if (s->reply.handle != 0) {
+        if (s->reply.cookie != 0) {
             /*
              * Some other request is being handled now. It should already be
-             * woken by whoever set s->reply.handle (or never wait in this
+             * woken by whoever set s->reply.cookie (or never wait in this
              * yield). So, we should not wake it here.
              */
-            ind2 = HANDLE_TO_INDEX(s, s->reply.handle);
+            ind2 = COOKIE_TO_INDEX(s, s->reply.cookie);
             assert(!s->requests[ind2].receiving);

             s->requests[ind].receiving = true;
@@ -445,9 +445,9 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t handle)
             /*
              * We may be woken for 2 reasons:
              * 1. From this function, executing in parallel coroutine, when our
-             *    handle is received.
+             *    cookie is received.
              * 2. From nbd_co_receive_one_chunk(), when previous request is
-             *    finished and s->reply.handle set to 0.
+             *    finished and s->reply.cookie set to 0.
              * Anyway, it's OK to lock the mutex and go to the next iteration.
              */

@@ -456,8 +456,8 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t handle)
             continue;
         }

-        /* We are under mutex and handle is 0. We have to do the dirty work. */
-        assert(s->reply.handle == 0);
+        /* We are under mutex and cookie is 0. We have to do the dirty work. */
+        assert(s->reply.cookie == 0);
         ret = nbd_receive_reply(s->bs, s->ioc, &s->reply, NULL);
         if (ret <= 0) {
             ret = ret ? ret : -EIO;
@@ -468,12 +468,12 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t handle)
             nbd_channel_error(s, -EINVAL);
             return -EINVAL;
         }
-        ind2 = HANDLE_TO_INDEX(s, s->reply.handle);
+        ind2 = COOKIE_TO_INDEX(s, s->reply.cookie);
         if (ind2 >= MAX_NBD_REQUESTS || !s->requests[ind2].coroutine) {
             nbd_channel_error(s, -EINVAL);
             return -EINVAL;
         }
-        if (s->reply.handle == handle) {
+        if (s->reply.cookie == cookie) {
             /* We are done */
             return 0;
         }
@@ -519,7 +519,7 @@ nbd_co_send_request(BlockDriverState *bs, NBDRequest *request,
     qemu_mutex_unlock(&s->requests_lock);

     qemu_co_mutex_lock(&s->send_mutex);
-    request->handle = INDEX_TO_HANDLE(s, i);
+    request->cookie = INDEX_TO_COOKIE(s, i);

     assert(s->ioc);

@@ -828,11 +828,11 @@ static coroutine_fn int nbd_co_receive_structured_payload(
  * corresponding to the server's error reply), and errp is unchanged.
  */
 static coroutine_fn int nbd_co_do_receive_one_chunk(
-        BDRVNBDState *s, uint64_t handle, bool only_structured,
+        BDRVNBDState *s, uint64_t cookie, bool only_structured,
         int *request_ret, QEMUIOVector *qiov, void **payload, Error **errp)
 {
     int ret;
-    int i = HANDLE_TO_INDEX(s, handle);
+    int i = COOKIE_TO_INDEX(s, cookie);
     void *local_payload = NULL;
     NBDStructuredReplyChunk *chunk;

@@ -841,14 +841,14 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     }
     *request_ret = 0;

-    ret = nbd_receive_replies(s, handle);
+    ret = nbd_receive_replies(s, cookie);
     if (ret < 0) {
         error_setg(errp, "Connection closed");
         return -EIO;
     }
     assert(s->ioc);

-    assert(s->reply.handle == handle);
+    assert(s->reply.cookie == cookie);

     if (nbd_reply_is_simple(&s->reply)) {
         if (only_structured) {
@@ -918,11 +918,11 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
  * Return value is a fatal error code or normal nbd reply error code
  */
 static coroutine_fn int nbd_co_receive_one_chunk(
-        BDRVNBDState *s, uint64_t handle, bool only_structured,
+        BDRVNBDState *s, uint64_t cookie, bool only_structured,
         int *request_ret, QEMUIOVector *qiov, NBDReply *reply, void **payload,
         Error **errp)
 {
-    int ret = nbd_co_do_receive_one_chunk(s, handle, only_structured,
+    int ret = nbd_co_do_receive_one_chunk(s, cookie, only_structured,
                                           request_ret, qiov, payload, errp);

     if (ret < 0) {
@@ -932,7 +932,7 @@ static coroutine_fn int nbd_co_receive_one_chunk(
         /* For assert at loop start in nbd_connection_entry */
         *reply = s->reply;
     }
-    s->reply.handle = 0;
+    s->reply.cookie = 0;

     nbd_recv_coroutines_wake(s);

@@ -975,10 +975,10 @@ static void nbd_iter_request_error(NBDReplyChunkIter *iter, int ret)
  * NBD_FOREACH_REPLY_CHUNK
  * The pointer stored in @payload requires g_free() to free it.
  */
-#define NBD_FOREACH_REPLY_CHUNK(s, iter, handle, structured, \
+#define NBD_FOREACH_REPLY_CHUNK(s, iter, cookie, structured, \
                                 qiov, reply, payload) \
     for (iter = (NBDReplyChunkIter) { .only_structured = structured }; \
-         nbd_reply_chunk_iter_receive(s, &iter, handle, qiov, reply, payload);)
+         nbd_reply_chunk_iter_receive(s, &iter, cookie, qiov, reply, payload);)

 /*
  * nbd_reply_chunk_iter_receive
@@ -986,7 +986,7 @@ static void nbd_iter_request_error(NBDReplyChunkIter *iter, int ret)
  */
 static bool coroutine_fn nbd_reply_chunk_iter_receive(BDRVNBDState *s,
                                                       NBDReplyChunkIter *iter,
-                                                      uint64_t handle,
+                                                      uint64_t cookie,
                                                       QEMUIOVector *qiov,
                                                       NBDReply *reply,
                                                       void **payload)
@@ -1005,7 +1005,7 @@ static bool coroutine_fn nbd_reply_chunk_iter_receive(BDRVNBDState *s,
         reply = &local_reply;
     }

-    ret = nbd_co_receive_one_chunk(s, handle, iter->only_structured,
+    ret = nbd_co_receive_one_chunk(s, cookie, iter->only_structured,
                                    &request_ret, qiov, reply, payload,
                                    &local_err);
     if (ret < 0) {
@@ -1038,7 +1038,7 @@ static bool coroutine_fn nbd_reply_chunk_iter_receive(BDRVNBDState *s,

 break_loop:
     qemu_mutex_lock(&s->requests_lock);
-    s->requests[HANDLE_TO_INDEX(s, handle)].coroutine = NULL;
+    s->requests[COOKIE_TO_INDEX(s, cookie)].coroutine = NULL;
     s->in_flight--;
     qemu_co_queue_next(&s->free_sema);
     qemu_mutex_unlock(&s->requests_lock);
@@ -1046,12 +1046,13 @@ break_loop:
     return false;
 }

-static int coroutine_fn nbd_co_receive_return_code(BDRVNBDState *s, uint64_t handle,
-                                                   int *request_ret, Error **errp)
+static int coroutine_fn
+nbd_co_receive_return_code(BDRVNBDState *s, uint64_t cookie,
+                           int *request_ret, Error **errp)
 {
     NBDReplyChunkIter iter;

-    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, NULL, NULL) {
+    NBD_FOREACH_REPLY_CHUNK(s, iter, cookie, false, NULL, NULL, NULL) {
         /* nbd_reply_chunk_iter_receive does all the work */
     }

@@ -1060,16 +1061,17 @@ static int coroutine_fn nbd_co_receive_return_code(BDRVNBDState *s, uint64_t han
     return iter.ret;
 }

-static int coroutine_fn nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t handle,
-                                                     uint64_t offset, QEMUIOVector *qiov,
-                                                     int *request_ret, Error **errp)
+static int coroutine_fn
+nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,
+                             uint64_t offset, QEMUIOVector *qiov,
+                             int *request_ret, Error **errp)
 {
     NBDReplyChunkIter iter;
     NBDReply reply;
     void *payload = NULL;
     Error *local_err = NULL;

-    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, s->info.structured_reply,
+    NBD_FOREACH_REPLY_CHUNK(s, iter, cookie, s->info.structured_reply,
                             qiov, &reply, &payload)
     {
         int ret;
@@ -1112,10 +1114,10 @@ static int coroutine_fn nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t h
     return iter.ret;
 }

-static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
-                                                         uint64_t handle, uint64_t length,
-                                                         NBDExtent *extent,
-                                                         int *request_ret, Error **errp)
+static int coroutine_fn
+nbd_co_receive_blockstatus_reply(BDRVNBDState *s, uint64_t cookie,
+                                 uint64_t length, NBDExtent *extent,
+                                 int *request_ret, Error **errp)
 {
     NBDReplyChunkIter iter;
     NBDReply reply;
@@ -1124,7 +1126,7 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
     bool received = false;

     assert(!extent->length);
-    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, &reply, &payload) {
+    NBD_FOREACH_REPLY_CHUNK(s, iter, cookie, false, NULL, &reply, &payload) {
         int ret;
         NBDStructuredReplyChunk *chunk = &reply.structured;

@@ -1194,11 +1196,11 @@ nbd_co_request(BlockDriverState *bs, NBDRequest *request,
             continue;
         }

-        ret = nbd_co_receive_return_code(s, request->handle,
+        ret = nbd_co_receive_return_code(s, request->cookie,
                                          &request_ret, &local_err);
         if (local_err) {
             trace_nbd_co_request_fail(request->from, request->len,
-                                      request->handle, request->flags,
+                                      request->cookie, request->flags,
                                       request->type,
                                       nbd_cmd_lookup(request->type),
                                       ret, error_get_pretty(local_err));
@@ -1253,10 +1255,10 @@ nbd_client_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
             continue;
         }

-        ret = nbd_co_receive_cmdread_reply(s, request.handle, offset, qiov,
+        ret = nbd_co_receive_cmdread_reply(s, request.cookie, offset, qiov,
                                            &request_ret, &local_err);
         if (local_err) {
-            trace_nbd_co_request_fail(request.from, request.len, request.handle,
+            trace_nbd_co_request_fail(request.from, request.len, request.cookie,
                                       request.flags, request.type,
                                       nbd_cmd_lookup(request.type),
                                       ret, error_get_pretty(local_err));
@@ -1411,11 +1413,11 @@ static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
             continue;
         }

-        ret = nbd_co_receive_blockstatus_reply(s, request.handle, bytes,
+        ret = nbd_co_receive_blockstatus_reply(s, request.cookie, bytes,
                                                &extent, &request_ret,
                                                &local_err);
         if (local_err) {
-            trace_nbd_co_request_fail(request.from, request.len, request.handle,
+            trace_nbd_co_request_fail(request.from, request.len, request.cookie,
                                       request.flags, request.type,
                                       nbd_cmd_lookup(request.type),
                                       ret, error_get_pretty(local_err));
diff --git a/nbd/client.c b/nbd/client.c
index ff75722e487..ea3590ca3d0 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2019 Red Hat, Inc.
+ *  Copyright Red Hat
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device Client Side
@@ -1350,14 +1350,14 @@ int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
 {
     uint8_t buf[NBD_REQUEST_SIZE];

-    trace_nbd_send_request(request->from, request->len, request->handle,
+    trace_nbd_send_request(request->from, request->len, request->cookie,
                            request->flags, request->type,
                            nbd_cmd_lookup(request->type));

     stl_be_p(buf, NBD_REQUEST_MAGIC);
     stw_be_p(buf + 4, request->flags);
     stw_be_p(buf + 6, request->type);
-    stq_be_p(buf + 8, request->handle);
+    stq_be_p(buf + 8, request->cookie);
     stq_be_p(buf + 16, request->from);
     stl_be_p(buf + 24, request->len);

@@ -1383,7 +1383,7 @@ static int nbd_receive_simple_reply(QIOChannel *ioc, NBDSimpleReply *reply,
     }

     reply->error = be32_to_cpu(reply->error);
-    reply->handle = be64_to_cpu(reply->handle);
+    reply->cookie = be64_to_cpu(reply->cookie);

     return 0;
 }
@@ -1410,7 +1410,7 @@ static int nbd_receive_structured_reply_chunk(QIOChannel *ioc,

     chunk->flags = be16_to_cpu(chunk->flags);
     chunk->type = be16_to_cpu(chunk->type);
-    chunk->handle = be64_to_cpu(chunk->handle);
+    chunk->cookie = be64_to_cpu(chunk->cookie);
     chunk->length = be32_to_cpu(chunk->length);

     return 0;
@@ -1487,7 +1487,7 @@ int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc,
         }
         trace_nbd_receive_simple_reply(reply->simple.error,
                                        nbd_err_lookup(reply->simple.error),
-                                       reply->handle);
+                                       reply->cookie);
         break;
     case NBD_STRUCTURED_REPLY_MAGIC:
         ret = nbd_receive_structured_reply_chunk(ioc, &reply->structured, errp);
@@ -1497,7 +1497,7 @@ int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc,
         type = nbd_reply_type_lookup(reply->structured.type);
         trace_nbd_receive_structured_reply_chunk(reply->structured.flags,
                                                  reply->structured.type, type,
-                                                 reply->structured.handle,
+                                                 reply->structured.cookie,
                                                  reply->structured.length);
         break;
     default:
diff --git a/nbd/server.c b/nbd/server.c
index 26b27d69202..8486b64b15d 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1428,7 +1428,7 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
        [ 0 ..  3]   magic   (NBD_REQUEST_MAGIC)
        [ 4 ..  5]   flags   (NBD_CMD_FLAG_FUA, ...)
        [ 6 ..  7]   type    (NBD_CMD_READ, ...)
-       [ 8 .. 15]   handle
+       [ 8 .. 15]   cookie
        [16 .. 23]   from
        [24 .. 27]   len
      */
@@ -1436,7 +1436,7 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
     magic = ldl_be_p(buf);
     request->flags  = lduw_be_p(buf + 4);
     request->type   = lduw_be_p(buf + 6);
-    request->handle = ldq_be_p(buf + 8);
+    request->cookie = ldq_be_p(buf + 8);
     request->from   = ldq_be_p(buf + 16);
     request->len    = ldl_be_p(buf + 24);

@@ -1885,11 +1885,11 @@ static int coroutine_fn nbd_co_send_iov(NBDClient *client, struct iovec *iov,
 }

 static inline void set_be_simple_reply(NBDSimpleReply *reply, uint64_t error,
-                                       uint64_t handle)
+                                       uint64_t cookie)
 {
     stl_be_p(&reply->magic, NBD_SIMPLE_REPLY_MAGIC);
     stl_be_p(&reply->error, error);
-    stq_be_p(&reply->handle, handle);
+    stq_be_p(&reply->cookie, cookie);
 }

 static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
@@ -1908,9 +1908,9 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,

     assert(!len || !nbd_err);
     assert(!client->structured_reply || request->type != NBD_CMD_READ);
-    trace_nbd_co_send_simple_reply(request->handle, nbd_err,
+    trace_nbd_co_send_simple_reply(request->cookie, nbd_err,
                                    nbd_err_lookup(nbd_err), len);
-    set_be_simple_reply(&reply, nbd_err, request->handle);
+    set_be_simple_reply(&reply, nbd_err, request->cookie);

     return nbd_co_send_iov(client, iov, 2, errp);
 }
@@ -1940,7 +1940,7 @@ static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
     stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
     stw_be_p(&chunk->flags, flags);
     stw_be_p(&chunk->type, type);
-    stq_be_p(&chunk->handle, request->handle);
+    stq_be_p(&chunk->cookie, request->cookie);
     stl_be_p(&chunk->length, length);
 }

@@ -1953,10 +1953,9 @@ static int coroutine_fn nbd_co_send_chunk_done(NBDClient *client,
         {.iov_base = &hdr},
     };

-    trace_nbd_co_send_chunk_done(request->handle);
+    trace_nbd_co_send_chunk_done(request->cookie);
     set_be_chunk(client, iov, 1, NBD_REPLY_FLAG_DONE,
                  NBD_REPLY_TYPE_NONE, request);
-
     return nbd_co_send_iov(client, iov, 1, errp);
 }

@@ -1977,7 +1976,7 @@ static int coroutine_fn nbd_co_send_chunk_read(NBDClient *client,
     };

     assert(size);
-    trace_nbd_co_send_chunk_read(request->handle, offset, data, size);
+    trace_nbd_co_send_chunk_read(request->cookie, offset, data, size);
     set_be_chunk(client, iov, 3, final ? NBD_REPLY_FLAG_DONE : 0,
                  NBD_REPLY_TYPE_OFFSET_DATA, request);
     stq_be_p(&chunk.offset, offset);
@@ -2001,7 +2000,7 @@ static int coroutine_fn nbd_co_send_chunk_error(NBDClient *client,
     };

     assert(nbd_err);
-    trace_nbd_co_send_chunk_error(request->handle, nbd_err,
+    trace_nbd_co_send_chunk_error(request->cookie, nbd_err,
                                   nbd_err_lookup(nbd_err), msg ? msg : "");
     set_be_chunk(client, iov, 3, NBD_REPLY_FLAG_DONE,
                  NBD_REPLY_TYPE_ERROR, request);
@@ -2052,7 +2051,7 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
                 {.iov_base = &chunk, .iov_len = sizeof(chunk)},
             };

-            trace_nbd_co_send_chunk_read_hole(request->handle,
+            trace_nbd_co_send_chunk_read_hole(request->cookie,
                                               offset + progress, pnum);
             set_be_chunk(client, iov, 2,
                          final ? NBD_REPLY_FLAG_DONE : 0,
@@ -2234,7 +2233,7 @@ nbd_co_send_extents(NBDClient *client, NBDRequest *request, NBDExtentArray *ea,

     nbd_extent_array_convert_to_be(ea);

-    trace_nbd_co_send_extents(request->handle, ea->count, context_id,
+    trace_nbd_co_send_extents(request->cookie, ea->count, context_id,
                               ea->total_length, last);
     set_be_chunk(client, iov, 3, last ? NBD_REPLY_FLAG_DONE : 0,
                  NBD_REPLY_TYPE_BLOCK_STATUS, request);
@@ -2337,7 +2336,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
         return ret;
     }

-    trace_nbd_co_receive_request_decode_type(request->handle, request->type,
+    trace_nbd_co_receive_request_decode_type(request->cookie, request->type,
                                              nbd_cmd_lookup(request->type));

     if (request->type != NBD_CMD_WRITE) {
@@ -2378,7 +2377,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
         }
         req->complete = true;

-        trace_nbd_co_receive_request_payload_received(request->handle,
+        trace_nbd_co_receive_request_payload_received(request->cookie,
                                                       request->len);
     }

diff --git a/nbd/trace-events b/nbd/trace-events
index 50ca05a9e22..f19a4d0db39 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -31,9 +31,9 @@ nbd_client_loop(void) "Doing NBD loop"
 nbd_client_loop_ret(int ret, const char *error) "NBD loop returned %d: %s"
 nbd_client_clear_queue(void) "Clearing NBD queue"
 nbd_client_clear_socket(void) "Clearing NBD socket"
-nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) }"
-nbd_receive_simple_reply(int32_t error, const char *errname, uint64_t handle) "Got simple reply: { .error = %" PRId32 " (%s), handle = %" PRIu64" }"
-nbd_receive_structured_reply_chunk(uint16_t flags, uint16_t type, const char *name, uint64_t handle, uint32_t length) "Got structured reply chunk: { flags = 0x%" PRIx16 ", type = %d (%s), handle = %" PRIu64 ", length = %" PRIu32 " }"
+nbd_send_request(uint64_t from, uint32_t len, uint64_t cookie, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .cookie = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) }"
+nbd_receive_simple_reply(int32_t error, const char *errname, uint64_t cookie) "Got simple reply: { .error = %" PRId32 " (%s), cookie = %" PRIu64" }"
+nbd_receive_structured_reply_chunk(uint16_t flags, uint16_t type, const char *name, uint64_t cookie, uint32_t length) "Got structured reply chunk: { flags = 0x%" PRIx16 ", type = %d (%s), cookie = %" PRIu64 ", length = %" PRIu32 " }"

 # common.c
 nbd_unknown_error(int err) "Squashing unexpected error %d to EINVAL"
@@ -63,14 +63,14 @@ nbd_negotiate_success(void) "Negotiation succeeded"
 nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from, uint32_t len) "Got request: { magic = 0x%" PRIx32 ", .flags = 0x%" PRIx16 ", .type = 0x%" PRIx16 ", from = %" PRIu64 ", len = %" PRIu32 " }"
 nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients to AIO context %p"
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p"
-nbd_co_send_simple_reply(uint64_t handle, uint32_t error, const char *errname, int len) "Send simple reply: handle = %" PRIu64 ", error = %" PRIu32 " (%s), len = %d"
-nbd_co_send_chunk_done(uint64_t handle) "Send structured reply done: handle = %" PRIu64
-nbd_co_send_chunk_read(uint64_t handle, uint64_t offset, void *data, size_t size) "Send structured read data reply: handle = %" PRIu64 ", offset = %" PRIu64 ", data = %p, len = %zu"
-nbd_co_send_chunk_read_hole(uint64_t handle, uint64_t offset, size_t size) "Send structured read hole reply: handle = %" PRIu64 ", offset = %" PRIu64 ", len = %zu"
-nbd_co_send_extents(uint64_t handle, unsigned int extents, uint32_t id, uint64_t length, int last) "Send block status reply: handle = %" PRIu64 ", extents = %u, context = %d (extents cover %" PRIu64 " bytes, last chunk = %d)"
-nbd_co_send_chunk_error(uint64_t handle, int err, const char *errname, const char *msg) "Send structured error reply: handle = %" PRIu64 ", error = %d (%s), msg = '%s'"
-nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, const char *name) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16 " (%s)"
-nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len) "Payload received: handle = %" PRIu64 ", len = %" PRIu32
+nbd_co_send_simple_reply(uint64_t cookie, uint32_t error, const char *errname, int len) "Send simple reply: cookie = %" PRIu64 ", error = %" PRIu32 " (%s), len = %d"
+nbd_co_send_chunk_done(uint64_t cookie) "Send structured reply done: cookie = %" PRIu64
+nbd_co_send_chunk_read(uint64_t cookie, uint64_t offset, void *data, size_t size) "Send structured read data reply: cookie = %" PRIu64 ", offset = %" PRIu64 ", data = %p, len = %zu"
+nbd_co_send_chunk_read_hole(uint64_t cookie, uint64_t offset, size_t size) "Send structured read hole reply: cookie = %" PRIu64 ", offset = %" PRIu64 ", len = %zu"
+nbd_co_send_extents(uint64_t cookie, unsigned int extents, uint32_t id, uint64_t length, int last) "Send block status reply: cookie = %" PRIu64 ", extents = %u, context = %d (extents cover %" PRIu64 " bytes, last chunk = %d)"
+nbd_co_send_chunk_error(uint64_t cookie, int err, const char *errname, const char *msg) "Send structured error reply: cookie = %" PRIu64 ", error = %d (%s), msg = '%s'"
+nbd_co_receive_request_decode_type(uint64_t cookie, uint16_t type, const char *name) "Decoding type: cookie = %" PRIu64 ", type = %" PRIu16 " (%s)"
+nbd_co_receive_request_payload_received(uint64_t cookie, uint32_t len) "Payload received: cookie = %" PRIu64 ", len = %" PRIu32
 nbd_co_receive_align_compliance(const char *op, uint64_t from, uint32_t len, uint32_t align) "client sent non-compliant unaligned %s request: from=0x%" PRIx64 ", len=0x%" PRIx32 ", align=0x%" PRIx32
 nbd_trip(void) "Reading request"

-- 
2.40.1


