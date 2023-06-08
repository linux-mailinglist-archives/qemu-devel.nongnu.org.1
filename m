Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C47F728211
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:02:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7G8t-00048p-Dh; Thu, 08 Jun 2023 09:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8X-0003vg-1O
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8U-0004gQ-Kd
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686232627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kmsZP6VkAAu/E7gm3FDvsqZsrxjZmoWP71ce9dPZ/DU=;
 b=axEnLviUSStqeYjIHYA9ci6iGUX2cpQ7oVW60lHUZX9zq03V+uNKSyNykZhotneRhwpjH/
 cgCn5LNA8/Q3zm7rct46wUQpbOCd35dax3Y7L+/dwN/29SxsB4y5a7i8aozul5k8ARMWG1
 KwFow2XpL+iYTum1ejKAJSYOaFvLcoI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-KQs8U6LxPLmoXCmDPz4hzA-1; Thu, 08 Jun 2023 09:57:03 -0400
X-MC-Unique: KQs8U6LxPLmoXCmDPz4hzA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 646933C1C4DD;
 Thu,  8 Jun 2023 13:57:03 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D04BB515540;
 Thu,  8 Jun 2023 13:57:02 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 09/24] nbd: Replace bool structured_reply with mode enum
Date: Thu,  8 Jun 2023 08:56:38 -0500
Message-Id: <20230608135653.2918540-10-eblake@redhat.com>
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

The upcoming patches for 64-bit extensions requires various points in
the protocol to make decisions based on what was negotiated.  While we
could easily add a 'bool extended_headers' alongside the existing
'bool structured_reply', this does not scale well if more modes are
added in the future.  Better is to expose the mode enum added in the
previous patch out to a wider use in the code base.

Where the code previously checked for structured_reply being set or
clear, it now prefers checking for an inequality; this works because
the nodes are in a continuum of increasing abilities, and allows us to
touch fewer places if we ever insert other modes in the middle of the
enum.  There should be no semantic change in this patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v4: new patch, expanding enum idea from v3 4/14
---
 include/block/nbd.h     |  2 +-
 block/nbd.c             |  8 +++++---
 nbd/client-connection.c |  4 ++--
 nbd/client.c            | 18 +++++++++---------
 nbd/server.c            | 27 +++++++++++++++------------
 qemu-nbd.c              |  4 +++-
 6 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index aba4279b56c..fea69ac24bb 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -304,7 +304,7 @@ typedef struct NBDExportInfo {

     /* In-out fields, set by client before nbd_receive_negotiate() and
      * updated by server results during nbd_receive_negotiate() */
-    bool structured_reply;
+    NBDMode mode; /* input maximum mode tolerated; output actual mode chosen */
     bool base_allocation; /* base:allocation context for NBD_CMD_BLOCK_STATUS */

     /* Set by server results during nbd_receive_negotiate() and
diff --git a/block/nbd.c b/block/nbd.c
index 5322e66166c..5f88f7a819b 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -464,7 +464,8 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie)
             nbd_channel_error(s, ret);
             return ret;
         }
-        if (nbd_reply_is_structured(&s->reply) && !s->info.structured_reply) {
+        if (nbd_reply_is_structured(&s->reply) &&
+            s->info.mode < NBD_MODE_STRUCTURED) {
             nbd_channel_error(s, -EINVAL);
             return -EINVAL;
         }
@@ -867,7 +868,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     }

     /* handle structured reply chunk */
-    assert(s->info.structured_reply);
+    assert(s->info.mode >= NBD_MODE_STRUCTURED);
     chunk = &s->reply.structured;

     if (chunk->type == NBD_REPLY_TYPE_NONE) {
@@ -1071,7 +1072,8 @@ nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,
     void *payload = NULL;
     Error *local_err = NULL;

-    NBD_FOREACH_REPLY_CHUNK(s, iter, cookie, s->info.structured_reply,
+    NBD_FOREACH_REPLY_CHUNK(s, iter, cookie,
+                            s->info.mode >= NBD_MODE_STRUCTURED,
                             qiov, &reply, &payload)
     {
         int ret;
diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index 3d14296c042..13e4cb6684b 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -1,5 +1,5 @@
 /*
- * QEMU Block driver for  NBD
+ * QEMU Block driver for NBD
  *
  * Copyright (c) 2021 Virtuozzo International GmbH.
  *
@@ -93,7 +93,7 @@ NBDClientConnection *nbd_client_connection_new(const SocketAddress *saddr,
         .do_negotiation = do_negotiation,

         .initial_info.request_sizes = true,
-        .initial_info.structured_reply = true,
+        .initial_info.mode = NBD_MODE_STRUCTURED,
         .initial_info.base_allocation = true,
         .initial_info.x_dirty_bitmap = g_strdup(x_dirty_bitmap),
         .initial_info.name = g_strdup(export_name ?: "")
diff --git a/nbd/client.c b/nbd/client.c
index 479208d5d9d..faa054c4527 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -880,7 +880,7 @@ static int nbd_list_meta_contexts(QIOChannel *ioc,
 static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
                                QCryptoTLSCreds *tlscreds,
                                const char *hostname, QIOChannel **outioc,
-                               bool structured_reply, bool *zeroes,
+                               NBDMode max_mode, bool *zeroes,
                                Error **errp)
 {
     ERRP_GUARD();
@@ -958,7 +958,7 @@ static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
         if (fixedNewStyle) {
             int result = 0;

-            if (structured_reply) {
+            if (max_mode >= NBD_MODE_STRUCTURED) {
                 result = nbd_request_simple_option(ioc,
                                                    NBD_OPT_STRUCTURED_REPLY,
                                                    false, errp);
@@ -1028,20 +1028,19 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
     trace_nbd_receive_negotiate_name(info->name);

     result = nbd_start_negotiate(aio_context, ioc, tlscreds, hostname, outioc,
-                                 info->structured_reply, &zeroes, errp);
+                                 info->mode, &zeroes, errp);
     if (result < 0) {
         return result;
     }

-    info->structured_reply = false;
+    info->mode = result;
     info->base_allocation = false;
     if (tlscreds && *outioc) {
         ioc = *outioc;
     }

-    switch ((NBDMode)result) {
+    switch (info->mode) {
     case NBD_MODE_STRUCTURED:
-        info->structured_reply = true;
         if (base_allocation) {
             result = nbd_negotiate_simple_meta_context(ioc, info, errp);
             if (result < 0) {
@@ -1150,8 +1149,8 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     QIOChannel *sioc = NULL;

     *info = NULL;
-    result = nbd_start_negotiate(NULL, ioc, tlscreds, hostname, &sioc, true,
-                                 NULL, errp);
+    result = nbd_start_negotiate(NULL, ioc, tlscreds, hostname, &sioc,
+                                 NBD_MODE_STRUCTURED, NULL, errp);
     if (tlscreds && sioc) {
         ioc = sioc;
     }
@@ -1182,7 +1181,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
             memset(&array[count - 1], 0, sizeof(*array));
             array[count - 1].name = name;
             array[count - 1].description = desc;
-            array[count - 1].structured_reply = result == NBD_MODE_STRUCTURED;
+            array[count - 1].mode = result;
         }

         for (i = 0; i < count; i++) {
@@ -1215,6 +1214,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
         /* Lone export name is implied, but we can parse length and flags */
         array = g_new0(NBDExportInfo, 1);
         array->name = g_strdup("");
+        array->mode = NBD_MODE_OLDSTYLE;
         count = 1;

         if (nbd_negotiate_finish_oldstyle(ioc, array, errp) < 0) {
diff --git a/nbd/server.c b/nbd/server.c
index 8486b64b15d..bade4f7990c 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -143,7 +143,7 @@ struct NBDClient {

     uint32_t check_align; /* If non-zero, check for aligned client requests */

-    bool structured_reply;
+    NBDMode mode;
     NBDExportMetaContexts export_meta;

     uint32_t opt; /* Current option being negotiated */
@@ -502,7 +502,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
     }

     myflags = client->exp->nbdflags;
-    if (client->structured_reply) {
+    if (client->mode >= NBD_MODE_STRUCTURED) {
         myflags |= NBD_FLAG_SEND_DF;
     }
     trace_nbd_negotiate_new_style_size_flags(client->exp->size, myflags);
@@ -687,7 +687,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)

     /* Send NBD_INFO_EXPORT always */
     myflags = exp->nbdflags;
-    if (client->structured_reply) {
+    if (client->mode >= NBD_MODE_STRUCTURED) {
         myflags |= NBD_FLAG_SEND_DF;
     }
     trace_nbd_negotiate_new_style_size_flags(exp->size, myflags);
@@ -985,7 +985,8 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     size_t i;
     size_t count = 0;

-    if (client->opt == NBD_OPT_SET_META_CONTEXT && !client->structured_reply) {
+    if (client->opt == NBD_OPT_SET_META_CONTEXT &&
+        client->mode < NBD_MODE_STRUCTURED) {
         return nbd_opt_invalid(client, errp,
                                "request option '%s' when structured reply "
                                "is not negotiated",
@@ -1261,13 +1262,13 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
             case NBD_OPT_STRUCTURED_REPLY:
                 if (length) {
                     ret = nbd_reject_length(client, false, errp);
-                } else if (client->structured_reply) {
+                } else if (client->mode >= NBD_MODE_STRUCTURED) {
                     ret = nbd_negotiate_send_rep_err(
                         client, NBD_REP_ERR_INVALID, errp,
                         "structured reply already negotiated");
                 } else {
                     ret = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
-                    client->structured_reply = true;
+                    client->mode = NBD_MODE_STRUCTURED;
                 }
                 break;

@@ -1907,7 +1908,9 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
     };

     assert(!len || !nbd_err);
-    assert(!client->structured_reply || request->type != NBD_CMD_READ);
+    assert(client->mode < NBD_MODE_STRUCTURED ||
+           (client->mode == NBD_MODE_STRUCTURED &&
+            request->type != NBD_CMD_READ));
     trace_nbd_co_send_simple_reply(request->cookie, nbd_err,
                                    nbd_err_lookup(nbd_err), len);
     set_be_simple_reply(&reply, nbd_err, request->cookie);
@@ -2409,7 +2412,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
                                               client->check_align);
     }
     valid_flags = NBD_CMD_FLAG_FUA;
-    if (request->type == NBD_CMD_READ && client->structured_reply) {
+    if (request->type == NBD_CMD_READ && client->mode >= NBD_MODE_STRUCTURED) {
         valid_flags |= NBD_CMD_FLAG_DF;
     } else if (request->type == NBD_CMD_WRITE_ZEROES) {
         valid_flags |= NBD_CMD_FLAG_NO_HOLE | NBD_CMD_FLAG_FAST_ZERO;
@@ -2435,7 +2438,7 @@ static coroutine_fn int nbd_send_generic_reply(NBDClient *client,
                                                const char *error_msg,
                                                Error **errp)
 {
-    if (client->structured_reply && ret < 0) {
+    if (client->mode >= NBD_MODE_STRUCTURED && ret < 0) {
         return nbd_co_send_chunk_error(client, request, -ret, error_msg, errp);
     } else {
         return nbd_co_send_simple_reply(client, request, ret < 0 ? -ret : 0,
@@ -2463,8 +2466,8 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
         }
     }

-    if (client->structured_reply && !(request->flags & NBD_CMD_FLAG_DF) &&
-        request->len)
+    if (client->mode >= NBD_MODE_STRUCTURED &&
+        !(request->flags & NBD_CMD_FLAG_DF) && request->len)
     {
         return nbd_co_send_sparse_read(client, request, request->from,
                                        data, request->len, errp);
@@ -2476,7 +2479,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
                                       "reading from file failed", errp);
     }

-    if (client->structured_reply) {
+    if (client->mode >= NBD_MODE_STRUCTURED) {
         if (request->len) {
             return nbd_co_send_chunk_read(client, request, request->from, data,
                                           request->len, true, errp);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 4276163564b..3ddd0bf02b4 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -274,8 +274,10 @@ static void *show_parts(void *arg)

 static void *nbd_client_thread(void *arg)
 {
+    /* TODO: Revisit this if nbd.ko ever gains support for structured reply */
     char *device = arg;
-    NBDExportInfo info = { .request_sizes = false, .name = g_strdup("") };
+    NBDExportInfo info = { .request_sizes = false, .name = g_strdup(""),
+                           .mode = NBD_MODE_SIMPLE };
     QIOChannelSocket *sioc;
     int fd = -1;
     int ret = EXIT_FAILURE;
-- 
2.40.1


