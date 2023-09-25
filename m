Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4337ADF68
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:04:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqr4-0002uX-QO; Mon, 25 Sep 2023 15:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkqqr-0002ra-IS
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:02:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkqql-0005Xu-KJ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695668550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RnCLMNI8G+fwHV6suCgpyCXaJAhIZ9b4QbGRyXBfKTo=;
 b=TMQ2WCQnMQTpKIYtyuDsMgENJd05o+UH1q3uuXWtp3b1wCqcY5sT8h8gjNB4FqRP/ACnu8
 RKJyfL5TWw1QgS/InRY0pVtKgLeQm9elwdKMg8uPeoXiFPmonm/FKTBs0Ahog9HjnBYggI
 RQ0mDrLraunntiLZlOyLDv3Uf5DP9nA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-pgOsW4IVMZaQgEJlJBqs3w-1; Mon, 25 Sep 2023 15:02:26 -0400
X-MC-Unique: pgOsW4IVMZaQgEJlJBqs3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B0C73800E9B;
 Mon, 25 Sep 2023 19:02:26 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B797C15BB8;
 Mon, 25 Sep 2023 19:02:25 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 5/7] nbd: Add types for extended headers
Date: Mon, 25 Sep 2023 14:01:20 -0500
Message-ID: <20230925190114.3163545-14-eblake@redhat.com>
In-Reply-To: <20230925190114.3163545-9-eblake@redhat.com>
References: <20230925190114.3163545-9-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add the constants and structs necessary for later patches to start
implementing the NBD_OPT_EXTENDED_HEADERS extension in both the client
and server, matching recent upstream nbd.git (through commit
e6f3b94a934).  This patch does not change any existing behavior, but
merely sets the stage for upcoming patches.

This patch does not change the status quo that neither the client nor
server use a packed-struct representation for the request header.
While most of the patch adds new types, there is also some churn for
renaming the existing NBDExtent to NBDExtent32 to contrast it with
NBDExtent64, which I thought was a nicer name than NBDExtentExt.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20230829175826.377251-22-eblake@redhat.com>
---
 include/block/nbd.h | 124 +++++++++++++++++++++++++++++++-------------
 nbd/nbd-internal.h  |   3 +-
 block/nbd.c         |   6 +--
 nbd/common.c        |  12 ++++-
 nbd/server.c        |   6 +--
 5 files changed, 106 insertions(+), 45 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index e07b9f9bff7..22a9b5d10e0 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -60,7 +60,7 @@ typedef enum NBDMode {
     NBD_MODE_EXPORT_NAME,  /* newstyle but only OPT_EXPORT_NAME safe */
     NBD_MODE_SIMPLE,       /* newstyle but only simple replies */
     NBD_MODE_STRUCTURED,   /* newstyle, structured replies enabled */
-    /* TODO add NBD_MODE_EXTENDED */
+    NBD_MODE_EXTENDED,     /* newstyle, extended headers enabled */
 } NBDMode;

 /* Transmission phase structs */
@@ -93,20 +93,36 @@ typedef struct NBDStructuredReplyChunk {
     uint32_t length; /* length of payload */
 } QEMU_PACKED NBDStructuredReplyChunk;

+typedef struct NBDExtendedReplyChunk {
+    uint32_t magic;  /* NBD_EXTENDED_REPLY_MAGIC */
+    uint16_t flags;  /* combination of NBD_REPLY_FLAG_* */
+    uint16_t type;   /* NBD_REPLY_TYPE_* */
+    uint64_t cookie; /* request handle */
+    uint64_t offset; /* request offset */
+    uint64_t length; /* length of payload */
+} QEMU_PACKED NBDExtendedReplyChunk;
+
 typedef union NBDReply {
     NBDSimpleReply simple;
     NBDStructuredReplyChunk structured;
+    NBDExtendedReplyChunk extended;
     struct {
         /*
-         * @magic and @cookie fields have the same offset and size both in
-         * simple reply and structured reply chunk, so let them be accessible
-         * without ".simple." or ".structured." specification
+         * @magic and @cookie fields have the same offset and size in all
+         * forms of replies, so let them be accessible without ".simple.",
+         * ".structured.", or ".extended." specifications.
          */
         uint32_t magic;
         uint32_t _skip;
         uint64_t cookie;
-    } QEMU_PACKED;
+    };
 } NBDReply;
+QEMU_BUILD_BUG_ON(offsetof(NBDReply, simple.cookie) !=
+                  offsetof(NBDReply, cookie));
+QEMU_BUILD_BUG_ON(offsetof(NBDReply, structured.cookie) !=
+                  offsetof(NBDReply, cookie));
+QEMU_BUILD_BUG_ON(offsetof(NBDReply, extended.cookie) !=
+                  offsetof(NBDReply, cookie));

 /* Header of chunk for NBD_REPLY_TYPE_OFFSET_DATA */
 typedef struct NBDStructuredReadData {
@@ -133,14 +149,34 @@ typedef struct NBDStructuredError {
 typedef struct NBDStructuredMeta {
     /* header's length >= 12 (at least one extent) */
     uint32_t context_id;
-    /* extents follows */
+    /* NBDExtent32 extents[] follows, array length implied by header */
 } QEMU_PACKED NBDStructuredMeta;

-/* Extent chunk for NBD_REPLY_TYPE_BLOCK_STATUS */
-typedef struct NBDExtent {
+/* Extent array element for NBD_REPLY_TYPE_BLOCK_STATUS */
+typedef struct NBDExtent32 {
     uint32_t length;
     uint32_t flags; /* NBD_STATE_* */
-} QEMU_PACKED NBDExtent;
+} QEMU_PACKED NBDExtent32;
+
+/* Header of NBD_REPLY_TYPE_BLOCK_STATUS_EXT */
+typedef struct NBDExtendedMeta {
+    /* header's length >= 24 (at least one extent) */
+    uint32_t context_id;
+    uint32_t count; /* header length must be count * 16 + 8 */
+    /* NBDExtent64 extents[count] follows */
+} QEMU_PACKED NBDExtendedMeta;
+
+/* Extent array element for NBD_REPLY_TYPE_BLOCK_STATUS_EXT */
+typedef struct NBDExtent64 {
+    uint64_t length;
+    uint64_t flags; /* NBD_STATE_* */
+} QEMU_PACKED NBDExtent64;
+
+/* Client payload for limiting NBD_CMD_BLOCK_STATUS reply */
+typedef struct NBDBlockStatusPayload {
+    uint64_t effect_length;
+    /* uint32_t ids[] follows, array length implied by header */
+} QEMU_PACKED NBDBlockStatusPayload;

 /* Transmission (export) flags: sent from server to client during handshake,
    but describe what will happen during transmission */
@@ -158,20 +194,22 @@ enum {
     NBD_FLAG_SEND_RESIZE_BIT        =  9, /* Send resize */
     NBD_FLAG_SEND_CACHE_BIT         = 10, /* Send CACHE (prefetch) */
     NBD_FLAG_SEND_FAST_ZERO_BIT     = 11, /* FAST_ZERO flag for WRITE_ZEROES */
+    NBD_FLAG_BLOCK_STAT_PAYLOAD_BIT = 12, /* PAYLOAD flag for BLOCK_STATUS */
 };

-#define NBD_FLAG_HAS_FLAGS         (1 << NBD_FLAG_HAS_FLAGS_BIT)
-#define NBD_FLAG_READ_ONLY         (1 << NBD_FLAG_READ_ONLY_BIT)
-#define NBD_FLAG_SEND_FLUSH        (1 << NBD_FLAG_SEND_FLUSH_BIT)
-#define NBD_FLAG_SEND_FUA          (1 << NBD_FLAG_SEND_FUA_BIT)
-#define NBD_FLAG_ROTATIONAL        (1 << NBD_FLAG_ROTATIONAL_BIT)
-#define NBD_FLAG_SEND_TRIM         (1 << NBD_FLAG_SEND_TRIM_BIT)
-#define NBD_FLAG_SEND_WRITE_ZEROES (1 << NBD_FLAG_SEND_WRITE_ZEROES_BIT)
-#define NBD_FLAG_SEND_DF           (1 << NBD_FLAG_SEND_DF_BIT)
-#define NBD_FLAG_CAN_MULTI_CONN    (1 << NBD_FLAG_CAN_MULTI_CONN_BIT)
-#define NBD_FLAG_SEND_RESIZE       (1 << NBD_FLAG_SEND_RESIZE_BIT)
-#define NBD_FLAG_SEND_CACHE        (1 << NBD_FLAG_SEND_CACHE_BIT)
-#define NBD_FLAG_SEND_FAST_ZERO    (1 << NBD_FLAG_SEND_FAST_ZERO_BIT)
+#define NBD_FLAG_HAS_FLAGS          (1 << NBD_FLAG_HAS_FLAGS_BIT)
+#define NBD_FLAG_READ_ONLY          (1 << NBD_FLAG_READ_ONLY_BIT)
+#define NBD_FLAG_SEND_FLUSH         (1 << NBD_FLAG_SEND_FLUSH_BIT)
+#define NBD_FLAG_SEND_FUA           (1 << NBD_FLAG_SEND_FUA_BIT)
+#define NBD_FLAG_ROTATIONAL         (1 << NBD_FLAG_ROTATIONAL_BIT)
+#define NBD_FLAG_SEND_TRIM          (1 << NBD_FLAG_SEND_TRIM_BIT)
+#define NBD_FLAG_SEND_WRITE_ZEROES  (1 << NBD_FLAG_SEND_WRITE_ZEROES_BIT)
+#define NBD_FLAG_SEND_DF            (1 << NBD_FLAG_SEND_DF_BIT)
+#define NBD_FLAG_CAN_MULTI_CONN     (1 << NBD_FLAG_CAN_MULTI_CONN_BIT)
+#define NBD_FLAG_SEND_RESIZE        (1 << NBD_FLAG_SEND_RESIZE_BIT)
+#define NBD_FLAG_SEND_CACHE         (1 << NBD_FLAG_SEND_CACHE_BIT)
+#define NBD_FLAG_SEND_FAST_ZERO     (1 << NBD_FLAG_SEND_FAST_ZERO_BIT)
+#define NBD_FLAG_BLOCK_STAT_PAYLOAD (1 << NBD_FLAG_BLOCK_STAT_PAYLOAD_BIT)

 /* New-style handshake (global) flags, sent from server to client, and
    control what will happen during handshake phase. */
@@ -194,6 +232,7 @@ enum {
 #define NBD_OPT_STRUCTURED_REPLY  (8)
 #define NBD_OPT_LIST_META_CONTEXT (9)
 #define NBD_OPT_SET_META_CONTEXT  (10)
+#define NBD_OPT_EXTENDED_HEADERS  (11)

 /* Option reply types. */
 #define NBD_REP_ERR(value) ((UINT32_C(1) << 31) | (value))
@@ -211,6 +250,8 @@ enum {
 #define NBD_REP_ERR_UNKNOWN         NBD_REP_ERR(6)  /* Export unknown */
 #define NBD_REP_ERR_SHUTDOWN        NBD_REP_ERR(7)  /* Server shutting down */
 #define NBD_REP_ERR_BLOCK_SIZE_REQD NBD_REP_ERR(8)  /* Need INFO_BLOCK_SIZE */
+#define NBD_REP_ERR_TOO_BIG         NBD_REP_ERR(9)  /* Payload size overflow */
+#define NBD_REP_ERR_EXT_HEADER_REQD NBD_REP_ERR(10) /* Need extended headers */

 /* Info types, used during NBD_REP_INFO */
 #define NBD_INFO_EXPORT         0
@@ -219,12 +260,14 @@ enum {
 #define NBD_INFO_BLOCK_SIZE     3

 /* Request flags, sent from client to server during transmission phase */
-#define NBD_CMD_FLAG_FUA        (1 << 0) /* 'force unit access' during write */
-#define NBD_CMD_FLAG_NO_HOLE    (1 << 1) /* don't punch hole on zero run */
-#define NBD_CMD_FLAG_DF         (1 << 2) /* don't fragment structured read */
-#define NBD_CMD_FLAG_REQ_ONE    (1 << 3) /* only one extent in BLOCK_STATUS
-                                          * reply chunk */
-#define NBD_CMD_FLAG_FAST_ZERO  (1 << 4) /* fail if WRITE_ZEROES is not fast */
+#define NBD_CMD_FLAG_FUA         (1 << 0) /* 'force unit access' during write */
+#define NBD_CMD_FLAG_NO_HOLE     (1 << 1) /* don't punch hole on zero run */
+#define NBD_CMD_FLAG_DF          (1 << 2) /* don't fragment structured read */
+#define NBD_CMD_FLAG_REQ_ONE     (1 << 3) \
+    /* only one extent in BLOCK_STATUS reply chunk */
+#define NBD_CMD_FLAG_FAST_ZERO   (1 << 4) /* fail if WRITE_ZEROES is not fast */
+#define NBD_CMD_FLAG_PAYLOAD_LEN (1 << 5) \
+    /* length describes payload, not effect; only with ext header */

 /* Supported request types */
 enum {
@@ -250,22 +293,31 @@ enum {
  */
 #define NBD_MAX_STRING_SIZE 4096

-/* Two types of reply structures */
+/* Two types of request structures, a given client will only use 1 */
+#define NBD_REQUEST_MAGIC           0x25609513
+#define NBD_EXTENDED_REQUEST_MAGIC  0x21e41c71
+
+/*
+ * Three types of reply structures, but what a client expects depends
+ * on NBD_OPT_STRUCTURED_REPLY and NBD_OPT_EXTENDED_HEADERS.
+ */
 #define NBD_SIMPLE_REPLY_MAGIC      0x67446698
 #define NBD_STRUCTURED_REPLY_MAGIC  0x668e33ef
+#define NBD_EXTENDED_REPLY_MAGIC    0x6e8a278c

-/* Structured reply flags */
+/* Chunk reply flags (for structured and extended replies) */
 #define NBD_REPLY_FLAG_DONE          (1 << 0) /* This reply-chunk is last */

-/* Structured reply types */
+/* Chunk reply types */
 #define NBD_REPLY_ERR(value)         ((1 << 15) | (value))

-#define NBD_REPLY_TYPE_NONE          0
-#define NBD_REPLY_TYPE_OFFSET_DATA   1
-#define NBD_REPLY_TYPE_OFFSET_HOLE   2
-#define NBD_REPLY_TYPE_BLOCK_STATUS  5
-#define NBD_REPLY_TYPE_ERROR         NBD_REPLY_ERR(1)
-#define NBD_REPLY_TYPE_ERROR_OFFSET  NBD_REPLY_ERR(2)
+#define NBD_REPLY_TYPE_NONE              0
+#define NBD_REPLY_TYPE_OFFSET_DATA       1
+#define NBD_REPLY_TYPE_OFFSET_HOLE       2
+#define NBD_REPLY_TYPE_BLOCK_STATUS      5
+#define NBD_REPLY_TYPE_BLOCK_STATUS_EXT  6
+#define NBD_REPLY_TYPE_ERROR             NBD_REPLY_ERR(1)
+#define NBD_REPLY_TYPE_ERROR_OFFSET      NBD_REPLY_ERR(2)

 /* Extent flags for base:allocation in NBD_REPLY_TYPE_BLOCK_STATUS */
 #define NBD_STATE_HOLE (1 << 0)
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
index 24f50b79e47..9e99a4ddb52 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -610,7 +610,7 @@ static int nbd_parse_offset_hole_payload(BDRVNBDState *s,
 static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
                                          NBDStructuredReplyChunk *chunk,
                                          uint8_t *payload, uint64_t orig_length,
-                                         NBDExtent *extent, Error **errp)
+                                         NBDExtent32 *extent, Error **errp)
 {
     uint32_t context_id;

@@ -1118,7 +1118,7 @@ nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,

 static int coroutine_fn
 nbd_co_receive_blockstatus_reply(BDRVNBDState *s, uint64_t cookie,
-                                 uint64_t length, NBDExtent *extent,
+                                 uint64_t length, NBDExtent32 *extent,
                                  int *request_ret, Error **errp)
 {
     NBDReplyChunkIter iter;
@@ -1373,7 +1373,7 @@ static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
         int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
     int ret, request_ret;
-    NBDExtent extent = { 0 };
+    NBDExtent32 extent = { 0 };
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     Error *local_err = NULL;

diff --git a/nbd/common.c b/nbd/common.c
index 989fbe54a19..3247c1d618a 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -79,6 +79,8 @@ const char *nbd_opt_lookup(uint32_t opt)
         return "list meta context";
     case NBD_OPT_SET_META_CONTEXT:
         return "set meta context";
+    case NBD_OPT_EXTENDED_HEADERS:
+        return "extended headers";
     default:
         return "<unknown>";
     }
@@ -112,6 +114,10 @@ const char *nbd_rep_lookup(uint32_t rep)
         return "server shutting down";
     case NBD_REP_ERR_BLOCK_SIZE_REQD:
         return "block size required";
+    case NBD_REP_ERR_TOO_BIG:
+        return "option payload too big";
+    case NBD_REP_ERR_EXT_HEADER_REQD:
+        return "extended headers required";
     default:
         return "<unknown>";
     }
@@ -170,7 +176,9 @@ const char *nbd_reply_type_lookup(uint16_t type)
     case NBD_REPLY_TYPE_OFFSET_HOLE:
         return "hole";
     case NBD_REPLY_TYPE_BLOCK_STATUS:
-        return "block status";
+        return "block status (32-bit)";
+    case NBD_REPLY_TYPE_BLOCK_STATUS_EXT:
+        return "block status (64-bit)";
     case NBD_REPLY_TYPE_ERROR:
         return "generic error";
     case NBD_REPLY_TYPE_ERROR_OFFSET:
@@ -261,6 +269,8 @@ const char *nbd_mode_lookup(NBDMode mode)
         return "simple headers";
     case NBD_MODE_STRUCTURED:
         return "structured replies";
+    case NBD_MODE_EXTENDED:
+        return "extended headers";
     default:
         return "<unknown>";
     }
diff --git a/nbd/server.c b/nbd/server.c
index 936c35e55c6..35fcd9fdbc9 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2072,7 +2072,7 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
 }

 typedef struct NBDExtentArray {
-    NBDExtent *extents;
+    NBDExtent32 *extents;
     unsigned int nb_alloc;
     unsigned int count;
     uint64_t total_length;
@@ -2085,7 +2085,7 @@ static NBDExtentArray *nbd_extent_array_new(unsigned int nb_alloc)
     NBDExtentArray *ea = g_new0(NBDExtentArray, 1);

     ea->nb_alloc = nb_alloc;
-    ea->extents = g_new(NBDExtent, nb_alloc);
+    ea->extents = g_new(NBDExtent32, nb_alloc);
     ea->can_add = true;

     return ea;
@@ -2148,7 +2148,7 @@ static int nbd_extent_array_add(NBDExtentArray *ea,
     }

     ea->total_length += length;
-    ea->extents[ea->count] = (NBDExtent) {.length = length, .flags = flags};
+    ea->extents[ea->count] = (NBDExtent32) {.length = length, .flags = flags};
     ea->count++;

     return 0;
-- 
2.41.0


