Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B06EC7BA969
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 20:47:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoTMD-0001MV-2P; Thu, 05 Oct 2023 14:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoTM1-0000nd-Di
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoTLx-00064K-87
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696531540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdUZNBjYS/GR+4+BBZH/6cvuzdA/9Xv8NXaDagnKdAE=;
 b=coaMeTKsuo6t/zD3H+VJwzaLLdEQ9TYDVJRA46KsgPXY0zLfjQyklru8hZji2FmmK7b8sT
 +1YfMuo4cdtjPRHEM1YNjBMhps8jfWc12ctDnqJbRN34+54sgsiOyV8w9aXscMETESnf6c
 t+Zqn1KzTByMBPcXcPnjOkLmTDq4kPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-8v_-8kFCNWaYKLKO_xUflw-1; Thu, 05 Oct 2023 14:45:32 -0400
X-MC-Unique: 8v_-8kFCNWaYKLKO_xUflw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BF02185A78E;
 Thu,  5 Oct 2023 18:45:31 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BA982156711;
 Thu,  5 Oct 2023 18:45:31 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 11/15] nbd/client: Accept 64-bit block status chunks
Date: Thu,  5 Oct 2023 13:44:58 -0500
Message-ID: <20231005184447.682556-28-eblake@redhat.com>
In-Reply-To: <20231005184447.682556-17-eblake@redhat.com>
References: <20231005184447.682556-17-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Once extended mode is enabled, we need to accept 64-bit status replies
(even for replies that don't exceed a 32-bit length).  It is easier to
normalize narrow replies into wide format so that the rest of our code
only has to handle one width.  Although a server is non-compliant if
it sends a 64-bit reply in compact mode, or a 32-bit reply in extended
mode, it is still easy enough to tolerate these mismatches.

In normal execution, we are only requesting "base:allocation" which
never exceeds 32 bits for flag values. But during testing with
x-dirty-bitmap, we can force qemu to connect to some other context
that might have 64-bit status bit; however, we ignore those upper bits
(other than mapping qemu:allocation-depth into something that
'qemu-img map --output=json' can expose), and since that only affects
testing, we really don't bother with checking whether more than the
two least-significant bits are set.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20230925192229.3186470-22-eblake@redhat.com>
---
 block/nbd.c        | 49 ++++++++++++++++++++++++++++++++--------------
 block/trace-events |  1 +
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 76461430411..52ebc8b2f53 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -615,13 +615,17 @@ static int nbd_parse_offset_hole_payload(BDRVNBDState *s,
  */
 static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
                                          NBDStructuredReplyChunk *chunk,
-                                         uint8_t *payload, uint64_t orig_length,
-                                         NBDExtent32 *extent, Error **errp)
+                                         uint8_t *payload, bool wide,
+                                         uint64_t orig_length,
+                                         NBDExtent64 *extent, Error **errp)
 {
     uint32_t context_id;
+    uint32_t count;
+    size_t ext_len = wide ? sizeof(*extent) : sizeof(NBDExtent32);
+    size_t pay_len = sizeof(context_id) + wide * sizeof(count) + ext_len;

     /* The server succeeded, so it must have sent [at least] one extent */
-    if (chunk->length < sizeof(context_id) + sizeof(*extent)) {
+    if (chunk->length < pay_len) {
         error_setg(errp, "Protocol error: invalid payload for "
                          "NBD_REPLY_TYPE_BLOCK_STATUS");
         return -EINVAL;
@@ -636,8 +640,15 @@ static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
         return -EINVAL;
     }

-    extent->length = payload_advance32(&payload);
-    extent->flags = payload_advance32(&payload);
+    if (wide) {
+        count = payload_advance32(&payload);
+        extent->length = payload_advance64(&payload);
+        extent->flags = payload_advance64(&payload);
+    } else {
+        count = 0;
+        extent->length = payload_advance32(&payload);
+        extent->flags = payload_advance32(&payload);
+    }

     if (extent->length == 0) {
         error_setg(errp, "Protocol error: server sent status chunk with "
@@ -658,7 +669,7 @@ static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
      * (always a safe status, even if it loses information).
      */
     if (s->info.min_block && !QEMU_IS_ALIGNED(extent->length,
-                                                   s->info.min_block)) {
+                                              s->info.min_block)) {
         trace_nbd_parse_blockstatus_compliance("extent length is unaligned");
         if (extent->length > s->info.min_block) {
             extent->length = QEMU_ALIGN_DOWN(extent->length,
@@ -672,13 +683,15 @@ static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
     /*
      * We used NBD_CMD_FLAG_REQ_ONE, so the server should not have
      * sent us any more than one extent, nor should it have included
-     * status beyond our request in that extent. However, it's easy
-     * enough to ignore the server's noncompliance without killing the
+     * status beyond our request in that extent. Furthermore, a wide
+     * server should have replied with an accurate count (we left
+     * count at 0 for a narrow server).  However, it's easy enough to
+     * ignore the server's noncompliance without killing the
      * connection; just ignore trailing extents, and clamp things to
      * the length of our request.
      */
-    if (chunk->length > sizeof(context_id) + sizeof(*extent)) {
-        trace_nbd_parse_blockstatus_compliance("more than one extent");
+    if (count != wide || chunk->length > pay_len) {
+        trace_nbd_parse_blockstatus_compliance("unexpected extent count");
     }
     if (extent->length > orig_length) {
         extent->length = orig_length;
@@ -1124,7 +1137,7 @@ nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,

 static int coroutine_fn
 nbd_co_receive_blockstatus_reply(BDRVNBDState *s, uint64_t cookie,
-                                 uint64_t length, NBDExtent32 *extent,
+                                 uint64_t length, NBDExtent64 *extent,
                                  int *request_ret, Error **errp)
 {
     NBDReplyChunkIter iter;
@@ -1137,11 +1150,17 @@ nbd_co_receive_blockstatus_reply(BDRVNBDState *s, uint64_t cookie,
     NBD_FOREACH_REPLY_CHUNK(s, iter, cookie, false, NULL, &reply, &payload) {
         int ret;
         NBDStructuredReplyChunk *chunk = &reply.structured;
+        bool wide;

         assert(nbd_reply_is_structured(&reply));

         switch (chunk->type) {
+        case NBD_REPLY_TYPE_BLOCK_STATUS_EXT:
         case NBD_REPLY_TYPE_BLOCK_STATUS:
+            wide = chunk->type == NBD_REPLY_TYPE_BLOCK_STATUS_EXT;
+            if ((s->info.mode >= NBD_MODE_EXTENDED) != wide) {
+                trace_nbd_extended_headers_compliance("block_status");
+            }
             if (received) {
                 nbd_channel_error(s, -EINVAL);
                 error_setg(&local_err, "Several BLOCK_STATUS chunks in reply");
@@ -1149,9 +1168,9 @@ nbd_co_receive_blockstatus_reply(BDRVNBDState *s, uint64_t cookie,
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
@@ -1381,7 +1400,7 @@ static int coroutine_fn GRAPH_RDLOCK nbd_client_co_block_status(
         int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
     int ret, request_ret;
-    NBDExtent32 extent = { 0 };
+    NBDExtent64 extent = { 0 };
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     Error *local_err = NULL;

diff --git a/block/trace-events b/block/trace-events
index 925aa554bbf..8e789e1f12f 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -166,6 +166,7 @@ iscsi_xcopy(void *src_lun, uint64_t src_off, void *dst_lun, uint64_t dst_off, ui
 # nbd.c
 nbd_parse_blockstatus_compliance(const char *err) "ignoring extra data from non-compliant server: %s"
 nbd_structured_read_compliance(const char *type) "server sent non-compliant unaligned read %s chunk"
+nbd_extended_headers_compliance(const char *type) "server sent non-compliant %s chunk not matching choice of extended headers"
 nbd_read_reply_entry_fail(int ret, const char *err) "ret = %d, err: %s"
 nbd_co_request_fail(uint64_t from, uint64_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name, int ret, const char *err) "Request failed { .from = %" PRIu64", .len = %" PRIu64 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) } ret = %d, err: %s"
 nbd_client_handshake(const char *export_name) "export '%s'"
-- 
2.41.0


