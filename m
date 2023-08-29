Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 470E378CBAD
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 20:04:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb33c-0002T0-Pe; Tue, 29 Aug 2023 14:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qb33W-0002Qk-7b
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qb33S-0000L6-00
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693332183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VQEuNU2/jJusSrTsFEzfelNd8oC3XZ5NHcpk8g3ZDmA=;
 b=EH768xsyE0g3cW3w0yjsaaK6wV/szsGe5/cXCtWakbdB0R9hyYOctUOBVMeS0pL7DAVZA2
 wlvwMd3ME6QCATx8sh7mqPW+IfvpyXmrnPPRWN4d7gy6pWE7XIXuhBnoYk3dOEYDoJ1So0
 1rrP959qNGQkj5TE7Xg2pcVgkY95z3E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-Wp95qIOVP9G4-pMteQb73A-1; Tue, 29 Aug 2023 14:03:00 -0400
X-MC-Unique: Wp95qIOVP9G4-pMteQb73A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7883857A84;
 Tue, 29 Aug 2023 18:02:58 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3901B2026D4B;
 Tue, 29 Aug 2023 18:02:58 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v6 04/17] nbd: Prepare for 64-bit request effect lengths
Date: Tue, 29 Aug 2023 12:58:31 -0500
Message-ID: <20230829175826.377251-23-eblake@redhat.com>
In-Reply-To: <20230829175826.377251-19-eblake@redhat.com>
References: <20230829175826.377251-19-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Widen the length field of NBDRequest to 64-bits, although we can
assert that all current uses are still under 32 bits: either because
of NBD_MAX_BUFFER_SIZE which is even smaller (and where size_t can
still be appropriate, even on 32-bit platforms), or because nothing
ever puts us into NBD_MODE_EXTENDED yet (and while future patches will
allow larger transactions, the lengths in play here are still capped
at 32-bit).  There are no semantic changes, other than a typo fix in a
couple of error messages.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v6: fix sign extension bug

v5: tweak commit message, adjust a few more spots [Vladimir]

v4: split off enum changes to earlier patches [Vladimir]
---
 include/block/nbd.h |  4 ++--
 block/nbd.c         | 25 +++++++++++++++++++------
 nbd/client.c        |  1 +
 nbd/server.c        | 23 +++++++++++++++--------
 block/trace-events  |  2 +-
 nbd/trace-events    | 14 +++++++-------
 6 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index b2fb8ab44d5..ec4e8eda6bd 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -71,8 +71,8 @@ typedef enum NBDMode {
  */
 typedef struct NBDRequest {
     uint64_t cookie;
-    uint64_t from;
-    uint32_t len;
+    uint64_t from;  /* Offset touched by the command */
+    uint64_t len;   /* Effect length; 32 bit limit without extended headers */
     uint16_t flags; /* NBD_CMD_FLAG_* */
     uint16_t type;  /* NBD_CMD_* */
     NBDMode mode;   /* Determines which network representation to use */
diff --git a/block/nbd.c b/block/nbd.c
index c7581794873..57123c17f94 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1306,10 +1306,11 @@ nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
     NBDRequest request = {
         .type = NBD_CMD_WRITE_ZEROES,
         .from = offset,
-        .len = bytes,  /* .len is uint32_t actually */
+        .len = bytes,
     };

-    assert(bytes <= UINT32_MAX); /* rely on max_pwrite_zeroes */
+    /* rely on max_pwrite_zeroes */
+    assert(bytes <= UINT32_MAX || s->info.mode >= NBD_MODE_EXTENDED);

     assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
     if (!(s->info.flags & NBD_FLAG_SEND_WRITE_ZEROES)) {
@@ -1356,10 +1357,11 @@ nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
     NBDRequest request = {
         .type = NBD_CMD_TRIM,
         .from = offset,
-        .len = bytes, /* len is uint32_t */
+        .len = bytes,
     };

-    assert(bytes <= UINT32_MAX); /* rely on max_pdiscard */
+    /* rely on max_pdiscard */
+    assert(bytes <= UINT32_MAX || s->info.mode >= NBD_MODE_EXTENDED);

     assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
     if (!(s->info.flags & NBD_FLAG_SEND_TRIM) || !bytes) {
@@ -1381,8 +1383,7 @@ static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
     NBDRequest request = {
         .type = NBD_CMD_BLOCK_STATUS,
         .from = offset,
-        .len = MIN(QEMU_ALIGN_DOWN(INT_MAX, bs->bl.request_alignment),
-                   MIN(bytes, s->info.size - offset)),
+        .len = MIN(bytes, s->info.size - offset),
         .flags = NBD_CMD_FLAG_REQ_ONE,
     };

@@ -1392,6 +1393,10 @@ static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
         *file = bs;
         return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
     }
+    if (s->info.mode < NBD_MODE_EXTENDED) {
+        request.len = MIN(QEMU_ALIGN_DOWN(INT_MAX, bs->bl.request_alignment),
+                          request.len);
+    }

     /*
      * Work around the fact that the block layer doesn't do
@@ -1956,6 +1961,14 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
     bs->bl.max_pwrite_zeroes = max;
     bs->bl.max_transfer = max;

+    /*
+     * Assume that if the server supports extended headers, it also
+     * supports unlimited size zero and trim commands.
+     */
+    if (s->info.mode >= NBD_MODE_EXTENDED) {
+        bs->bl.max_pdiscard = bs->bl.max_pwrite_zeroes = 0;
+    }
+
     if (s->info.opt_block &&
         s->info.opt_block > bs->bl.opt_transfer) {
         bs->bl.opt_transfer = s->info.opt_block;
diff --git a/nbd/client.c b/nbd/client.c
index 40a1eb72346..1495a9b0ab1 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1355,6 +1355,7 @@ int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
     uint8_t buf[NBD_REQUEST_SIZE];

     assert(request->mode <= NBD_MODE_STRUCTURED); /* TODO handle extended */
+    assert(request->len <= UINT32_MAX);
     trace_nbd_send_request(request->from, request->len, request->cookie,
                            request->flags, request->type,
                            nbd_cmd_lookup(request->type));
diff --git a/nbd/server.c b/nbd/server.c
index 97403db2e07..e38a8f700a9 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1165,7 +1165,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
         client->optlen = length;

         if (length > NBD_MAX_BUFFER_SIZE) {
-            error_setg(errp, "len (%" PRIu32" ) is larger than max len (%u)",
+            error_setg(errp, "len (%" PRIu32 ") is larger than max len (%u)",
                        length, NBD_MAX_BUFFER_SIZE);
             return -EINVAL;
         }
@@ -1441,7 +1441,7 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
     request->type   = lduw_be_p(buf + 6);
     request->cookie = ldq_be_p(buf + 8);
     request->from   = ldq_be_p(buf + 16);
-    request->len    = ldl_be_p(buf + 24);
+    request->len    = (uint32_t)ldl_be_p(buf + 24); /* widen 32 to 64 bits */

     trace_nbd_receive_request(magic, request->flags, request->type,
                               request->from, request->len);
@@ -1899,7 +1899,7 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
                                                  NBDRequest *request,
                                                  uint32_t error,
                                                  void *data,
-                                                 size_t len,
+                                                 uint64_t len,
                                                  Error **errp)
 {
     NBDSimpleReply reply;
@@ -1910,6 +1910,7 @@ static int coroutine_fn nbd_co_send_simple_reply(NBDClient *client,
     };

     assert(!len || !nbd_err);
+    assert(len <= NBD_MAX_STRING_SIZE);
     assert(client->mode < NBD_MODE_STRUCTURED ||
            (client->mode == NBD_MODE_STRUCTURED &&
             request->type != NBD_CMD_READ));
@@ -1968,7 +1969,7 @@ static int coroutine_fn nbd_co_send_chunk_read(NBDClient *client,
                                                NBDRequest *request,
                                                uint64_t offset,
                                                void *data,
-                                               size_t size,
+                                               uint64_t size,
                                                bool final,
                                                Error **errp)
 {
@@ -1980,7 +1981,7 @@ static int coroutine_fn nbd_co_send_chunk_read(NBDClient *client,
         {.iov_base = data, .iov_len = size}
     };

-    assert(size);
+    assert(size && size <= NBD_MAX_BUFFER_SIZE);
     trace_nbd_co_send_chunk_read(request->cookie, offset, data, size);
     set_be_chunk(client, iov, 3, final ? NBD_REPLY_FLAG_DONE : 0,
                  NBD_REPLY_TYPE_OFFSET_DATA, request);
@@ -2023,13 +2024,14 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
                                                 NBDRequest *request,
                                                 uint64_t offset,
                                                 uint8_t *data,
-                                                size_t size,
+                                                uint64_t size,
                                                 Error **errp)
 {
     int ret = 0;
     NBDExport *exp = client->exp;
     size_t progress = 0;

+    assert(size <= NBD_MAX_BUFFER_SIZE);
     while (progress < size) {
         int64_t pnum;
         int status = blk_co_block_status_above(exp->common.blk, NULL,
@@ -2359,7 +2361,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
         request->type == NBD_CMD_CACHE)
     {
         if (request->len > NBD_MAX_BUFFER_SIZE) {
-            error_setg(errp, "len (%" PRIu32" ) is larger than max len (%u)",
+            error_setg(errp, "len (%" PRIu64 ") is larger than max len (%u)",
                        request->len, NBD_MAX_BUFFER_SIZE);
             return -EINVAL;
         }
@@ -2375,6 +2377,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
     }

     if (request->type == NBD_CMD_WRITE) {
+        assert(request->len <= NBD_MAX_BUFFER_SIZE);
         if (nbd_read(client->ioc, req->data, request->len, "CMD_WRITE data",
                      errp) < 0)
         {
@@ -2396,7 +2399,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
     }
     if (request->from > client->exp->size ||
         request->len > client->exp->size - request->from) {
-        error_setg(errp, "operation past EOF; From: %" PRIu64 ", Len: %" PRIu32
+        error_setg(errp, "operation past EOF; From: %" PRIu64 ", Len: %" PRIu64
                    ", Size: %" PRIu64, request->from, request->len,
                    client->exp->size);
         return (request->type == NBD_CMD_WRITE ||
@@ -2458,6 +2461,7 @@ static coroutine_fn int nbd_do_cmd_read(NBDClient *client, NBDRequest *request,
     NBDExport *exp = client->exp;

     assert(request->type == NBD_CMD_READ);
+    assert(request->len <= NBD_MAX_BUFFER_SIZE);

     /* XXX: NBD Protocol only documents use of FUA with WRITE */
     if (request->flags & NBD_CMD_FLAG_FUA) {
@@ -2508,6 +2512,7 @@ static coroutine_fn int nbd_do_cmd_cache(NBDClient *client, NBDRequest *request,
     NBDExport *exp = client->exp;

     assert(request->type == NBD_CMD_CACHE);
+    assert(request->len <= NBD_MAX_BUFFER_SIZE);

     ret = blk_co_preadv(exp->common.blk, request->from, request->len,
                         NULL, BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);
@@ -2541,6 +2546,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         if (request->flags & NBD_CMD_FLAG_FUA) {
             flags |= BDRV_REQ_FUA;
         }
+        assert(request->len <= NBD_MAX_BUFFER_SIZE);
         ret = blk_co_pwrite(exp->common.blk, request->from, request->len, data,
                             flags);
         return nbd_send_generic_reply(client, request, ret,
@@ -2584,6 +2590,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
             return nbd_send_generic_reply(client, request, -EINVAL,
                                           "need non-zero length", errp);
         }
+        assert(request->len <= UINT32_MAX);
         if (client->export_meta.count) {
             bool dont_fragment = request->flags & NBD_CMD_FLAG_REQ_ONE;
             int contexts_remaining = client->export_meta.count;
diff --git a/block/trace-events b/block/trace-events
index 6f121b76365..925aa554bbf 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -167,7 +167,7 @@ iscsi_xcopy(void *src_lun, uint64_t src_off, void *dst_lun, uint64_t dst_off, ui
 nbd_parse_blockstatus_compliance(const char *err) "ignoring extra data from non-compliant server: %s"
 nbd_structured_read_compliance(const char *type) "server sent non-compliant unaligned read %s chunk"
 nbd_read_reply_entry_fail(int ret, const char *err) "ret = %d, err: %s"
-nbd_co_request_fail(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name, int ret, const char *err) "Request failed { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) } ret = %d, err: %s"
+nbd_co_request_fail(uint64_t from, uint64_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name, int ret, const char *err) "Request failed { .from = %" PRIu64", .len = %" PRIu64 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) } ret = %d, err: %s"
 nbd_client_handshake(const char *export_name) "export '%s'"
 nbd_client_handshake_success(const char *export_name) "export '%s'"
 nbd_reconnect_attempt(unsigned in_flight) "in_flight %u"
diff --git a/nbd/trace-events b/nbd/trace-events
index f19a4d0db39..f9dccfcfb44 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -31,7 +31,7 @@ nbd_client_loop(void) "Doing NBD loop"
 nbd_client_loop_ret(int ret, const char *error) "NBD loop returned %d: %s"
 nbd_client_clear_queue(void) "Clearing NBD queue"
 nbd_client_clear_socket(void) "Clearing NBD socket"
-nbd_send_request(uint64_t from, uint32_t len, uint64_t cookie, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu32 ", .cookie = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) }"
+nbd_send_request(uint64_t from, uint64_t len, uint64_t cookie, uint16_t flags, uint16_t type, const char *name) "Sending request to server: { .from = %" PRIu64", .len = %" PRIu64 ", .cookie = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) }"
 nbd_receive_simple_reply(int32_t error, const char *errname, uint64_t cookie) "Got simple reply: { .error = %" PRId32 " (%s), cookie = %" PRIu64" }"
 nbd_receive_structured_reply_chunk(uint16_t flags, uint16_t type, const char *name, uint64_t cookie, uint32_t length) "Got structured reply chunk: { flags = 0x%" PRIx16 ", type = %d (%s), cookie = %" PRIu64 ", length = %" PRIu32 " }"

@@ -60,18 +60,18 @@ nbd_negotiate_options_check_option(uint32_t option, const char *name) "Checking
 nbd_negotiate_begin(void) "Beginning negotiation"
 nbd_negotiate_new_style_size_flags(uint64_t size, unsigned flags) "advertising size %" PRIu64 " and flags 0x%x"
 nbd_negotiate_success(void) "Negotiation succeeded"
-nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from, uint32_t len) "Got request: { magic = 0x%" PRIx32 ", .flags = 0x%" PRIx16 ", .type = 0x%" PRIx16 ", from = %" PRIu64 ", len = %" PRIu32 " }"
+nbd_receive_request(uint32_t magic, uint16_t flags, uint16_t type, uint64_t from, uint64_t len) "Got request: { magic = 0x%" PRIx32 ", .flags = 0x%" PRIx16 ", .type = 0x%" PRIx16 ", from = %" PRIu64 ", len = %" PRIu64 " }"
 nbd_blk_aio_attached(const char *name, void *ctx) "Export %s: Attaching clients to AIO context %p"
 nbd_blk_aio_detach(const char *name, void *ctx) "Export %s: Detaching clients from AIO context %p"
-nbd_co_send_simple_reply(uint64_t cookie, uint32_t error, const char *errname, int len) "Send simple reply: cookie = %" PRIu64 ", error = %" PRIu32 " (%s), len = %d"
+nbd_co_send_simple_reply(uint64_t cookie, uint32_t error, const char *errname, uint64_t len) "Send simple reply: cookie = %" PRIu64 ", error = %" PRIu32 " (%s), len = %" PRIu64
 nbd_co_send_chunk_done(uint64_t cookie) "Send structured reply done: cookie = %" PRIu64
-nbd_co_send_chunk_read(uint64_t cookie, uint64_t offset, void *data, size_t size) "Send structured read data reply: cookie = %" PRIu64 ", offset = %" PRIu64 ", data = %p, len = %zu"
-nbd_co_send_chunk_read_hole(uint64_t cookie, uint64_t offset, size_t size) "Send structured read hole reply: cookie = %" PRIu64 ", offset = %" PRIu64 ", len = %zu"
+nbd_co_send_chunk_read(uint64_t cookie, uint64_t offset, void *data, uint64_t size) "Send structured read data reply: cookie = %" PRIu64 ", offset = %" PRIu64 ", data = %p, len = %" PRIu64
+nbd_co_send_chunk_read_hole(uint64_t cookie, uint64_t offset, uint64_t size) "Send structured read hole reply: cookie = %" PRIu64 ", offset = %" PRIu64 ", len = %" PRIu64
 nbd_co_send_extents(uint64_t cookie, unsigned int extents, uint32_t id, uint64_t length, int last) "Send block status reply: cookie = %" PRIu64 ", extents = %u, context = %d (extents cover %" PRIu64 " bytes, last chunk = %d)"
 nbd_co_send_chunk_error(uint64_t cookie, int err, const char *errname, const char *msg) "Send structured error reply: cookie = %" PRIu64 ", error = %d (%s), msg = '%s'"
 nbd_co_receive_request_decode_type(uint64_t cookie, uint16_t type, const char *name) "Decoding type: cookie = %" PRIu64 ", type = %" PRIu16 " (%s)"
-nbd_co_receive_request_payload_received(uint64_t cookie, uint32_t len) "Payload received: cookie = %" PRIu64 ", len = %" PRIu32
-nbd_co_receive_align_compliance(const char *op, uint64_t from, uint32_t len, uint32_t align) "client sent non-compliant unaligned %s request: from=0x%" PRIx64 ", len=0x%" PRIx32 ", align=0x%" PRIx32
+nbd_co_receive_request_payload_received(uint64_t cookie, uint64_t len) "Payload received: cookie = %" PRIu64 ", len = %" PRIu64
+nbd_co_receive_align_compliance(const char *op, uint64_t from, uint64_t len, uint32_t align) "client sent non-compliant unaligned %s request: from=0x%" PRIx64 ", len=0x%" PRIx64 ", align=0x%" PRIx32
 nbd_trip(void) "Reading request"

 # client-connection.c
-- 
2.41.0


