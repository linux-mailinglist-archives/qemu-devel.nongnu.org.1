Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A337BA96C
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 20:48:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoTMP-0001i1-OV; Thu, 05 Oct 2023 14:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoTMN-0001aT-AU
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoTM7-00066u-OW
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696531551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mXn1HegIYrClv1KgYVt2yI5lthxZholSVcziJ0ZnFj8=;
 b=eILZ+L19ft1h8586SiqnOk/0hlkT+zACqwGJfWVIggW5TliYLixOEis3N6KaS189vzgLtB
 Fj1DYpvDDMOk30KJ3XXdMDJGlNFQFnTqzHIV5Di/mlZqBgbLdntW+pRUmCc6eHRGxAd95h
 wgU7iDupVwvb9fK950Hgz8PTINH+nkU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-wKxzMzHQMEmqCl_F38Aa6A-1; Thu, 05 Oct 2023 14:45:32 -0400
X-MC-Unique: wKxzMzHQMEmqCl_F38Aa6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 459ED85A5BD;
 Thu,  5 Oct 2023 18:45:32 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C946D215670B;
 Thu,  5 Oct 2023 18:45:31 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 12/15] nbd/client: Request extended headers during negotiation
Date: Thu,  5 Oct 2023 13:44:59 -0500
Message-ID: <20231005184447.682556-29-eblake@redhat.com>
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

All the pieces are in place for a client to finally request extended
headers.  Note that we must not request extended headers when qemu-nbd
is used to connect to the kernel module (as nbd.ko does not expect
them, but expects us to do the negotiation in userspace before handing
the socket over to the kernel), but there is no harm in all other
clients requesting them.

Extended headers are not essential to the information collected during
'qemu-nbd --list', but probing for it gives us one more piece of
information in that output.  Update the iotests affected by the new
line of output.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20230925192229.3186470-23-eblake@redhat.com>
---
 nbd/client-connection.c                       |  2 +-
 nbd/client.c                                  | 20 ++++++++++++++-----
 qemu-nbd.c                                    |  3 +++
 tests/qemu-iotests/223.out                    |  6 ++++++
 tests/qemu-iotests/233.out                    |  4 ++++
 tests/qemu-iotests/241.out                    |  3 +++
 tests/qemu-iotests/307.out                    |  5 +++++
 .../tests/nbd-qemu-allocation.out             |  1 +
 8 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index aa0201b7107..f9da67c87e3 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -93,7 +93,7 @@ NBDClientConnection *nbd_client_connection_new(const SocketAddress *saddr,
         .do_negotiation = do_negotiation,

         .initial_info.request_sizes = true,
-        .initial_info.mode = NBD_MODE_STRUCTURED,
+        .initial_info.mode = NBD_MODE_EXTENDED,
         .initial_info.base_allocation = true,
         .initial_info.x_dirty_bitmap = g_strdup(x_dirty_bitmap),
         .initial_info.name = g_strdup(export_name ?: "")
diff --git a/nbd/client.c b/nbd/client.c
index a2f253062aa..29ffc609a4b 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -953,15 +953,23 @@ static int nbd_start_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
         if (fixedNewStyle) {
             int result = 0;

+            if (max_mode >= NBD_MODE_EXTENDED) {
+                result = nbd_request_simple_option(ioc,
+                                                   NBD_OPT_EXTENDED_HEADERS,
+                                                   false, errp);
+                if (result) {
+                    return result < 0 ? -EINVAL : NBD_MODE_EXTENDED;
+                }
+            }
             if (max_mode >= NBD_MODE_STRUCTURED) {
                 result = nbd_request_simple_option(ioc,
                                                    NBD_OPT_STRUCTURED_REPLY,
                                                    false, errp);
-                if (result < 0) {
-                    return -EINVAL;
+                if (result) {
+                    return result < 0 ? -EINVAL : NBD_MODE_STRUCTURED;
                 }
             }
-            return result ? NBD_MODE_STRUCTURED : NBD_MODE_SIMPLE;
+            return NBD_MODE_SIMPLE;
         } else {
             return NBD_MODE_EXPORT_NAME;
         }
@@ -1034,6 +1042,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     }

     switch (info->mode) {
+    case NBD_MODE_EXTENDED:
     case NBD_MODE_STRUCTURED:
         if (base_allocation) {
             result = nbd_negotiate_simple_meta_context(ioc, info, errp);
@@ -1144,7 +1153,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,

     *info = NULL;
     result = nbd_start_negotiate(ioc, tlscreds, hostname, &sioc,
-                                 NBD_MODE_STRUCTURED, NULL, errp);
+                                 NBD_MODE_EXTENDED, NULL, errp);
     if (tlscreds && sioc) {
         ioc = sioc;
     }
@@ -1155,6 +1164,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     switch ((NBDMode)result) {
     case NBD_MODE_SIMPLE:
     case NBD_MODE_STRUCTURED:
+    case NBD_MODE_EXTENDED:
         /* newstyle - use NBD_OPT_LIST to populate array, then try
          * NBD_OPT_INFO on each array member. If structured replies
          * are enabled, also try NBD_OPT_LIST_META_CONTEXT. */
@@ -1191,7 +1201,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
                 break;
             }

-            if (result == NBD_MODE_STRUCTURED &&
+            if (result >= NBD_MODE_STRUCTURED &&
                 nbd_list_meta_contexts(ioc, &array[i], errp) < 0) {
                 goto out;
             }
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 54faa87a0c0..1a39bb8fac0 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -235,6 +235,9 @@ static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds *tls,
             printf("  opt block: %u\n", list[i].opt_block);
             printf("  max block: %u\n", list[i].max_block);
         }
+        printf("  transaction size: %s\n",
+               list[i].mode >= NBD_MODE_EXTENDED ?
+               "64-bit" : "32-bit");
         if (list[i].n_contexts) {
             printf("  available meta contexts: %d\n", list[i].n_contexts);
             for (j = 0; j < list[i].n_contexts; j++) {
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 86a37014d0f..32f05f1c9af 100644
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
index 237c82767ea..1910f7df20f 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -39,6 +39,7 @@ exports available: 1
  export: ''
   size:  67108864
   min block: 1
+  transaction size: 64-bit

 == check TLS fail over TCP with mismatched hostname ==
 qemu-img: Could not open 'driver=nbd,host=localhost,port=PORT,tls-creds=tls0': Certificate does not match the hostname localhost
@@ -53,6 +54,7 @@ exports available: 1
  export: ''
   size:  67108864
   min block: 1
+  transaction size: 64-bit

 == check TLS with different CA fails ==
 qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': The certificate hasn't got a known issuer
@@ -83,6 +85,7 @@ exports available: 1
  export: ''
   size:  67108864
   min block: 1
+  transaction size: 64-bit

 == check TLS works over UNIX with PSK ==
 image: nbd+unix://?socket=SOCK_DIR/qemu-nbd.sock
@@ -93,6 +96,7 @@ exports available: 1
  export: ''
   size:  67108864
   min block: 1
+  transaction size: 64-bit

 == check TLS fails over UNIX with mismatch PSK ==
 qemu-img: Could not open 'driver=nbd,path=SOCK_DIR/qemu-nbd.sock,tls-creds=tls0': TLS handshake failed: The TLS connection was non-properly terminated.
diff --git a/tests/qemu-iotests/241.out b/tests/qemu-iotests/241.out
index 7946c286d51..7267cd2997e 100644
--- a/tests/qemu-iotests/241.out
+++ b/tests/qemu-iotests/241.out
@@ -6,6 +6,7 @@ exports available: 1
  export: ''
   size:  1024
   min block: 1
+  transaction size: 64-bit
 [{ "start": 0, "length": 1000, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
 { "start": 1000, "length": 24, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
@@ -16,6 +17,7 @@ exports available: 1
  export: ''
   size:  1024
   min block: 512
+  transaction size: 64-bit
 [{ "start": 0, "length": 1024, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
@@ -28,6 +30,7 @@ exports available: 1
  export: ''
   size:  1024
   min block: 1
+  transaction size: 64-bit
 [{ "start": 0, "length": 1000, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
 { "start": 1000, "length": 24, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
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
index 138eb09c6d0..1db16926ed4 100644
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
2.41.0


