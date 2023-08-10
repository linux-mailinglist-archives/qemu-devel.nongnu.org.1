Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13226777F59
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 19:43:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU9g9-00040E-Ij; Thu, 10 Aug 2023 13:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qU9g5-0003vy-BB
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qU9g2-0004yf-BB
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691689345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gf79eOlNPK7QSRBZLfBAIO97dabtP5nRjmkxpydMLz0=;
 b=Vb+6vgNxaLjjLR6FbFRA4zaAFQKaSwUCwhty8Bh2zN47Yx0EMGNFEd5k/AXNLsmOcQHWHW
 PbrnxFcnt6ZnDjsNW2olhJta4zyccav5yXRtVjUefu9f5HnATZapcWCFmWNUdKX2v0Wz8a
 1V9ymalYzdm6dkl1+NN3iu2JMz54aZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-YRfbZASLMv-91ynO3nX1mA-1; Thu, 10 Aug 2023 13:42:22 -0400
X-MC-Unique: YRfbZASLMv-91ynO3nX1mA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E025C858EED;
 Thu, 10 Aug 2023 17:42:21 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E43F1121314;
 Thu, 10 Aug 2023 17:42:21 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH v5 05/17] nbd/server: Refactor handling of command sanity
 checks
Date: Thu, 10 Aug 2023 12:36:52 -0500
Message-ID: <20230810173646.17695-24-eblake@redhat.com>
In-Reply-To: <20230810173646.17695-19-eblake@redhat.com>
References: <20230810173646.17695-19-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

Upcoming additions to support NBD 64-bit effect lengths will add a new
command flag NBD_CMD_FLAG_PAYLOAD_LEN that needs to be considered in
our sanity checks of the client's messages (that is, more than just
CMD_WRITE have the potential to carry a client payload when extended
headers are in effect).  But before we can start to support that, it
is easier to first refactor the existing set of various if statements
over open-coded combinations of request->type to instead be a single
switch statement over all command types that sets witnesses, then
straight-line processing based on the witnesses.  No semantic change
is intended.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v5: new patch split out from v4 13/24 [Vladimir]
---
 nbd/server.c | 118 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 44 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index db8f5943139..795f7c86781 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2329,11 +2329,16 @@ static int coroutine_fn nbd_co_send_bitmap(NBDClient *client,
  * to the client (although the caller may still need to disconnect after
  * reporting the error).
  */
-static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
+static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
+                                               NBDRequest *request,
                                                Error **errp)
 {
     NBDClient *client = req->client;
-    int valid_flags;
+    bool check_length = false;
+    bool check_rofs = false;
+    bool allocate_buffer = false;
+    unsigned payload_len = 0;
+    int valid_flags = NBD_CMD_FLAG_FUA;
     int ret;

     g_assert(qemu_in_coroutine());
@@ -2345,55 +2350,88 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *

     trace_nbd_co_receive_request_decode_type(request->cookie, request->type,
                                              nbd_cmd_lookup(request->type));
-
-    if (request->type != NBD_CMD_WRITE) {
-        /* No payload, we are ready to read the next request.  */
-        req->complete = true;
-    }
-
-    if (request->type == NBD_CMD_DISC) {
+    switch (request->type) {
+    case NBD_CMD_DISC:
         /* Special case: we're going to disconnect without a reply,
          * whether or not flags, from, or len are bogus */
+        req->complete = true;
         return -EIO;
-    }

-    if (request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE ||
-        request->type == NBD_CMD_CACHE)
-    {
-        if (request->len > NBD_MAX_BUFFER_SIZE) {
-            error_setg(errp, "len (%" PRIu64" ) is larger than max len (%u)",
-                       request->len, NBD_MAX_BUFFER_SIZE);
-            return -EINVAL;
+    case NBD_CMD_READ:
+        if (client->mode >= NBD_MODE_STRUCTURED) {
+            valid_flags |= NBD_CMD_FLAG_DF;
         }
+        check_length = true;
+        allocate_buffer = true;
+        break;

-        if (request->type != NBD_CMD_CACHE) {
-            req->data = blk_try_blockalign(client->exp->common.blk,
-                                           request->len);
-            if (req->data == NULL) {
-                error_setg(errp, "No memory");
-                return -ENOMEM;
-            }
-        }
+    case NBD_CMD_WRITE:
+        payload_len = request->len;
+        check_length = true;
+        allocate_buffer = true;
+        check_rofs = true;
+        break;
+
+    case NBD_CMD_FLUSH:
+        break;
+
+    case NBD_CMD_TRIM:
+        check_rofs = true;
+        break;
+
+    case NBD_CMD_CACHE:
+        check_length = true;
+        break;
+
+    case NBD_CMD_WRITE_ZEROES:
+        valid_flags |= NBD_CMD_FLAG_NO_HOLE | NBD_CMD_FLAG_FAST_ZERO;
+        check_rofs = true;
+        break;
+
+    case NBD_CMD_BLOCK_STATUS:
+        valid_flags |= NBD_CMD_FLAG_REQ_ONE;
+        break;
+
+    default:
+        /* Unrecognized, will fail later */
+        ;
     }

-    if (request->type == NBD_CMD_WRITE) {
-        assert(request->len <= NBD_MAX_BUFFER_SIZE);
-        if (nbd_read(client->ioc, req->data, request->len, "CMD_WRITE data",
-                     errp) < 0)
-        {
+    /* Payload and buffer handling. */
+    if (!payload_len) {
+        req->complete = true;
+    }
+    if (check_length && request->len > NBD_MAX_BUFFER_SIZE) {
+        /* READ, WRITE, CACHE */
+        error_setg(errp, "len (%" PRIu64" ) is larger than max len (%u)",
+                   request->len, NBD_MAX_BUFFER_SIZE);
+        return -EINVAL;
+    }
+    if (allocate_buffer) {
+        /* READ, WRITE */
+        req->data = blk_try_blockalign(client->exp->common.blk,
+                                       request->len);
+        if (req->data == NULL) {
+            error_setg(errp, "No memory");
+            return -ENOMEM;
+        }
+    }
+    if (payload_len) {
+        /* WRITE */
+        assert(req->data);
+        ret = nbd_read(client->ioc, req->data, payload_len,
+                       "CMD_WRITE data", errp);
+        if (ret < 0) {
             return -EIO;
         }
         req->complete = true;
-
         trace_nbd_co_receive_request_payload_received(request->cookie,
-                                                      request->len);
+                                                      payload_len);
     }

     /* Sanity checks. */
-    if (client->exp->nbdflags & NBD_FLAG_READ_ONLY &&
-        (request->type == NBD_CMD_WRITE ||
-         request->type == NBD_CMD_WRITE_ZEROES ||
-         request->type == NBD_CMD_TRIM)) {
+    if (client->exp->nbdflags & NBD_FLAG_READ_ONLY && check_rofs) {
+        /* WRITE, TRIM, WRITE_ZEROES */
         error_setg(errp, "Export is read-only");
         return -EROFS;
     }
@@ -2416,14 +2454,6 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
                                               request->len,
                                               client->check_align);
     }
-    valid_flags = NBD_CMD_FLAG_FUA;
-    if (request->type == NBD_CMD_READ && client->mode >= NBD_MODE_STRUCTURED) {
-        valid_flags |= NBD_CMD_FLAG_DF;
-    } else if (request->type == NBD_CMD_WRITE_ZEROES) {
-        valid_flags |= NBD_CMD_FLAG_NO_HOLE | NBD_CMD_FLAG_FAST_ZERO;
-    } else if (request->type == NBD_CMD_BLOCK_STATUS) {
-        valid_flags |= NBD_CMD_FLAG_REQ_ONE;
-    }
     if (request->flags & ~valid_flags) {
         error_setg(errp, "unsupported flags for command %s (got 0x%x)",
                    nbd_cmd_lookup(request->type), request->flags);
-- 
2.41.0


