Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB11759FFC
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 22:38:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMDvF-00063m-LG; Wed, 19 Jul 2023 16:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDvE-00062w-3I
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDvA-0001qU-Td
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689799036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+WxGHPAGJ2bgJG5hdUy55sG/HLYIwTEicdrG14+eMG4=;
 b=dV0w/xJule1+zOU4tjPjijRhq++zOwdq8Ee2bnWbbjGto5M3qCQSFFBLNHe9SkQTH1w56f
 +ZnfYe7N53YWQG4tetIO7YmcROV9sgNSZWb5Os7e3ifFP6unwqI8RNpG/pxTZW2Bz6bYC/
 RixDaW6fX2nSmGct76vJtgFZJqI0c+A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-gDAveugLPJ-LQCw5Klvagw-1; Wed, 19 Jul 2023 16:37:11 -0400
X-MC-Unique: gDAveugLPJ-LQCw5Klvagw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AFF5936D22;
 Wed, 19 Jul 2023 20:37:11 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18AF64CD0F5;
 Wed, 19 Jul 2023 20:37:11 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 14/14] nbd: Use enum for various negotiation modes
Date: Wed, 19 Jul 2023 15:27:51 -0500
Message-ID: <20230719202736.2675295-30-eblake@redhat.com>
In-Reply-To: <20230719202736.2675295-16-eblake@redhat.com>
References: <20230719202736.2675295-16-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Deciphering the hard-coded list of integer return values from
nbd_start_negotiate() will only get more confusing when adding support
for 64-bit extended headers.  Better is to name things in an enum.
Although the function in question is private to client.c, putting the
enum in a public header and including an enum-to-string conversion
will allow its use in more places in upcoming patches.

The enum is intentionally laid out so that operators like <= can be
used to group multiple modes with similar characteristics, and where
the least powerful mode has value 0, even though this patch does not
exploit that.  No semantic change intended.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230608135653.2918540-9-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/block/nbd.h | 11 +++++++++++
 nbd/client.c        | 46 ++++++++++++++++++++++++---------------------
 nbd/common.c        | 17 +++++++++++++++++
 3 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index fb935d56e57..4428bcffbb9 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -53,6 +53,16 @@ typedef struct NBDOptionReplyMetaContext {
     /* metadata context name follows */
 } QEMU_PACKED NBDOptionReplyMetaContext;

+/* Track results of negotiation */
+typedef enum NBDMode {
+    /* Keep this list in a continuum of increasing features. */
+    NBD_MODE_OLDSTYLE,     /* server lacks newstyle negotiation */
+    NBD_MODE_EXPORT_NAME,  /* newstyle but only OPT_EXPORT_NAME safe */
+    NBD_MODE_SIMPLE,       /* newstyle but only simple replies */
+    NBD_MODE_STRUCTURED,   /* newstyle, structured replies enabled */
+    /* TODO add NBD_MODE_EXTENDED */
+} NBDMode;
+
 /* Transmission phase structs
  *
  * Note: these are _NOT_ the same as the network representation of an NBD
@@ -405,6 +415,7 @@ const char *nbd_rep_lookup(uint32_t rep);
 const char *nbd_info_lookup(uint16_t info);
 const char *nbd_cmd_lookup(uint16_t info);
 const char *nbd_err_lookup(int err);
+const char *nbd_mode_lookup(NBDMode mode);

 /* nbd/client-connection.c */
 void nbd_client_connection_enable_retry(NBDClientConnection *conn);
diff --git a/nbd/client.c b/nbd/client.c
index 1b5569556fe..479208d5d9d 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -875,10 +875,7 @@ static int nbd_list_meta_contexts(QIOChannel *ioc,
  * Start the handshake to the server.  After a positive return, the server
  * is ready to accept additional NBD_OPT requests.
  * Returns: negative errno: failure talking to server
- *          0: server is oldstyle, must call nbd_negotiate_finish_oldstyle
- *          1: server is newstyle, but can only accept EXPORT_NAME
- *          2: server is newstyle, but lacks structured replies
- *          3: server is newstyle and set up for structured replies
+ *          non-negative: enum NBDMode describing server abilities
  */
 static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
                                QCryptoTLSCreds *tlscreds,
@@ -969,16 +966,16 @@ static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
                     return -EINVAL;
                 }
             }
-            return 2 + result;
+            return result ? NBD_MODE_STRUCTURED : NBD_MODE_SIMPLE;
         } else {
-            return 1;
+            return NBD_MODE_EXPORT_NAME;
         }
     } else if (magic == NBD_CLIENT_MAGIC) {
         if (tlscreds) {
             error_setg(errp, "Server does not support STARTTLS");
             return -EINVAL;
         }
-        return 0;
+        return NBD_MODE_OLDSTYLE;
     } else {
         error_setg(errp, "Bad server magic received: 0x%" PRIx64, magic);
         return -EINVAL;
@@ -1032,6 +1029,9 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,

     result = nbd_start_negotiate(aio_context, ioc, tlscreds, hostname, outioc,
                                  info->structured_reply, &zeroes, errp);
+    if (result < 0) {
+        return result;
+    }

     info->structured_reply = false;
     info->base_allocation = false;
@@ -1039,8 +1039,8 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
         ioc = *outioc;
     }

-    switch (result) {
-    case 3: /* newstyle, with structured replies */
+    switch ((NBDMode)result) {
+    case NBD_MODE_STRUCTURED:
         info->structured_reply = true;
         if (base_allocation) {
             result = nbd_negotiate_simple_meta_context(ioc, info, errp);
@@ -1050,7 +1050,7 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
             info->base_allocation = result == 1;
         }
         /* fall through */
-    case 2: /* newstyle, try OPT_GO */
+    case NBD_MODE_SIMPLE:
         /* Try NBD_OPT_GO first - if it works, we are done (it
          * also gives us a good message if the server requires
          * TLS).  If it is not available, fall back to
@@ -1073,7 +1073,7 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
             return -EINVAL;
         }
         /* fall through */
-    case 1: /* newstyle, but limited to EXPORT_NAME */
+    case NBD_MODE_EXPORT_NAME:
         /* write the export name request */
         if (nbd_send_option_request(ioc, NBD_OPT_EXPORT_NAME, -1, info->name,
                                     errp) < 0) {
@@ -1089,7 +1089,7 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
             return -EINVAL;
         }
         break;
-    case 0: /* oldstyle, parse length and flags */
+    case NBD_MODE_OLDSTYLE:
         if (*info->name) {
             error_setg(errp, "Server does not support non-empty export names");
             return -EINVAL;
@@ -1099,7 +1099,7 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
         }
         break;
     default:
-        return result;
+        g_assert_not_reached();
     }

     trace_nbd_receive_negotiate_size_flags(info->size, info->flags);
@@ -1155,10 +1155,13 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     if (tlscreds && sioc) {
         ioc = sioc;
     }
+    if (result < 0) {
+        goto out;
+    }

-    switch (result) {
-    case 2:
-    case 3:
+    switch ((NBDMode)result) {
+    case NBD_MODE_SIMPLE:
+    case NBD_MODE_STRUCTURED:
         /* newstyle - use NBD_OPT_LIST to populate array, then try
          * NBD_OPT_INFO on each array member. If structured replies
          * are enabled, also try NBD_OPT_LIST_META_CONTEXT. */
@@ -1179,7 +1182,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
             memset(&array[count - 1], 0, sizeof(*array));
             array[count - 1].name = name;
             array[count - 1].description = desc;
-            array[count - 1].structured_reply = result == 3;
+            array[count - 1].structured_reply = result == NBD_MODE_STRUCTURED;
         }

         for (i = 0; i < count; i++) {
@@ -1195,7 +1198,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
                 break;
             }

-            if (result == 3 &&
+            if (result == NBD_MODE_STRUCTURED &&
                 nbd_list_meta_contexts(ioc, &array[i], errp) < 0) {
                 goto out;
             }
@@ -1204,11 +1207,12 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
         /* Send NBD_OPT_ABORT as a courtesy before hanging up */
         nbd_send_opt_abort(ioc);
         break;
-    case 1: /* newstyle, but limited to EXPORT_NAME */
+    case NBD_MODE_EXPORT_NAME:
         error_setg(errp, "Server does not support export lists");
         /* We can't even send NBD_OPT_ABORT, so merely hang up */
         goto out;
-    case 0: /* oldstyle, parse length and flags */
+    case NBD_MODE_OLDSTYLE:
+        /* Lone export name is implied, but we can parse length and flags */
         array = g_new0(NBDExportInfo, 1);
         array->name = g_strdup("");
         count = 1;
@@ -1226,7 +1230,7 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
         }
         break;
     default:
-        goto out;
+        g_assert_not_reached();
     }

     *info = array;
diff --git a/nbd/common.c b/nbd/common.c
index ddfe7d11837..989fbe54a19 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -248,3 +248,20 @@ int nbd_errno_to_system_errno(int err)
     }
     return ret;
 }
+
+
+const char *nbd_mode_lookup(NBDMode mode)
+{
+    switch (mode) {
+    case NBD_MODE_OLDSTYLE:
+        return "oldstyle";
+    case NBD_MODE_EXPORT_NAME:
+        return "export name only";
+    case NBD_MODE_SIMPLE:
+        return "simple headers";
+    case NBD_MODE_STRUCTURED:
+        return "structured replies";
+    default:
+        return "<unknown>";
+    }
+}
-- 
2.41.0


