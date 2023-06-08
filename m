Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA137281F3
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:58:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7G8l-00042i-Sv; Thu, 08 Jun 2023 09:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8V-0003tL-8S
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8N-0004eS-Hx
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686232621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=exAPpjNFpQdIDU1RlqkHA2fF0HUrXaD17Puo6xs/MGQ=;
 b=RmmrxZYsvR0SjknubbsrSD1OW3GclKVG1twkjR8GV5jEUrEdRyzCM+Dcte9Muidu5LBiMq
 t254Djx8mQ2jgEL2oscnX66/dB6cyMGhSwvuTcSQJfibW+c8E6+RfLoP3ei2wuuFcT0nNx
 +qwoEN7s2ibEXmGUVGp52gPy92mdB8E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93--5Gn8zZDMrKs2oQVtM3oDg-1; Thu, 08 Jun 2023 09:57:00 -0400
X-MC-Unique: -5Gn8zZDMrKs2oQVtM3oDg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDB16280D59E;
 Thu,  8 Jun 2023 13:56:58 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 461A3515546;
 Thu,  8 Jun 2023 13:56:58 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 03/24] nbd/server: Prepare for alternate-size headers
Date: Thu,  8 Jun 2023 08:56:32 -0500
Message-Id: <20230608135653.2918540-4-eblake@redhat.com>
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

Upstream NBD now documents[1] an extension that supports 64-bit effect
lengths in requests.  As part of that extension, the size of the reply
headers will change in order to permit a 64-bit length in the reply
for symmetry[2].  Additionally, where the reply header is currently 16
bytes for simple reply, and 20 bytes for structured reply; with the
extension enabled, there will only be one extended reply header, of 32
bytes, with both structured and extended modes sending identical
payloads for chunked replies.

Since we are already wired up to use iovecs, it is easiest to allow
for this change in header size by splitting each structured reply
across multiple iovecs, one for the header (which will become wider in
a future patch according to client negotiation), and the other(s) for
the chunk payload, and removing the header from the payload struct
definitions.  Rename the affected functions with s/structured/chunk/
to make it obvious that the code will be reused in extended mode.

Interestingly, the client side code never utilized the packed types,
so only the server code needs to be updated.

[1] https://github.com/NetworkBlockDevice/nbd/blob/extension-ext-header/doc/proto.md
as of NBD commit e6f3b94a934

[2] Note that on the surface, this is because some future server might
permit a 4G+ NBD_CMD_READ and need to reply with that much data in one
transaction.  But even though the extended reply length is widened to
64 bits, for now the NBD spec is clear that servers will not reply
with more than a maximum payload bounded by the 32-bit
NBD_INFO_BLOCK_SIZE field; allowing a client and server to mutually
agree to transactions larger than 4G would require yet another
extension.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v4: hoist earlier in series, drop most changes to
nbd_co_send_simple_reply, pass niov to set_be_chunk, rename several
functions, drop R-b
---
 include/block/nbd.h |   8 +--
 nbd/server.c        | 137 ++++++++++++++++++++++++++------------------
 nbd/trace-events    |   8 +--
 3 files changed, 88 insertions(+), 65 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 9c3ceae5ba5..e563f1774b0 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -96,28 +96,28 @@ typedef union NBDReply {

 /* Header of chunk for NBD_REPLY_TYPE_OFFSET_DATA */
 typedef struct NBDStructuredReadData {
-    NBDStructuredReplyChunk h; /* h.length >= 9 */
+    /* header's .length >= 9 */
     uint64_t offset;
     /* At least one byte of data payload follows, calculated from h.length */
 } QEMU_PACKED NBDStructuredReadData;

 /* Complete chunk for NBD_REPLY_TYPE_OFFSET_HOLE */
 typedef struct NBDStructuredReadHole {
-    NBDStructuredReplyChunk h; /* h.length == 12 */
+    /* header's length == 12 */
     uint64_t offset;
     uint32_t length;
 } QEMU_PACKED NBDStructuredReadHole;

 /* Header of all NBD_REPLY_TYPE_ERROR* errors */
 typedef struct NBDStructuredError {
-    NBDStructuredReplyChunk h; /* h.length >= 6 */
+    /* header's length >= 6 */
     uint32_t error;
     uint16_t message_length;
 } QEMU_PACKED NBDStructuredError;

 /* Header of NBD_REPLY_TYPE_BLOCK_STATUS */
 typedef struct NBDStructuredMeta {
-    NBDStructuredReplyChunk h; /* h.length >= 12 (at least one extent) */
+    /* header's length >= 12 (at least one extent) */
     uint32_t context_id;
     /* extents follows */
 } QEMU_PACKED NBDStructuredMeta;
diff --git a/nbd/server.c b/nbd/server.c
index febe001a399..6698ab46365 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2022 Red Hat, Inc.
+ *  Copyright Red Hat
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device Server Side
@@ -1906,16 +1906,36 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
         {.iov_base = data, .iov_len = len}
     };

+    assert(!len || !nbd_err);
     trace_nbd_co_send_simple_reply(handle, nbd_err, nbd_err_lookup(nbd_err),
                                    len);
     set_be_simple_reply(&reply, nbd_err, handle);

-    return nbd_co_send_iov(client, iov, len ? 2 : 1, errp);
+    return nbd_co_send_iov(client, iov, 2, errp);
 }

-static inline void set_be_chunk(NBDStructuredReplyChunk *chunk, uint16_t flags,
-                                uint16_t type, uint64_t handle, uint32_t length)
+/*
+ * Prepare the header of a reply chunk for network transmission.
+ *
+ * On input, @iov is partially initialized: iov[0].iov_base must point
+ * to an uninitialized NBDReply, while the remaining @niov elements
+ * (if any) must be ready for transmission.  This function then
+ * populates iov[0] for transmission.
+ */
+static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
+                                size_t niov, uint16_t flags, uint16_t type,
+                                uint64_t handle)
 {
+    /* TODO - handle structured vs. extended replies */
+    NBDStructuredReplyChunk *chunk = iov->iov_base;
+    size_t i, length = 0;
+
+    for (i = 1; i < niov; i++) {
+        length += iov[i].iov_len;
+    }
+    assert(length <= NBD_MAX_BUFFER_SIZE + sizeof(NBDStructuredReadData));
+
+    iov[0].iov_len = sizeof(*chunk);
     stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
     stw_be_p(&chunk->flags, flags);
     stw_be_p(&chunk->type, type);
@@ -1923,67 +1943,71 @@ static inline void set_be_chunk(NBDStructuredReplyChunk *chunk, uint16_t flags,
     stl_be_p(&chunk->length, length);
 }

-static int coroutine_fn nbd_co_send_structured_done(NBDClient *client,
-                                                    uint64_t handle,
-                                                    Error **errp)
+static int coroutine_fn nbd_co_send_chunk_done(NBDClient *client,
+                                               uint64_t handle,
+                                               Error **errp)
 {
-    NBDStructuredReplyChunk chunk;
+    NBDReply hdr;
     struct iovec iov[] = {
-        {.iov_base = &chunk, .iov_len = sizeof(chunk)},
+        {.iov_base = &hdr},
     };

-    trace_nbd_co_send_structured_done(handle);
-    set_be_chunk(&chunk, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_NONE, handle, 0);
+    trace_nbd_co_send_chunk_done(handle);
+    set_be_chunk(client, iov, 1, NBD_REPLY_FLAG_DONE,
+                 NBD_REPLY_TYPE_NONE, handle);

     return nbd_co_send_iov(client, iov, 1, errp);
 }

-static int coroutine_fn nbd_co_send_structured_read(NBDClient *client,
-                                                    uint64_t handle,
-                                                    uint64_t offset,
-                                                    void *data,
-                                                    size_t size,
-                                                    bool final,
-                                                    Error **errp)
+static int coroutine_fn nbd_co_send_chunk_read(NBDClient *client,
+                                               uint64_t handle,
+                                               uint64_t offset,
+                                               void *data,
+                                               size_t size,
+                                               bool final,
+                                               Error **errp)
 {
+    NBDReply hdr;
     NBDStructuredReadData chunk;
     struct iovec iov[] = {
+        {.iov_base = &hdr},
         {.iov_base = &chunk, .iov_len = sizeof(chunk)},
         {.iov_base = data, .iov_len = size}
     };

     assert(size);
-    trace_nbd_co_send_structured_read(handle, offset, data, size);
-    set_be_chunk(&chunk.h, final ? NBD_REPLY_FLAG_DONE : 0,
-                 NBD_REPLY_TYPE_OFFSET_DATA, handle,
-                 sizeof(chunk) - sizeof(chunk.h) + size);
+    trace_nbd_co_send_chunk_read(handle, offset, data, size);
+    set_be_chunk(client, iov, 3, final ? NBD_REPLY_FLAG_DONE : 0,
+                 NBD_REPLY_TYPE_OFFSET_DATA, handle);
     stq_be_p(&chunk.offset, offset);

-    return nbd_co_send_iov(client, iov, 2, errp);
+    return nbd_co_send_iov(client, iov, 3, errp);
 }

-static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
-                                                     uint64_t handle,
-                                                     uint32_t error,
-                                                     const char *msg,
-                                                     Error **errp)
+static int coroutine_fn nbd_co_send_chunk_error(NBDClient *client,
+                                                uint64_t handle,
+                                                uint32_t error,
+                                                const char *msg,
+                                                Error **errp)
 {
+    NBDReply hdr;
     NBDStructuredError chunk;
     int nbd_err = system_errno_to_nbd_errno(error);
     struct iovec iov[] = {
+        {.iov_base = &hdr},
         {.iov_base = &chunk, .iov_len = sizeof(chunk)},
         {.iov_base = (char *)msg, .iov_len = msg ? strlen(msg) : 0},
     };

     assert(nbd_err);
-    trace_nbd_co_send_structured_error(handle, nbd_err,
-                                       nbd_err_lookup(nbd_err), msg ? msg : "");
-    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_ERROR, handle,
-                 sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len);
+    trace_nbd_co_send_chunk_error(handle, nbd_err,
+                                  nbd_err_lookup(nbd_err), msg ? msg : "");
+    set_be_chunk(client, iov, 3, NBD_REPLY_FLAG_DONE,
+                 NBD_REPLY_TYPE_ERROR, handle);
     stl_be_p(&chunk.error, nbd_err);
-    stw_be_p(&chunk.message_length, iov[1].iov_len);
+    stw_be_p(&chunk.message_length, iov[2].iov_len);

-    return nbd_co_send_iov(client, iov, 1 + !!iov[1].iov_len, errp);
+    return nbd_co_send_iov(client, iov, 3, errp);
 }

 /* Do a sparse read and send the structured reply to the client.
@@ -2013,27 +2037,27 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
             char *msg = g_strdup_printf("unable to check for holes: %s",
                                         strerror(-status));

-            ret = nbd_co_send_structured_error(client, handle, -status, msg,
-                                               errp);
+            ret = nbd_co_send_chunk_error(client, handle, -status, msg, errp);
             g_free(msg);
             return ret;
         }
         assert(pnum && pnum <= size - progress);
         final = progress + pnum == size;
         if (status & BDRV_BLOCK_ZERO) {
+            NBDReply hdr;
             NBDStructuredReadHole chunk;
             struct iovec iov[] = {
+                {.iov_base = &hdr},
                 {.iov_base = &chunk, .iov_len = sizeof(chunk)},
             };

-            trace_nbd_co_send_structured_read_hole(handle, offset + progress,
-                                                   pnum);
-            set_be_chunk(&chunk.h, final ? NBD_REPLY_FLAG_DONE : 0,
-                         NBD_REPLY_TYPE_OFFSET_HOLE,
-                         handle, sizeof(chunk) - sizeof(chunk.h));
+            trace_nbd_co_send_chunk_read_hole(handle, offset + progress, pnum);
+            set_be_chunk(client, iov, 2,
+                         final ? NBD_REPLY_FLAG_DONE : 0,
+                         NBD_REPLY_TYPE_OFFSET_HOLE, handle);
             stq_be_p(&chunk.offset, offset + progress);
             stl_be_p(&chunk.length, pnum);
-            ret = nbd_co_send_iov(client, iov, 1, errp);
+            ret = nbd_co_send_iov(client, iov, 2, errp);
         } else {
             ret = blk_co_pread(exp->common.blk, offset + progress, pnum,
                                data + progress, 0);
@@ -2041,9 +2065,8 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
                 error_setg_errno(errp, -ret, "reading from file failed");
                 break;
             }
-            ret = nbd_co_send_structured_read(client, handle, offset + progress,
-                                              data + progress, pnum, final,
-                                              errp);
+            ret = nbd_co_send_chunk_read(client, handle, offset + progress,
+                                         data + progress, pnum, final, errp);
         }

         if (ret < 0) {
@@ -2199,8 +2222,10 @@ static int coroutine_fn
 nbd_co_send_extents(NBDClient *client, uint64_t handle, NBDExtentArray *ea,
                     bool last, uint32_t context_id, Error **errp)
 {
+    NBDReply hdr;
     NBDStructuredMeta chunk;
     struct iovec iov[] = {
+        {.iov_base = &hdr},
         {.iov_base = &chunk, .iov_len = sizeof(chunk)},
         {.iov_base = ea->extents, .iov_len = ea->count * sizeof(ea->extents[0])}
     };
@@ -2209,12 +2234,11 @@ nbd_co_send_extents(NBDClient *client, uint64_t handle, NBDExtentArray *ea,

     trace_nbd_co_send_extents(handle, ea->count, context_id, ea->total_length,
                               last);
-    set_be_chunk(&chunk.h, last ? NBD_REPLY_FLAG_DONE : 0,
-                 NBD_REPLY_TYPE_BLOCK_STATUS,
-                 handle, sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len);
+    set_be_chunk(client, iov, 3, last ? NBD_REPLY_FLAG_DONE : 0,
+                 NBD_REPLY_TYPE_BLOCK_STATUS, handle);
     stl_be_p(&chunk.context_id, context_id);

-    return nbd_co_send_iov(client, iov, 2, errp);
+    return nbd_co_send_iov(client, iov, 3, errp);
 }

 /* Get block status from the exported device and send it to the client */
@@ -2235,8 +2259,8 @@ coroutine_fn nbd_co_send_block_status(NBDClient *client, uint64_t handle,
         ret = blockalloc_to_extents(blk, offset, length, ea);
     }
     if (ret < 0) {
-        return nbd_co_send_structured_error(
-                client, handle, -ret, "can't get block status", errp);
+        return nbd_co_send_chunk_error(client, handle, -ret,
+                                       "can't get block status", errp);
     }

     return nbd_co_send_extents(client, handle, ea, last, context_id, errp);
@@ -2408,8 +2432,7 @@ static coroutine_fn int nbd_send_generic_reply(NBDClient *client,
                                                Error **errp)
 {
     if (client->structured_reply && ret < 0) {
-        return nbd_co_send_structured_error(client, handle, -ret, error_msg,
-                                            errp);
+        return nbd_co_send_chunk_error(client, handle, -ret, error_msg, errp);
     } else {
         return nbd_co_send_simple_reply(client, handle, ret < 0 ? -ret : 0,
                                         NULL, 0, errp);
@@ -2451,11 +2474,11 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,

     if (client->structured_reply) {
         if (request->len) {
-            return nbd_co_send_structured_read(client, request->handle,
-                                               request->from, data,
-                                               request->len, true, errp);
+            return nbd_co_send_chunk_read(client, request->handle,
+                                          request->from, data,
+                                          request->len, true, errp);
         } else {
-            return nbd_co_send_structured_done(client, request->handle, errp);
+            return nbd_co_send_chunk_done(client, request->handle, errp);
         }
     } else {
         return nbd_co_send_simple_reply(client, request->handle, 0,
diff --git a/nbd/trace-events b/nbd/trace-events
index b7032ca2778..50ca05a9e22 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -64,11 +64,11 @@ nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from
 nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients to AIO context %p"
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p"
 nbd_co_send_simple_reply(uint64_t handle, uint32_t error, const char *errname, int len) "Send simple reply: handle = %" PRIu64 ", error = %" PRIu32 " (%s), len = %d"
-nbd_co_send_structured_done(uint64_t handle) "Send structured reply done: handle = %" PRIu64
-nbd_co_send_structured_read(uint64_t handle, uint64_t offset, void *data, size_t size) "Send structured read data reply: handle = %" PRIu64 ", offset = %" PRIu64 ", data = %p, len = %zu"
-nbd_co_send_structured_read_hole(uint64_t handle, uint64_t offset, size_t size) "Send structured read hole reply: handle = %" PRIu64 ", offset = %" PRIu64 ", len = %zu"
+nbd_co_send_chunk_done(uint64_t handle) "Send structured reply done: handle = %" PRIu64
+nbd_co_send_chunk_read(uint64_t handle, uint64_t offset, void *data, size_t size) "Send structured read data reply: handle = %" PRIu64 ", offset = %" PRIu64 ", data = %p, len = %zu"
+nbd_co_send_chunk_read_hole(uint64_t handle, uint64_t offset, size_t size) "Send structured read hole reply: handle = %" PRIu64 ", offset = %" PRIu64 ", len = %zu"
 nbd_co_send_extents(uint64_t handle, unsigned int extents, uint32_t id, uint64_t length, int last) "Send block status reply: handle = %" PRIu64 ", extents = %u, context = %d (extents cover %" PRIu64 " bytes, last chunk = %d)"
-nbd_co_send_structured_error(uint64_t handle, int err, const char *errname, const char *msg) "Send structured error reply: handle = %" PRIu64 ", error = %d (%s), msg = '%s'"
+nbd_co_send_chunk_error(uint64_t handle, int err, const char *errname, const char *msg) "Send structured error reply: handle = %" PRIu64 ", error = %d (%s), msg = '%s'"
 nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, const char *name) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16 " (%s)"
 nbd_co_receive_request_payload_received(uint64_t handle, uint32_t len) "Payload received: handle = %" PRIu64 ", len = %" PRIu32
 nbd_co_receive_align_compliance(const char *op, uint64_t from, uint32_t len, uint32_t align) "client sent non-compliant unaligned %s request: from=0x%" PRIx64 ", len=0x%" PRIx32 ", align=0x%" PRIx32
-- 
2.40.1


