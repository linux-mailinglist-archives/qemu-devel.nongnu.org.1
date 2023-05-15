Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5261D703DF0
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeGg-00055i-PO; Mon, 15 May 2023 15:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGd-00052r-Bh
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGb-0004Af-6i
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x8LXh6FmG95O9DEskqkbt8Mtn3tqkbxXHdZ02P1qCXw=;
 b=eOBFY7TJqprCBVqs8hz0/5UV3A4x9XCpO4bb1s0GmVy3ulxDPNd6W+BDMZseROey9LSpSd
 f94zWicqc/JFoB+Poz3PkfyziiO/L0OdAxtkXTBj54yaLNCtf8zljfxmJjlaxUjIyw74/R
 VsA+idUhu7HGVQhLd1sOenhBbEZX7EU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-cW_wjmS6PgmPeDPaQYtRPw-1; Mon, 15 May 2023 15:53:53 -0400
X-MC-Unique: cW_wjmS6PgmPeDPaQYtRPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5A45380673F;
 Mon, 15 May 2023 19:53:52 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36E371410DD5;
 Mon, 15 May 2023 19:53:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, vsementsov@yandex-team.ru,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PATCH v3 09/14] nbd/server: Initial support for extended headers
Date: Mon, 15 May 2023 14:53:38 -0500
Message-Id: <20230515195343.1915857-10-eblake@redhat.com>
In-Reply-To: <20230515195343.1915857-1-eblake@redhat.com>
References: <20230515195343.1915857-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

Time to support clients that request extended headers.  Now we can
finally reach the code added across several previous patches.

Even though the NBD spec has been altered to allow us to accept
NBD_CMD_READ larger than the max payload size (provided our response
is a hole or broken up over more than one data chunk), we are not
planning to take advantage of that, and continue to cap NBD_CMD_READ
to 32M regardless of header size.

For NBD_CMD_WRITE_ZEROES and NBD_CMD_TRIM, the block layer already
supports 64-bit operations without any effort on our part.  For
NBD_CMD_BLOCK_STATUS, the client's length is a hint, and the previous
patch took care of implementing the required
NBD_REPLY_TYPE_BLOCK_STATUS_EXT.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/nbd-internal.h |   5 +-
 nbd/server.c       | 130 +++++++++++++++++++++++++++++++++++----------
 2 files changed, 106 insertions(+), 29 deletions(-)

diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 133b1d94b50..dfa02f77ee4 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -34,8 +34,11 @@
  * https://github.com/yoe/nbd/blob/master/doc/proto.md
  */

-/* Size of all NBD_OPT_*, without payload */
+/* Size of all compact NBD_CMD_*, without payload */
 #define NBD_REQUEST_SIZE            (4 + 2 + 2 + 8 + 8 + 4)
+/* Size of all extended NBD_CMD_*, without payload */
+#define NBD_EXTENDED_REQUEST_SIZE   (4 + 2 + 2 + 8 + 8 + 8)
+
 /* Size of all NBD_REP_* sent in answer to most NBD_OPT_*, without payload */
 #define NBD_REPLY_SIZE              (4 + 4 + 8)
 /* Size of reply to NBD_OPT_EXPORT_NAME */
diff --git a/nbd/server.c b/nbd/server.c
index b4c15ae1a14..6475a76c1f0 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -482,6 +482,10 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
         [10 .. 133]   reserved     (0) [unless no_zeroes]
      */
     trace_nbd_negotiate_handle_export_name();
+    if (client->header_style >= NBD_HEADER_EXTENDED) {
+        error_setg(errp, "Extended headers already negotiated");
+        return -EINVAL;
+    }
     if (client->optlen > NBD_MAX_STRING_SIZE) {
         error_setg(errp, "Bad length received");
         return -EINVAL;
@@ -1262,7 +1266,11 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
             case NBD_OPT_STRUCTURED_REPLY:
                 if (length) {
                     ret = nbd_reject_length(client, false, errp);
-                } else if (client->header_style >= NBD_HEADER_STRUCTURED) {
+                } else if (client->header_style >= NBD_HEADER_EXTENDED) {
+                    ret = nbd_negotiate_send_rep_err(
+                        client, NBD_REP_ERR_EXT_HEADER_REQD, errp,
+                        "extended headers already negotiated");
+                } else if (client->header_style == NBD_HEADER_STRUCTURED) {
                     ret = nbd_negotiate_send_rep_err(
                         client, NBD_REP_ERR_INVALID, errp,
                         "structured reply already negotiated");
@@ -1278,6 +1286,19 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
                                                  errp);
                 break;

+            case NBD_OPT_EXTENDED_HEADERS:
+                if (length) {
+                    ret = nbd_reject_length(client, false, errp);
+                } else if (client->header_style >= NBD_HEADER_EXTENDED) {
+                    ret = nbd_negotiate_send_rep_err(
+                        client, NBD_REP_ERR_INVALID, errp,
+                        "extended headers already negotiated");
+                } else {
+                    ret = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
+                    client->header_style = NBD_HEADER_EXTENDED;
+                }
+                break;
+
             default:
                 ret = nbd_opt_drop(client, NBD_REP_ERR_UNSUP, errp,
                                    "Unsupported option %" PRIu32 " (%s)",
@@ -1413,11 +1434,13 @@ nbd_read_eof(NBDClient *client, void *buffer, size_t size, Error **errp)
 static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *request,
                                             Error **errp)
 {
-    uint8_t buf[NBD_REQUEST_SIZE];
-    uint32_t magic;
+    uint8_t buf[NBD_EXTENDED_REQUEST_SIZE];
+    uint32_t magic, expect;
     int ret;
+    size_t size = client->header_style == NBD_HEADER_EXTENDED ?
+        NBD_EXTENDED_REQUEST_SIZE : NBD_REQUEST_SIZE;

-    ret = nbd_read_eof(client, buf, sizeof(buf), errp);
+    ret = nbd_read_eof(client, buf, size, errp);
     if (ret < 0) {
         return ret;
     }
@@ -1425,13 +1448,21 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
         return -EIO;
     }

-    /* Request
-       [ 0 ..  3]   magic   (NBD_REQUEST_MAGIC)
-       [ 4 ..  5]   flags   (NBD_CMD_FLAG_FUA, ...)
-       [ 6 ..  7]   type    (NBD_CMD_READ, ...)
-       [ 8 .. 15]   handle
-       [16 .. 23]   from
-       [24 .. 27]   len
+    /*
+     * Compact request
+     *  [ 0 ..  3]   magic   (NBD_REQUEST_MAGIC)
+     *  [ 4 ..  5]   flags   (NBD_CMD_FLAG_FUA, ...)
+     *  [ 6 ..  7]   type    (NBD_CMD_READ, ...)
+     *  [ 8 .. 15]   handle
+     *  [16 .. 23]   from
+     *  [24 .. 27]   len
+     * Extended request
+     *  [ 0 ..  3]   magic   (NBD_EXTENDED_REQUEST_MAGIC)
+     *  [ 4 ..  5]   flags   (NBD_CMD_FLAG_FUA, NBD_CMD_FLAG_PAYLOAD_LEN, ...)
+     *  [ 6 ..  7]   type    (NBD_CMD_READ, ...)
+     *  [ 8 .. 15]   handle
+     *  [16 .. 23]   from
+     *  [24 .. 31]   len
      */

     magic = ldl_be_p(buf);
@@ -1439,12 +1470,18 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
     request->type   = lduw_be_p(buf + 6);
     request->handle = ldq_be_p(buf + 8);
     request->from   = ldq_be_p(buf + 16);
-    request->len    = ldl_be_p(buf + 24); /* widen 32 to 64 bits */
+    if (client->header_style >= NBD_HEADER_EXTENDED) {
+        request->len = ldq_be_p(buf + 24);
+        expect = NBD_EXTENDED_REQUEST_MAGIC;
+    } else {
+        request->len = ldl_be_p(buf + 24); /* widen 32 to 64 bits */
+        expect = NBD_REQUEST_MAGIC;
+    }

     trace_nbd_receive_request(magic, request->flags, request->type,
                               request->from, request->len);

-    if (magic != NBD_REQUEST_MAGIC) {
+    if (magic != expect) {
         error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
         return -EINVAL;
     }
@@ -1887,14 +1924,37 @@ static int coroutine_fn nbd_co_send_iov(NBDClient *client, struct iovec *iov,
 }

 static inline void set_be_simple_reply(NBDClient *client, struct iovec *iov,
-                                       uint64_t error, NBDRequest *request)
+                                       uint32_t error, NBDStructuredError *err,
+                                       NBDRequest *request)
 {
-    NBDSimpleReply *reply = iov->iov_base;
+    if (client->header_style >= NBD_HEADER_EXTENDED) {
+        NBDExtendedReplyChunk *chunk = iov->iov_base;

-    iov->iov_len = sizeof(*reply);
-    stl_be_p(&reply->magic, NBD_SIMPLE_REPLY_MAGIC);
-    stl_be_p(&reply->error, error);
-    stq_be_p(&reply->handle, request->handle);
+        iov->iov_len = sizeof(*chunk);
+        stl_be_p(&chunk->magic, NBD_EXTENDED_REPLY_MAGIC);
+        stw_be_p(&chunk->flags, NBD_REPLY_FLAG_DONE);
+        stq_be_p(&chunk->handle, request->handle);
+        stq_be_p(&chunk->offset, request->from);
+        if (error) {
+            assert(!iov[1].iov_base);
+            iov[1].iov_base = err;
+            iov[1].iov_len = sizeof(*err);
+            stw_be_p(&chunk->type, NBD_REPLY_TYPE_ERROR);
+            stq_be_p(&chunk->length, sizeof(*err));
+            stl_be_p(&err->error, error);
+            stw_be_p(&err->message_length, 0);
+        } else {
+            stw_be_p(&chunk->type, NBD_REPLY_TYPE_NONE);
+            stq_be_p(&chunk->length, 0);
+        }
+    } else {
+        NBDSimpleReply *reply = iov->iov_base;
+
+        iov->iov_len = sizeof(*reply);
+        stl_be_p(&reply->magic, NBD_SIMPLE_REPLY_MAGIC);
+        stl_be_p(&reply->error, error);
+        stq_be_p(&reply->handle, request->handle);
+    }
 }

 static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
@@ -1906,30 +1966,44 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
 {
     NBDReply hdr;
     int nbd_err = system_errno_to_nbd_errno(error);
+    NBDStructuredError err;
     struct iovec iov[] = {
         {.iov_base = &hdr},
         {.iov_base = data, .iov_len = len}
     };

+    assert(!len || !nbd_err);
     trace_nbd_co_send_simple_reply(request->handle, nbd_err,
                                    nbd_err_lookup(nbd_err), len);
-    set_be_simple_reply(client, &iov[0], nbd_err, request);
+    set_be_simple_reply(client, &iov[0], nbd_err, &err, request);

-    return nbd_co_send_iov(client, iov, len ? 2 : 1, errp);
+    return nbd_co_send_iov(client, iov, iov[1].iov_len ? 2 : 1, errp);
 }

 static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
                                 uint16_t flags, uint16_t type,
                                 NBDRequest *request, uint32_t length)
 {
-    NBDStructuredReplyChunk *chunk = iov->iov_base;
+    if (client->header_style >= NBD_HEADER_EXTENDED) {
+        NBDExtendedReplyChunk *chunk = iov->iov_base;

-    iov->iov_len = sizeof(*chunk);
-    stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
-    stw_be_p(&chunk->flags, flags);
-    stw_be_p(&chunk->type, type);
-    stq_be_p(&chunk->handle, request->handle);
-    stl_be_p(&chunk->length, length);
+        iov->iov_len = sizeof(*chunk);
+        stl_be_p(&chunk->magic, NBD_EXTENDED_REPLY_MAGIC);
+        stw_be_p(&chunk->flags, flags);
+        stw_be_p(&chunk->type, type);
+        stq_be_p(&chunk->handle, request->handle);
+        stq_be_p(&chunk->offset, request->from);
+        stq_be_p(&chunk->length, length);
+    } else {
+        NBDStructuredReplyChunk *chunk = iov->iov_base;
+
+        iov->iov_len = sizeof(*chunk);
+        stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
+        stw_be_p(&chunk->flags, flags);
+        stw_be_p(&chunk->type, type);
+        stq_be_p(&chunk->handle, request->handle);
+        stl_be_p(&chunk->length, length);
+    }
 }

 static int coroutine_fn nbd_co_send_structured_done(NBDClient *client,
-- 
2.40.1


