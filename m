Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B3E7ADF6C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:04:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqr6-0002vc-OL; Mon, 25 Sep 2023 15:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkqr2-0002u9-Ci
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkqql-0005XW-3t
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695668549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=teA9tMr7PV0hHVrfLUY1BUr2aVzkx5D3kF19N81N4Ag=;
 b=TaElqZmGwr0goo8HwKY7C5IkTptFQtuil8NLM5uz7Bow8cFoAw3A4IecPpZwitM6+5p52L
 QazUK91EPY7gfjsNhPf1bE6ufjOAArNJuXEA8wTOK3FkmLBuvdr8qCK8rasU0kfN/1rH/q
 rHcshmiP3QMkUtlmmpnwWqgNrZcH+Ns=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-ZkIWlPjlNkmuZjAvDZWYFA-1; Mon, 25 Sep 2023 15:02:25 -0400
X-MC-Unique: ZkIWlPjlNkmuZjAvDZWYFA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A17FF3800E94;
 Mon, 25 Sep 2023 19:02:24 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21400C15BB8;
 Mon, 25 Sep 2023 19:02:24 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 3/7] nbd: Replace bool structured_reply with mode enum
Date: Mon, 25 Sep 2023 14:01:18 -0500
Message-ID: <20230925190114.3163545-12-eblake@redhat.com>
In-Reply-To: <20230925190114.3163545-9-eblake@redhat.com>
References: <20230925190114.3163545-9-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The upcoming patches for 64-bit extensions requires various points in
the protocol to make decisions based on what was negotiated.  While we
could easily add a 'bool extended_headers' alongside the existing
'bool structured_reply', this does not scale well if more modes are
added in the future.  Better is to expose the mode enum added in the
recent commit bfe04d0a7d out to a wider use in the code base.

Where the code previously checked for structured_reply being set or
clear, it now prefers checking for an inequality; this works because
the nodes are in a continuum of increasing abilities, and allows us to
touch fewer places if we ever insert other modes in the middle of the
enum.  There should be no semantic change in this patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230829175826.377251-20-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/block/nbd.h     |  2 +-
 block/nbd.c             |  8 +++++---
 nbd/client-connection.c |  4 ++--
 nbd/client.c            | 18 +++++++++---------
 nbd/server.c            | 31 ++++++++++++++++++-------------
 qemu-nbd.c              |  4 +++-
 6 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index f672b76173b..53226764574 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -305,7 +305,7 @@ typedef struct NBDExportInfo {

     /* In-out fields, set by client before nbd_receive_negotiate() and
      * updated by server results during nbd_receive_negotiate() */
-    bool structured_reply;
+    NBDMode mode; /* input maximum mode tolerated; output actual mode chosen */
     bool base_allocation; /* base:allocation context for NBD_CMD_BLOCK_STATUS */

     /* Set by server results during nbd_receive_negotiate() and
diff --git a/block/nbd.c b/block/nbd.c
index cc48580df70..676b755d79f 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -463,7 +463,8 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie)
             nbd_channel_error(s, ret);
             return ret;
         }
-        if (nbd_reply_is_structured(&s->reply) && !s->info.structured_reply) {
+        if (nbd_reply_is_structured(&s->reply) &&
+            s->info.mode < NBD_MODE_STRUCTURED) {
             nbd_channel_error(s, -EINVAL);
             return -EINVAL;
         }
@@ -866,7 +867,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     }

     /* handle structured reply chunk */
-    assert(s->info.structured_reply);
+    assert(s->info.mode >= NBD_MODE_STRUCTURED);
     chunk = &s->reply.structured;

     if (chunk->type == NBD_REPLY_TYPE_NONE) {
@@ -1070,7 +1071,8 @@ nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,
     void *payload = NULL;
     Error *local_err = NULL;

-    NBD_FOREACH_REPLY_CHUNK(s, iter, cookie, s->info.structured_reply,
+    NBD_FOREACH_REPLY_CHUNK(s, iter, cookie,
+                            s->info.mode >= NBD_MODE_STRUCTURED,
                             qiov, &reply, &payload)
     {
         int ret;
diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index 53a6549914c..aa0201b7107 100644
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
index bd7e2001366..844be42181a 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -879,7 +879,7 @@ static int nbd_list_meta_contexts(QIOChannel *ioc,
  */
 static int nbd_start_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
                                const char *hostname, QIOChannel **outioc,
-                               bool structured_reply, bool *zeroes,
+                               NBDMode max_mode, bool *zeroes,
                                Error **errp)
 {
     ERRP_GUARD();
@@ -953,7 +953,7 @@ static int nbd_start_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
         if (fixedNewStyle) {
             int result = 0;

-            if (structured_reply) {
+            if (max_mode >= NBD_MODE_STRUCTURED) {
                 result = nbd_request_simple_option(ioc,
                                                    NBD_OPT_STRUCTURED_REPLY,
                                                    false, errp);
@@ -1022,20 +1022,19 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     trace_nbd_receive_negotiate_name(info->name);

     result = nbd_start_negotiate(ioc, tlscreds, hostname, outioc,
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
@@ -1144,8 +1143,8 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     QIOChannel *sioc = NULL;

     *info = NULL;
-    result = nbd_start_negotiate(ioc, tlscreds, hostname, &sioc, true,
-                                 NULL, errp);
+    result = nbd_start_negotiate(ioc, tlscreds, hostname, &sioc,
+                                 NBD_MODE_STRUCTURED, NULL, errp);
     if (tlscreds && sioc) {
         ioc = sioc;
     }
@@ -1176,7 +1175,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
             memset(&array[count - 1], 0, sizeof(*array));
             array[count - 1].name = name;
             array[count - 1].description = desc;
-            array[count - 1].structured_reply = result == NBD_MODE_STRUCTURED;
+            array[count - 1].mode = result;
         }

         for (i = 0; i < count; i++) {
@@ -1209,6 +1208,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
         /* Lone export name is implied, but we can parse length and flags */
         array = g_new0(NBDExportInfo, 1);
         array->name = g_strdup("");
+        array->mode = NBD_MODE_OLDSTYLE;
         count = 1;

         if (nbd_negotiate_finish_oldstyle(ioc, array, errp) < 0) {
diff --git a/nbd/server.c b/nbd/server.c
index b5f93a20c9c..936c35e55c6 100644
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
@@ -1122,10 +1123,12 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
     if (nbd_read32(client->ioc, &flags, "flags", errp) < 0) {
         return -EIO;
     }
+    client->mode = NBD_MODE_EXPORT_NAME;
     trace_nbd_negotiate_options_flags(flags);
     if (flags & NBD_FLAG_C_FIXED_NEWSTYLE) {
         fixedNewstyle = true;
         flags &= ~NBD_FLAG_C_FIXED_NEWSTYLE;
+        client->mode = NBD_MODE_SIMPLE;
     }
     if (flags & NBD_FLAG_C_NO_ZEROES) {
         no_zeroes = true;
@@ -1261,13 +1264,13 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
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

@@ -1895,7 +1898,9 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
     };

     assert(!len || !nbd_err);
-    assert(!client->structured_reply || request->type != NBD_CMD_READ);
+    assert(client->mode < NBD_MODE_STRUCTURED ||
+           (client->mode == NBD_MODE_STRUCTURED &&
+            request->type != NBD_CMD_READ));
     trace_nbd_co_send_simple_reply(request->cookie, nbd_err,
                                    nbd_err_lookup(nbd_err), len);
     set_be_simple_reply(&reply, nbd_err, request->cookie);
@@ -1971,7 +1976,7 @@ static int coroutine_fn nbd_co_send_chunk_read(NBDClient *client,

     return nbd_co_send_iov(client, iov, 3, errp);
 }
-/*ebb*/
+
 static int coroutine_fn nbd_co_send_chunk_error(NBDClient *client,
                                                 NBDRequest *request,
                                                 uint32_t error,
@@ -2397,7 +2402,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
                                               client->check_align);
     }
     valid_flags = NBD_CMD_FLAG_FUA;
-    if (request->type == NBD_CMD_READ && client->structured_reply) {
+    if (request->type == NBD_CMD_READ && client->mode >= NBD_MODE_STRUCTURED) {
         valid_flags |= NBD_CMD_FLAG_DF;
     } else if (request->type == NBD_CMD_WRITE_ZEROES) {
         valid_flags |= NBD_CMD_FLAG_NO_HOLE | NBD_CMD_FLAG_FAST_ZERO;
@@ -2423,7 +2428,7 @@ static coroutine_fn int nbd_send_generic_reply(NBDClient *client,
                                                const char *error_msg,
                                                Error **errp)
 {
-    if (client->structured_reply && ret < 0) {
+    if (client->mode >= NBD_MODE_STRUCTURED && ret < 0) {
         return nbd_co_send_chunk_error(client, request, -ret, error_msg, errp);
     } else {
         return nbd_co_send_simple_reply(client, request, ret < 0 ? -ret : 0,
@@ -2451,8 +2456,8 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
         }
     }

-    if (client->structured_reply && !(request->flags & NBD_CMD_FLAG_DF) &&
-        request->len)
+    if (client->mode >= NBD_MODE_STRUCTURED &&
+        !(request->flags & NBD_CMD_FLAG_DF) && request->len)
     {
         return nbd_co_send_sparse_read(client, request, request->from,
                                        data, request->len, errp);
@@ -2464,7 +2469,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
                                       "reading from file failed", errp);
     }

-    if (client->structured_reply) {
+    if (client->mode >= NBD_MODE_STRUCTURED) {
         if (request->len) {
             return nbd_co_send_chunk_read(client, request, request->from, data,
                                           request->len, true, errp);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 30eeb6f3c75..70aa3c487a0 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -295,7 +295,9 @@ static void *show_parts(void *arg)
 static void *nbd_client_thread(void *arg)
 {
     struct NbdClientOpts *opts = arg;
-    NBDExportInfo info = { .request_sizes = false, .name = g_strdup("") };
+    /* TODO: Revisit this if nbd.ko ever gains support for structured reply */
+    NBDExportInfo info = { .request_sizes = false, .name = g_strdup(""),
+                           .mode = NBD_MODE_SIMPLE };
     QIOChannelSocket *sioc;
     int fd = -1;
     int ret = EXIT_FAILURE;
-- 
2.41.0


