Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4077ADF92
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:27:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrEB-0003WG-1T; Mon, 25 Sep 2023 15:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkrDx-0003Io-Sf
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:26:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkrDv-00025Z-Ad
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695669986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLtEjTWIJvhzZTN3L5Zwsj4BahVISGbKXuWtRSVZMBQ=;
 b=A825zGMCtO5Mu52Gr55xvQxaks4SDfouAYUDmSz1E6o1fXeh9AVQHIEkEDFxua/P/yNeby
 J3dBVT9oBCSKRBHS8J+4MleLf0uaOKjjvaaJiXMsCE5kChwCIO7znADHUugABS/QbcNk7A
 ldgim7GhgKQbQvuuOHEvNlc9Ssr+/+I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543--dlLq7zbNJaPJY0vd14-lQ-1; Mon, 25 Sep 2023 15:26:23 -0400
X-MC-Unique: -dlLq7zbNJaPJY0vd14-lQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0636C80CDBE;
 Mon, 25 Sep 2023 19:26:23 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72BA61678B;
 Mon, 25 Sep 2023 19:26:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v7 12/12] nbd/server: Add FLAG_PAYLOAD support to
 CMD_BLOCK_STATUS
Date: Mon, 25 Sep 2023 14:22:42 -0500
Message-ID: <20230925192229.3186470-26-eblake@redhat.com>
In-Reply-To: <20230925192229.3186470-14-eblake@redhat.com>
References: <20230925192229.3186470-14-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Allow a client to request a subset of negotiated meta contexts.  For
example, a client may ask to use a single connection to learn about
both block status and dirty bitmaps, but where the dirty bitmap
queries only need to be performed on a subset of the disk; forcing the
server to compute that information on block status queries in the rest
of the disk is wasted effort (both at the server, and on the amount of
traffic sent over the wire to be parsed and ignored by the client).

Qemu as an NBD client never requests to use more than one meta
context, so it has no need to use block status payloads.  Testing this
instead requires support from libnbd, which CAN access multiple meta
contexts in parallel from a single NBD connection; an interop test
submitted to the libnbd project at the same time as this patch
demonstrates the feature working, as well as testing some corner cases
(for example, when the payload length is longer than the export
length), although other corner cases (like passing the same id
duplicated) requires a protocol fuzzer because libnbd is not wired up
to break the protocol that badly.

This also includes tweaks to 'qemu-nbd --list' to show when a server
is advertising the capability, and to the testsuite to reflect the
addition to that output.

Of note: qemu will always advertise the new feature bit during
NBD_OPT_INFO if extended headers have alreay been negotiated
(regardless of whether any NBD_OPT_SET_META_CONTEXT negotiation has
occurred); but for NBD_OPT_GO, qemu only advertises the feature if
block status is also enabled (that is, if the client does not
negotiate any contexts, then NBD_CMD_BLOCK_STATUS cannot be used, so
the feature is not advertised).

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v5: factor out 'id - NBD_MTA_ID_DIRTY_BITMAP' [Vladimir], rework logic
on zero-length requests to be clearer [Vladimir], rebase to earlier
changes
---
 docs/interop/nbd.txt                          |   2 +-
 nbd/server.c                                  | 114 ++++++++++++++++--
 qemu-nbd.c                                    |   1 +
 nbd/trace-events                              |   1 +
 tests/qemu-iotests/223.out                    |  12 +-
 tests/qemu-iotests/307.out                    |  10 +-
 .../tests/nbd-qemu-allocation.out             |   2 +-
 7 files changed, 122 insertions(+), 20 deletions(-)

diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
index 9aae5e1f294..18efb251de9 100644
--- a/docs/interop/nbd.txt
+++ b/docs/interop/nbd.txt
@@ -69,4 +69,4 @@ NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE
 NBD_CMD_FLAG_FAST_ZERO
 * 5.2: NBD_CMD_BLOCK_STATUS for "qemu:allocation-depth"
 * 7.1: NBD_FLAG_CAN_MULTI_CONN for shareable writable exports
-* 8.2: NBD_OPT_EXTENDED_HEADERS
+* 8.2: NBD_OPT_EXTENDED_HEADERS, NBD_FLAG_BLOCK_STATUS_PAYLOAD
diff --git a/nbd/server.c b/nbd/server.c
index 2d4cec75a49..898580a9b0b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -512,6 +512,9 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
     if (client->mode >= NBD_MODE_STRUCTURED) {
         myflags |= NBD_FLAG_SEND_DF;
     }
+    if (client->mode >= NBD_MODE_EXTENDED && client->contexts.count) {
+        myflags |= NBD_FLAG_BLOCK_STAT_PAYLOAD;
+    }
     trace_nbd_negotiate_new_style_size_flags(client->exp->size, myflags);
     stq_be_p(buf, client->exp->size);
     stw_be_p(buf + 8, myflags);
@@ -699,6 +702,10 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
     if (client->mode >= NBD_MODE_STRUCTURED) {
         myflags |= NBD_FLAG_SEND_DF;
     }
+    if (client->mode >= NBD_MODE_EXTENDED &&
+        (client->contexts.count || client->opt == NBD_OPT_INFO)) {
+        myflags |= NBD_FLAG_BLOCK_STAT_PAYLOAD;
+    }
     trace_nbd_negotiate_new_style_size_flags(exp->size, myflags);
     stq_be_p(buf, exp->size);
     stw_be_p(buf + 8, myflags);
@@ -2420,6 +2427,87 @@ static int coroutine_fn nbd_co_send_bitmap(NBDClient *client,
     return nbd_co_send_extents(client, request, ea, last, context_id, errp);
 }

+/*
+ * nbd_co_block_status_payload_read
+ * Called when a client wants a subset of negotiated contexts via a
+ * BLOCK_STATUS payload.  Check the payload for valid length and
+ * contents.  On success, return 0 with request updated to effective
+ * length.  If request was invalid but all payload consumed, return 0
+ * with request->len and request->contexts->count set to 0 (which will
+ * trigger an appropriate NBD_EINVAL response later on).  Return
+ * negative errno if the payload was not fully consumed.
+ */
+static int
+nbd_co_block_status_payload_read(NBDClient *client, NBDRequest *request,
+                                 Error **errp)
+{
+    int payload_len = request->len;
+    g_autofree char *buf = NULL;
+    size_t count, i, nr_bitmaps;
+    uint32_t id;
+
+    if (payload_len > NBD_MAX_BUFFER_SIZE) {
+        error_setg(errp, "len (%" PRIu64 ") is larger than max len (%u)",
+                   request->len, NBD_MAX_BUFFER_SIZE);
+        return -EINVAL;
+    }
+
+    assert(client->contexts.exp == client->exp);
+    nr_bitmaps = client->exp->nr_export_bitmaps;
+    request->contexts = g_new0(NBDMetaContexts, 1);
+    request->contexts->exp = client->exp;
+
+    if (payload_len % sizeof(uint32_t) ||
+        payload_len < sizeof(NBDBlockStatusPayload) ||
+        payload_len > (sizeof(NBDBlockStatusPayload) +
+                       sizeof(id) * client->contexts.count)) {
+        goto skip;
+    }
+
+    buf = g_malloc(payload_len);
+    if (nbd_read(client->ioc, buf, payload_len,
+                 "CMD_BLOCK_STATUS data", errp) < 0) {
+        return -EIO;
+    }
+    trace_nbd_co_receive_request_payload_received(request->cookie,
+                                                  payload_len);
+    request->contexts->bitmaps = g_new0(bool, nr_bitmaps);
+    count = (payload_len - sizeof(NBDBlockStatusPayload)) / sizeof(id);
+    payload_len = 0;
+
+    for (i = 0; i < count; i++) {
+        id = ldl_be_p(buf + sizeof(NBDBlockStatusPayload) + sizeof(id) * i);
+        if (id == NBD_META_ID_BASE_ALLOCATION) {
+            if (request->contexts->base_allocation) {
+                goto skip;
+            }
+            request->contexts->base_allocation = true;
+        } else if (id == NBD_META_ID_ALLOCATION_DEPTH) {
+            if (request->contexts->allocation_depth) {
+                goto skip;
+            }
+            request->contexts->allocation_depth = true;
+        } else {
+            int idx = id - NBD_META_ID_DIRTY_BITMAP;
+
+            if (idx > nr_bitmaps || request->contexts->bitmaps[idx]) {
+                goto skip;
+            }
+            request->contexts->bitmaps[idx] = true;
+        }
+    }
+
+    request->len = ldq_be_p(buf);
+    request->contexts->count = count;
+    return 0;
+
+ skip:
+    trace_nbd_co_receive_block_status_payload_compliance(request->from,
+                                                         request->len);
+    request->len = request->contexts->count = 0;
+    return nbd_drop(client->ioc, payload_len, errp);
+}
+
 /* nbd_co_receive_request
  * Collect a client request. Return 0 if request looks valid, -EIO to drop
  * connection right away, -EAGAIN to indicate we were interrupted and the
@@ -2505,7 +2593,18 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
         break;

     case NBD_CMD_BLOCK_STATUS:
-        request->contexts = &client->contexts;
+        if (extended_with_payload) {
+            ret = nbd_co_block_status_payload_read(client, request, errp);
+            if (ret < 0) {
+                return ret;
+            }
+            /* payload now consumed */
+            check_length = extended_with_payload = false;
+            payload_len = 0;
+            valid_flags |= NBD_CMD_FLAG_PAYLOAD_LEN;
+        } else {
+            request->contexts = &client->contexts;
+        }
         valid_flags |= NBD_CMD_FLAG_REQ_ONE;
         break;

@@ -2747,16 +2846,16 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,

     case NBD_CMD_BLOCK_STATUS:
         assert(request->contexts);
-        if (!request->len) {
-            return nbd_send_generic_reply(client, request, -EINVAL,
-                                          "need non-zero length", errp);
-        }
         assert(client->mode >= NBD_MODE_EXTENDED ||
                request->len <= UINT32_MAX);
         if (request->contexts->count) {
             bool dont_fragment = request->flags & NBD_CMD_FLAG_REQ_ONE;
             int contexts_remaining = request->contexts->count;

+            if (!request->len) {
+                return nbd_send_generic_reply(client, request, -EINVAL,
+                                              "need non-zero length", errp);
+            }
             if (request->contexts->base_allocation) {
                 ret = nbd_co_send_block_status(client, request,
                                                exp->common.blk,
@@ -2893,8 +2992,9 @@ static coroutine_fn void nbd_trip(void *opaque)
         goto disconnect;
     }

-    /* We must disconnect after NBD_CMD_WRITE if we did not
-     * read the payload.
+    /*
+     * We must disconnect after NBD_CMD_WRITE or BLOCK_STATUS with
+     * payload if we did not read the payload.
      */
     if (!req->complete) {
         error_setg(&local_err, "Request handling failed in intermediate state");
diff --git a/qemu-nbd.c b/qemu-nbd.c
index e6681450cfe..7f1734cfccc 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -219,6 +219,7 @@ static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds *tls,
                 [NBD_FLAG_SEND_RESIZE_BIT]          = "resize",
                 [NBD_FLAG_SEND_CACHE_BIT]           = "cache",
                 [NBD_FLAG_SEND_FAST_ZERO_BIT]       = "fast-zero",
+                [NBD_FLAG_BLOCK_STAT_PAYLOAD_BIT]   = "block-status-payload",
             };

             printf("  size:  %" PRIu64 "\n", list[i].size);
diff --git a/nbd/trace-events b/nbd/trace-events
index 8f4e20ee9f2..ac186c19ec0 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -70,6 +70,7 @@ nbd_co_send_chunk_read(uint64_t cookie, uint64_t offset, void *data, uint64_t si
 nbd_co_send_chunk_read_hole(uint64_t cookie, uint64_t offset, uint64_t size) "Send structured read hole reply: cookie = %" PRIu64 ", offset = %" PRIu64 ", len = %" PRIu64
 nbd_co_send_extents(uint64_t cookie, unsigned int extents, uint32_t id, uint64_t length, int last) "Send block status reply: cookie = %" PRIu64 ", extents = %u, context = %d (extents cover %" PRIu64 " bytes, last chunk = %d)"
 nbd_co_send_chunk_error(uint64_t cookie, int err, const char *errname, const char *msg) "Send structured error reply: cookie = %" PRIu64 ", error = %d (%s), msg = '%s'"
+nbd_co_receive_block_status_payload_compliance(uint64_t from, int len) "client sent unusable block status payload: from=0x%" PRIx64 ", len=0x%x"
 nbd_co_receive_request_decode_type(uint64_t cookie, uint16_t type, const char *name) "Decoding type: cookie = %" PRIu64 ", type = %" PRIu16 " (%s)"
 nbd_co_receive_request_payload_received(uint64_t cookie, uint64_t len) "Payload received: cookie = %" PRIu64 ", len = %" PRIu64
 nbd_co_receive_ext_payload_compliance(uint64_t from, uint64_t len) "client sent non-compliant write without payload flag: from=0x%" PRIx64 ", len=0x%" PRIx64
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 32f05f1c9af..e5e7f42caac 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -83,7 +83,7 @@ exports available: 0
 exports available: 3
  export: 'n'
   size:  4194304
-  flags: 0x58f ( readonly flush fua df multi cache )
+  flags: 0x158f ( readonly flush fua df multi cache block-status-payload )
   min block: 1
   opt block: 4096
   max block: 33554432
@@ -94,7 +94,7 @@ exports available: 3
  export: 'n2'
   description: some text
   size:  4194304
-  flags: 0xded ( flush fua trim zeroes df multi cache fast-zero )
+  flags: 0x1ded ( flush fua trim zeroes df multi cache fast-zero block-status-payload )
   min block: 1
   opt block: 4096
   max block: 33554432
@@ -104,7 +104,7 @@ exports available: 3
    qemu:dirty-bitmap:b2
  export: 'n3'
   size:  4194304
-  flags: 0x58f ( readonly flush fua df multi cache )
+  flags: 0x158f ( readonly flush fua df multi cache block-status-payload )
   min block: 1
   opt block: 4096
   max block: 33554432
@@ -205,7 +205,7 @@ exports available: 0
 exports available: 3
  export: 'n'
   size:  4194304
-  flags: 0x58f ( readonly flush fua df multi cache )
+  flags: 0x158f ( readonly flush fua df multi cache block-status-payload )
   min block: 1
   opt block: 4096
   max block: 33554432
@@ -216,7 +216,7 @@ exports available: 3
  export: 'n2'
   description: some text
   size:  4194304
-  flags: 0xded ( flush fua trim zeroes df multi cache fast-zero )
+  flags: 0x1ded ( flush fua trim zeroes df multi cache fast-zero block-status-payload )
   min block: 1
   opt block: 4096
   max block: 33554432
@@ -226,7 +226,7 @@ exports available: 3
    qemu:dirty-bitmap:b2
  export: 'n3'
   size:  4194304
-  flags: 0x58f ( readonly flush fua df multi cache )
+  flags: 0x158f ( readonly flush fua df multi cache block-status-payload )
   min block: 1
   opt block: 4096
   max block: 33554432
diff --git a/tests/qemu-iotests/307.out b/tests/qemu-iotests/307.out
index 2b9a6a67a1a..f645f3315f8 100644
--- a/tests/qemu-iotests/307.out
+++ b/tests/qemu-iotests/307.out
@@ -15,7 +15,7 @@ wrote 4096/4096 bytes at offset 0
 exports available: 1
  export: 'fmt'
   size:  67108864
-  flags: 0x58f ( readonly flush fua df multi cache )
+  flags: 0x158f ( readonly flush fua df multi cache block-status-payload )
   min block: XXX
   opt block: XXX
   max block: XXX
@@ -44,7 +44,7 @@ exports available: 1
 exports available: 1
  export: 'fmt'
   size:  67108864
-  flags: 0x58f ( readonly flush fua df multi cache )
+  flags: 0x158f ( readonly flush fua df multi cache block-status-payload )
   min block: XXX
   opt block: XXX
   max block: XXX
@@ -76,7 +76,7 @@ exports available: 1
 exports available: 2
  export: 'fmt'
   size:  67108864
-  flags: 0x58f ( readonly flush fua df multi cache )
+  flags: 0x158f ( readonly flush fua df multi cache block-status-payload )
   min block: XXX
   opt block: XXX
   max block: XXX
@@ -86,7 +86,7 @@ exports available: 2
  export: 'export1'
   description: This is the writable second export
   size:  67108864
-  flags: 0xded ( flush fua trim zeroes df multi cache fast-zero )
+  flags: 0x1ded ( flush fua trim zeroes df multi cache fast-zero block-status-payload )
   min block: XXX
   opt block: XXX
   max block: XXX
@@ -113,7 +113,7 @@ exports available: 1
  export: 'export1'
   description: This is the writable second export
   size:  67108864
-  flags: 0xded ( flush fua trim zeroes df multi cache fast-zero )
+  flags: 0x1ded ( flush fua trim zeroes df multi cache fast-zero block-status-payload )
   min block: XXX
   opt block: XXX
   max block: XXX
diff --git a/tests/qemu-iotests/tests/nbd-qemu-allocation.out b/tests/qemu-iotests/tests/nbd-qemu-allocation.out
index 1db16926ed4..56b57c69ed8 100644
--- a/tests/qemu-iotests/tests/nbd-qemu-allocation.out
+++ b/tests/qemu-iotests/tests/nbd-qemu-allocation.out
@@ -17,7 +17,7 @@ wrote 2097152/2097152 bytes at offset 1048576
 exports available: 1
  export: ''
   size:  4194304
-  flags: 0x48f ( readonly flush fua df cache )
+  flags: 0x148f ( readonly flush fua df cache block-status-payload )
   min block: 1
   opt block: 4096
   max block: 33554432
-- 
2.41.0


