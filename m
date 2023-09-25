Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83C7ADF93
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:27:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrE5-0003KV-P1; Mon, 25 Sep 2023 15:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkrDv-0003Fb-1k
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkrDs-00024R-TW
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695669984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQjoT9RmcylVgU8z39nqavl45UqQZqdCKq09T4QJ6KI=;
 b=UOFGFWXkl2IdRtCZ+YfIQWE0Fs/tP7MzxBgMwc5SlF5vVGyEooFvV0DSnPlYbWGyTE+1Vd
 UuGWz+agQLykeyFCf6MfL9R8FW582+hMwpcFZ7/hP6Ec0N97z/At/Iq54okAXSlleb4pE7
 yhkcp9gQlaR+lvk0i77gWs62fbl3CeI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-dJFqrPA_NIiyfawuWb-4mw-1; Mon, 25 Sep 2023 15:26:22 -0400
X-MC-Unique: dJFqrPA_NIiyfawuWb-4mw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 394723C1ACDB;
 Mon, 25 Sep 2023 19:26:22 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4FA351E3;
 Mon, 25 Sep 2023 19:26:21 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v7 11/12] nbd/server: Prepare for per-request filtering of
 BLOCK_STATUS
Date: Mon, 25 Sep 2023 14:22:41 -0500
Message-ID: <20230925192229.3186470-25-eblake@redhat.com>
In-Reply-To: <20230925192229.3186470-14-eblake@redhat.com>
References: <20230925192229.3186470-14-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The next commit will add support for the optional extension
NBD_CMD_FLAG_PAYLOAD during NBD_CMD_BLOCK_STATUS, where the client can
request that the server only return a subset of negotiated contexts,
rather than all contexts.  To make that task easier, this patch
populates the list of contexts to return on a per-command basis (for
now, identical to the full set of negotiated contexts).

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v5: fix null dereference on early error [Vladimir], hoist in assertion
from v4 24/24

v4: split out NBDMetaContexts refactoring to its own patch, track
NBDRequests.contexts as a pointer rather than inline
---
 include/block/nbd.h |  1 +
 nbd/server.c        | 22 +++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 2006497f987..4e7bd6342f9 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -77,6 +77,7 @@ typedef struct NBDRequest {
     uint16_t flags; /* NBD_CMD_FLAG_* */
     uint16_t type;  /* NBD_CMD_* */
     NBDMode mode;   /* Determines which network representation to use */
+    NBDMetaContexts *contexts; /* Used by NBD_CMD_BLOCK_STATUS */
 } NBDRequest;

 typedef struct NBDSimpleReply {
diff --git a/nbd/server.c b/nbd/server.c
index 44ebbd139b2..2d4cec75a49 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2505,6 +2505,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
         break;

     case NBD_CMD_BLOCK_STATUS:
+        request->contexts = &client->contexts;
         valid_flags |= NBD_CMD_FLAG_REQ_ONE;
         break;

@@ -2745,17 +2746,18 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                                       "discard failed", errp);

     case NBD_CMD_BLOCK_STATUS:
+        assert(request->contexts);
         if (!request->len) {
             return nbd_send_generic_reply(client, request, -EINVAL,
                                           "need non-zero length", errp);
         }
         assert(client->mode >= NBD_MODE_EXTENDED ||
                request->len <= UINT32_MAX);
-        if (client->contexts.count) {
+        if (request->contexts->count) {
             bool dont_fragment = request->flags & NBD_CMD_FLAG_REQ_ONE;
-            int contexts_remaining = client->contexts.count;
+            int contexts_remaining = request->contexts->count;

-            if (client->contexts.base_allocation) {
+            if (request->contexts->base_allocation) {
                 ret = nbd_co_send_block_status(client, request,
                                                exp->common.blk,
                                                request->from,
@@ -2768,7 +2770,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                 }
             }

-            if (client->contexts.allocation_depth) {
+            if (request->contexts->allocation_depth) {
                 ret = nbd_co_send_block_status(client, request,
                                                exp->common.blk,
                                                request->from, request->len,
@@ -2781,8 +2783,9 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                 }
             }

+            assert(request->contexts->exp == client->exp);
             for (i = 0; i < client->exp->nr_export_bitmaps; i++) {
-                if (!client->contexts.bitmaps[i]) {
+                if (!request->contexts->bitmaps[i]) {
                     continue;
                 }
                 ret = nbd_co_send_bitmap(client, request,
@@ -2798,6 +2801,10 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
             assert(!contexts_remaining);

             return 0;
+        } else if (client->contexts.count) {
+            return nbd_send_generic_reply(client, request, -EINVAL,
+                                          "CMD_BLOCK_STATUS payload not valid",
+                                          errp);
         } else {
             return nbd_send_generic_reply(client, request, -EINVAL,
                                           "CMD_BLOCK_STATUS not negotiated",
@@ -2876,6 +2883,11 @@ static coroutine_fn void nbd_trip(void *opaque)
     } else {
         ret = nbd_handle_request(client, &request, req->data, &local_err);
     }
+    if (request.contexts && request.contexts != &client->contexts) {
+        assert(request.type == NBD_CMD_BLOCK_STATUS);
+        g_free(request.contexts->bitmaps);
+        g_free(request.contexts);
+    }
     if (ret < 0) {
         error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
-- 
2.41.0


