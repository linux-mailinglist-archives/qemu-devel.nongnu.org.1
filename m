Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED17281FE
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:59:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7G8n-00044v-VF; Thu, 08 Jun 2023 09:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8V-0003tG-44
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8P-0004fi-VJ
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686232625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JokQggT6bH+kDhFJOhw/lO+F4z8+gvpOIodpQcQA6KI=;
 b=Untah1lUElRAuOpVfbx1v4/1um4KEmYJH9Re6GGmVLrzHrkkm7k69lwT+ud4WVNmOAmcnM
 vwoGkHQapUp3pdnx6P40RWuSqKC7wvvNitoDtwW8Ie9qjPvEsZtR/WSXRcAN/MY66lAGG6
 fxU/rGRbL5uNcRHPzOLZPvvkrS2kX2o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-iRCxf-1yNAWyzMvso5ujiw-1; Thu, 08 Jun 2023 09:57:01 -0400
X-MC-Unique: iRCxf-1yNAWyzMvso5ujiw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C8E080A0C5;
 Thu,  8 Jun 2023 13:57:01 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95E4A492B00;
 Thu,  8 Jun 2023 13:57:00 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 06/24] nbd/client: Simplify cookie vs. index computation
Date: Thu,  8 Jun 2023 08:56:35 -0500
Message-Id: <20230608135653.2918540-7-eblake@redhat.com>
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

Our code relies on a sentinel cookie value of zero for deciding when a
packet has been handled, as well as relying on array indices between 0
and MAX_NBD_REQUESTS-1 for dereferencing purposes.  As long as we can
symmetrically convert between two forms, there is no reason to go with
the odd choice of using XOR with a random pointer, when we can instead
simplify the mappings with a mere offset of 1.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v4: new patch
---
 block/nbd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index be3c46c6fee..5322e66166c 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -50,8 +50,8 @@
 #define EN_OPTSTR ":exportname="
 #define MAX_NBD_REQUESTS    16

-#define COOKIE_TO_INDEX(bs, cookie) ((cookie) ^ (uint64_t)(intptr_t)(bs))
-#define INDEX_TO_COOKIE(bs, index)  ((index)  ^ (uint64_t)(intptr_t)(bs))
+#define COOKIE_TO_INDEX(cookie) ((cookie) - 1)
+#define INDEX_TO_COOKIE(index)  ((index) + 1)

 typedef struct {
     Coroutine *coroutine;
@@ -420,7 +420,7 @@ static void coroutine_fn GRAPH_RDLOCK nbd_reconnect_attempt(BDRVNBDState *s)
 static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie)
 {
     int ret;
-    uint64_t ind = COOKIE_TO_INDEX(s, cookie), ind2;
+    uint64_t ind = COOKIE_TO_INDEX(cookie), ind2;
     QEMU_LOCK_GUARD(&s->receive_mutex);

     while (true) {
@@ -435,7 +435,7 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie)
              * woken by whoever set s->reply.cookie (or never wait in this
              * yield). So, we should not wake it here.
              */
-            ind2 = COOKIE_TO_INDEX(s, s->reply.cookie);
+            ind2 = COOKIE_TO_INDEX(s->reply.cookie);
             assert(!s->requests[ind2].receiving);

             s->requests[ind].receiving = true;
@@ -468,7 +468,7 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie)
             nbd_channel_error(s, -EINVAL);
             return -EINVAL;
         }
-        ind2 = COOKIE_TO_INDEX(s, s->reply.cookie);
+        ind2 = COOKIE_TO_INDEX(s->reply.cookie);
         if (ind2 >= MAX_NBD_REQUESTS || !s->requests[ind2].coroutine) {
             nbd_channel_error(s, -EINVAL);
             return -EINVAL;
@@ -519,7 +519,7 @@ nbd_co_send_request(BlockDriverState *bs, NBDRequest *request,
     qemu_mutex_unlock(&s->requests_lock);

     qemu_co_mutex_lock(&s->send_mutex);
-    request->cookie = INDEX_TO_COOKIE(s, i);
+    request->cookie = INDEX_TO_COOKIE(i);

     assert(s->ioc);

@@ -832,7 +832,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
         int *request_ret, QEMUIOVector *qiov, void **payload, Error **errp)
 {
     int ret;
-    int i = COOKIE_TO_INDEX(s, cookie);
+    int i = COOKIE_TO_INDEX(cookie);
     void *local_payload = NULL;
     NBDStructuredReplyChunk *chunk;

@@ -1038,7 +1038,7 @@ static bool coroutine_fn nbd_reply_chunk_iter_receive(BDRVNBDState *s,

 break_loop:
     qemu_mutex_lock(&s->requests_lock);
-    s->requests[COOKIE_TO_INDEX(s, cookie)].coroutine = NULL;
+    s->requests[COOKIE_TO_INDEX(cookie)].coroutine = NULL;
     s->in_flight--;
     qemu_co_queue_next(&s->free_sema);
     qemu_mutex_unlock(&s->requests_lock);
-- 
2.40.1


