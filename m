Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED1D728212
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:02:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7G8t-00048k-AB; Thu, 08 Jun 2023 09:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8V-0003tM-9J
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8O-0004fC-1i
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686232623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0MRSY00ZzZNFI+oEzrqbs+Q5FGrrhrzhwh3Yd/lHwXY=;
 b=BDcoMkL3DnxosPtJK5M7HDClyNshk67ygYPSeLXnJRUAeBOYHvAY/W2X8x6oSsrTbM6YI4
 DKvyw8tzYrTBZxahA67Ub60Pg/WkLAGyAjbTXHhA6DNG/OiXrx01AlSSvQ26WAxUB37Jqf
 c905txhqa71RmisNwc9ORnxHX/U2LGU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-a4sTQtrnP7uL-BWc2ZOm7w-1; Thu, 08 Jun 2023 09:57:00 -0400
X-MC-Unique: a4sTQtrnP7uL-BWc2ZOm7w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9ECF9280D58D;
 Thu,  8 Jun 2023 13:56:59 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22D78515540;
 Thu,  8 Jun 2023 13:56:59 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	libguestfs@redhat.com,
	vsementsov@yandex-team.ru
Subject: [PATCH v4 04/24] nbd/server: Refactor to pass full request around
Date: Thu,  8 Jun 2023 08:56:33 -0500
Message-Id: <20230608135653.2918540-5-eblake@redhat.com>
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

Part of NBD's 64-bit headers extension involves passing the client's
requested offset back as part of the reply header (one reason it
stated for this change: converting absolute offsets stored in
NBD_REPLY_TYPE_OFFSET_DATA to relative offsets within the buffer is
easier if the absolute offset of the buffer is also available).  This
is a refactoring patch to pass the full request around the reply
stack, rather than just the handle, so that later patches can then
access request->from when extended headers are active.  Meanwhile,
this patch enables us to now assert that simple replies are only
attempted when appropriate, and otherwise has no semantic change.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

v4: reorder earlier in series, add assertion, keep R-b
---
 nbd/server.c | 114 ++++++++++++++++++++++++++-------------------------
 1 file changed, 59 insertions(+), 55 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 6698ab46365..26b27d69202 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1893,7 +1893,7 @@ static inline void set_be_simple_reply(NBDSimpleReply *reply, uint64_t error,
 }

 static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
-                                                 uint64_t handle,
+                                                 NBDRequest *request,
                                                  uint32_t error,
                                                  void *data,
                                                  size_t len,
@@ -1907,9 +1907,10 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
     };

     assert(!len || !nbd_err);
-    trace_nbd_co_send_simple_reply(handle, nbd_err, nbd_err_lookup(nbd_err),
-                                   len);
-    set_be_simple_reply(&reply, nbd_err, handle);
+    assert(!client->structured_reply || request->type != NBD_CMD_READ);
+    trace_nbd_co_send_simple_reply(request->handle, nbd_err,
+                                   nbd_err_lookup(nbd_err), len);
+    set_be_simple_reply(&reply, nbd_err, request->handle);

     return nbd_co_send_iov(client, iov, 2, errp);
 }
@@ -1924,7 +1925,7 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
  */
 static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
                                 size_t niov, uint16_t flags, uint16_t type,
-                                uint64_t handle)
+                                NBDRequest *request)
 {
     /* TODO - handle structured vs. extended replies */
     NBDStructuredReplyChunk *chunk = iov->iov_base;
@@ -1939,12 +1940,12 @@ static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
     stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
     stw_be_p(&chunk->flags, flags);
     stw_be_p(&chunk->type, type);
-    stq_be_p(&chunk->handle, handle);
+    stq_be_p(&chunk->handle, request->handle);
     stl_be_p(&chunk->length, length);
 }

 static int coroutine_fn nbd_co_send_chunk_done(NBDClient *client,
-                                               uint64_t handle,
+                                               NBDRequest *request,
                                                Error **errp)
 {
     NBDReply hdr;
@@ -1952,15 +1953,15 @@ static int coroutine_fn nbd_co_send_chunk_done(NBDClient *client,
         {.iov_base = &hdr},
     };

-    trace_nbd_co_send_chunk_done(handle);
+    trace_nbd_co_send_chunk_done(request->handle);
     set_be_chunk(client, iov, 1, NBD_REPLY_FLAG_DONE,
-                 NBD_REPLY_TYPE_NONE, handle);
+                 NBD_REPLY_TYPE_NONE, request);

     return nbd_co_send_iov(client, iov, 1, errp);
 }

 static int coroutine_fn nbd_co_send_chunk_read(NBDClient *client,
-                                               uint64_t handle,
+                                               NBDRequest *request,
                                                uint64_t offset,
                                                void *data,
                                                size_t size,
@@ -1976,16 +1977,16 @@ static int coroutine_fn nbd_co_send_chunk_read(NBDClient *client,
     };

     assert(size);
-    trace_nbd_co_send_chunk_read(handle, offset, data, size);
+    trace_nbd_co_send_chunk_read(request->handle, offset, data, size);
     set_be_chunk(client, iov, 3, final ? NBD_REPLY_FLAG_DONE : 0,
-                 NBD_REPLY_TYPE_OFFSET_DATA, handle);
+                 NBD_REPLY_TYPE_OFFSET_DATA, request);
     stq_be_p(&chunk.offset, offset);

     return nbd_co_send_iov(client, iov, 3, errp);
 }
-
+/*ebb*/
 static int coroutine_fn nbd_co_send_chunk_error(NBDClient *client,
-                                                uint64_t handle,
+                                                NBDRequest *request,
                                                 uint32_t error,
                                                 const char *msg,
                                                 Error **errp)
@@ -2000,10 +2001,10 @@ static int coroutine_fn nbd_co_send_chunk_error(NBDClient *client,
     };

     assert(nbd_err);
-    trace_nbd_co_send_chunk_error(handle, nbd_err,
+    trace_nbd_co_send_chunk_error(request->handle, nbd_err,
                                   nbd_err_lookup(nbd_err), msg ? msg : "");
     set_be_chunk(client, iov, 3, NBD_REPLY_FLAG_DONE,
-                 NBD_REPLY_TYPE_ERROR, handle);
+                 NBD_REPLY_TYPE_ERROR, request);
     stl_be_p(&chunk.error, nbd_err);
     stw_be_p(&chunk.message_length, iov[2].iov_len);

@@ -2015,7 +2016,7 @@ static int coroutine_fn nbd_co_send_chunk_error(NBDClient *client,
  * reported to the client, at which point this function succeeds.
  */
 static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
-                                                uint64_t handle,
+                                                NBDRequest *request,
                                                 uint64_t offset,
                                                 uint8_t *data,
                                                 size_t size,
@@ -2037,7 +2038,7 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
             char *msg = g_strdup_printf("unable to check for holes: %s",
                                         strerror(-status));

-            ret = nbd_co_send_chunk_error(client, handle, -status, msg, errp);
+            ret = nbd_co_send_chunk_error(client, request, -status, msg, errp);
             g_free(msg);
             return ret;
         }
@@ -2051,10 +2052,11 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
                 {.iov_base = &chunk, .iov_len = sizeof(chunk)},
             };

-            trace_nbd_co_send_chunk_read_hole(handle, offset + progress, pnum);
+            trace_nbd_co_send_chunk_read_hole(request->handle,
+                                              offset + progress, pnum);
             set_be_chunk(client, iov, 2,
                          final ? NBD_REPLY_FLAG_DONE : 0,
-                         NBD_REPLY_TYPE_OFFSET_HOLE, handle);
+                         NBD_REPLY_TYPE_OFFSET_HOLE, request);
             stq_be_p(&chunk.offset, offset + progress);
             stl_be_p(&chunk.length, pnum);
             ret = nbd_co_send_iov(client, iov, 2, errp);
@@ -2065,7 +2067,7 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
                 error_setg_errno(errp, -ret, "reading from file failed");
                 break;
             }
-            ret = nbd_co_send_chunk_read(client, handle, offset + progress,
+            ret = nbd_co_send_chunk_read(client, request, offset + progress,
                                          data + progress, pnum, final, errp);
         }

@@ -2219,7 +2221,7 @@ static int coroutine_fn blockalloc_to_extents(BlockBackend *blk,
  * @last controls whether NBD_REPLY_FLAG_DONE is sent.
  */
 static int coroutine_fn
-nbd_co_send_extents(NBDClient *client, uint64_t handle, NBDExtentArray *ea,
+nbd_co_send_extents(NBDClient *client, NBDRequest *request, NBDExtentArray *ea,
                     bool last, uint32_t context_id, Error **errp)
 {
     NBDReply hdr;
@@ -2232,10 +2234,10 @@ nbd_co_send_extents(NBDClient *client, uint64_t handle, NBDExtentArray *ea,

     nbd_extent_array_convert_to_be(ea);

-    trace_nbd_co_send_extents(handle, ea->count, context_id, ea->total_length,
-                              last);
+    trace_nbd_co_send_extents(request->handle, ea->count, context_id,
+                              ea->total_length, last);
     set_be_chunk(client, iov, 3, last ? NBD_REPLY_FLAG_DONE : 0,
-                 NBD_REPLY_TYPE_BLOCK_STATUS, handle);
+                 NBD_REPLY_TYPE_BLOCK_STATUS, request);
     stl_be_p(&chunk.context_id, context_id);

     return nbd_co_send_iov(client, iov, 3, errp);
@@ -2243,7 +2245,7 @@ nbd_co_send_extents(NBDClient *client, uint64_t handle, NBDExtentArray *ea,

 /* Get block status from the exported device and send it to the client */
 static int
-coroutine_fn nbd_co_send_block_status(NBDClient *client, uint64_t handle,
+coroutine_fn nbd_co_send_block_status(NBDClient *client, NBDRequest *request,
                                       BlockBackend *blk, uint64_t offset,
                                       uint32_t length, bool dont_fragment,
                                       bool last, uint32_t context_id,
@@ -2259,11 +2261,11 @@ coroutine_fn nbd_co_send_block_status(NBDClient *client, uint64_t handle,
         ret = blockalloc_to_extents(blk, offset, length, ea);
     }
     if (ret < 0) {
-        return nbd_co_send_chunk_error(client, handle, -ret,
+        return nbd_co_send_chunk_error(client, request, -ret,
                                        "can't get block status", errp);
     }

-    return nbd_co_send_extents(client, handle, ea, last, context_id, errp);
+    return nbd_co_send_extents(client, request, ea, last, context_id, errp);
 }

 /* Populate @ea from a dirty bitmap. */
@@ -2298,17 +2300,20 @@ static void bitmap_to_extents(BdrvDirtyBitmap *bitmap,
     bdrv_dirty_bitmap_unlock(bitmap);
 }

-static int coroutine_fn nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
-                                           BdrvDirtyBitmap *bitmap, uint64_t offset,
-                                           uint32_t length, bool dont_fragment, bool last,
-                                           uint32_t context_id, Error **errp)
+static int coroutine_fn nbd_co_send_bitmap(NBDClient *client,
+                                           NBDRequest *request,
+                                           BdrvDirtyBitmap *bitmap,
+                                           uint64_t offset,
+                                           uint32_t length, bool dont_fragment,
+                                           bool last, uint32_t context_id,
+                                           Error **errp)
 {
     unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_EXTENTS;
     g_autoptr(NBDExtentArray) ea = nbd_extent_array_new(nb_extents);

     bitmap_to_extents(bitmap, offset, length, ea);

-    return nbd_co_send_extents(client, handle, ea, last, context_id, errp);
+    return nbd_co_send_extents(client, request, ea, last, context_id, errp);
 }

 /* nbd_co_receive_request
@@ -2426,15 +2431,15 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
  * Returns 0 if connection is still live, -errno on failure to talk to client
  */
 static coroutine_fn int nbd_send_generic_reply(NBDClient *client,
-                                               uint64_t handle,
+                                               NBDRequest *request,
                                                int ret,
                                                const char *error_msg,
                                                Error **errp)
 {
     if (client->structured_reply && ret < 0) {
-        return nbd_co_send_chunk_error(client, handle, -ret, error_msg, errp);
+        return nbd_co_send_chunk_error(client, request, -ret, error_msg, errp);
     } else {
-        return nbd_co_send_simple_reply(client, handle, ret < 0 ? -ret : 0,
+        return nbd_co_send_simple_reply(client, request, ret < 0 ? -ret : 0,
                                         NULL, 0, errp);
     }
 }
@@ -2454,7 +2459,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
     if (request->flags & NBD_CMD_FLAG_FUA) {
         ret = blk_co_flush(exp->common.blk);
         if (ret < 0) {
-            return nbd_send_generic_reply(client, request->handle, ret,
+            return nbd_send_generic_reply(client, request, ret,
                                           "flush failed", errp);
         }
     }
@@ -2462,26 +2467,25 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
     if (client->structured_reply && !(request->flags & NBD_CMD_FLAG_DF) &&
         request->len)
     {
-        return nbd_co_send_sparse_read(client, request->handle, request->from,
+        return nbd_co_send_sparse_read(client, request, request->from,
                                        data, request->len, errp);
     }

     ret = blk_co_pread(exp->common.blk, request->from, request->len, data, 0);
     if (ret < 0) {
-        return nbd_send_generic_reply(client, request->handle, ret,
+        return nbd_send_generic_reply(client, request, ret,
                                       "reading from file failed", errp);
     }

     if (client->structured_reply) {
         if (request->len) {
-            return nbd_co_send_chunk_read(client, request->handle,
-                                          request->from, data,
+            return nbd_co_send_chunk_read(client, request, request->from, data,
                                           request->len, true, errp);
         } else {
-            return nbd_co_send_chunk_done(client, request->handle, errp);
+            return nbd_co_send_chunk_done(client, request, errp);
         }
     } else {
-        return nbd_co_send_simple_reply(client, request->handle, 0,
+        return nbd_co_send_simple_reply(client, request, 0,
                                         data, request->len, errp);
     }
 }
@@ -2504,7 +2508,7 @@ static coroutine_fn int nbd_do_cmd_cache(NBDClient *client, NBDRequest *request,
     ret = blk_co_preadv(exp->common.blk, request->from, request->len,
                         NULL, BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);

-    return nbd_send_generic_reply(client, request->handle, ret,
+    return nbd_send_generic_reply(client, request, ret,
                                   "caching data failed", errp);
 }

@@ -2535,7 +2539,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         }
         ret = blk_co_pwrite(exp->common.blk, request->from, request->len, data,
                             flags);
-        return nbd_send_generic_reply(client, request->handle, ret,
+        return nbd_send_generic_reply(client, request, ret,
                                       "writing to file failed", errp);

     case NBD_CMD_WRITE_ZEROES:
@@ -2551,7 +2555,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         }
         ret = blk_co_pwrite_zeroes(exp->common.blk, request->from, request->len,
                                    flags);
-        return nbd_send_generic_reply(client, request->handle, ret,
+        return nbd_send_generic_reply(client, request, ret,
                                       "writing to file failed", errp);

     case NBD_CMD_DISC:
@@ -2560,7 +2564,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,

     case NBD_CMD_FLUSH:
         ret = blk_co_flush(exp->common.blk);
-        return nbd_send_generic_reply(client, request->handle, ret,
+        return nbd_send_generic_reply(client, request, ret,
                                       "flush failed", errp);

     case NBD_CMD_TRIM:
@@ -2568,12 +2572,12 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         if (ret >= 0 && request->flags & NBD_CMD_FLAG_FUA) {
             ret = blk_co_flush(exp->common.blk);
         }
-        return nbd_send_generic_reply(client, request->handle, ret,
+        return nbd_send_generic_reply(client, request, ret,
                                       "discard failed", errp);

     case NBD_CMD_BLOCK_STATUS:
         if (!request->len) {
-            return nbd_send_generic_reply(client, request->handle, -EINVAL,
+            return nbd_send_generic_reply(client, request, -EINVAL,
                                           "need non-zero length", errp);
         }
         if (client->export_meta.count) {
@@ -2581,7 +2585,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
             int contexts_remaining = client->export_meta.count;

             if (client->export_meta.base_allocation) {
-                ret = nbd_co_send_block_status(client, request->handle,
+                ret = nbd_co_send_block_status(client, request,
                                                exp->common.blk,
                                                request->from,
                                                request->len, dont_fragment,
@@ -2594,7 +2598,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
             }

             if (client->export_meta.allocation_depth) {
-                ret = nbd_co_send_block_status(client, request->handle,
+                ret = nbd_co_send_block_status(client, request,
                                                exp->common.blk,
                                                request->from, request->len,
                                                dont_fragment,
@@ -2610,7 +2614,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                 if (!client->export_meta.bitmaps[i]) {
                     continue;
                 }
-                ret = nbd_co_send_bitmap(client, request->handle,
+                ret = nbd_co_send_bitmap(client, request,
                                          client->exp->export_bitmaps[i],
                                          request->from, request->len,
                                          dont_fragment, !--contexts_remaining,
@@ -2624,7 +2628,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,

             return 0;
         } else {
-            return nbd_send_generic_reply(client, request->handle, -EINVAL,
+            return nbd_send_generic_reply(client, request, -EINVAL,
                                           "CMD_BLOCK_STATUS not negotiated",
                                           errp);
         }
@@ -2632,7 +2636,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
     default:
         msg = g_strdup_printf("invalid request type (%" PRIu32 ") received",
                               request->type);
-        ret = nbd_send_generic_reply(client, request->handle, -EINVAL, msg,
+        ret = nbd_send_generic_reply(client, request, -EINVAL, msg,
                                      errp);
         g_free(msg);
         return ret;
@@ -2695,7 +2699,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         Error *export_err = local_err;

         local_err = NULL;
-        ret = nbd_send_generic_reply(client, request.handle, -EINVAL,
+        ret = nbd_send_generic_reply(client, &request, -EINVAL,
                                      error_get_pretty(export_err), &local_err);
         error_free(export_err);
     } else {
-- 
2.40.1


