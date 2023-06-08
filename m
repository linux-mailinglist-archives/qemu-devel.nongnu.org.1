Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D51C07281FB
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:59:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7G93-0004JX-Fi; Thu, 08 Jun 2023 09:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8h-0003z5-1R
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8V-0004hc-2m
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686232630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=97QsBZzgnr607Y5/HyhuSK8H15MqjCKg3VC/padbjqI=;
 b=LAFr3nynoWl4TMM+WuReX1aZ4U4LkHHism0qJiADjx1/ZPR7o90LcFzGRpm5iHRn+byaDK
 lrcbvKAxt45mUh6I7OYPLTatLKwbGfbIC04lOwI3qpncFUm1kdDuiDaXNMA3owOy6rrEdX
 Pr0HrztKgm019WoUadLCcpBzNwR5BSI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-32mYy-o2OHCdO-BCTo2izw-1; Thu, 08 Jun 2023 09:57:06 -0400
X-MC-Unique: 32mYy-o2OHCdO-BCTo2izw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 646683C1C4CF;
 Thu,  8 Jun 2023 13:57:06 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E713F492B00;
 Thu,  8 Jun 2023 13:57:05 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	libguestfs@redhat.com,
	vsementsov@yandex-team.ru
Subject: [PATCH v4 13/24] nbd/server: Refactor handling of request payload
Date: Thu,  8 Jun 2023 08:56:42 -0500
Message-Id: <20230608135653.2918540-14-eblake@redhat.com>
In-Reply-To: <20230608135653.2918540-1-eblake@redhat.com>
References: <20230608135653.2918540-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Upcoming additions to support NBD 64-bit effect lengths allow for the
possibility to distinguish between payload length (capped at 32M) and
effect length (up to 63 bits).  Without that extension, only the
NBD_CMD_WRITE request has a payload; but with the extension, it makes
sense to allow at least NBD_CMD_BLOCK_STATUS to have both a payload
and effect length (where the payload is a limited-size struct that in
turns gives the real effect length as well as a subset of known ids
for which status is requested).  Other future NBD commands may also
have a request payload, so the 64-bit extension introduces a new
NBD_CMD_FLAG_PAYLOAD_LEN that distinguishes between whether the header
length is a payload length or an effect length, rather than
hard-coding the decision based on the command.  Note that we do not
support the payload version of BLOCK_STATUS yet.

For this patch, no semantic change is intended for a compliant client.
For a non-compliant client, it is possible that the error behavior
changes (a different message, a change on whether the connection is
killed or remains alive for the next command, or so forth), in part
because req->complete is set later on some paths, but all errors
should still be handled gracefully.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v4: less indentation on several 'if's [Vladimir]
---
 nbd/server.c     | 76 ++++++++++++++++++++++++++++++------------------
 nbd/trace-events |  1 +
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 4ac05d0cd7b..d7dc29f0445 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2329,6 +2329,8 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
                                                Error **errp)
 {
     NBDClient *client = req->client;
+    bool extended_with_payload;
+    unsigned payload_len = 0;
     int valid_flags;
     int ret;

@@ -2342,48 +2344,63 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
     trace_nbd_co_receive_request_decode_type(request->cookie, request->type,
                                              nbd_cmd_lookup(request->type));

-    if (request->type != NBD_CMD_WRITE) {
-        /* No payload, we are ready to read the next request.  */
-        req->complete = true;
-    }
-
     if (request->type == NBD_CMD_DISC) {
         /* Special case: we're going to disconnect without a reply,
          * whether or not flags, from, or len are bogus */
+        req->complete = true;
         return -EIO;
     }

-    if (request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE ||
-        request->type == NBD_CMD_CACHE)
-    {
-        if (request->len > NBD_MAX_BUFFER_SIZE) {
-            error_setg(errp, "len (%" PRIu64" ) is larger than max len (%u)",
-                       request->len, NBD_MAX_BUFFER_SIZE);
-            return -EINVAL;
+    /* Payload and buffer handling. */
+    extended_with_payload = client->mode >= NBD_MODE_EXTENDED &&
+        (request->flags & NBD_CMD_FLAG_PAYLOAD_LEN);
+    if ((request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE ||
+         request->type == NBD_CMD_CACHE || extended_with_payload) &&
+        request->len > NBD_MAX_BUFFER_SIZE) {
+        error_setg(errp, "len (%" PRIu64" ) is larger than max len (%u)",
+                   request->len, NBD_MAX_BUFFER_SIZE);
+        return -EINVAL;
+    }
+
+    if (request->type == NBD_CMD_WRITE || extended_with_payload) {
+        payload_len = request->len;
+        if (request->type != NBD_CMD_WRITE) {
+            /*
+             * For now, we don't support payloads on other
+             * commands; but we can keep the connection alive.
+             */
+            request->len = 0;
+        } else if (client->mode >= NBD_MODE_EXTENDED &&
+                   !extended_with_payload) {
+            /* The client is noncompliant. Trace it, but proceed. */
+            trace_nbd_co_receive_ext_payload_compliance(request->from,
+                                                        request->len);
         }
+    }

-        if (request->type != NBD_CMD_CACHE) {
-            req->data = blk_try_blockalign(client->exp->common.blk,
-                                           request->len);
-            if (req->data == NULL) {
-                error_setg(errp, "No memory");
-                return -ENOMEM;
-            }
+    if (request->type == NBD_CMD_WRITE || request->type == NBD_CMD_READ) {
+        req->data = blk_try_blockalign(client->exp->common.blk,
+                                       request->len);
+        if (req->data == NULL) {
+            error_setg(errp, "No memory");
+            return -ENOMEM;
         }
     }

-    if (request->type == NBD_CMD_WRITE) {
-        assert(request->len <= NBD_MAX_BUFFER_SIZE);
-        if (nbd_read(client->ioc, req->data, request->len, "CMD_WRITE data",
-                     errp) < 0)
-        {
+    if (payload_len) {
+        if (req->data) {
+            ret = nbd_read(client->ioc, req->data, payload_len,
+                           "CMD_WRITE data", errp);
+        } else {
+            ret = nbd_drop(client->ioc, payload_len, errp);
+        }
+        if (ret < 0) {
             return -EIO;
         }
-        req->complete = true;
-
         trace_nbd_co_receive_request_payload_received(request->cookie,
-                                                      request->len);
+                                                      payload_len);
     }
+    req->complete = true;

     /* Sanity checks. */
     if (client->exp->nbdflags & NBD_FLAG_READ_ONLY &&
@@ -2413,7 +2430,10 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
                                               client->check_align);
     }
     valid_flags = NBD_CMD_FLAG_FUA;
-    if (request->type == NBD_CMD_READ && client->mode >= NBD_MODE_STRUCTURED) {
+    if (request->type == NBD_CMD_WRITE && client->mode >= NBD_MODE_EXTENDED) {
+        valid_flags |= NBD_CMD_FLAG_PAYLOAD_LEN;
+    } else if (request->type == NBD_CMD_READ &&
+               client->mode >= NBD_MODE_STRUCTURED) {
         valid_flags |= NBD_CMD_FLAG_DF;
     } else if (request->type == NBD_CMD_WRITE_ZEROES) {
         valid_flags |= NBD_CMD_FLAG_NO_HOLE | NBD_CMD_FLAG_FAST_ZERO;
diff --git a/nbd/trace-events b/nbd/trace-events
index 3338da2be2a..6a34d7f027a 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -71,6 +71,7 @@ nbd_co_send_extents(uint64_t cookie, unsigned int extents, uint32_t id, uint64_t
 nbd_co_send_chunk_error(uint64_t cookie, int err, const char *errname, const char *msg) "Send structured error reply: cookie = %" PRIu64 ", error = %d (%s), msg = '%s'"
 nbd_co_receive_request_decode_type(uint64_t cookie, uint16_t type, const char *name) "Decoding type: cookie = %" PRIu64 ", type = %" PRIu16 " (%s)"
 nbd_co_receive_request_payload_received(uint64_t cookie, uint64_t len) "Payload received: cookie = %" PRIu64 ", len = %" PRIu64
+nbd_co_receive_ext_payload_compliance(uint64_t from, uint64_t len) "client sent non-compliant write without payload flag: from=0x%" PRIx64 ", len=0x%" PRIx64
 nbd_co_receive_align_compliance(const char *op, uint64_t from, uint64_t len, uint32_t align) "client sent non-compliant unaligned %s request: from=0x%" PRIx64 ", len=0x%" PRIx64 ", align=0x%" PRIx32
 nbd_trip(void) "Reading request"

-- 
2.40.1


