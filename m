Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7D0703DF2
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:56:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeGi-00057n-Ch; Mon, 15 May 2023 15:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGe-00053y-Qc
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:54:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGc-0004B8-Ml
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mg+PhMMflxdmZpw8YYsPKuHoWXa2EWfts8podHa8CW4=;
 b=cjd7kKz5BUHidE/Y/OzIThkmRAlkCtUhUAVVj7hV1/hdKTLvbhZZYILY2+KHTlU5XNfPVh
 nbRcZXjfTYduUljp5oHt61ZpWmVbwnkZIfHk9rA8a4k+NJ3Zb78+/ChL2FZnsiM+wDKEGZ
 gpH8iSG+PsI+SHuirzvLreUgFo+ghwU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-r2ER-CiDM-iWUE0OkrAiSw-1; Mon, 15 May 2023 15:53:55 -0400
X-MC-Unique: r2ER-CiDM-iWUE0OkrAiSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E4C880080E;
 Mon, 15 May 2023 19:53:55 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90CB9140E917;
 Mon, 15 May 2023 19:53:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PATCH v3 12/14] nbd/client: Request extended headers during
 negotiation
Date: Mon, 15 May 2023 14:53:41 -0500
Message-Id: <20230515195343.1915857-13-eblake@redhat.com>
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

All the pieces are in place for a client to finally request extended
headers.  Note that we must not request extended headers when qemu-nbd
is used to connect to the kernel module (as nbd.ko does not expect
them), but there is no harm in all other clients requesting them.

Extended headers are not essential to the information collected during
'qemu-nbd --list', but probing for it gives us one more piece of
information in that output.  Update the iotests affected by the new
line of output.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c                                   |  5 +--
 nbd/client-connection.c                       |  2 +-
 nbd/client.c                                  | 38 ++++++++++++-------
 qemu-nbd.c                                    |  3 ++
 tests/qemu-iotests/223.out                    |  6 +++
 tests/qemu-iotests/233.out                    |  5 +++
 tests/qemu-iotests/241.out                    |  3 ++
 tests/qemu-iotests/307.out                    |  5 +++
 .../tests/nbd-qemu-allocation.out             |  1 +
 9 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 150dfe7170c..db107ff0806 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1146,10 +1146,9 @@ static int coroutine_fn nbd_co_receive_blockstatus_reply(BDRVNBDState *s,

         switch (chunk->type) {
         case NBD_REPLY_TYPE_BLOCK_STATUS_EXT:
-            wide = true;
-            /* fallthrough */
         case NBD_REPLY_TYPE_BLOCK_STATUS:
-            if (s->info.extended_headers != wide) {
+            wide = chunk->type == NBD_REPLY_TYPE_BLOCK_STATUS_EXT;
+            if ((s->info.header_style == NBD_HEADER_EXTENDED) != wide) {
                 trace_nbd_extended_headers_compliance("block_status");
             }
             if (received) {
diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index 62d75af0bb3..8e0606cadf0 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -93,7 +93,7 @@ NBDClientConnection *nbd_client_connection_new(const SocketAddress *saddr,
         .do_negotiation = do_negotiation,

         .initial_info.request_sizes = true,
-        .initial_info.header_style = NBD_HEADER_STRUCTURED,
+        .initial_info.header_style = NBD_HEADER_EXTENDED,
         .initial_info.base_allocation = true,
         .initial_info.x_dirty_bitmap = g_strdup(x_dirty_bitmap),
         .initial_info.name = g_strdup(export_name ?: "")
diff --git a/nbd/client.c b/nbd/client.c
index e5db3c8b79d..7edddfd2f83 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -879,11 +879,12 @@ static int nbd_list_meta_contexts(QIOChannel *ioc,
  *          1: server is newstyle, but can only accept EXPORT_NAME
  *          2: server is newstyle, but lacks structured replies
  *          3: server is newstyle and set up for structured replies
+ *          4: server is newstyle and set up for extended headers
  */
 static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
                                QCryptoTLSCreds *tlscreds,
                                const char *hostname, QIOChannel **outioc,
-                               bool structured_reply, bool *zeroes,
+                               NBDHeaderStyle style, bool *zeroes,
                                Error **errp)
 {
     ERRP_GUARD();
@@ -961,15 +962,23 @@ static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
         if (fixedNewStyle) {
             int result = 0;

-            if (structured_reply) {
+            if (style >= NBD_HEADER_EXTENDED) {
+                result = nbd_request_simple_option(ioc,
+                                                   NBD_OPT_EXTENDED_HEADERS,
+                                                   false, errp);
+                if (result) {
+                    return result < 0 ? -EINVAL : 4;
+                }
+            }
+            if (style >= NBD_HEADER_STRUCTURED) {
                 result = nbd_request_simple_option(ioc,
                                                    NBD_OPT_STRUCTURED_REPLY,
                                                    false, errp);
-                if (result < 0) {
-                    return -EINVAL;
+                if (result) {
+                    return result < 0 ? -EINVAL : 3;
                 }
             }
-            return 2 + result;
+            return 2;
         } else {
             return 1;
         }
@@ -1031,8 +1040,7 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
     trace_nbd_receive_negotiate_name(info->name);

     result = nbd_start_negotiate(aio_context, ioc, tlscreds, hostname, outioc,
-                                 info->header_style >= NBD_HEADER_STRUCTURED,
-                                 &zeroes, errp);
+                                 info->header_style, &zeroes, errp);

     info->header_style = NBD_HEADER_SIMPLE;
     info->base_allocation = false;
@@ -1041,8 +1049,10 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
     }

     switch (result) {
+    case 4: /* newstyle, with extended headers */
     case 3: /* newstyle, with structured replies */
-        info->header_style = NBD_HEADER_STRUCTURED;
+        /* Relies on encoding of _STRUCTURED and _EXTENDED */
+        info->header_style = result - 2;
         if (base_allocation) {
             result = nbd_negotiate_simple_meta_context(ioc, info, errp);
             if (result < 0) {
@@ -1151,8 +1161,8 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     QIOChannel *sioc = NULL;

     *info = NULL;
-    result = nbd_start_negotiate(NULL, ioc, tlscreds, hostname, &sioc, true,
-                                 NULL, errp);
+    result = nbd_start_negotiate(NULL, ioc, tlscreds, hostname, &sioc,
+                                 NBD_HEADER_EXTENDED, NULL, errp);
     if (tlscreds && sioc) {
         ioc = sioc;
     }
@@ -1160,6 +1170,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     switch (result) {
     case 2:
     case 3:
+    case 4:
         /* newstyle - use NBD_OPT_LIST to populate array, then try
          * NBD_OPT_INFO on each array member. If structured replies
          * are enabled, also try NBD_OPT_LIST_META_CONTEXT. */
@@ -1180,8 +1191,9 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
             memset(&array[count - 1], 0, sizeof(*array));
             array[count - 1].name = name;
             array[count - 1].description = desc;
-            array[count - 1].header_style = result == 3 ?
-                NBD_HEADER_STRUCTURED : NBD_HEADER_SIMPLE;
+
+            /* Depends on values of _SIMPLE, _STRUCTURED, and _EXTENDED */
+            array[count - 1].header_style = result - 2;
         }

         for (i = 0; i < count; i++) {
@@ -1197,7 +1209,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
                 break;
             }

-            if (result == 3 &&
+            if (result >= 3 &&
                 nbd_list_meta_contexts(ioc, &array[i], errp) < 0) {
                 goto out;
             }
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 6ff45308a9c..8c35442626a 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -238,6 +238,9 @@ static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds *tls,
             printf("  opt block: %u\n", list[i].opt_block);
             printf("  max block: %u\n", list[i].max_block);
         }
+        printf("  transaction size: %s\n",
+               list[i].header_style >= NBD_HEADER_EXTENDED ?
+               "64-bit" : "32-bit");
         if (list[i].n_contexts) {
             printf("  available meta contexts: %d\n", list[i].n_contexts);
             for (j = 0; j < list[i].n_contexts; j++) {
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 26fb347c5da..b98582c38ea 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -87,6 +87,7 @@ exports available: 3
   min block: 1
   opt block: 4096
   max block: 33554432
+  transaction size: 64-bit
   available meta contexts: 2
    base:allocation
    qemu:dirty-bitmap:b
@@ -97,6 +98,7 @@ exports available: 3
   min block: 1
   opt block: 4096
   max block: 33554432
+  transaction size: 64-bit
   available meta contexts: 2
    base:allocation
    qemu:dirty-bitmap:b2
@@ -106,6 +108,7 @@ exports available: 3
   min block: 1
   opt block: 4096
   max block: 33554432
+  transaction size: 64-bit
   available meta contexts: 2
    base:allocation
    qemu:dirty-bitmap:b3
@@ -206,6 +209,7 @@ exports available: 3
   min block: 1
   opt block: 4096
   max block: 33554432
+  transaction size: 64-bit
   available meta contexts: 2
    base:allocation
    qemu:dirty-bitmap:b
@@ -216,6 +220,7 @@ exports available: 3
   min block: 1
   opt block: 4096
   max block: 33554432
+  transaction size: 64-bit
   available meta contexts: 2
    base:allocation
    qemu:dirty-bitmap:b2
@@ -225,6 +230,7 @@ exports available: 3
   min block: 1
   opt block: 4096
   max block: 33554432
+  transaction size: 64-bit
   available meta contexts: 2
    base:allocation
    qemu:dirty-bitmap:b3
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 237c82767ea..33cb622ecf0 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -53,6 +53,11 @@ exports available: 1
  export: ''
   size:  67108864
   min block: 1
+  opt block: 4096
+  max block: 33554432
+  transaction size: 64-bit
+  available meta contexts: 1
+   base:allocation

 == check TLS with different CA fails ==
 qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': The certificate hasn't got a known issuer
diff --git a/tests/qemu-iotests/241.out b/tests/qemu-iotests/241.out
index 88e8cfcd7e2..a9efb876521 100644
--- a/tests/qemu-iotests/241.out
+++ b/tests/qemu-iotests/241.out
@@ -6,6 +6,7 @@ exports available: 1
  export: ''
   size:  1024
   min block: 1
+  transaction size: 64-bit
 [{ "start": 0, "length": 1000, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
 { "start": 1000, "length": 24, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
@@ -16,6 +17,7 @@ exports available: 1
  export: ''
   size:  1024
   min block: 512
+  transaction size: 64-bit
 [{ "start": 0, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
@@ -28,6 +30,7 @@ exports available: 1
  export: ''
   size:  1024
   min block: 1
+  transaction size: 64-bit
 [{ "start": 0, "length": 1000, "depth": 0, "present": true, "zero": false, "data": true, "offset": OFFSET},
 { "start": 1000, "length": 24, "depth": 0, "present": true, "zero": true, "data": false, "offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
diff --git a/tests/qemu-iotests/307.out b/tests/qemu-iotests/307.out
index 390f05d1b78..2b9a6a67a1a 100644
--- a/tests/qemu-iotests/307.out
+++ b/tests/qemu-iotests/307.out
@@ -19,6 +19,7 @@ exports available: 1
   min block: XXX
   opt block: XXX
   max block: XXX
+  transaction size: 64-bit
   available meta contexts: 1
    base:allocation

@@ -47,6 +48,7 @@ exports available: 1
   min block: XXX
   opt block: XXX
   max block: XXX
+  transaction size: 64-bit
   available meta contexts: 1
    base:allocation

@@ -78,6 +80,7 @@ exports available: 2
   min block: XXX
   opt block: XXX
   max block: XXX
+  transaction size: 64-bit
   available meta contexts: 1
    base:allocation
  export: 'export1'
@@ -87,6 +90,7 @@ exports available: 2
   min block: XXX
   opt block: XXX
   max block: XXX
+  transaction size: 64-bit
   available meta contexts: 1
    base:allocation

@@ -113,6 +117,7 @@ exports available: 1
   min block: XXX
   opt block: XXX
   max block: XXX
+  transaction size: 64-bit
   available meta contexts: 1
    base:allocation

diff --git a/tests/qemu-iotests/tests/nbd-qemu-allocation.out b/tests/qemu-iotests/tests/nbd-qemu-allocation.out
index 9d938db24e6..659276032b0 100644
--- a/tests/qemu-iotests/tests/nbd-qemu-allocation.out
+++ b/tests/qemu-iotests/tests/nbd-qemu-allocation.out
@@ -21,6 +21,7 @@ exports available: 1
   min block: 1
   opt block: 4096
   max block: 33554432
+  transaction size: 64-bit
   available meta contexts: 2
    base:allocation
    qemu:allocation-depth
-- 
2.40.1


