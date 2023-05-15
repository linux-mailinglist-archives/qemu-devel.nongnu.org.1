Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 793AD703DE0
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:54:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeGi-00058R-TF; Mon, 15 May 2023 15:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGg-00056h-FE
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pyeGe-0004CT-0Z
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDtCnaR5nhJZidr1Omt5FxsUH98Ew9OfqQx8RUS2iw0=;
 b=PmCkBsiVlEd23rzh0dvsS4vmGZK6gwpFCtGR2XXIleapPfHUpfckU7YdNiEcMYvnuGaNU4
 O7DM06WoxgzM3HM3VmjWnOdk89Zto5rgMxDbLk5DlojvoQN35jlANfFKkPPYVJ29WpATNF
 avPhYRnlMATiifJb13xAKoVMR/td2W8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-NFGox09hO6OYAfYYAqRZZw-1; Mon, 15 May 2023 15:53:56 -0400
X-MC-Unique: NFGox09hO6OYAfYYAqRZZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04E6F18A6468;
 Mon, 15 May 2023 19:53:56 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65E0F14152F6;
 Mon, 15 May 2023 19:53:55 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PATCH v3 13/14] nbd/server: Prepare for per-request filtering of
 BLOCK_STATUS
Date: Mon, 15 May 2023 14:53:42 -0500
Message-Id: <20230515195343.1915857-14-eblake@redhat.com>
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

The next commit will add support for the new addition of
NBD_CMD_FLAG_PAYLOAD during NBD_CMD_BLOCK_STATUS, where the client can
request that the server only return a subset of negotiated contexts,
rather than all contexts.  To make that task easier, this patch
populates the list of contexts to return on a per-command basis (for
now, identical to the full set of negotiated contexts).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h |  15 ++++++
 nbd/server.c        | 108 +++++++++++++++++++++++---------------------
 2 files changed, 72 insertions(+), 51 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 865bb4ee2e1..6696d61bd59 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -60,6 +60,20 @@ typedef enum NBDHeaderStyle {
     NBD_HEADER_EXTENDED,    /* NBD_OPT_EXTENDED_HEADERS negotiated */
 } NBDHeaderStyle;

+/*
+ * NBDMetaContexts represents a list of meta contexts in use, as
+ * selected by NBD_OPT_SET_META_CONTEXT. Also used for
+ * NBD_OPT_LIST_META_CONTEXT, and payload filtering in
+ * NBD_CMD_BLOCK_STATUS.
+ */
+typedef struct NBDMetaContexts {
+    size_t count; /* number of negotiated contexts */
+    bool base_allocation; /* export base:allocation context (block status) */
+    bool allocation_depth; /* export qemu:allocation-depth */
+    size_t nr_bitmaps; /* Length of bitmaps array */
+    bool *bitmaps; /* export qemu:dirty-bitmap:<export bitmap name> */
+} NBDMetaContexts;
+
 /*
  * Note: NBDRequest is _NOT_ the same as the network representation of an NBD
  * request!
@@ -70,6 +84,7 @@ typedef struct NBDRequest {
     uint64_t len;   /* Effect length; 32 bit limit without extended headers */
     uint16_t flags; /* NBD_CMD_FLAG_* */
     uint16_t type;  /* NBD_CMD_* */
+    NBDMetaContexts contexts; /* Used by NBD_CMD_BLOCK_STATUS */
 } NBDRequest;

 typedef struct NBDSimpleReply {
diff --git a/nbd/server.c b/nbd/server.c
index 6475a76c1f0..db550c82cd2 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -105,20 +105,6 @@ struct NBDExport {

 static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);

-/* NBDExportMetaContexts represents a list of contexts to be exported,
- * as selected by NBD_OPT_SET_META_CONTEXT. Also used for
- * NBD_OPT_LIST_META_CONTEXT. */
-typedef struct NBDExportMetaContexts {
-    NBDExport *exp;
-    size_t count; /* number of negotiated contexts */
-    bool base_allocation; /* export base:allocation context (block status) */
-    bool allocation_depth; /* export qemu:allocation-depth */
-    bool *bitmaps; /*
-                    * export qemu:dirty-bitmap:<export bitmap name>,
-                    * sized by exp->nr_export_bitmaps
-                    */
-} NBDExportMetaContexts;
-
 struct NBDClient {
     int refcount;
     void (*close_fn)(NBDClient *client, bool negotiated);
@@ -144,7 +130,8 @@ struct NBDClient {
     uint32_t check_align; /* If non-zero, check for aligned client requests */

     NBDHeaderStyle header_style;
-    NBDExportMetaContexts export_meta;
+    NBDExport *context_exp; /* export of last OPT_SET_META_CONTEXT */
+    NBDMetaContexts contexts; /* Negotiated meta contexts */

     uint32_t opt; /* Current option being negotiated */
     uint32_t optlen; /* remaining length of data in ioc for the option being
@@ -457,8 +444,8 @@ static int nbd_negotiate_handle_list(NBDClient *client, Error **errp)

 static void nbd_check_meta_export(NBDClient *client)
 {
-    if (client->exp != client->export_meta.exp) {
-        client->export_meta.count = 0;
+    if (client->exp != client->context_exp) {
+        client->contexts.count = 0;
     }
 }

@@ -852,7 +839,7 @@ static bool nbd_strshift(const char **str, const char *prefix)
  * Handle queries to 'base' namespace. For now, only the base:allocation
  * context is available.  Return true if @query has been handled.
  */
-static bool nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
+static bool nbd_meta_base_query(NBDClient *client, NBDMetaContexts *meta,
                                 const char *query)
 {
     if (!nbd_strshift(&query, "base:")) {
@@ -872,8 +859,8 @@ static bool nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
  * and qemu:allocation-depth contexts are available.  Return true if @query
  * has been handled.
  */
-static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
-                                const char *query)
+static bool nbd_meta_qemu_query(NBDClient *client, NBDExport *exp,
+                                NBDMetaContexts *meta, const char *query)
 {
     size_t i;

@@ -884,9 +871,9 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,

     if (!*query) {
         if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
-            meta->allocation_depth = meta->exp->allocation_depth;
-            if (meta->exp->nr_export_bitmaps) {
-                memset(meta->bitmaps, 1, meta->exp->nr_export_bitmaps);
+            meta->allocation_depth = exp->allocation_depth;
+            if (meta->nr_bitmaps) {
+                memset(meta->bitmaps, 1, meta->nr_bitmaps);
             }
         }
         trace_nbd_negotiate_meta_query_parse("empty");
@@ -895,7 +882,7 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,

     if (strcmp(query, "allocation-depth") == 0) {
         trace_nbd_negotiate_meta_query_parse("allocation-depth");
-        meta->allocation_depth = meta->exp->allocation_depth;
+        meta->allocation_depth = exp->allocation_depth;
         return true;
     }

@@ -903,17 +890,17 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
         trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
         if (!*query) {
             if (client->opt == NBD_OPT_LIST_META_CONTEXT &&
-                meta->exp->nr_export_bitmaps) {
-                memset(meta->bitmaps, 1, meta->exp->nr_export_bitmaps);
+                exp->nr_export_bitmaps) {
+                memset(meta->bitmaps, 1, exp->nr_export_bitmaps);
             }
             trace_nbd_negotiate_meta_query_parse("empty");
             return true;
         }

-        for (i = 0; i < meta->exp->nr_export_bitmaps; i++) {
+        for (i = 0; i < meta->nr_bitmaps; i++) {
             const char *bm_name;

-            bm_name = bdrv_dirty_bitmap_name(meta->exp->export_bitmaps[i]);
+            bm_name = bdrv_dirty_bitmap_name(exp->export_bitmaps[i]);
             if (strcmp(bm_name, query) == 0) {
                 meta->bitmaps[i] = true;
                 trace_nbd_negotiate_meta_query_parse(query);
@@ -937,8 +924,8 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
  *
  * Return -errno on I/O error, 0 if option was completely handled by
  * sending a reply about inconsistent lengths, or 1 on success. */
-static int nbd_negotiate_meta_query(NBDClient *client,
-                                    NBDExportMetaContexts *meta, Error **errp)
+static int nbd_negotiate_meta_query(NBDClient *client, NBDExport *exp,
+                                    NBDMetaContexts *meta, Error **errp)
 {
     int ret;
     g_autofree char *query = NULL;
@@ -965,7 +952,7 @@ static int nbd_negotiate_meta_query(NBDClient *client,
     if (nbd_meta_base_query(client, meta, query)) {
         return 1;
     }
-    if (nbd_meta_qemu_query(client, meta, query)) {
+    if (nbd_meta_qemu_query(client, exp, meta, query)) {
         return 1;
     }

@@ -977,14 +964,15 @@ static int nbd_negotiate_meta_query(NBDClient *client,
  * Handle NBD_OPT_LIST_META_CONTEXT and NBD_OPT_SET_META_CONTEXT
  *
  * Return -errno on I/O error, or 0 if option was completely handled. */
-static int nbd_negotiate_meta_queries(NBDClient *client,
-                                      NBDExportMetaContexts *meta, Error **errp)
+static int nbd_negotiate_meta_queries(NBDClient *client, Error **errp)
 {
     int ret;
     g_autofree char *export_name = NULL;
     /* Mark unused to work around https://bugs.llvm.org/show_bug.cgi?id=3888 */
     g_autofree G_GNUC_UNUSED bool *bitmaps = NULL;
-    NBDExportMetaContexts local_meta = {0};
+    NBDMetaContexts local_meta = {0};
+    NBDMetaContexts *meta;
+    NBDExport *exp;
     uint32_t nb_queries;
     size_t i;
     size_t count = 0;
@@ -1000,6 +988,9 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
         /* Only change the caller's meta on SET. */
         meta = &local_meta;
+    } else {
+        meta = &client->contexts;
+        client->context_exp = NULL;
     }

     g_free(meta->bitmaps);
@@ -1010,14 +1001,15 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
         return ret;
     }

-    meta->exp = nbd_export_find(export_name);
-    if (meta->exp == NULL) {
+    exp = nbd_export_find(export_name);
+    if (exp == NULL) {
         g_autofree char *sane_name = nbd_sanitize_name(export_name);

         return nbd_opt_drop(client, NBD_REP_ERR_UNKNOWN, errp,
                             "export '%s' not present", sane_name);
     }
-    meta->bitmaps = g_new0(bool, meta->exp->nr_export_bitmaps);
+    meta->nr_bitmaps = exp->nr_export_bitmaps;
+    meta->bitmaps = g_new0(bool, exp->nr_export_bitmaps);
     if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
         bitmaps = meta->bitmaps;
     }
@@ -1033,13 +1025,13 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     if (client->opt == NBD_OPT_LIST_META_CONTEXT && !nb_queries) {
         /* enable all known contexts */
         meta->base_allocation = true;
-        meta->allocation_depth = meta->exp->allocation_depth;
-        if (meta->exp->nr_export_bitmaps) {
-            memset(meta->bitmaps, 1, meta->exp->nr_export_bitmaps);
+        meta->allocation_depth = exp->allocation_depth;
+        if (exp->nr_export_bitmaps) {
+            memset(meta->bitmaps, 1, meta->nr_bitmaps);
         }
     } else {
         for (i = 0; i < nb_queries; ++i) {
-            ret = nbd_negotiate_meta_query(client, meta, errp);
+            ret = nbd_negotiate_meta_query(client, exp, meta, errp);
             if (ret <= 0) {
                 return ret;
             }
@@ -1066,7 +1058,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
         count++;
     }

-    for (i = 0; i < meta->exp->nr_export_bitmaps; i++) {
+    for (i = 0; i < meta->nr_bitmaps; i++) {
         const char *bm_name;
         g_autofree char *context = NULL;

@@ -1074,7 +1066,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
             continue;
         }

-        bm_name = bdrv_dirty_bitmap_name(meta->exp->export_bitmaps[i]);
+        bm_name = bdrv_dirty_bitmap_name(exp->export_bitmaps[i]);
         context = g_strdup_printf("qemu:dirty-bitmap:%s", bm_name);

         ret = nbd_negotiate_send_meta_context(client, context,
@@ -1089,6 +1081,9 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     ret = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
     if (ret == 0) {
         meta->count = count;
+        if (client->opt == NBD_OPT_SET_META_CONTEXT) {
+            client->context_exp = exp;
+        }
     }

     return ret;
@@ -1282,8 +1277,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)

             case NBD_OPT_LIST_META_CONTEXT:
             case NBD_OPT_SET_META_CONTEXT:
-                ret = nbd_negotiate_meta_queries(client, &client->export_meta,
-                                                 errp);
+                ret = nbd_negotiate_meta_queries(client, errp);
                 break;

             case NBD_OPT_EXTENDED_HEADERS:
@@ -1514,7 +1508,7 @@ void nbd_client_put(NBDClient *client)
             QTAILQ_REMOVE(&client->exp->clients, client, next);
             blk_exp_unref(&client->exp->common);
         }
-        g_free(client->export_meta.bitmaps);
+        g_free(client->contexts.bitmaps);
         g_free(client);
     }
 }
@@ -2489,6 +2483,8 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
                 return -ENOMEM;
             }
         }
+    } else if (request->type == NBD_CMD_BLOCK_STATUS) {
+        request->contexts = client->contexts;
     }

     if (payload_len) {
@@ -2715,11 +2711,11 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         }
         assert(client->header_style >= NBD_HEADER_EXTENDED ||
                request->len <= UINT32_MAX);
-        if (client->export_meta.count) {
+        if (request->contexts.count) {
             bool dont_fragment = request->flags & NBD_CMD_FLAG_REQ_ONE;
-            int contexts_remaining = client->export_meta.count;
+            int contexts_remaining = request->contexts.count;

-            if (client->export_meta.base_allocation) {
+            if (request->contexts.base_allocation) {
                 ret = nbd_co_send_block_status(client, request,
                                                exp->common.blk,
                                                request->from,
@@ -2732,7 +2728,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                 }
             }

-            if (client->export_meta.allocation_depth) {
+            if (request->contexts.allocation_depth) {
                 ret = nbd_co_send_block_status(client, request,
                                                exp->common.blk,
                                                request->from, request->len,
@@ -2745,8 +2741,10 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                 }
             }

+            assert(request->contexts.nr_bitmaps ==
+                   client->exp->nr_export_bitmaps);
             for (i = 0; i < client->exp->nr_export_bitmaps; i++) {
-                if (!client->export_meta.bitmaps[i]) {
+                if (!request->contexts.bitmaps[i]) {
                     continue;
                 }
                 ret = nbd_co_send_bitmap(client, request,
@@ -2762,6 +2760,10 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
             assert(!contexts_remaining);

             return 0;
+        } else if (client->contexts.count) {
+            return nbd_send_generic_reply(client, request, -EINVAL,
+                                          "CMD_BLOCK_STATUS payload not valid",
+                                          errp);
         } else {
             return nbd_send_generic_reply(client, request, -EINVAL,
                                           "CMD_BLOCK_STATUS not negotiated",
@@ -2840,6 +2842,10 @@ static coroutine_fn void nbd_trip(void *opaque)
     } else {
         ret = nbd_handle_request(client, &request, req->data, &local_err);
     }
+    if (request.type == NBD_CMD_BLOCK_STATUS &&
+        request.contexts.bitmaps != client->contexts.bitmaps) {
+        g_free(request.contexts.bitmaps);
+    }
     if (ret < 0) {
         error_prepend(&local_err, "Failed to send reply: ");
         goto disconnect;
-- 
2.40.1


