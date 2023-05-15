Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE28B703DE1
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:54:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeGc-00051Y-B1; Mon, 15 May 2023 15:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGa-0004zV-Gj
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGY-000492-Er
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkjP2ZahjkkXmi0fUDknsveGjU3+Qt8KmGUvVSzGK9g=;
 b=LJn+rL10OnUL4Becldxe/mhEOrOozOFN5GHFM3YK/xuQg4K0FCN9MeCvGUFAzW3Aia7/sS
 TOAz58UB9LDhnn/lXINdtbtlzW9aFkTbUBsg+5sf//LduvNfRjIDpqoMp3DqDcHNsU67ya
 cg/aCwutonrm6c2FDqmjMvKXJE8CSsU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-g7rd2Ph8PjqZ5EMmbzLDJA-1; Mon, 15 May 2023 15:53:50 -0400
X-MC-Unique: g7rd2Ph8PjqZ5EMmbzLDJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BCA21C0A583;
 Mon, 15 May 2023 19:53:50 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 702A61410F23;
 Mon, 15 May 2023 19:53:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PATCH v3 05/14] nbd: Add types for extended headers
Date: Mon, 15 May 2023 14:53:34 -0500
Message-Id: <20230515195343.1915857-6-eblake@redhat.com>
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

Add the constants and structs necessary for later patches to start
implementing the NBD_OPT_EXTENDED_HEADERS extension in both the client
and server, matching recent commit e6f3b94a934] in the upstream nbd
project.  This patch does not change any existing behavior, but merely
sets the stage.

This patch does not change the status quo that neither the client nor
server use a packed-struct representation for the request header.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/interop/nbd.txt |  1 +
 include/block/nbd.h  | 74 ++++++++++++++++++++++++++++++++------------
 nbd/common.c         | 10 +++++-
 3 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
index f5ca25174a6..abaf4c28a96 100644
--- a/docs/interop/nbd.txt
+++ b/docs/interop/nbd.txt
@@ -69,3 +69,4 @@ NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE
 NBD_CMD_FLAG_FAST_ZERO
 * 5.2: NBD_CMD_BLOCK_STATUS for "qemu:allocation-depth"
 * 7.1: NBD_FLAG_CAN_MULTI_CONN for shareable writable exports
+* 8.1: NBD_OPT_EXTENDED_HEADERS
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 50626ab2744..d753fb8006f 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -87,13 +87,24 @@ typedef struct NBDStructuredReplyChunk {
     uint32_t length; /* length of payload */
 } QEMU_PACKED NBDStructuredReplyChunk;

+typedef struct NBDExtendedReplyChunk {
+    uint32_t magic;  /* NBD_EXTENDED_REPLY_MAGIC */
+    uint16_t flags;  /* combination of NBD_REPLY_FLAG_* */
+    uint16_t type;   /* NBD_REPLY_TYPE_* */
+    uint64_t handle; /* request handle */
+    uint64_t offset; /* request offset */
+    uint64_t length; /* length of payload */
+} QEMU_PACKED NBDExtendedReplyChunk;
+
 typedef union NBDReply {
     NBDSimpleReply simple;
     NBDStructuredReplyChunk structured;
+    NBDExtendedReplyChunk extended;
     struct {
-        /* @magic and @handle fields have the same offset and size both in
-         * simple reply and structured reply chunk, so let them be accessible
-         * without ".simple." or ".structured." specification
+        /*
+         * @magic and @handle fields have the same offset and size in all
+         * forms of replies, so let them be accessible without ".simple.",
+         * ".structured.", or ".extended." specifications.
          */
         uint32_t magic;
         uint32_t _skip;
@@ -126,15 +137,29 @@ typedef struct NBDStructuredError {
 typedef struct NBDStructuredMeta {
     /* header's length >= 12 (at least one extent) */
     uint32_t context_id;
-    /* extents follows */
+    /* NBDExtent extents[] follows, array length implied by header */
 } QEMU_PACKED NBDStructuredMeta;

-/* Extent chunk for NBD_REPLY_TYPE_BLOCK_STATUS */
+/* Extent array for NBD_REPLY_TYPE_BLOCK_STATUS */
 typedef struct NBDExtent {
     uint32_t length;
     uint32_t flags; /* NBD_STATE_* */
 } QEMU_PACKED NBDExtent;

+/* Header of NBD_REPLY_TYPE_BLOCK_STATUS_EXT */
+typedef struct NBDStructuredMetaExt {
+    /* header's length >= 24 (at least one extent) */
+    uint32_t context_id;
+    uint32_t count; /* header length must be count * 16 + 8 */
+    /* NBDExtentExt extents[count] follows */
+} QEMU_PACKED NBDStructuredMetaExt;
+
+/* Extent array for NBD_REPLY_TYPE_BLOCK_STATUS_EXT */
+typedef struct NBDExtentExt {
+    uint64_t length;
+    uint64_t flags; /* NBD_STATE_* */
+} QEMU_PACKED NBDExtentExt;
+
 /* Transmission (export) flags: sent from server to client during handshake,
    but describe what will happen during transmission */
 enum {
@@ -187,6 +212,7 @@ enum {
 #define NBD_OPT_STRUCTURED_REPLY  (8)
 #define NBD_OPT_LIST_META_CONTEXT (9)
 #define NBD_OPT_SET_META_CONTEXT  (10)
+#define NBD_OPT_EXTENDED_HEADERS  (11)

 /* Option reply types. */
 #define NBD_REP_ERR(value) ((UINT32_C(1) << 31) | (value))
@@ -204,6 +230,8 @@ enum {
 #define NBD_REP_ERR_UNKNOWN         NBD_REP_ERR(6)  /* Export unknown */
 #define NBD_REP_ERR_SHUTDOWN        NBD_REP_ERR(7)  /* Server shutting down */
 #define NBD_REP_ERR_BLOCK_SIZE_REQD NBD_REP_ERR(8)  /* Need INFO_BLOCK_SIZE */
+#define NBD_REP_ERR_TOO_BIG         NBD_REP_ERR(9)  /* Payload size overflow */
+#define NBD_REP_ERR_EXT_HEADER_REQD NBD_REP_ERR(10) /* Need extended headers */

 /* Info types, used during NBD_REP_INFO */
 #define NBD_INFO_EXPORT         0
@@ -212,12 +240,14 @@ enum {
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
@@ -243,12 +273,17 @@ enum {
  */
 #define NBD_MAX_STRING_SIZE 4096

-/* Transmission request structure */
+/* Two types of request structures, a given client will only use 1 */
 #define NBD_REQUEST_MAGIC           0x25609513
+#define NBD_EXTENDED_REQUEST_MAGIC  0x21e41c71

-/* Two types of reply structures */
+/*
+ * Three types of reply structures, but what a client expects depends
+ * on NBD_OPT_STRUCTURED_REPLY and NBD_OPT_EXTENDED_HEADERS.
+ */
 #define NBD_SIMPLE_REPLY_MAGIC      0x67446698
 #define NBD_STRUCTURED_REPLY_MAGIC  0x668e33ef
+#define NBD_EXTENDED_REPLY_MAGIC    0x6e8a278c

 /* Structured reply flags */
 #define NBD_REPLY_FLAG_DONE          (1 << 0) /* This reply-chunk is last */
@@ -256,12 +291,13 @@ enum {
 /* Structured reply types */
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
diff --git a/nbd/common.c b/nbd/common.c
index ddfe7d11837..137466defd2 100644
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
-- 
2.40.1


