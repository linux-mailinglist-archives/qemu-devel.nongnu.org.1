Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 117EF777F5B
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 19:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU9gG-00046h-NY; Thu, 10 Aug 2023 13:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qU9gC-000449-Ln
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qU9gA-00052k-Jh
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691689354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5O5O/o6K8ddwBvdg4YENFgSCzr4MnI0Z9OdKB0lspM=;
 b=Q8IKbMek2JwxaO4VQI8yKzen3mQrNObaQhJNRoWx9IZ37i6GRBh+XvtG+ydG1Nf8L4BUhd
 0wA2vt7TI87eHL5R3rYqt28buqqLWcCjuHK71TT4cAIX4nGH17XqRaOxkgIIw6P37IxDqA
 c3O2iSGhoLHjciDlM9BP4IvKRLbyfw4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-NXJfdMBuOyi2brK75vLy8Q-1; Thu, 10 Aug 2023 13:42:28 -0400
X-MC-Unique: NXJfdMBuOyi2brK75vLy8Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 867588DC666;
 Thu, 10 Aug 2023 17:42:28 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 141541121314;
 Thu, 10 Aug 2023 17:42:28 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v5 16/17] nbd/server: Prepare for per-request filtering of
 BLOCK_STATUS
Date: Thu, 10 Aug 2023 12:37:03 -0500
Message-ID: <20230810173646.17695-35-eblake@redhat.com>
In-Reply-To: <20230810173646.17695-19-eblake@redhat.com>
References: <20230810173646.17695-19-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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
index 7643c321f36..9285aa85826 100644
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
index 76235347174..ed988aa6308 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2511,6 +2511,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
         break;

     case NBD_CMD_BLOCK_STATUS:
+        request->contexts = &client->contexts;
         valid_flags |= NBD_CMD_FLAG_REQ_ONE;
         break;

@@ -2751,17 +2752,18 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
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
@@ -2774,7 +2776,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                 }
             }

-            if (client->contexts.allocation_depth) {
+            if (request->contexts->allocation_depth) {
                 ret = nbd_co_send_block_status(client, request,
                                                exp->common.blk,
                                                request->from, request->len,
@@ -2787,8 +2789,9 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                 }
             }

+            assert(request->contexts->exp == client->exp);
             for (i = 0; i < client->exp->nr_export_bitmaps; i++) {
-                if (!client->contexts.bitmaps[i]) {
+                if (!request->contexts->bitmaps[i]) {
                     continue;
                 }
                 ret = nbd_co_send_bitmap(client, request,
@@ -2804,6 +2807,10 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
             assert(!contexts_remaining);

             return 0;
+        } else if (client->contexts.count) {
+            return nbd_send_generic_reply(client, request, -EINVAL,
+                                          "CMD_BLOCK_STATUS payload not valid",
+                                          errp);
         } else {
             return nbd_send_generic_reply(client, request, -EINVAL,
                                           "CMD_BLOCK_STATUS not negotiated",
@@ -2882,6 +2889,11 @@ static coroutine_fn void nbd_trip(void *opaque)
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


