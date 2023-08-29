Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7D878CBD8
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 20:10:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb33a-0002SR-JT; Tue, 29 Aug 2023 14:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qb33U-0002Pp-K1
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:03:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qb33P-0000Kk-Pr
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693332181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxUwZ8q67Vgr8YGuhKSgFVyGjlO72/H7aWyvec7F8G0=;
 b=BUEklusWa+9eWgMzJF49WBBOS9tUIgfo4JhL5YPQfB7qHFCBQ0dB50XdgSuCnfHaynXWRi
 nEe81u3oGKZLKv9AECCfS2iFsgoy9+oyPuB8wMRorG1704SwgTJ9MqMC5YyoiJjqEQthkQ
 /FovyoW3KnX5LZtTXM+X2T2fsQuhS1Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-4A-jX-awMpeBPvZ36TQiww-1; Tue, 29 Aug 2023 14:02:57 -0400
X-MC-Unique: 4A-jX-awMpeBPvZ36TQiww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5171085CCE0;
 Tue, 29 Aug 2023 18:02:57 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D73A82026D4B;
 Tue, 29 Aug 2023 18:02:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v6 02/17] nbd/client: Pass mode through to nbd_send_request
Date: Tue, 29 Aug 2023 12:58:29 -0500
Message-ID: <20230829175826.377251-21-eblake@redhat.com>
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

Once the 64-bit headers extension is enabled, the data layout we send
over the wire for a client request depends on the mode negotiated with
the server.  Rather than adding a parameter to nbd_send_request, we
can add a member to struct NBDRequest, since it already does not
reflect on-wire format.  Some callers initialize it directly; many
others rely on a common initialization point during
nbd_co_send_request().  At this point, there is no semantic change.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

v5: R-b added
v4: new patch, based on ideas in v3 4/14, but by modifying NBDRequest
instead of adding a parameter
---
 include/block/nbd.h | 12 +++++++-----
 block/nbd.c         |  5 +++--
 nbd/client.c        |  3 ++-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index abf6030b513..c4cbe130e07 100644
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
index 5f88f7a819b..ca5991f868a 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -339,7 +339,7 @@ int coroutine_fn nbd_co_do_establish_connection(BlockDriverState *bs,
          * We have connected, but must fail for other reasons.
          * Send NBD_CMD_DISC as a courtesy to the server.
          */
-        NBDRequest request = { .type = NBD_CMD_DISC };
+        NBDRequest request = { .type = NBD_CMD_DISC, .mode = s->info.mode };

         nbd_send_request(s->ioc, &request);

@@ -521,6 +521,7 @@ nbd_co_send_request(BlockDriverState *bs, NBDRequest *request,

     qemu_co_mutex_lock(&s->send_mutex);
     request->cookie = INDEX_TO_COOKIE(i);
+    request->mode = s->info.mode;

     assert(s->ioc);

@@ -1466,7 +1467,7 @@ static void nbd_yank(void *opaque)
 static void nbd_client_close(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
-    NBDRequest request = { .type = NBD_CMD_DISC };
+    NBDRequest request = { .type = NBD_CMD_DISC, .mode = s->info.mode };

     if (s->ioc) {
         nbd_send_request(s->ioc, &request);
diff --git a/nbd/client.c b/nbd/client.c
index faa054c4527..40a1eb72346 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1224,7 +1224,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
         /* Send NBD_CMD_DISC as a courtesy to the server, but ignore all
          * errors now that we have the information we wanted. */
         if (nbd_drop(ioc, 124, NULL) == 0) {
-            NBDRequest request = { .type = NBD_CMD_DISC };
+            NBDRequest request = { .type = NBD_CMD_DISC, .mode = result };

             nbd_send_request(ioc, &request);
         }
@@ -1354,6 +1354,7 @@ int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
 {
     uint8_t buf[NBD_REQUEST_SIZE];

+    assert(request->mode <= NBD_MODE_STRUCTURED); /* TODO handle extended */
     trace_nbd_send_request(request->from, request->len, request->cookie,
                            request->flags, request->type,
                            nbd_cmd_lookup(request->type));
-- 
2.41.0


