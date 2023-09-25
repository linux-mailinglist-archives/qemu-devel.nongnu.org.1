Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F377ADF67
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:04:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqr5-0002ur-Vs; Mon, 25 Sep 2023 15:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkqqr-0002rb-Nr
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:02:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkqqm-0005YQ-3s
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695668551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3WtU/wxbnIFHSOQudlz+eJvKqNN/TkZju0/TeOBbOhA=;
 b=J/uYg5PlKTh78C7GgTzZ4wogVQCcsK8Q6kfiBScHK1dVl5JnPbIAFqpsh7so4gv612wB8L
 7PF8/aXdnPFQ1c1T8mbXjDM30AobzW39cW2OsaMgB81PaCHZHW0E5JauiBVIB1Jxfcnen0
 qJCrjmhwUWsBbnpP2bWL/eNAUpGBomo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-b-ULmEU1N9Cp88PvcfR1sg-1; Mon, 25 Sep 2023 15:02:27 -0400
X-MC-Unique: b-ULmEU1N9Cp88PvcfR1sg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 701A81C06501;
 Mon, 25 Sep 2023 19:02:27 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E977C15BB8;
 Mon, 25 Sep 2023 19:02:27 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 7/7] nbd/server: Refactor handling of command sanity checks
Date: Mon, 25 Sep 2023 14:01:22 -0500
Message-ID: <20230925190114.3163545-16-eblake@redhat.com>
In-Reply-To: <20230925190114.3163545-9-eblake@redhat.com>
References: <20230925190114.3163545-9-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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
Message-ID: <20230829175826.377251-24-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 nbd/server.c | 118 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 44 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 0ca0a4c5c25..7a6f95071f8 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2317,11 +2317,16 @@ static int coroutine_fn nbd_co_send_bitmap(NBDClient *client,
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
@@ -2333,55 +2338,88 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *

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
-            error_setg(errp, "len (%" PRIu64 ") is larger than max len (%u)",
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
+        error_setg(errp, "len (%" PRIu64 ") is larger than max len (%u)",
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
@@ -2404,14 +2442,6 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
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


