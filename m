Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B730E703DE2
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:54:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeGb-00050t-Gt; Mon, 15 May 2023 15:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGY-0004x1-Tj
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGW-00048H-NP
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QObjYA4nPhzdAe/FN48h18FXK2oe78Wi1tXnfubnLgU=;
 b=Lb3VWU5MMzceJ0bISmKWQgbt1kagduukev+IfpdITX1xDa13gArIiVQfXqJ0o/0U9HqAo5
 E7o2LInGehln2bVvsMYZused81/3ruRzNrObJrw7wuNMNQx7gN8L1kgfpTgcVpqZYlTTlt
 moV1m1CvPr6TIC5iz9ecfR7x5e9FZDU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-Eg6QlqHkPS2OTSMbLFlkmg-1; Mon, 15 May 2023 15:53:48 -0400
X-MC-Unique: Eg6QlqHkPS2OTSMbLFlkmg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B03185A5B1;
 Mon, 15 May 2023 19:53:48 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD11A1410ED9;
 Mon, 15 May 2023 19:53:47 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PATCH v3 03/14] nbd/server: Prepare for alternate-size headers
Date: Mon, 15 May 2023 14:53:32 -0500
Message-Id: <20230515195343.1915857-4-eblake@redhat.com>
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
for symmetry[2].  Additionally, where the reply header is currently
16 bytes for simple reply, and 20 bytes for structured reply; with the
extension enabled, there will only be one structured reply type, of 32
bytes.  Since we are already wired up to use iovecs, it is easiest to
allow for this change in header size by splitting each structured
reply across two iovecs, one for the header (which will become
variable-length in a future patch according to client negotiation),
and the other for the payload, and removing the header from the
payload struct definitions.  Interestingly, the client side code never
utilized the packed types, so only the server code needs to be
updated.

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
 include/block/nbd.h |  8 +++---
 nbd/server.c        | 64 ++++++++++++++++++++++++++++-----------------
 2 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index a4c98169c39..f1d838d24f5 100644
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
index e239c2890fa..eefe3401560 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1885,9 +1885,12 @@ static int coroutine_fn nbd_co_send_iov(NBDClient *client, struct iovec *iov,
     return ret;
 }

-static inline void set_be_simple_reply(NBDSimpleReply *reply, uint64_t error,
-                                       uint64_t handle)
+static inline void set_be_simple_reply(NBDClient *client, struct iovec *iov,
+                                       uint64_t error, uint64_t handle)
 {
+    NBDSimpleReply *reply = iov->iov_base;
+
+    iov->iov_len = sizeof(*reply);
     stl_be_p(&reply->magic, NBD_SIMPLE_REPLY_MAGIC);
     stl_be_p(&reply->error, error);
     stq_be_p(&reply->handle, handle);
@@ -1900,23 +1903,27 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
                                                  size_t len,
                                                  Error **errp)
 {
-    NBDSimpleReply reply;
+    NBDReply hdr;
     int nbd_err = system_errno_to_nbd_errno(error);
     struct iovec iov[] = {
-        {.iov_base = &reply, .iov_len = sizeof(reply)},
+        {.iov_base = &hdr},
         {.iov_base = data, .iov_len = len}
     };

     trace_nbd_co_send_simple_reply(handle, nbd_err, nbd_err_lookup(nbd_err),
                                    len);
-    set_be_simple_reply(&reply, nbd_err, handle);
+    set_be_simple_reply(client, &iov[0], nbd_err, handle);

     return nbd_co_send_iov(client, iov, len ? 2 : 1, errp);
 }

-static inline void set_be_chunk(NBDStructuredReplyChunk *chunk, uint16_t flags,
-                                uint16_t type, uint64_t handle, uint32_t length)
+static inline void set_be_chunk(NBDClient *client, struct iovec *iov,
+                                uint16_t flags, uint16_t type,
+                                uint64_t handle, uint32_t length)
 {
+    NBDStructuredReplyChunk *chunk = iov->iov_base;
+
+    iov->iov_len = sizeof(*chunk);
     stl_be_p(&chunk->magic, NBD_STRUCTURED_REPLY_MAGIC);
     stw_be_p(&chunk->flags, flags);
     stw_be_p(&chunk->type, type);
@@ -1928,13 +1935,14 @@ static int coroutine_fn nbd_co_send_structured_done(NBDClient *client,
                                                     uint64_t handle,
                                                     Error **errp)
 {
-    NBDStructuredReplyChunk chunk;
+    NBDReply hdr;
     struct iovec iov[] = {
-        {.iov_base = &chunk, .iov_len = sizeof(chunk)},
+        {.iov_base = &hdr},
     };

     trace_nbd_co_send_structured_done(handle);
-    set_be_chunk(&chunk, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_NONE, handle, 0);
+    set_be_chunk(client, &iov[0], NBD_REPLY_FLAG_DONE,
+                 NBD_REPLY_TYPE_NONE, handle, 0);

     return nbd_co_send_iov(client, iov, 1, errp);
 }
@@ -1947,20 +1955,21 @@ static int coroutine_fn nbd_co_send_structured_read(NBDClient *client,
                                                     bool final,
                                                     Error **errp)
 {
+    NBDReply hdr;
     NBDStructuredReadData chunk;
     struct iovec iov[] = {
+        {.iov_base = &hdr},
         {.iov_base = &chunk, .iov_len = sizeof(chunk)},
         {.iov_base = data, .iov_len = size}
     };

     assert(size);
     trace_nbd_co_send_structured_read(handle, offset, data, size);
-    set_be_chunk(&chunk.h, final ? NBD_REPLY_FLAG_DONE : 0,
-                 NBD_REPLY_TYPE_OFFSET_DATA, handle,
-                 sizeof(chunk) - sizeof(chunk.h) + size);
+    set_be_chunk(client, &iov[0], final ? NBD_REPLY_FLAG_DONE : 0,
+                 NBD_REPLY_TYPE_OFFSET_DATA, handle, iov[1].iov_len + size);
     stq_be_p(&chunk.offset, offset);

-    return nbd_co_send_iov(client, iov, 2, errp);
+    return nbd_co_send_iov(client, iov, 3, errp);
 }

 static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
@@ -1969,9 +1978,11 @@ static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
                                                      const char *msg,
                                                      Error **errp)
 {
+    NBDReply hdr;
     NBDStructuredError chunk;
     int nbd_err = system_errno_to_nbd_errno(error);
     struct iovec iov[] = {
+        {.iov_base = &hdr},
         {.iov_base = &chunk, .iov_len = sizeof(chunk)},
         {.iov_base = (char *)msg, .iov_len = msg ? strlen(msg) : 0},
     };
@@ -1979,12 +1990,12 @@ static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
     assert(nbd_err);
     trace_nbd_co_send_structured_error(handle, nbd_err,
                                        nbd_err_lookup(nbd_err), msg ? msg : "");
-    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_ERROR, handle,
-                 sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len);
+    set_be_chunk(client, &iov[0], NBD_REPLY_FLAG_DONE,
+                 NBD_REPLY_TYPE_ERROR, handle, iov[1].iov_len + iov[2].iov_len);
     stl_be_p(&chunk.error, nbd_err);
-    stw_be_p(&chunk.message_length, iov[1].iov_len);
+    stw_be_p(&chunk.message_length, iov[2].iov_len);

-    return nbd_co_send_iov(client, iov, 1 + !!iov[1].iov_len, errp);
+    return nbd_co_send_iov(client, iov, 2 + !!iov[2].iov_len, errp);
 }

 /* Do a sparse read and send the structured reply to the client.
@@ -2022,19 +2033,22 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
         assert(pnum && pnum <= size - progress);
         final = progress + pnum == size;
         if (status & BDRV_BLOCK_ZERO) {
+            NBDReply hdr;
             NBDStructuredReadHole chunk;
             struct iovec iov[] = {
+                {.iov_base = &hdr},
                 {.iov_base = &chunk, .iov_len = sizeof(chunk)},
             };

             trace_nbd_co_send_structured_read_hole(handle, offset + progress,
                                                    pnum);
-            set_be_chunk(&chunk.h, final ? NBD_REPLY_FLAG_DONE : 0,
+            set_be_chunk(client, &iov[0],
+                         final ? NBD_REPLY_FLAG_DONE : 0,
                          NBD_REPLY_TYPE_OFFSET_HOLE,
-                         handle, sizeof(chunk) - sizeof(chunk.h));
+                         handle, iov[1].iov_len);
             stq_be_p(&chunk.offset, offset + progress);
             stl_be_p(&chunk.length, pnum);
-            ret = nbd_co_send_iov(client, iov, 1, errp);
+            ret = nbd_co_send_iov(client, iov, 2, errp);
         } else {
             ret = blk_co_pread(exp->common.blk, offset + progress, pnum,
                                data + progress, 0);
@@ -2200,8 +2214,10 @@ static int coroutine_fn
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
@@ -2210,12 +2226,12 @@ nbd_co_send_extents(NBDClient *client, uint64_t handle, NBDExtentArray *ea,

     trace_nbd_co_send_extents(handle, ea->count, context_id, ea->total_length,
                               last);
-    set_be_chunk(&chunk.h, last ? NBD_REPLY_FLAG_DONE : 0,
+    set_be_chunk(client, &iov[0], last ? NBD_REPLY_FLAG_DONE : 0,
                  NBD_REPLY_TYPE_BLOCK_STATUS,
-                 handle, sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len);
+                 handle, iov[1].iov_len + iov[2].iov_len);
     stl_be_p(&chunk.context_id, context_id);

-    return nbd_co_send_iov(client, iov, 2, errp);
+    return nbd_co_send_iov(client, iov, 3, errp);
 }

 /* Get block status from the exported device and send it to the client */
-- 
2.40.1


