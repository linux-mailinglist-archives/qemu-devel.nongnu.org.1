Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC2703DEB
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:56:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeGb-000517-MK; Mon, 15 May 2023 15:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGY-0004x4-Vv
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGX-00048Q-3i
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9huCnnV+mUh73j5rsWzMMWTTm1hmku6avOKaDuwRgEI=;
 b=I0w6Dwm6j3l/SBVTUTnlt7sCo3jgNp0uG9WUMpvy2yEsOMJW1zgIaAVhUhtTs6IiZ8Ez4c
 QxkiGQ5Wx4zydlqKqW3rQRDhR2K42M+tgL/dPxfK12aHyYsBSlkxBbw4fRut3qbfbf6uWB
 gSdTA+21VrnaYBkRYOlKoSHlZolIsmU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-NbB0GvapOtWvGw8f4xuKDQ-1; Mon, 15 May 2023 15:53:51 -0400
X-MC-Unique: NbB0GvapOtWvGw8f4xuKDQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFBD385C074;
 Mon, 15 May 2023 19:53:50 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4298114171B6;
 Mon, 15 May 2023 19:53:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, vsementsov@yandex-team.ru,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PATCH v3 06/14] nbd/server: Refactor handling of request payload
Date: Mon, 15 May 2023 14:53:35 -0500
Message-Id: <20230515195343.1915857-7-eblake@redhat.com>
In-Reply-To: <20230515195343.1915857-1-eblake@redhat.com>
References: <20230515195343.1915857-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
killed or remains alive for the next command, or so forth), but all
errors should still be handled gracefully.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c     | 55 +++++++++++++++++++++++++++++++++---------------
 nbd/trace-events |  1 +
 2 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index cf38a104d9a..5812a773ace 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2316,6 +2316,8 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
                                                Error **errp)
 {
     NBDClient *client = req->client;
+    bool extended_with_payload;
+    int payload_len = 0;
     int valid_flags;
     int ret;

@@ -2329,27 +2331,41 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
     trace_nbd_co_receive_request_decode_type(request->handle, request->type,
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

+    /* Payload and buffer handling. */
+    extended_with_payload = client->header_style >= NBD_HEADER_EXTENDED &&
+        (request->flags & NBD_CMD_FLAG_PAYLOAD_LEN);
     if (request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE ||
-        request->type == NBD_CMD_CACHE)
-    {
+        request->type == NBD_CMD_CACHE || extended_with_payload) {
         if (request->len > NBD_MAX_BUFFER_SIZE) {
             error_setg(errp, "len (%" PRIu64" ) is larger than max len (%u)",
                        request->len, NBD_MAX_BUFFER_SIZE);
             return -EINVAL;
         }

-        if (request->type != NBD_CMD_CACHE) {
+        if (request->type == NBD_CMD_WRITE || extended_with_payload) {
+            payload_len = request->len;
+            if (request->type != NBD_CMD_WRITE) {
+                /*
+                 * For now, we don't support payloads on other
+                 * commands; but we can keep the connection alive.
+                 */
+                request->len = 0;
+            } else if (client->header_style >= NBD_HEADER_EXTENDED &&
+                       !extended_with_payload) {
+                /* The client is noncompliant. Trace it, but proceed. */
+                trace_nbd_co_receive_ext_payload_compliance(request->from,
+                                                            request->len);
+            }
+        }
+
+        if (request->type == NBD_CMD_WRITE || request->type == NBD_CMD_READ) {
             req->data = blk_try_blockalign(client->exp->common.blk,
                                            request->len);
             if (req->data == NULL) {
@@ -2359,18 +2375,20 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
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
         trace_nbd_co_receive_request_payload_received(request->handle,
-                                                      request->len);
+                                                      payload_len);
     }
+    req->complete = true;

     /* Sanity checks. */
     if (client->exp->nbdflags & NBD_FLAG_READ_ONLY &&
@@ -2400,7 +2418,10 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
                                               client->check_align);
     }
     valid_flags = NBD_CMD_FLAG_FUA;
-    if (request->type == NBD_CMD_READ &&
+    if (request->type == NBD_CMD_WRITE &&
+        client->header_style >= NBD_HEADER_EXTENDED) {
+        valid_flags |= NBD_CMD_FLAG_PAYLOAD_LEN;
+    } else if (request->type == NBD_CMD_READ &&
         client->header_style >= NBD_HEADER_STRUCTURED) {
         valid_flags |= NBD_CMD_FLAG_DF;
     } else if (request->type == NBD_CMD_WRITE_ZEROES) {
diff --git a/nbd/trace-events b/nbd/trace-events
index e2c1d68688d..adf5666e207 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -71,6 +71,7 @@ nbd_co_send_extents(uint64_t handle, unsigned int extents, uint32_t id, uint64_t
 nbd_co_send_structured_error(uint64_t handle, int err, const char *errname, const char *msg) "Send structured error reply: handle = %" PRIu64 ", error = %d (%s), msg = '%s'"
 nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type, const char *name) "Decoding type: handle = %" PRIu64 ", type = %" PRIu16 " (%s)"
 nbd_co_receive_request_payload_received(uint64_t handle, uint64_t len) "Payload received: handle = %" PRIu64 ", len = %" PRIu64
+nbd_co_receive_ext_payload_compliance(uint64_t from, uint64_t len) "client sent non-compliant write without payload flag: from=0x%" PRIx64 ", len=0x%" PRIx64
 nbd_co_receive_align_compliance(const char *op, uint64_t from, uint64_t len, uint32_t align) "client sent non-compliant unaligned %s request: from=0x%" PRIx64 ", len=0x%" PRIx64 ", align=0x%" PRIx32
 nbd_trip(void) "Reading request"

-- 
2.40.1


