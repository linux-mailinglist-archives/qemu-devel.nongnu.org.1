Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C85C78CBB3
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 20:05:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb356-0003AS-I4; Tue, 29 Aug 2023 14:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qb33d-0002TY-IK
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qb33T-0000MD-7A
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693332186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62NnH8MyQ1PmLFPrHsQqgp22j81yedkMYowXqBQvRHU=;
 b=RrRPdxNc4KXjeaXNsbXr67w+pxFkRgXBtAo7qVKB6YRRayG3fOY7dSE3v4avXUpKY4fmnJ
 /IoicvG0I9tgy+7Ym++w/VouHtheAzXpJCXqjGuDe6thGGAaJb/3/j75K5Pjpc8+qVlKk/
 G6SShZgZj2jRbklLr+3T93VWbQrgYI4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-vpPFqlb-OSK5wr514rd8pg-1; Tue, 29 Aug 2023 14:03:00 -0400
X-MC-Unique: vpPFqlb-OSK5wr514rd8pg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 419CE38210B3;
 Tue, 29 Aug 2023 18:03:00 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5DF22026D4B;
 Tue, 29 Aug 2023 18:02:59 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH v6 07/17] nbd/server: Prepare to receive extended header
 requests
Date: Tue, 29 Aug 2023 12:58:34 -0500
Message-ID: <20230829175826.377251-26-eblake@redhat.com>
In-Reply-To: <20230829175826.377251-19-eblake@redhat.com>
References: <20230829175826.377251-19-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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
index adcfcdeacb7..b8e8694f3f4 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1415,11 +1415,13 @@ nbd_read_eof(NBDClient *client, void *buffer, size_t size, Error **errp)
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
@@ -1427,13 +1429,21 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
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
@@ -1441,13 +1451,20 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
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


