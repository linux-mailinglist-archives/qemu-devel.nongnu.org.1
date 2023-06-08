Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C3728219
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:03:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7G8v-0004AY-D6; Thu, 08 Jun 2023 09:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8a-0003yF-Tr
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8U-0004gK-Nl
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686232626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dYBhlfkH7hYfuaXOhkTsYPit9D637+pdt6XFLwODPQ=;
 b=JiW+kLOEDyu3TiG286nYxpDz6F8euYM1iz60P8hnXfJLC8MfSp3uLMSRlrLlqe/fkw/p0o
 UYSXVNCP92WuVrkO+jKMkfqHB0zIyG7QJaggvyW9BRnAZwSAg02dqdCEXMTMGg8JIdw6eX
 Ii9mV+tYz+L4GqD+m8wwAHLRgKQfXYo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-TjdZ2y46Pp2BLJP-g7oksw-1; Thu, 08 Jun 2023 09:57:05 -0400
X-MC-Unique: TjdZ2y46Pp2BLJP-g7oksw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE5401C0942B;
 Thu,  8 Jun 2023 13:57:04 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 640AC492B00;
 Thu,  8 Jun 2023 13:57:04 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 11/24] nbd: Add types for extended headers
Date: Thu,  8 Jun 2023 08:56:40 -0500
Message-Id: <20230608135653.2918540-12-eblake@redhat.com>
In-Reply-To: <20230608135653.2918540-1-eblake@redhat.com>
References: <20230608135653.2918540-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---

v4: Hoist earlier in series, tweak a few comments, defer docs/interop
change to when feature is actually turned on, NBDExtent rename, add
QEMU_BUG_BUILD_ON for sanity sake, hoist in block status payload bits
from v3 14/14; R-b dropped
---
 include/block/nbd.h | 124 +++++++++++++++++++++++++++++++-------------
 nbd/nbd-internal.h  |   3 +-
 block/nbd.c         |   6 +--
 nbd/common.c        |  12 ++++-
 nbd/server.c        |   6 +--
 5 files changed, 106 insertions(+), 45 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 52420660a65..f706e38dc72 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -59,7 +59,7 @@ typedef enum NBDMode {
     NBD_MODE_EXPORT_NAME,  /* newstyle but only OPT_EXPORT_NAME safe */
     NBD_MODE_SIMPLE,       /* newstyle but only simple replies */
     NBD_MODE_STRUCTURED,   /* newstyle, structured replies enabled */
-    /* TODO add NBD_MODE_EXTENDED */
+    NBD_MODE_EXTENDED,     /* newstyle, extended headers enabled */
 } NBDMode;

 /* Transmission phase structs */
@@ -92,20 +92,36 @@ typedef struct NBDStructuredReplyChunk {
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
@@ -132,14 +148,34 @@ typedef struct NBDStructuredError {
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
@@ -157,20 +193,22 @@ enum {
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
@@ -193,6 +231,7 @@ enum {
 #define NBD_OPT_STRUCTURED_REPLY  (8)
 #define NBD_OPT_LIST_META_CONTEXT (9)
 #define NBD_OPT_SET_META_CONTEXT  (10)
+#define NBD_OPT_EXTENDED_HEADERS  (11)

 /* Option reply types. */
 #define NBD_REP_ERR(value) ((UINT32_C(1) << 31) | (value))
@@ -210,6 +249,8 @@ enum {
 #define NBD_REP_ERR_UNKNOWN         NBD_REP_ERR(6)  /* Export unknown */
 #define NBD_REP_ERR_SHUTDOWN        NBD_REP_ERR(7)  /* Server shutting down */
 #define NBD_REP_ERR_BLOCK_SIZE_REQD NBD_REP_ERR(8)  /* Need INFO_BLOCK_SIZE */
+#define NBD_REP_ERR_TOO_BIG         NBD_REP_ERR(9)  /* Payload size overflow */
+#define NBD_REP_ERR_EXT_HEADER_REQD NBD_REP_ERR(10) /* Need extended headers */

 /* Info types, used during NBD_REP_INFO */
 #define NBD_INFO_EXPORT         0
@@ -218,12 +259,14 @@ enum {
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
@@ -249,22 +292,31 @@ enum {
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
index ca5991f868a..c7581794873 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -611,7 +611,7 @@ static int nbd_parse_offset_hole_payload(BDRVNBDState *s,
 static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
                                          NBDStructuredReplyChunk *chunk,
                                          uint8_t *payload, uint64_t orig_length,
-                                         NBDExtent *extent, Error **errp)
+                                         NBDExtent32 *extent, Error **errp)
 {
     uint32_t context_id;

@@ -1119,7 +1119,7 @@ nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,

 static int coroutine_fn
 nbd_co_receive_blockstatus_reply(BDRVNBDState *s, uint64_t cookie,
-                                 uint64_t length, NBDExtent *extent,
+                                 uint64_t length, NBDExtent32 *extent,
                                  int *request_ret, Error **errp)
 {
     NBDReplyChunkIter iter;
@@ -1374,7 +1374,7 @@ static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
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
index bade4f7990c..9b16f7e5405 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2082,7 +2082,7 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
 }

 typedef struct NBDExtentArray {
-    NBDExtent *extents;
+    NBDExtent32 *extents;
     unsigned int nb_alloc;
     unsigned int count;
     uint64_t total_length;
@@ -2095,7 +2095,7 @@ static NBDExtentArray *nbd_extent_array_new(unsigned int nb_alloc)
     NBDExtentArray *ea = g_new0(NBDExtentArray, 1);

     ea->nb_alloc = nb_alloc;
-    ea->extents = g_new(NBDExtent, nb_alloc);
+    ea->extents = g_new(NBDExtent32, nb_alloc);
     ea->can_add = true;

     return ea;
@@ -2158,7 +2158,7 @@ static int nbd_extent_array_add(NBDExtentArray *ea,
     }

     ea->total_length += length;
-    ea->extents[ea->count] = (NBDExtent) {.length = length, .flags = flags};
+    ea->extents[ea->count] = (NBDExtent32) {.length = length, .flags = flags};
     ea->count++;

     return 0;
-- 
2.40.1


