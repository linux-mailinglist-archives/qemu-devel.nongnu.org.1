Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D5D7BA960
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 20:47:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoTM4-0000lW-4d; Thu, 05 Oct 2023 14:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoTLr-0000e8-T0
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoTLn-0005yq-OJ
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696531531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZDgqA2bxOdJNarqL30LuyoAFfJADlSJZ3YnclFjnW34=;
 b=FO13/+8ClwHGxoQG5fQ+4tI2gwtFvEZqodNF5OQhteMcYg7IAEV13Ss1IzjngXtj7dwF3l
 qz0VPu8VFo3MFiUJjyrCsFt8BV7ErnA9p5568v1kWxAoweGgSEaEPJOQYEKoY4mpLEOYjb
 nGMExkmFo3lRM62IFCnpBcpxSRATgGc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-ABYYxuYFN6u63nJAnTkWOQ-1; Thu, 05 Oct 2023 14:45:27 -0400
X-MC-Unique: ABYYxuYFN6u63nJAnTkWOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 639F93C23FC0;
 Thu,  5 Oct 2023 18:45:27 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC1AD2156711;
 Thu,  5 Oct 2023 18:45:26 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 04/15] nbd/server: Support a request payload
Date: Thu,  5 Oct 2023 13:44:51 -0500
Message-ID: <20231005184447.682556-21-eblake@redhat.com>
In-Reply-To: <20231005184447.682556-17-eblake@redhat.com>
References: <20231005184447.682556-17-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Upcoming additions to support NBD 64-bit effect lengths allow for the
possibility to distinguish between payload length (capped at 32M) and
effect length (64 bits, although we generally assume 63 bits because
of off_t limitations).  Without that extension, only the NBD_CMD_WRITE
request has a payload; but with the extension, it makes sense to allow
at least NBD_CMD_BLOCK_STATUS to have both a payload and effect length
in a future patch (where the payload is a limited-size struct that in
turn gives the real effect length as well as a subset of known ids for
which status is requested).  Other future NBD commands may also have a
request payload, so the 64-bit extension introduces a new
NBD_CMD_FLAG_PAYLOAD_LEN that distinguishes between whether the header
length is a payload length or an effect length, rather than
hard-coding the decision based on the command.

According to the spec, a client should never send a command with a
payload without the negotiation phase proving such extension is
available.  So in the unlikely event the bit is set or cleared
incorrectly, the client is already at fault; if the client then
provides the payload, we can gracefully consume it off the wire and
fail the command with NBD_EINVAL (subsequent checks for magic numbers
ensure we are still in sync), while if the client fails to send
payload we block waiting for it (basically deadlocking our connection
to the bad client, but not negatively impacting our ability to service
other clients, so not a security risk).  Note that we do not support
the payload version of BLOCK_STATUS yet.

This patch also fixes a latent bug introduced in b2578459: once
request->len can be 64 bits, assigning it to a 32-bit payload_len can
cause wraparound to 0 which then sets req->complete prematurely;
thankfully, the bug was not possible back then (it takes this and
later patches to even allow request->len larger than 32 bits; and
since previously the only 'payload_len = request->len' assignment was
in NBD_CMD_WRITE which also sets check_length, which in turn rejects
lengths larger than 32M before relying on any possibly-truncated value
stored in payload_len).

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230925192229.3186470-15-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
[eblake: enhance comment on handling client error, fix type bug]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c     | 42 +++++++++++++++++++++++++++++++++++++-----
 nbd/trace-events |  1 +
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 7a6f95071f8..56e9b41828e 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2322,10 +2322,12 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
                                                Error **errp)
 {
     NBDClient *client = req->client;
+    bool extended_with_payload;
     bool check_length = false;
     bool check_rofs = false;
     bool allocate_buffer = false;
-    unsigned payload_len = 0;
+    bool payload_okay = false;
+    uint64_t payload_len = 0;
     int valid_flags = NBD_CMD_FLAG_FUA;
     int ret;

@@ -2338,6 +2340,13 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,

     trace_nbd_co_receive_request_decode_type(request->cookie, request->type,
                                              nbd_cmd_lookup(request->type));
+    extended_with_payload = client->mode >= NBD_MODE_EXTENDED &&
+        request->flags & NBD_CMD_FLAG_PAYLOAD_LEN;
+    if (extended_with_payload) {
+        payload_len = request->len;
+        check_length = true;
+    }
+
     switch (request->type) {
     case NBD_CMD_DISC:
         /* Special case: we're going to disconnect without a reply,
@@ -2354,6 +2363,15 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
         break;

     case NBD_CMD_WRITE:
+        if (client->mode >= NBD_MODE_EXTENDED) {
+            if (!extended_with_payload) {
+                /* The client is noncompliant. Trace it, but proceed. */
+                trace_nbd_co_receive_ext_payload_compliance(request->from,
+                                                            request->len);
+            }
+            valid_flags |= NBD_CMD_FLAG_PAYLOAD_LEN;
+        }
+        payload_okay = true;
         payload_len = request->len;
         check_length = true;
         allocate_buffer = true;
@@ -2395,6 +2413,16 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
                    request->len, NBD_MAX_BUFFER_SIZE);
         return -EINVAL;
     }
+    if (payload_len && !payload_okay) {
+        /*
+         * For now, we don't support payloads on other commands; but
+         * we can keep the connection alive by ignoring the payload.
+         * We will fail the command later with NBD_EINVAL for the use
+         * of an unsupported flag (and not for access beyond bounds).
+         */
+        assert(request->type != NBD_CMD_WRITE);
+        request->len = 0;
+    }
     if (allocate_buffer) {
         /* READ, WRITE */
         req->data = blk_try_blockalign(client->exp->common.blk,
@@ -2405,10 +2433,14 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
         }
     }
     if (payload_len) {
-        /* WRITE */
-        assert(req->data);
-        ret = nbd_read(client->ioc, req->data, payload_len,
-                       "CMD_WRITE data", errp);
+        if (payload_okay) {
+            /* WRITE */
+            assert(req->data);
+            ret = nbd_read(client->ioc, req->data, payload_len,
+                           "CMD_WRITE data", errp);
+        } else {
+            ret = nbd_drop(client->ioc, payload_len, errp);
+        }
         if (ret < 0) {
             return -EIO;
         }
diff --git a/nbd/trace-events b/nbd/trace-events
index f9dccfcfb44..c1a3227613f 100644
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
2.41.0


