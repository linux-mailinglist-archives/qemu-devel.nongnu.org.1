Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D1F7ADF99
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:28:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrE4-0003JL-Ua; Mon, 25 Sep 2023 15:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkrDq-0003EV-UV
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkrDo-00022Z-V4
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695669980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZHzFVQpYOiDLCInvE7JT/fzR5kjzMKnK/wRAWpLExGQ=;
 b=B9RpIicUVZ1ZTOdE1iEDvNyuFl5W518AlUutYcYeKDZFN5JvVwn+fn42WY6uakY6DLmg1s
 n+rL/wVUjGe+M6nuWzIO2VL7LT15bIckN5QLwDI5xuMQ26b7HGPtDMUbBrP4SroYtn9diu
 6fisfN0JY23SKbBH2C7KKOvOVlq9ui8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-FM3sMHlZPO-hc2GwoHCjwA-1; Mon, 25 Sep 2023 15:26:16 -0400
X-MC-Unique: FM3sMHlZPO-hc2GwoHCjwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0ABB3C1ACD5;
 Mon, 25 Sep 2023 19:26:15 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 492DB51E3;
 Mon, 25 Sep 2023 19:26:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com,
	qemu-block@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH v7 02/12] nbd/server: Prepare to receive extended header
 requests
Date: Mon, 25 Sep 2023 14:22:32 -0500
Message-ID: <20230925192229.3186470-16-eblake@redhat.com>
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

Although extended mode is not yet enabled, once we do turn it on, we
need to accept extended requests for all messages.  Previous patches
have already taken care of supporting 64-bit lengths, now we just need
to read it off the wire.

Note that this implementation will block indefinitely on a buggy
client that sends a non-extended payload (that is, we try to read a
full packet before we ever check the magic number, but a client that
mistakenly sends a simple request after negotiating extended headers
doesn't send us enough bytes), but it's no different from any other
client that stops talking to us partway through a packet and thus not
worth coding around.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

v6: fix sign extension bug

v5: no change

v4: new patch, split out from v3 9/14
---
 nbd/nbd-internal.h |  5 ++++-
 nbd/server.c       | 43 ++++++++++++++++++++++++++++++-------------
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 133b1d94b50..dfa02f77ee4 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -34,8 +34,11 @@
  * https://github.com/yoe/nbd/blob/master/doc/proto.md
  */

-/* Size of all NBD_OPT_*, without payload */
+/* Size of all compact NBD_CMD_*, without payload */
 #define NBD_REQUEST_SIZE            (4 + 2 + 2 + 8 + 8 + 4)
+/* Size of all extended NBD_CMD_*, without payload */
+#define NBD_EXTENDED_REQUEST_SIZE   (4 + 2 + 2 + 8 + 8 + 8)
+
 /* Size of all NBD_REP_* sent in answer to most NBD_OPT_*, without payload */
 #define NBD_REPLY_SIZE              (4 + 4 + 8)
 /* Size of reply to NBD_OPT_EXPORT_NAME */
diff --git a/nbd/server.c b/nbd/server.c
index 1eabcfc908d..e227e470d41 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1411,11 +1411,13 @@ nbd_read_eof(NBDClient *client, void *buffer, size_t size, Error **errp)
 static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *request,
                                             Error **errp)
 {
-    uint8_t buf[NBD_REQUEST_SIZE];
-    uint32_t magic;
+    uint8_t buf[NBD_EXTENDED_REQUEST_SIZE];
+    uint32_t magic, expect;
     int ret;
+    size_t size = client->mode >= NBD_MODE_EXTENDED ?
+        NBD_EXTENDED_REQUEST_SIZE : NBD_REQUEST_SIZE;

-    ret = nbd_read_eof(client, buf, sizeof(buf), errp);
+    ret = nbd_read_eof(client, buf, size, errp);
     if (ret < 0) {
         return ret;
     }
@@ -1423,13 +1425,21 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
         return -EIO;
     }

-    /* Request
-       [ 0 ..  3]   magic   (NBD_REQUEST_MAGIC)
-       [ 4 ..  5]   flags   (NBD_CMD_FLAG_FUA, ...)
-       [ 6 ..  7]   type    (NBD_CMD_READ, ...)
-       [ 8 .. 15]   cookie
-       [16 .. 23]   from
-       [24 .. 27]   len
+    /*
+     * Compact request
+     *  [ 0 ..  3]   magic   (NBD_REQUEST_MAGIC)
+     *  [ 4 ..  5]   flags   (NBD_CMD_FLAG_FUA, ...)
+     *  [ 6 ..  7]   type    (NBD_CMD_READ, ...)
+     *  [ 8 .. 15]   cookie
+     *  [16 .. 23]   from
+     *  [24 .. 27]   len
+     * Extended request
+     *  [ 0 ..  3]   magic   (NBD_EXTENDED_REQUEST_MAGIC)
+     *  [ 4 ..  5]   flags   (NBD_CMD_FLAG_FUA, NBD_CMD_FLAG_PAYLOAD_LEN, ...)
+     *  [ 6 ..  7]   type    (NBD_CMD_READ, ...)
+     *  [ 8 .. 15]   cookie
+     *  [16 .. 23]   from
+     *  [24 .. 31]   len
      */

     magic = ldl_be_p(buf);
@@ -1437,13 +1447,20 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
     request->type   = lduw_be_p(buf + 6);
     request->cookie = ldq_be_p(buf + 8);
     request->from   = ldq_be_p(buf + 16);
-    request->len    = (uint32_t)ldl_be_p(buf + 24); /* widen 32 to 64 bits */
+    if (client->mode >= NBD_MODE_EXTENDED) {
+        request->len = ldq_be_p(buf + 24);
+        expect = NBD_EXTENDED_REQUEST_MAGIC;
+    } else {
+        request->len = (uint32_t)ldl_be_p(buf + 24); /* widen 32 to 64 bits */
+        expect = NBD_REQUEST_MAGIC;
+    }

     trace_nbd_receive_request(magic, request->flags, request->type,
                               request->from, request->len);

-    if (magic != NBD_REQUEST_MAGIC) {
-        error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
+    if (magic != expect) {
+        error_setg(errp, "invalid magic (got 0x%" PRIx32 ", expected 0x%"
+                   PRIx32 ")", magic, expect);
         return -EINVAL;
     }
     return 0;
-- 
2.41.0


