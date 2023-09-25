Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 938897ADF8C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:27:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrE6-0003Nb-Ou; Mon, 25 Sep 2023 15:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkrDw-0003Hp-Lb
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkrDu-00024v-7X
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695669985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fU317Ge/keg0OIUDcl3cpPvGcMiXlJgNPe9dO8Ou7U8=;
 b=hsrOYoClPBRtu2QATjiZIKj3x3ZqE+bDubsNZMh7BodQKnk6NoSSFqATeBQcHbq+v3Pckd
 ssbDOIfYjFhsyRQ5Js8JSqv/E2AUcggVRmNmQn7hmaEkBMIElognPtw5p/88hoMg6hweJP
 M3ZSzxFMIiMAQ72wbOnOFTND9peuxBA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-Y5kr0JnpO82XoqsGpQ7fMQ-1; Mon, 25 Sep 2023 15:26:21 -0400
X-MC-Unique: Y5kr0JnpO82XoqsGpQ7fMQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BE533816C81;
 Mon, 25 Sep 2023 19:26:21 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E864328FE;
 Mon, 25 Sep 2023 19:26:20 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v7 10/12] nbd/server: Refactor list of negotiated meta contexts
Date: Mon, 25 Sep 2023 14:22:40 -0500
Message-ID: <20230925192229.3186470-24-eblake@redhat.com>
In-Reply-To: <20230925192229.3186470-14-eblake@redhat.com>
References: <20230925192229.3186470-14-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peform several minor refactorings of how the list of negotiated meta
contexts is managed, to make upcoming patches easier: Promote the
internal type NBDExportMetaContexts to the public opaque type
NBDMetaContexts, and mark exp const.  Use a shorter member name in
NBDClient.  Hoist calls to nbd_check_meta_context() earlier in their
callers, as the number of negotiated contexts may impact the flags
exposed in regards to an export, which in turn requires a new
parameter.  Drop a redundant parameter to nbd_negotiate_meta_queries.
No semantic change intended on the success path; on the failure path,
dropping context in nbd_check_meta_export even when reporting an error
is safer.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

v5: rebase to master, tweak commit message [Vladimir], R-b added

v4: new patch split out from v3 13/14, with smaller impact (quit
trying to separate exp outside of NBDMeataContexts)
---
 include/block/nbd.h |  1 +
 nbd/server.c        | 55 ++++++++++++++++++++++++---------------------
 2 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index ba8724f5336..2006497f987 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -29,6 +29,7 @@
 typedef struct NBDExport NBDExport;
 typedef struct NBDClient NBDClient;
 typedef struct NBDClientConnection NBDClientConnection;
+typedef struct NBDMetaContexts NBDMetaContexts;

 extern const BlockExportDriver blk_exp_nbd;

diff --git a/nbd/server.c b/nbd/server.c
index b09ee44c159..44ebbd139b2 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -105,11 +105,13 @@ struct NBDExport {

 static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);

-/* NBDExportMetaContexts represents a list of contexts to be exported,
+/*
+ * NBDMetaContexts represents a list of meta contexts in use,
  * as selected by NBD_OPT_SET_META_CONTEXT. Also used for
- * NBD_OPT_LIST_META_CONTEXT. */
-typedef struct NBDExportMetaContexts {
-    NBDExport *exp;
+ * NBD_OPT_LIST_META_CONTEXT.
+ */
+struct NBDMetaContexts {
+    const NBDExport *exp; /* associated export */
     size_t count; /* number of negotiated contexts */
     bool base_allocation; /* export base:allocation context (block status) */
     bool allocation_depth; /* export qemu:allocation-depth */
@@ -117,7 +119,7 @@ typedef struct NBDExportMetaContexts {
                     * export qemu:dirty-bitmap:<export bitmap name>,
                     * sized by exp->nr_export_bitmaps
                     */
-} NBDExportMetaContexts;
+};

 struct NBDClient {
     int refcount;
@@ -144,7 +146,7 @@ struct NBDClient {
     uint32_t check_align; /* If non-zero, check for aligned client requests */

     NBDMode mode;
-    NBDExportMetaContexts export_meta;
+    NBDMetaContexts contexts; /* Negotiated meta contexts */

     uint32_t opt; /* Current option being negotiated */
     uint32_t optlen; /* remaining length of data in ioc for the option being
@@ -455,10 +457,10 @@ static int nbd_negotiate_handle_list(NBDClient *client, Error **errp)
     return nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
 }

-static void nbd_check_meta_export(NBDClient *client)
+static void nbd_check_meta_export(NBDClient *client, NBDExport *exp)
 {
-    if (client->exp != client->export_meta.exp) {
-        client->export_meta.count = 0;
+    if (exp != client->contexts.exp) {
+        client->contexts.count = 0;
     }
 }

@@ -504,6 +506,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
         error_setg(errp, "export not found");
         return -EINVAL;
     }
+    nbd_check_meta_export(client, client->exp);

     myflags = client->exp->nbdflags;
     if (client->mode >= NBD_MODE_STRUCTURED) {
@@ -521,7 +524,6 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,

     QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
     blk_exp_ref(&client->exp->common);
-    nbd_check_meta_export(client);

     return 0;
 }
@@ -641,6 +643,9 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
                                           errp, "export '%s' not present",
                                           sane_name);
     }
+    if (client->opt == NBD_OPT_GO) {
+        nbd_check_meta_export(client, exp);
+    }

     /* Don't bother sending NBD_INFO_NAME unless client requested it */
     if (sendname) {
@@ -729,7 +734,6 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
         client->check_align = check_align;
         QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
         blk_exp_ref(&client->exp->common);
-        nbd_check_meta_export(client);
         rc = 1;
     }
     return rc;
@@ -852,7 +856,7 @@ static bool nbd_strshift(const char **str, const char *prefix)
  * Handle queries to 'base' namespace. For now, only the base:allocation
  * context is available.  Return true if @query has been handled.
  */
-static bool nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
+static bool nbd_meta_base_query(NBDClient *client, NBDMetaContexts *meta,
                                 const char *query)
 {
     if (!nbd_strshift(&query, "base:")) {
@@ -872,7 +876,7 @@ static bool nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
  * and qemu:allocation-depth contexts are available.  Return true if @query
  * has been handled.
  */
-static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
+static bool nbd_meta_qemu_query(NBDClient *client, NBDMetaContexts *meta,
                                 const char *query)
 {
     size_t i;
@@ -938,7 +942,7 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
  * Return -errno on I/O error, 0 if option was completely handled by
  * sending a reply about inconsistent lengths, or 1 on success. */
 static int nbd_negotiate_meta_query(NBDClient *client,
-                                    NBDExportMetaContexts *meta, Error **errp)
+                                    NBDMetaContexts *meta, Error **errp)
 {
     int ret;
     g_autofree char *query = NULL;
@@ -977,14 +981,14 @@ static int nbd_negotiate_meta_query(NBDClient *client,
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
     uint32_t nb_queries;
     size_t i;
     size_t count = 0;
@@ -1000,6 +1004,8 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
         /* Only change the caller's meta on SET. */
         meta = &local_meta;
+    } else {
+        meta = &client->contexts;
     }

     g_free(meta->bitmaps);
@@ -1284,8 +1290,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)

             case NBD_OPT_LIST_META_CONTEXT:
             case NBD_OPT_SET_META_CONTEXT:
-                ret = nbd_negotiate_meta_queries(client, &client->export_meta,
-                                                 errp);
+                ret = nbd_negotiate_meta_queries(client, errp);
                 break;

             case NBD_OPT_EXTENDED_HEADERS:
@@ -1512,7 +1517,7 @@ void nbd_client_put(NBDClient *client)
             QTAILQ_REMOVE(&client->exp->clients, client, next);
             blk_exp_unref(&client->exp->common);
         }
-        g_free(client->export_meta.bitmaps);
+        g_free(client->contexts.bitmaps);
         g_free(client);
     }
 }
@@ -2746,11 +2751,11 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         }
         assert(client->mode >= NBD_MODE_EXTENDED ||
                request->len <= UINT32_MAX);
-        if (client->export_meta.count) {
+        if (client->contexts.count) {
             bool dont_fragment = request->flags & NBD_CMD_FLAG_REQ_ONE;
-            int contexts_remaining = client->export_meta.count;
+            int contexts_remaining = client->contexts.count;

-            if (client->export_meta.base_allocation) {
+            if (client->contexts.base_allocation) {
                 ret = nbd_co_send_block_status(client, request,
                                                exp->common.blk,
                                                request->from,
@@ -2763,7 +2768,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                 }
             }

-            if (client->export_meta.allocation_depth) {
+            if (client->contexts.allocation_depth) {
                 ret = nbd_co_send_block_status(client, request,
                                                exp->common.blk,
                                                request->from, request->len,
@@ -2777,7 +2782,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
             }

             for (i = 0; i < client->exp->nr_export_bitmaps; i++) {
-                if (!client->export_meta.bitmaps[i]) {
+                if (!client->contexts.bitmaps[i]) {
                     continue;
                 }
                 ret = nbd_co_send_bitmap(client, request,
-- 
2.41.0


