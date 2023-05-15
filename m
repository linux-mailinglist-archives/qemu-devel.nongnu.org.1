Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 387F0703DDF
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:54:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeGe-00053d-FT; Mon, 15 May 2023 15:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGa-00050M-Pa
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGY-00048x-Ef
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7vUy56vOuvTFNAFraMTmM5buDOZutDaWHKMocoh+sic=;
 b=IJAv3JVOM0g3nBHHjsgKktVIIlw7o5DQQuGG61tnuOW1iEZrv1Tp8Djwz+0rAuURIqvw5G
 kXEVsa30vZnvt2rIfrwKSskt29pHy5JdN4n4fMOovsjCEfAgs8KQSUx8y24ztNOWfMvt6D
 iriYvPdUgrzZLOPZ/EUXZ2RR1PGpfxE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-HowCdepmNwWJ1PIqxXZ3rg-1; Mon, 15 May 2023 15:53:52 -0400
X-MC-Unique: HowCdepmNwWJ1PIqxXZ3rg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F15C010146EA;
 Mon, 15 May 2023 19:53:51 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 830421410DD5;
 Mon, 15 May 2023 19:53:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, vsementsov@yandex-team.ru,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PATCH v3 08/14] nbd/server: Support 64-bit block status
Date: Mon, 15 May 2023 14:53:37 -0500
Message-Id: <20230515195343.1915857-9-eblake@redhat.com>
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

The NBD spec states that if the client negotiates extended headers,
the server must avoid NBD_REPLY_TYPE_BLOCK_STATUS and instead use
NBD_REPLY_TYPE_BLOCK_STATUS_EXT which supports 64-bit lengths, even if
the reply does not need more than 32 bits.  As of this patch,
client->header_style is still never NBD_HEADER_EXTENDED, so the code
added here does not take effect until the next patch enables
negotiation.

For now, all metacontexts that we know how to export never populate
more than 32 bits of information, so we don't have to worry about
NBD_REP_ERR_EXT_HEADER_REQD or filtering during handshake, and we
always send all zeroes for the upper 32 bits of status during
NBD_CMD_BLOCK_STATUS.

Note that we previously had some interesting size-juggling on call
chains, such as:

nbd_co_send_block_status(uint32_t length)
-> blockstatus_to_extents(uint32_t bytes)
  -> bdrv_block_status_above(bytes, &uint64_t num)
  -> nbd_extent_array_add(uint64_t num)
    -> store num in 32-bit length

But we were lucky that it never overflowed: bdrv_block_status_above
never sets num larger than bytes, and we had previously been capping
'bytes' at 32 bits (since the protocol does not allow sending a larger
request without extended headers).  This patch adds some assertions
that ensure we continue to avoid overflowing 32 bits for a narrow
client, while fully utilizing 64-bits all the way through when the
client understands that.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 86 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 24 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index ffab51efd26..b4c15ae1a14 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2073,7 +2073,15 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
 }

 typedef struct NBDExtentArray {
-    NBDExtent *extents;
+    NBDHeaderStyle style;           /* 32- or 64-bit extent descriptions */
+    union {
+        NBDStructuredMeta id;       /* style == NBD_HEADER_STRUCTURED */
+        NBDStructuredMetaExt meta;  /* style == NBD_HEADER_EXTENDED */
+    };
+    union {
+        NBDExtent *narrow;          /* style == NBD_HEADER_STRUCTURED */
+        NBDExtentExt *extents;      /* style == NBD_HEADER_EXTENDED */
+    };
     unsigned int nb_alloc;
     unsigned int count;
     uint64_t total_length;
@@ -2081,12 +2089,15 @@ typedef struct NBDExtentArray {
     bool converted_to_be;
 } NBDExtentArray;

-static NBDExtentArray *nbd_extent_array_new(unsigned int nb_alloc)
+static NBDExtentArray *nbd_extent_array_new(unsigned int nb_alloc,
+                                            NBDHeaderStyle style)
 {
     NBDExtentArray *ea = g_new0(NBDExtentArray, 1);

+    assert(style >= NBD_HEADER_STRUCTURED);
     ea->nb_alloc = nb_alloc;
-    ea->extents = g_new(NBDExtent, nb_alloc);
+    ea->extents = g_new(NBDExtentExt, nb_alloc);
+    ea->style = style;
     ea->can_add = true;

     return ea;
@@ -2100,17 +2111,37 @@ static void nbd_extent_array_free(NBDExtentArray *ea)
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free)

 /* Further modifications of the array after conversion are abandoned */
-static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
+static void nbd_extent_array_convert_to_be(NBDExtentArray *ea,
+                                           uint32_t context_id,
+                                           struct iovec *iov)
 {
     int i;

     assert(!ea->converted_to_be);
+    assert(iov[0].iov_base == &ea->meta);
+    assert(iov[1].iov_base == ea->extents);
     ea->can_add = false;
     ea->converted_to_be = true;

-    for (i = 0; i < ea->count; i++) {
-        ea->extents[i].flags = cpu_to_be32(ea->extents[i].flags);
-        ea->extents[i].length = cpu_to_be32(ea->extents[i].length);
+    stl_be_p(&ea->meta.context_id, context_id);
+    if (ea->style >= NBD_HEADER_EXTENDED) {
+        stl_be_p(&ea->meta.count, ea->count);
+        for (i = 0; i < ea->count; i++) {
+            ea->extents[i].length = cpu_to_be64(ea->extents[i].length);
+            ea->extents[i].flags = cpu_to_be64(ea->extents[i].flags);
+        }
+        iov[0].iov_len = sizeof(ea->meta);
+        iov[1].iov_len = ea->count * sizeof(ea->extents[0]);
+    } else {
+        /* Conversion reduces memory usage, order of iteration matters */
+        for (i = 0; i < ea->count; i++) {
+            assert(ea->extents[i].length <= UINT32_MAX);
+            assert((uint32_t) ea->extents[i].flags == ea->extents[i].flags);
+            ea->narrow[i].length = cpu_to_be32(ea->extents[i].length);
+            ea->narrow[i].flags = cpu_to_be32(ea->extents[i].flags);
+        }
+        iov[0].iov_len = sizeof(ea->id);
+        iov[1].iov_len = ea->count * sizeof(ea->narrow[0]);
     }
 }

@@ -2124,19 +2155,23 @@ static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
  * would result in an incorrect range reported to the client)
  */
 static int nbd_extent_array_add(NBDExtentArray *ea,
-                                uint32_t length, uint32_t flags)
+                                uint64_t length, uint32_t flags)
 {
     assert(ea->can_add);

     if (!length) {
         return 0;
     }
+    if (ea->style == NBD_HEADER_STRUCTURED) {
+        assert(length <= UINT32_MAX);
+    }

     /* Extend previous extent if flags are the same */
     if (ea->count > 0 && flags == ea->extents[ea->count - 1].flags) {
-        uint64_t sum = (uint64_t)length + ea->extents[ea->count - 1].length;
+        uint64_t sum = length + ea->extents[ea->count - 1].length;

-        if (sum <= UINT32_MAX) {
+        assert(sum >= length);
+        if (sum <= UINT32_MAX || ea->style >= NBD_HEADER_EXTENDED) {
             ea->extents[ea->count - 1].length = sum;
             ea->total_length += length;
             return 0;
@@ -2149,7 +2184,7 @@ static int nbd_extent_array_add(NBDExtentArray *ea,
     }

     ea->total_length += length;
-    ea->extents[ea->count] = (NBDExtent) {.length = length, .flags = flags};
+    ea->extents[ea->count] = (NBDExtentExt) {.length = length, .flags = flags};
     ea->count++;

     return 0;
@@ -2218,21 +2253,20 @@ nbd_co_send_extents(NBDClient *client, NBDRequest *request, NBDExtentArray *ea,
                     bool last, uint32_t context_id, Error **errp)
 {
     NBDReply hdr;
-    NBDStructuredMeta chunk;
     struct iovec iov[] = {
         {.iov_base = &hdr},
-        {.iov_base = &chunk, .iov_len = sizeof(chunk)},
-        {.iov_base = ea->extents, .iov_len = ea->count * sizeof(ea->extents[0])}
+        {.iov_base = &ea->meta},
+        {.iov_base = ea->extents}
     };
+    uint16_t type = client->header_style == NBD_HEADER_EXTENDED ?
+        NBD_REPLY_TYPE_BLOCK_STATUS_EXT : NBD_REPLY_TYPE_BLOCK_STATUS;

-    nbd_extent_array_convert_to_be(ea);
+    nbd_extent_array_convert_to_be(ea, context_id, &iov[1]);

     trace_nbd_co_send_extents(request->handle, ea->count, context_id,
                               ea->total_length, last);
-    set_be_chunk(client, &iov[0], last ? NBD_REPLY_FLAG_DONE : 0,
-                 NBD_REPLY_TYPE_BLOCK_STATUS,
+    set_be_chunk(client, &iov[0], last ? NBD_REPLY_FLAG_DONE : 0, type,
                  request, iov[1].iov_len + iov[2].iov_len);
-    stl_be_p(&chunk.context_id, context_id);

     return nbd_co_send_iov(client, iov, 3, errp);
 }
@@ -2241,13 +2275,14 @@ nbd_co_send_extents(NBDClient *client, NBDRequest *request, NBDExtentArray *ea,
 static int
 coroutine_fn nbd_co_send_block_status(NBDClient *client, NBDRequest *request,
                                       BlockBackend *blk, uint64_t offset,
-                                      uint32_t length, bool dont_fragment,
+                                      uint64_t length, bool dont_fragment,
                                       bool last, uint32_t context_id,
                                       Error **errp)
 {
     int ret;
     unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_EXTENTS;
-    g_autoptr(NBDExtentArray) ea = nbd_extent_array_new(nb_extents);
+    g_autoptr(NBDExtentArray) ea =
+        nbd_extent_array_new(nb_extents, client->header_style);

     if (context_id == NBD_META_ID_BASE_ALLOCATION) {
         ret = blockstatus_to_extents(blk, offset, length, ea);
@@ -2270,11 +2305,12 @@ static void bitmap_to_extents(BdrvDirtyBitmap *bitmap,
     int64_t start, dirty_start, dirty_count;
     int64_t end = offset + length;
     bool full = false;
+    int64_t bound = es->style >= NBD_HEADER_EXTENDED ? INT64_MAX : INT32_MAX;

     bdrv_dirty_bitmap_lock(bitmap);

     for (start = offset;
-         bdrv_dirty_bitmap_next_dirty_area(bitmap, start, end, INT32_MAX,
+         bdrv_dirty_bitmap_next_dirty_area(bitmap, start, end, bound,
                                            &dirty_start, &dirty_count);
          start = dirty_start + dirty_count)
     {
@@ -2298,12 +2334,13 @@ static int coroutine_fn nbd_co_send_bitmap(NBDClient *client,
                                            NBDRequest *request,
                                            BdrvDirtyBitmap *bitmap,
                                            uint64_t offset,
-                                           uint32_t length, bool dont_fragment,
+                                           uint64_t length, bool dont_fragment,
                                            bool last, uint32_t context_id,
                                            Error **errp)
 {
     unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_EXTENTS;
-    g_autoptr(NBDExtentArray) ea = nbd_extent_array_new(nb_extents);
+    g_autoptr(NBDExtentArray) ea =
+        nbd_extent_array_new(nb_extents, client->header_style);

     bitmap_to_extents(bitmap, offset, length, ea);

@@ -2602,7 +2639,8 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
             return nbd_send_generic_reply(client, request, -EINVAL,
                                           "need non-zero length", errp);
         }
-        assert(request->len <= UINT32_MAX);
+        assert(client->header_style >= NBD_HEADER_EXTENDED ||
+               request->len <= UINT32_MAX);
         if (client->export_meta.count) {
             bool dont_fragment = request->flags & NBD_CMD_FLAG_REQ_ONE;
             int contexts_remaining = client->export_meta.count;
-- 
2.40.1


