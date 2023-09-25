Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7477ADF64
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:04:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqqz-0002ru-D6; Mon, 25 Sep 2023 15:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkqqo-0002qJ-Ew
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkqqk-0005Xl-AR
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695668549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWTGopw2Z/nyfjx0J1OHtw1KKgfeUR28/hboQdVW0gE=;
 b=bW7rOMeA3Bg+8t1ZHVxRIgXOaW/PjXol59f27wb6WGHQ0h5iCyVdsODDaVH/uTyH6KTCeh
 hmvWVDIXrHJkye9KvZYjciuLkjBCEyDrs9EfNuNa9NkCEcio4BigE9rQRCpwNRObDvEe9p
 TUY4XcFm2hMKiFcvexP1CCZVRycoPTU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-F0p2YizXPCy4aGgQ9bIZRQ-1; Mon, 25 Sep 2023 15:02:25 -0400
X-MC-Unique: F0p2YizXPCy4aGgQ9bIZRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FE7D29AB410;
 Mon, 25 Sep 2023 19:02:25 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0866C15BB8;
 Mon, 25 Sep 2023 19:02:24 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 4/7] nbd/client: Pass mode through to nbd_send_request
Date: Mon, 25 Sep 2023 14:01:19 -0500
Message-ID: <20230925190114.3163545-13-eblake@redhat.com>
In-Reply-To: <20230925190114.3163545-9-eblake@redhat.com>
References: <20230925190114.3163545-9-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Once the 64-bit headers extension is enabled, the data layout we send
over the wire for a client request depends on the mode negotiated with
the server.  Rather than adding a parameter to nbd_send_request, we
can add a member to struct NBDRequest, since it already does not
reflect on-wire format.  Some callers initialize it directly; many
others rely on a common initialization point during
nbd_co_send_request().  At this point, there is no semantic change.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20230829175826.377251-21-eblake@redhat.com>
---
 include/block/nbd.h | 12 +++++++-----
 block/nbd.c         |  5 +++--
 nbd/client.c        |  3 ++-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 53226764574..e07b9f9bff7 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -63,17 +63,19 @@ typedef enum NBDMode {
     /* TODO add NBD_MODE_EXTENDED */
 } NBDMode;

-/* Transmission phase structs
- *
- * Note: these are _NOT_ the same as the network representation of an NBD
- * request and reply!
+/* Transmission phase structs */
+
+/*
+ * Note: NBDRequest is _NOT_ the same as the network representation of an NBD
+ * request!
  */
 typedef struct NBDRequest {
     uint64_t cookie;
     uint64_t from;
     uint32_t len;
     uint16_t flags; /* NBD_CMD_FLAG_* */
-    uint16_t type; /* NBD_CMD_* */
+    uint16_t type;  /* NBD_CMD_* */
+    NBDMode mode;   /* Determines which network representation to use */
 } NBDRequest;

 typedef struct NBDSimpleReply {
diff --git a/block/nbd.c b/block/nbd.c
index 676b755d79f..24f50b79e47 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -339,7 +339,7 @@ int coroutine_fn nbd_co_do_establish_connection(BlockDriverState *bs,
          * We have connected, but must fail for other reasons.
          * Send NBD_CMD_DISC as a courtesy to the server.
          */
-        NBDRequest request = { .type = NBD_CMD_DISC };
+        NBDRequest request = { .type = NBD_CMD_DISC, .mode = s->info.mode };

         nbd_send_request(s->ioc, &request);

@@ -520,6 +520,7 @@ nbd_co_send_request(BlockDriverState *bs, NBDRequest *request,

     qemu_co_mutex_lock(&s->send_mutex);
     request->cookie = INDEX_TO_COOKIE(i);
+    request->mode = s->info.mode;

     assert(s->ioc);

@@ -1465,7 +1466,7 @@ static void nbd_yank(void *opaque)
 static void nbd_client_close(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
-    NBDRequest request = { .type = NBD_CMD_DISC };
+    NBDRequest request = { .type = NBD_CMD_DISC, .mode = s->info.mode };

     if (s->ioc) {
         nbd_send_request(s->ioc, &request);
diff --git a/nbd/client.c b/nbd/client.c
index 844be42181a..345f1c0f2d0 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1218,7 +1218,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
         /* Send NBD_CMD_DISC as a courtesy to the server, but ignore all
          * errors now that we have the information we wanted. */
         if (nbd_drop(ioc, 124, NULL) == 0) {
-            NBDRequest request = { .type = NBD_CMD_DISC };
+            NBDRequest request = { .type = NBD_CMD_DISC, .mode = result };

             nbd_send_request(ioc, &request);
         }
@@ -1348,6 +1348,7 @@ int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
 {
     uint8_t buf[NBD_REQUEST_SIZE];

+    assert(request->mode <= NBD_MODE_STRUCTURED); /* TODO handle extended */
     trace_nbd_send_request(request->from, request->len, request->cookie,
                            request->flags, request->type,
                            nbd_cmd_lookup(request->type));
-- 
2.41.0


