Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0194672820D
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:00:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7G8v-0004AB-7Y; Thu, 08 Jun 2023 09:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8j-00042h-NX
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8g-0004ko-Lw
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686232635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/QnKxV2pN16lLcAjxkXlbh+ajdIrWM1LhBM7kNJsoY4=;
 b=N5cJvZ3iUN2LdWnFOnBoZYQi7pQbDfDu5+VTzLvdOx/PweKrf6cDYl0vEQ6uWDSSzZsBu+
 qhO/cNymz5NN+GmbhQvkf5XgTDamF4fZC7LpHuvLIkZ1A6p099Fu8MGV98Lh6171XhPdu7
 e13gr09P1+Dk2ppPmWPQq4qSBtDfHQ4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-5wP7wlCEPHyhTaitPIesUQ-1; Thu, 08 Jun 2023 09:57:14 -0400
X-MC-Unique: 5wP7wlCEPHyhTaitPIesUQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DD8C185A78B;
 Thu,  8 Jun 2023 13:57:14 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DACB3492B00;
 Thu,  8 Jun 2023 13:57:13 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 23/24] nbd/server: Prepare for per-request filtering of
 BLOCK_STATUS
Date: Thu,  8 Jun 2023 08:56:52 -0500
Message-Id: <20230608135653.2918540-24-eblake@redhat.com>
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

The next commit will add support for the optional extension
NBD_CMD_FLAG_PAYLOAD during NBD_CMD_BLOCK_STATUS, where the client can
request that the server only return a subset of negotiated contexts,
rather than all contexts.  To make that task easier, this patch
populates the list of contexts to return on a per-command basis (for
now, identical to the full set of negotiated contexts).

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v4: split out NBDMetaContexts refactoring to its own patch, track
NBDRequests.contexts as a pointer rather than inline
---
 include/block/nbd.h |  1 +
 nbd/server.c        | 22 +++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index f240707f646..47850be5a66 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -76,6 +76,7 @@ typedef struct NBDRequest {
     uint16_t flags; /* NBD_CMD_FLAG_* */
     uint16_t type;  /* NBD_CMD_* */
     NBDMode mode;   /* Determines which network representation to use */
+    NBDMetaContexts *contexts; /* Used by NBD_CMD_BLOCK_STATUS */
 } NBDRequest;

 typedef struct NBDSimpleReply {
diff --git a/nbd/server.c b/nbd/server.c
index 42a4300c95e..308846fe46b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2491,6 +2491,8 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
             error_setg(errp, "No memory");
             return -ENOMEM;
         }
+    } else if (request->type == NBD_CMD_BLOCK_STATUS) {
+        request->contexts = &client->contexts;
     }

     if (payload_len) {
@@ -2716,11 +2718,11 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
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
@@ -2733,7 +2735,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                 }
             }

-            if (client->contexts.allocation_depth) {
+            if (request->contexts->allocation_depth) {
                 ret = nbd_co_send_block_status(client, request,
                                                exp->common.blk,
                                                request->from, request->len,
@@ -2746,8 +2748,9 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                 }
             }

+            assert(request->contexts->exp == client->exp);
             for (i = 0; i < client->exp->nr_export_bitmaps; i++) {
-                if (!client->contexts.bitmaps[i]) {
+                if (!request->contexts->bitmaps[i]) {
                     continue;
                 }
                 ret = nbd_co_send_bitmap(client, request,
@@ -2763,6 +2766,10 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
             assert(!contexts_remaining);

             return 0;
+        } else if (client->contexts.count) {
+            return nbd_send_generic_reply(client, request, -EINVAL,
+                                          "CMD_BLOCK_STATUS payload not valid",
+                                          errp);
         } else {
             return nbd_send_generic_reply(client, request, -EINVAL,
                                           "CMD_BLOCK_STATUS not negotiated",
@@ -2841,6 +2848,11 @@ static coroutine_fn void nbd_trip(void *opaque)
     } else {
         ret = nbd_handle_request(client, &request, req->data, &local_err);
     }
+    if (request.type == NBD_CMD_BLOCK_STATUS &&
+        request.contexts != &client->contexts) {
+        g_free(request.contexts->bitmaps);
+        g_free(request.contexts);
+    }
     if (ret < 0) {
         error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
-- 
2.40.1


