Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50604703DF3
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:56:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeGd-00052S-Lx; Mon, 15 May 2023 15:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGa-0004y0-69
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGX-00048f-D9
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YXGMvNdyQKI62GC2T3OrM2p0y1Hz31nyiQXcdVnt1S0=;
 b=PPzpIIpvfLYud6Ltc7SlBXEg5fRWzH3tFdXdlaK6VU6Z7EXzfKHWWpv1MEtbVoyMN6SoPJ
 xIvKSu7+cimy8dU7Kid7aUacuTwFeIFVXX5jhrQQp5QBu0ODfpxB1R/7sHNFeqE10eznAR
 vgSwzq1QdOKoC8vq8pqtdfBAmBGj2a8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-ynvl_14gOe6LJagMA9UcSw-1; Mon, 15 May 2023 15:53:49 -0400
X-MC-Unique: ynvl_14gOe6LJagMA9UcSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E54984AF31;
 Mon, 15 May 2023 19:53:49 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 909B71410DD5;
 Mon, 15 May 2023 19:53:48 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PATCH v3 04/14] nbd: Prepare for 64-bit request effect lengths
Date: Mon, 15 May 2023 14:53:33 -0500
Message-Id: <20230515195343.1915857-5-eblake@redhat.com>
In-Reply-To: <20230515195343.1915857-1-eblake@redhat.com>
References: <20230515195343.1915857-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Widen the length field of NBDRequest to 64-bits, although we can
assert that all current uses are still under 32 bits.  Move the
request magic number to nbd.h, to live alongside the reply magic
number.  Convert 'bool structured_reply' into a tri-state enum that
will eventually track whether the client successfully negotiated
extended headers with the server, allowing the nbd driver to pass
larger requests along where possible; although in this patch the enum
never surpasses structured replies, for no semantic change yet.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h     | 36 +++++++++++++++++++++------------
 nbd/nbd-internal.h      |  3 +--
 block/nbd.c             | 45 +++++++++++++++++++++++++++--------------
 nbd/client-connection.c |  4 ++--
 nbd/client.c            | 18 ++++++++++-------
 nbd/server.c            | 37 +++++++++++++++++++--------------
 nbd/trace-events        |  8 ++++----
 7 files changed, 93 insertions(+), 58 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index f1d838d24f5..50626ab2744 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2022 Red Hat, Inc.
+ *  Copyright Red Hat
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device
@@ -51,19 +51,26 @@ typedef struct NBDOptionReplyMetaContext {
     /* metadata context name follows */
 } QEMU_PACKED NBDOptionReplyMetaContext;

-/* Transmission phase structs
- *
- * Note: these are _NOT_ the same as the network representation of an NBD
- * request and reply!
+/* Transmission phase structs */
+
+/* Header style in use */
+typedef enum NBDHeaderStyle {
+    NBD_HEADER_SIMPLE,      /* default; simple replies only */
+    NBD_HEADER_STRUCTURED,  /* NBD_OPT_STRUCTURED_REPLY negotiated */
+    NBD_HEADER_EXTENDED,    /* NBD_OPT_EXTENDED_HEADERS negotiated */
+} NBDHeaderStyle;
+
+/*
+ * Note: NBDRequest is _NOT_ the same as the network representation of an NBD
+ * request!
  */
-struct NBDRequest {
+typedef struct NBDRequest {
     uint64_t handle;
-    uint64_t from;
-    uint32_t len;
+    uint64_t from;  /* Offset touched by the command */
+    uint64_t len;   /* Effect length; 32 bit limit without extended headers */
     uint16_t flags; /* NBD_CMD_FLAG_* */
-    uint16_t type; /* NBD_CMD_* */
-};
-typedef struct NBDRequest NBDRequest;
+    uint16_t type;  /* NBD_CMD_* */
+} NBDRequest;

 typedef struct NBDSimpleReply {
     uint32_t magic;  /* NBD_SIMPLE_REPLY_MAGIC */
@@ -236,6 +243,9 @@ enum {
  */
 #define NBD_MAX_STRING_SIZE 4096

+/* Transmission request structure */
+#define NBD_REQUEST_MAGIC           0x25609513
+
 /* Two types of reply structures */
 #define NBD_SIMPLE_REPLY_MAGIC      0x67446698
 #define NBD_STRUCTURED_REPLY_MAGIC  0x668e33ef
@@ -293,7 +303,7 @@ struct NBDExportInfo {

     /* In-out fields, set by client before nbd_receive_negotiate() and
      * updated by server results during nbd_receive_negotiate() */
-    bool structured_reply;
+    NBDHeaderStyle header_style;
     bool base_allocation; /* base:allocation context for NBD_CMD_BLOCK_STATUS */

     /* Set by server results during nbd_receive_negotiate() and
@@ -323,7 +333,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
                             Error **errp);
 int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
              Error **errp);
-int nbd_send_request(QIOChannel *ioc, NBDRequest *request);
+int nbd_send_request(QIOChannel *ioc, NBDRequest *request, NBDHeaderStyle hdr);
 int coroutine_fn nbd_receive_reply(BlockDriverState *bs, QIOChannel *ioc,
                                    NBDReply *reply, Error **errp);
 int nbd_client(int fd);
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index df42fef7066..133b1d94b50 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -1,7 +1,7 @@
 /*
  * NBD Internal Declarations
  *
- * Copyright (C) 2016 Red Hat, Inc.
+ * Copyright Red Hat
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -44,7 +44,6 @@
 #define NBD_OLDSTYLE_NEGOTIATE_SIZE (8 + 8 + 8 + 4 + 124)

 #define NBD_INIT_MAGIC              0x4e42444d41474943LL /* ASCII "NBDMAGIC" */
-#define NBD_REQUEST_MAGIC           0x25609513
 #define NBD_OPTS_MAGIC              0x49484156454F5054LL /* ASCII "IHAVEOPT" */
 #define NBD_CLIENT_MAGIC            0x0000420281861253LL
 #define NBD_REP_MAGIC               0x0003e889045565a9LL
diff --git a/block/nbd.c b/block/nbd.c
index a3f8f8a9d5e..6ad6a4f5ecd 100644
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
@@ -341,7 +341,7 @@ int coroutine_fn nbd_co_do_establish_connection(BlockDriverState *bs,
          */
         NBDRequest request = { .type = NBD_CMD_DISC };

-        nbd_send_request(s->ioc, &request);
+        nbd_send_request(s->ioc, &request, s->info.header_style);

         yank_unregister_function(BLOCKDEV_YANK_INSTANCE(s->bs->node_name),
                                  nbd_yank, bs);
@@ -464,7 +464,8 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t handle)
             nbd_channel_error(s, ret);
             return ret;
         }
-        if (nbd_reply_is_structured(&s->reply) && !s->info.structured_reply) {
+        if (nbd_reply_is_structured(&s->reply) &&
+            s->info.header_style < NBD_HEADER_STRUCTURED) {
             nbd_channel_error(s, -EINVAL);
             return -EINVAL;
         }
@@ -525,14 +526,14 @@ nbd_co_send_request(BlockDriverState *bs, NBDRequest *request,

     if (qiov) {
         qio_channel_set_cork(s->ioc, true);
-        rc = nbd_send_request(s->ioc, request);
+        rc = nbd_send_request(s->ioc, request, s->info.header_style);
         if (rc >= 0 && qio_channel_writev_all(s->ioc, qiov->iov, qiov->niov,
                                               NULL) < 0) {
             rc = -EIO;
         }
         qio_channel_set_cork(s->ioc, false);
     } else {
-        rc = nbd_send_request(s->ioc, request);
+        rc = nbd_send_request(s->ioc, request, s->info.header_style);
     }
     qemu_co_mutex_unlock(&s->send_mutex);

@@ -867,7 +868,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     }

     /* handle structured reply chunk */
-    assert(s->info.structured_reply);
+    assert(s->info.header_style >= NBD_HEADER_STRUCTURED);
     chunk = &s->reply.structured;

     if (chunk->type == NBD_REPLY_TYPE_NONE) {
@@ -1069,7 +1070,8 @@ static int coroutine_fn nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t h
     void *payload = NULL;
     Error *local_err = NULL;

-    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, s->info.structured_reply,
+    NBD_FOREACH_REPLY_CHUNK(s, iter, handle,
+                            s->info.header_style >= NBD_HEADER_STRUCTURED,
                             qiov, &reply, &payload)
     {
         int ret;
@@ -1301,10 +1303,11 @@ nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
     NBDRequest request = {
         .type = NBD_CMD_WRITE_ZEROES,
         .from = offset,
-        .len = bytes,  /* .len is uint32_t actually */
+        .len = bytes,
     };

-    assert(bytes <= UINT32_MAX); /* rely on max_pwrite_zeroes */
+    /* rely on max_pwrite_zeroes */
+    assert(bytes <= UINT32_MAX || s->info.header_style >= NBD_HEADER_EXTENDED);

     assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
     if (!(s->info.flags & NBD_FLAG_SEND_WRITE_ZEROES)) {
@@ -1351,10 +1354,11 @@ nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
     NBDRequest request = {
         .type = NBD_CMD_TRIM,
         .from = offset,
-        .len = bytes, /* len is uint32_t */
+        .len = bytes,
     };

-    assert(bytes <= UINT32_MAX); /* rely on max_pdiscard */
+    /* rely on max_pdiscard */
+    assert(bytes <= UINT32_MAX || s->info.header_style >= NBD_HEADER_EXTENDED);

     assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
     if (!(s->info.flags & NBD_FLAG_SEND_TRIM) || !bytes) {
@@ -1376,8 +1380,7 @@ static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
     NBDRequest request = {
         .type = NBD_CMD_BLOCK_STATUS,
         .from = offset,
-        .len = MIN(QEMU_ALIGN_DOWN(INT_MAX, bs->bl.request_alignment),
-                   MIN(bytes, s->info.size - offset)),
+        .len = MIN(bytes, s->info.size - offset),
         .flags = NBD_CMD_FLAG_REQ_ONE,
     };

@@ -1387,6 +1390,10 @@ static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
         *file = bs;
         return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
     }
+    if (s->info.header_style < NBD_HEADER_EXTENDED) {
+        request.len = MIN(QEMU_ALIGN_DOWN(INT_MAX, bs->bl.request_alignment),
+                          request.len);
+    }

     /*
      * Work around the fact that the block layer doesn't do
@@ -1465,7 +1472,7 @@ static void nbd_client_close(BlockDriverState *bs)
     NBDRequest request = { .type = NBD_CMD_DISC };

     if (s->ioc) {
-        nbd_send_request(s->ioc, &request);
+        nbd_send_request(s->ioc, &request, s->info.header_style);
     }

     nbd_teardown_connection(bs);
@@ -1951,6 +1958,14 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
     bs->bl.max_pwrite_zeroes = max;
     bs->bl.max_transfer = max;

+    /*
+     * Assume that if the server supports extended headers, it also
+     * supports unlimited size zero and trim commands.
+     */
+    if (s->info.header_style >= NBD_HEADER_EXTENDED) {
+        bs->bl.max_pdiscard = bs->bl.max_pwrite_zeroes = 0;
+    }
+
     if (s->info.opt_block &&
         s->info.opt_block > bs->bl.opt_transfer) {
         bs->bl.opt_transfer = s->info.opt_block;
diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index e5b1046a1c7..62d75af0bb3 100644
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
+        .initial_info.header_style = NBD_HEADER_STRUCTURED,
         .initial_info.base_allocation = true,
         .initial_info.x_dirty_bitmap = g_strdup(x_dirty_bitmap),
         .initial_info.name = g_strdup(export_name ?: "")
diff --git a/nbd/client.c b/nbd/client.c
index 46f476400ab..17d1f57da60 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2019 Red Hat, Inc.
+ *  Copyright Red Hat
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device Client Side
@@ -1031,9 +1031,10 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
     trace_nbd_receive_negotiate_name(info->name);

     result = nbd_start_negotiate(aio_context, ioc, tlscreds, hostname, outioc,
-                                 info->structured_reply, &zeroes, errp);
+                                 info->header_style >= NBD_HEADER_STRUCTURED,
+                                 &zeroes, errp);

-    info->structured_reply = false;
+    info->header_style = NBD_HEADER_SIMPLE;
     info->base_allocation = false;
     if (tlscreds && *outioc) {
         ioc = *outioc;
@@ -1041,7 +1042,7 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,

     switch (result) {
     case 3: /* newstyle, with structured replies */
-        info->structured_reply = true;
+        info->header_style = NBD_HEADER_STRUCTURED;
         if (base_allocation) {
             result = nbd_negotiate_simple_meta_context(ioc, info, errp);
             if (result < 0) {
@@ -1179,7 +1180,8 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
             memset(&array[count - 1], 0, sizeof(*array));
             array[count - 1].name = name;
             array[count - 1].description = desc;
-            array[count - 1].structured_reply = result == 3;
+            array[count - 1].header_style = result == 3 ?
+                NBD_HEADER_STRUCTURED : NBD_HEADER_SIMPLE;
         }

         for (i = 0; i < count; i++) {
@@ -1222,7 +1224,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
         if (nbd_drop(ioc, 124, NULL) == 0) {
             NBDRequest request = { .type = NBD_CMD_DISC };

-            nbd_send_request(ioc, &request);
+            nbd_send_request(ioc, &request, NBD_HEADER_SIMPLE);
         }
         break;
     default:
@@ -1346,10 +1348,12 @@ int nbd_disconnect(int fd)

 #endif /* __linux__ */

-int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
+int nbd_send_request(QIOChannel *ioc, NBDRequest *request, NBDHeaderStyle hdr)
 {
     uint8_t buf[NBD_REQUEST_SIZE];

+    assert(hdr < NBD_HEADER_EXTENDED);
+    assert(request->len <= UINT32_MAX);
     trace_nbd_send_request(request->from, request->len, request->handle,
                            request->flags, request->type,
                            nbd_cmd_lookup(request->type));
diff --git a/nbd/server.c b/nbd/server.c
index eefe3401560..cf38a104d9a 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2022 Red Hat, Inc.
+ *  Copyright Red Hat
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device Server Side
@@ -143,7 +143,7 @@ struct NBDClient {

     uint32_t check_align; /* If non-zero, check for aligned client requests */

-    bool structured_reply;
+    NBDHeaderStyle header_style;
     NBDExportMetaContexts export_meta;

     uint32_t opt; /* Current option being negotiated */
@@ -502,7 +502,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
     }

     myflags = client->exp->nbdflags;
-    if (client->structured_reply) {
+    if (client->header_style >= NBD_HEADER_STRUCTURED) {
         myflags |= NBD_FLAG_SEND_DF;
     }
     trace_nbd_negotiate_new_style_size_flags(client->exp->size, myflags);
@@ -687,7 +687,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)

     /* Send NBD_INFO_EXPORT always */
     myflags = exp->nbdflags;
-    if (client->structured_reply) {
+    if (client->header_style >= NBD_HEADER_STRUCTURED) {
         myflags |= NBD_FLAG_SEND_DF;
     }
     trace_nbd_negotiate_new_style_size_flags(exp->size, myflags);
@@ -985,7 +985,8 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     size_t i;
     size_t count = 0;

-    if (client->opt == NBD_OPT_SET_META_CONTEXT && !client->structured_reply) {
+    if (client->opt == NBD_OPT_SET_META_CONTEXT &&
+        client->header_style < NBD_HEADER_STRUCTURED) {
         return nbd_opt_invalid(client, errp,
                                "request option '%s' when structured reply "
                                "is not negotiated",
@@ -1261,13 +1262,13 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
             case NBD_OPT_STRUCTURED_REPLY:
                 if (length) {
                     ret = nbd_reject_length(client, false, errp);
-                } else if (client->structured_reply) {
+                } else if (client->header_style >= NBD_HEADER_STRUCTURED) {
                     ret = nbd_negotiate_send_rep_err(
                         client, NBD_REP_ERR_INVALID, errp,
                         "structured reply already negotiated");
                 } else {
                     ret = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
-                    client->structured_reply = true;
+                    client->header_style = NBD_HEADER_STRUCTURED;
                 }
                 break;

@@ -1438,7 +1439,7 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
     request->type   = lduw_be_p(buf + 6);
     request->handle = ldq_be_p(buf + 8);
     request->from   = ldq_be_p(buf + 16);
-    request->len    = ldl_be_p(buf + 24);
+    request->len    = ldl_be_p(buf + 24); /* widen 32 to 64 bits */

     trace_nbd_receive_request(magic, request->flags, request->type,
                               request->from, request->len);
@@ -2343,7 +2344,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
         request->type == NBD_CMD_CACHE)
     {
         if (request->len > NBD_MAX_BUFFER_SIZE) {
-            error_setg(errp, "len (%" PRIu32" ) is larger than max len (%u)",
+            error_setg(errp, "len (%" PRIu64" ) is larger than max len (%u)",
                        request->len, NBD_MAX_BUFFER_SIZE);
             return -EINVAL;
         }
@@ -2359,6 +2360,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
     }

     if (request->type == NBD_CMD_WRITE) {
+        assert(request->len <= NBD_MAX_BUFFER_SIZE);
         if (nbd_read(client->ioc, req->data, request->len, "CMD_WRITE data",
                      errp) < 0)
         {
@@ -2380,7 +2382,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
     }
     if (request->from > client->exp->size ||
         request->len > client->exp->size - request->from) {
-        error_setg(errp, "operation past EOF; From: %" PRIu64 ", Len: %" PRIu32
+        error_setg(errp, "operation past EOF; From: %" PRIu64 ", Len: %" PRIu64
                    ", Size: %" PRIu64, request->from, request->len,
                    client->exp->size);
         return (request->type == NBD_CMD_WRITE ||
@@ -2398,7 +2400,8 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
                                               client->check_align);
     }
     valid_flags = NBD_CMD_FLAG_FUA;
-    if (request->type == NBD_CMD_READ && client->structured_reply) {
+    if (request->type == NBD_CMD_READ &&
+        client->header_style >= NBD_HEADER_STRUCTURED) {
         valid_flags |= NBD_CMD_FLAG_DF;
     } else if (request->type == NBD_CMD_WRITE_ZEROES) {
         valid_flags |= NBD_CMD_FLAG_NO_HOLE | NBD_CMD_FLAG_FAST_ZERO;
@@ -2424,7 +2427,7 @@ static coroutine_fn int nbd_send_generic_reply(NBDClient *client,
                                                const char *error_msg,
                                                Error **errp)
 {
-    if (client->structured_reply && ret < 0) {
+    if (client->header_style >= NBD_HEADER_STRUCTURED && ret < 0) {
         return nbd_co_send_structured_error(client, handle, -ret, error_msg,
                                             errp);
     } else {
@@ -2443,6 +2446,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
     NBDExport *exp = client->exp;

     assert(request->type == NBD_CMD_READ);
+    assert(request->len <= NBD_MAX_BUFFER_SIZE);

     /* XXX: NBD Protocol only documents use of FUA with WRITE */
     if (request->flags & NBD_CMD_FLAG_FUA) {
@@ -2453,8 +2457,8 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
         }
     }

-    if (client->structured_reply && !(request->flags & NBD_CMD_FLAG_DF) &&
-        request->len)
+    if (client->header_style >= NBD_HEADER_STRUCTURED &&
+        !(request->flags & NBD_CMD_FLAG_DF) && request->len)
     {
         return nbd_co_send_sparse_read(client, request->handle, request->from,
                                        data, request->len, errp);
@@ -2466,7 +2470,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
                                       "reading from file failed", errp);
     }

-    if (client->structured_reply) {
+    if (client->header_style >= NBD_HEADER_STRUCTURED) {
         if (request->len) {
             return nbd_co_send_structured_read(client, request->handle,
                                                request->from, data,
@@ -2494,6 +2498,7 @@ static coroutine_fn int nbd_do_cmd_cache(NBDClient *client, NBDRequest *request,
     NBDExport *exp = client->exp;

     assert(request->type == NBD_CMD_CACHE);
+    assert(request->len <= NBD_MAX_BUFFER_SIZE);

     ret = blk_co_preadv(exp->common.blk, request->from, request->len,
                         NULL, BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);
@@ -2527,6 +2532,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         if (request->flags & NBD_CMD_FLAG_FUA) {
             flags |= BDRV_REQ_FUA;
         }
+        assert(request->len <= NBD_MAX_BUFFER_SIZE);
         ret = blk_co_pwrite(exp->common.blk, request->from, request->len, data,
                             flags);
         return nbd_send_generic_reply(client, request->handle, ret,
@@ -2570,6 +2576,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
             return nbd_send_generic_reply(client, request->handle, -EINVAL,
                                           "need non-zero length", errp);
         }
+        assert(request->len <= UINT32_MAX);
         if (client->export_meta.count) {
             bool dont_fragment = request->flags & NBD_CMD_FLAG_REQ_ONE;
             int contexts_remaining = client->export_meta.count;
diff --git a/nbd/trace-events b/nbd/trace-events
index b7032ca2778..e2c1d68688d 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -31,7 +31,7 @@ nbd_client_loop(void) "Doing NBD loop"
 nbd_client_loop_ret(int ret, const char *error) "NBD loop returned %d: %s"
 nbd_client_clear_queue(void) "Clearing NBD queue"
 nbd_client_clear_socket(void) "Clearing NBD socket"
-nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) }"
+nbd_send_request(uint64_t from, uint64_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu64 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) }"
 nbd_receive_simple_reply(int32_t error, const char *errname, uint64_t handle) "Got simple reply: { .error = %" PRId32 " (%s), handle = %" PRIu64" }"
 nbd_receive_structured_reply_chunk(uint16_t flags, uint16_t type, const char *name, uint64_t handle, uint32_t length) "Got structured reply chunk: { flags = 0x%" PRIx16 ", type = %d (%s), handle = %" PRIu64 ", length = %" PRIu32 " }"

@@ -60,7 +60,7 @@ nbd_negotiate_options_check_option(uint32_t option, const char *name) "Checking
 nbd_negotiate_begin(void) "Beginning negotiation"
 nbd_negotiate_new_style_size_flags(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags 0x%x"
 nbd_negotiate_success(void) "Negotiation succeeded"
-nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from, uint32_t len) "Got request: { magic = 0x%" PRIx32 ", .flags = 0x%" PRIx16 ", .type = 0x%" PRIx16 ", from = %" PRIu64 ", len = %" PRIu32 " }"
+nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from, uint64_t len) "Got request: { magic = 0x%" PRIx32 ", .flags = 0x%" PRIx16 ", .type = 0x%" PRIx16 ", from = %" PRIu64 ", len = %" PRIu64 " }"
 nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients to AIO context %p"
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p"
 nbd_co_send_simple_reply(uint64_t handle, uint32_t error, const char *errname, int len) "Send simple reply: handle = %" PRIu64 ", error = %" PRIu32 " (%s), len = %d"
@@ -70,8 +70,8 @@ nbd_co_send_structured_read_hole(uint64_t handle, uint64_t offset, size_t size)
 nbd_co_send_extents(uint64_t handle, unsigned int extents, uint32_t id, uint64_t length, int last) "Send block status reply: handle = %" PRIu64 ", extents = %u, context = %d (extents cover %" PRIu64 " bytes, last chunk = %d)"
 nbd_co_send_structured_error(uint64_t handle, int err, const char *errname, const char *msg) "Send structured error reply: handle = %" PRIu64 ", error = %d (%s), msg = '%s'"
 nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, const char *name) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16 " (%s)"
-nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len) "Payload received: handle = %" PRIu64 ", len = %" PRIu32
-nbd_co_receive_align_compliance(const char *op, uint64_t from, uint32_t len, uint32_t align) "client sent non-compliant unaligned %s request: from=0x%" PRIx64 ", len=0x%" PRIx32 ", align=0x%" PRIx32
+nbd_co_receive_request_payload_received(uint64_t handle, uint64_t len) "Payload received: handle = %" PRIu64 ", len = %" PRIu64
+nbd_co_receive_align_compliance(const char *op, uint64_t from, uint64_t len, uint32_t align) "client sent non-compliant unaligned %s request: from=0x%" PRIx64 ", len=0x%" PRIx64 ", align=0x%" PRIx32
 nbd_trip(void) "Reading request"

 # client-connection.c
-- 
2.40.1


