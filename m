Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE877281F1
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:58:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7G94-0004MC-Df; Thu, 08 Jun 2023 09:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8h-0003z7-2n
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8a-0004jl-Dw
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686232633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b4KTHIdASJFojj3Hj/Jrck+pACsUu7CtkXPfpgmPlzc=;
 b=dDRmHiswdYQxr61tDMDHoLaRD4Bc2aoL7sUAc3+683N+KcOhRwRONsOpCgZsb4HzEuo5pK
 RMfKAHzuDyswsi8IZ5ujszjTv+1Xi5ktA1PAwMyTygMS9EvO8V2+afH5vwyBB7NWwNod5W
 pXuSkVW87utF1f77vLcSUXdh9tUQBfM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-Y4hJ3F6vNLy4N-ZFzohTuA-1; Thu, 08 Jun 2023 09:57:08 -0400
X-MC-Unique: Y4hJ3F6vNLy4N-ZFzohTuA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 459BF1C0942A;
 Thu,  8 Jun 2023 13:57:08 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF364492B00;
 Thu,  8 Jun 2023 13:57:07 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	libguestfs@redhat.com,
	vsementsov@yandex-team.ru
Subject: [PATCH v4 16/24] nbd/server: Support 64-bit block status
Date: Thu,  8 Jun 2023 08:56:45 -0500
Message-Id: <20230608135653.2918540-17-eblake@redhat.com>
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

The NBD spec states that if the client negotiates extended headers,
the server must avoid NBD_REPLY_TYPE_BLOCK_STATUS and instead use
NBD_REPLY_TYPE_BLOCK_STATUS_EXT which supports 64-bit lengths, even if
the reply does not need more than 32 bits.  As of this patch,
client->mode is still never NBD_MODE_EXTENDED, so the code added here
does not take effect until the next patch enables negotiation.

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

v4: split conversion to big-endian across two helper functions rather
than in-place union [Vladimir]
---
 nbd/server.c | 104 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 78 insertions(+), 26 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 84c848a31d3..3010ff0dca4 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2111,20 +2111,24 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
 }

 typedef struct NBDExtentArray {
-    NBDExtent32 *extents;
+    NBDExtent64 *extents;
     unsigned int nb_alloc;
     unsigned int count;
     uint64_t total_length;
+    bool extended;
     bool can_add;
     bool converted_to_be;
 } NBDExtentArray;

-static NBDExtentArray *nbd_extent_array_new(unsigned int nb_alloc)
+static NBDExtentArray *nbd_extent_array_new(unsigned int nb_alloc,
+                                            NBDMode mode)
 {
     NBDExtentArray *ea = g_new0(NBDExtentArray, 1);

+    assert(mode >= NBD_MODE_STRUCTURED);
     ea->nb_alloc = nb_alloc;
-    ea->extents = g_new(NBDExtent32, nb_alloc);
+    ea->extents = g_new(NBDExtent64, nb_alloc);
+    ea->extended = mode >= NBD_MODE_EXTENDED;
     ea->can_add = true;

     return ea;
@@ -2143,15 +2147,36 @@ static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
     int i;

     assert(!ea->converted_to_be);
+    assert(ea->extended);
     ea->can_add = false;
     ea->converted_to_be = true;

     for (i = 0; i < ea->count; i++) {
-        ea->extents[i].flags = cpu_to_be32(ea->extents[i].flags);
-        ea->extents[i].length = cpu_to_be32(ea->extents[i].length);
+        ea->extents[i].length = cpu_to_be64(ea->extents[i].length);
+        ea->extents[i].flags = cpu_to_be64(ea->extents[i].flags);
     }
 }

+/* Further modifications of the array after conversion are abandoned */
+static NBDExtent32 *nbd_extent_array_convert_to_narrow(NBDExtentArray *ea)
+{
+    int i;
+    NBDExtent32 *extents = g_new(NBDExtent32, ea->count);
+
+    assert(!ea->converted_to_be);
+    assert(!ea->extended);
+    ea->can_add = false;
+    ea->converted_to_be = true;
+
+    for (i = 0; i < ea->count; i++) {
+        assert((ea->extents[i].length | ea->extents[i].flags) <= UINT32_MAX);
+        extents[i].length = cpu_to_be32(ea->extents[i].length);
+        extents[i].flags = cpu_to_be32(ea->extents[i].flags);
+    }
+
+    return extents;
+}
+
 /*
  * Add extent to NBDExtentArray. If extent can't be added (no available space),
  * return -1.
@@ -2162,19 +2187,23 @@ static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
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
+    if (!ea->extended) {
+        assert(length <= UINT32_MAX);
+    }

     /* Extend previous extent if flags are the same */
     if (ea->count > 0 && flags == ea->extents[ea->count - 1].flags) {
-        uint64_t sum = (uint64_t)length + ea->extents[ea->count - 1].length;
+        uint64_t sum = length + ea->extents[ea->count - 1].length;

-        if (sum <= UINT32_MAX) {
+        assert(sum >= length);
+        if (sum <= UINT32_MAX || ea->extended) {
             ea->extents[ea->count - 1].length = sum;
             ea->total_length += length;
             return 0;
@@ -2187,7 +2216,7 @@ static int nbd_extent_array_add(NBDExtentArray *ea,
     }

     ea->total_length += length;
-    ea->extents[ea->count] = (NBDExtent32) {.length = length, .flags = flags};
+    ea->extents[ea->count] = (NBDExtent64) {.length = length, .flags = flags};
     ea->count++;

     return 0;
@@ -2256,20 +2285,39 @@ nbd_co_send_extents(NBDClient *client, NBDRequest *request, NBDExtentArray *ea,
                     bool last, uint32_t context_id, Error **errp)
 {
     NBDReply hdr;
-    NBDStructuredMeta chunk;
-    struct iovec iov[] = {
-        {.iov_base = &hdr},
-        {.iov_base = &chunk, .iov_len = sizeof(chunk)},
-        {.iov_base = ea->extents, .iov_len = ea->count * sizeof(ea->extents[0])}
-    };
-
-    nbd_extent_array_convert_to_be(ea);
+    NBDStructuredMeta meta;
+    NBDExtendedMeta meta_ext;
+    g_autofree NBDExtent32 *extents = NULL;
+    uint16_t type;
+    struct iovec iov[] = { {.iov_base = &hdr}, {0}, {0} };
+
+    if (client->mode >= NBD_MODE_EXTENDED) {
+        type = NBD_REPLY_TYPE_BLOCK_STATUS_EXT;
+
+        iov[1].iov_base = &meta_ext;
+        iov[1].iov_len = sizeof(meta_ext);
+        stl_be_p(&meta_ext.context_id, context_id);
+        stl_be_p(&meta_ext.count, ea->count);
+
+        nbd_extent_array_convert_to_be(ea);
+        iov[2].iov_base = ea->extents;
+        iov[2].iov_len = ea->count * sizeof(ea->extents[0]);
+    } else {
+        type = NBD_REPLY_TYPE_BLOCK_STATUS;
+
+        iov[1].iov_base = &meta;
+        iov[1].iov_len = sizeof(meta);
+        stl_be_p(&meta.context_id, context_id);
+
+        extents = nbd_extent_array_convert_to_narrow(ea);
+        iov[2].iov_base = extents;
+        iov[2].iov_len = ea->count * sizeof(extents[0]);
+    }

     trace_nbd_co_send_extents(request->cookie, ea->count, context_id,
                               ea->total_length, last);
-    set_be_chunk(client, iov, 3, last ? NBD_REPLY_FLAG_DONE : 0,
-                 NBD_REPLY_TYPE_BLOCK_STATUS, request);
-    stl_be_p(&chunk.context_id, context_id);
+    set_be_chunk(client, iov, 3, last ? NBD_REPLY_FLAG_DONE : 0, type,
+                 request);

     return nbd_co_send_iov(client, iov, 3, errp);
 }
@@ -2278,13 +2326,14 @@ nbd_co_send_extents(NBDClient *client, NBDRequest *request, NBDExtentArray *ea,
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
+        nbd_extent_array_new(nb_extents, client->mode);

     if (context_id == NBD_META_ID_BASE_ALLOCATION) {
         ret = blockstatus_to_extents(blk, offset, length, ea);
@@ -2307,11 +2356,12 @@ static void bitmap_to_extents(BdrvDirtyBitmap *bitmap,
     int64_t start, dirty_start, dirty_count;
     int64_t end = offset + length;
     bool full = false;
+    int64_t bound = es->extended ? INT64_MAX : INT32_MAX;

     bdrv_dirty_bitmap_lock(bitmap);

     for (start = offset;
-         bdrv_dirty_bitmap_next_dirty_area(bitmap, start, end, INT32_MAX,
+         bdrv_dirty_bitmap_next_dirty_area(bitmap, start, end, bound,
                                            &dirty_start, &dirty_count);
          start = dirty_start + dirty_count)
     {
@@ -2335,12 +2385,13 @@ static int coroutine_fn nbd_co_send_bitmap(NBDClient *client,
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
+        nbd_extent_array_new(nb_extents, client->mode);

     bitmap_to_extents(bitmap, offset, length, ea);

@@ -2637,7 +2688,8 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
             return nbd_send_generic_reply(client, request, -EINVAL,
                                           "need non-zero length", errp);
         }
-        assert(request->len <= UINT32_MAX);
+        assert(client->mode >= NBD_MODE_EXTENDED ||
+               request->len <= UINT32_MAX);
         if (client->export_meta.count) {
             bool dont_fragment = request->flags & NBD_CMD_FLAG_REQ_ONE;
             int contexts_remaining = client->export_meta.count;
-- 
2.40.1


