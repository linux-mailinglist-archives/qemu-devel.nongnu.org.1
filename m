Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A63AD703DEF
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:56:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeGh-000572-Fm; Mon, 15 May 2023 15:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGe-00053g-2m
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:54:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGc-0004BN-9g
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6VeQzzy3eJexSuxrAw9D7GJOnRJhG7T2DR3AFd9pdsU=;
 b=RekJ9gIqk2fI7FlB7C061AbfHNmymFKNQ5wk0D3jwBU0VGcXYgHD+whzwrLT98gFfhUC6n
 fVUkMrmeeEqSb7aO/TIHQ4zEUGlvvgbP1SeY2LBTUS7k2PxcV8Fk9zGuefB+CPWHTjrTJ8
 5nKcSxmRbwGXxyajJfG3e5o+qYDjBpM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-o9mza3toORuJEGcVR5QePw-1; Mon, 15 May 2023 15:53:54 -0400
X-MC-Unique: o9mza3toORuJEGcVR5QePw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F9D1867956;
 Mon, 15 May 2023 19:53:54 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B42CB1410F23;
 Mon, 15 May 2023 19:53:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PATCH v3 11/14] nbd/client: Accept 64-bit block status chunks
Date: Mon, 15 May 2023 14:53:40 -0500
Message-Id: <20230515195343.1915857-12-eblake@redhat.com>
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

Because we use NBD_CMD_FLAG_REQ_ONE with NBD_CMD_BLOCK_STATUS, a
client in narrow mode should not be able to provoke a server into
sending a block status result larger than the client's 32-bit request.
But in extended mode, a 64-bit status request must be able to handle a
64-bit status result, once a future patch enables the client
requesting extended mode.  We can also tolerate a non-compliant server
sending the new chunk even when it should not.

In normal execution, we are only requesting "base:allocation" which
never exceeds 32 bits. But during testing with x-dirty-bitmap, we can
force qemu to connect to some other context that might have 64-bit
status bit; however, we ignore those upper bits (other than mapping
qemu:allocation-depth into something that 'qemu-img map --output=json'
can expose), and since it is only testing, we really don't bother with
checking whether more than the two least-significant bits are set.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c        | 39 ++++++++++++++++++++++++++++-----------
 block/trace-events |  1 +
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index d6caea44928..150dfe7170c 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -610,13 +610,16 @@ static int nbd_parse_offset_hole_payload(BDRVNBDState *s,
  */
 static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
                                          NBDStructuredReplyChunk *chunk,
-                                         uint8_t *payload, uint64_t orig_length,
-                                         NBDExtent *extent, Error **errp)
+                                         uint8_t *payload, bool wide,
+                                         uint64_t orig_length,
+                                         NBDExtentExt *extent, Error **errp)
 {
     uint32_t context_id;
+    uint32_t count = 0;
+    size_t len = wide ? sizeof(*extent) : sizeof(NBDExtent);

     /* The server succeeded, so it must have sent [at least] one extent */
-    if (chunk->length < sizeof(context_id) + sizeof(*extent)) {
+    if (chunk->length < sizeof(context_id) + wide * sizeof(count) + len) {
         error_setg(errp, "Protocol error: invalid payload for "
                          "NBD_REPLY_TYPE_BLOCK_STATUS");
         return -EINVAL;
@@ -631,8 +634,14 @@ static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
         return -EINVAL;
     }

-    extent->length = payload_advance32(&payload);
-    extent->flags = payload_advance32(&payload);
+    if (wide) {
+        count = payload_advance32(&payload);
+        extent->length = payload_advance64(&payload);
+        extent->flags = payload_advance64(&payload);
+    } else {
+        extent->length = payload_advance32(&payload);
+        extent->flags = payload_advance32(&payload);
+    }

     if (extent->length == 0) {
         error_setg(errp, "Protocol error: server sent status chunk with "
@@ -672,7 +681,8 @@ static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
      * connection; just ignore trailing extents, and clamp things to
      * the length of our request.
      */
-    if (chunk->length > sizeof(context_id) + sizeof(*extent)) {
+    if (count != wide ||
+        chunk->length > sizeof(context_id) + wide * sizeof(count) + len) {
         trace_nbd_parse_blockstatus_compliance("more than one extent");
     }
     if (extent->length > orig_length) {
@@ -1117,7 +1127,7 @@ static int coroutine_fn nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t h

 static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
                                                          uint64_t handle, uint64_t length,
-                                                         NBDExtent *extent,
+                                                         NBDExtentExt *extent,
                                                          int *request_ret, Error **errp)
 {
     NBDReplyChunkIter iter;
@@ -1125,6 +1135,7 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
     void *payload = NULL;
     Error *local_err = NULL;
     bool received = false;
+    bool wide = false;

     assert(!extent->length);
     NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, &reply, &payload) {
@@ -1134,7 +1145,13 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
         assert(nbd_reply_is_structured(&reply));

         switch (chunk->type) {
+        case NBD_REPLY_TYPE_BLOCK_STATUS_EXT:
+            wide = true;
+            /* fallthrough */
         case NBD_REPLY_TYPE_BLOCK_STATUS:
+            if (s->info.extended_headers != wide) {
+                trace_nbd_extended_headers_compliance("block_status");
+            }
             if (received) {
                 nbd_channel_error(s, -EINVAL);
                 error_setg(&local_err, "Several BLOCK_STATUS chunks in reply");
@@ -1142,9 +1159,9 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
             }
             received = true;

-            ret = nbd_parse_blockstatus_payload(s, &reply.structured,
-                                                payload, length, extent,
-                                                &local_err);
+            ret = nbd_parse_blockstatus_payload(
+                s, &reply.structured, payload, wide,
+                length, extent, &local_err);
             if (ret < 0) {
                 nbd_channel_error(s, ret);
                 nbd_iter_channel_error(&iter, ret, &local_err);
@@ -1374,7 +1391,7 @@ static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
         int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
     int ret, request_ret;
-    NBDExtent extent = { 0 };
+    NBDExtentExt extent = { 0 };
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     Error *local_err = NULL;

diff --git a/block/trace-events b/block/trace-events
index 48dbf10c66f..afb32fcce5b 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -168,6 +168,7 @@ iscsi_xcopy(void *src_lun, uint64_t src_off, void *dst_lun, uint64_t dst_off, ui
 # nbd.c
 nbd_parse_blockstatus_compliance(const char *err) "ignoring extra data from non-compliant server: %s"
 nbd_structured_read_compliance(const char *type) "server sent non-compliant unaligned read %s chunk"
+nbd_extended_headers_compliance(const char *type) "server sent non-compliant %s chunk not matching choice of extended headers"
 nbd_read_reply_entry_fail(int ret, const char *err) "ret = %d, err: %s"
 nbd_co_request_fail(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name, int ret, const char *err) "Request failed { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) } ret = %d, err: %s"
 nbd_client_handshake(const char *export_name) "export '%s'"
-- 
2.40.1


