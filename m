Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6062072A4AE
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 22:21:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7iaA-00022h-V2; Fri, 09 Jun 2023 16:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q7ia8-00022E-7A; Fri, 09 Jun 2023 16:19:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q7ia6-0000AT-IT; Fri, 09 Jun 2023 16:19:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2882B21A37;
 Fri,  9 Jun 2023 20:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686341973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dII3YeyRx5/wTOevFR7gC9FxsWNXtQL9wfxZonUGT+M=;
 b=g+BDXGM1ptuz36/1RqcON/bXXgf2jCHzH9mZY3eynkVyns31/VBHVoHGJT8ftklMmDOPhz
 sHQxPwwM90CX0agKQhKrSvj5Rk0HbX6YVYQ135ANWxUjU2dADOYOvxFecFOD88e5STl0v0
 hC9F2umaYWRYh8o/ZSlVFqVja7N+Bt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686341973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dII3YeyRx5/wTOevFR7gC9FxsWNXtQL9wfxZonUGT+M=;
 b=Z97rGZhmyf/48SikgZNxzxsSeFTvzbx4Ejpkj+m2xTCsL2XTlNmE8qWjN6rLwzW+yWlXm5
 Ze+RuUSbwRR7E7AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4692F139C8;
 Fri,  9 Jun 2023 20:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yOIkA1KJg2R/SwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 09 Jun 2023 20:19:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 05/10] block: Convert bdrv_query_block_graph_info to
 coroutine
Date: Fri,  9 Jun 2023 17:19:05 -0300
Message-Id: <20230609201910.12100-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230609201910.12100-1-farosas@suse.de>
References: <20230609201910.12100-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We're converting callers of bdrv_get_allocated_file_size() to run in
coroutines because that function will be made asynchronous when called
(indirectly) from the QMP dispatcher.

This function is a candidate because it calls bdrv_do_query_node_info(),
which in turn calls bdrv_get_allocated_file_size().

All the functions called from bdrv_do_query_node_info() onwards are
coroutine-safe, either have a coroutine version themselves[1] or are
mostly simple code/string manipulation[2].

1) bdrv_getlength(), bdrv_get_allocated_file_size(), bdrv_get_info(),
   bdrv_get_specific_info();

2) bdrv_refresh_filename(), bdrv_get_format_name(),
   bdrv_get_full_backing_filename(), bdrv_query_snapshot_info_list();

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block/qapi.c         | 12 +++++++-----
 include/block/qapi.h |  6 +++++-
 qemu-img.c           |  2 --
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 1cbb0935ff..a2e71edaff 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -375,7 +375,7 @@ fail:
 }
 
 /**
- * bdrv_query_block_graph_info:
+ * bdrv_co_query_block_graph_info:
  * @bs: root node to start from
  * @p_info: location to store image information
  * @errp: location to store error information
@@ -384,15 +384,17 @@ fail:
  *
  * @p_info will be set only on success. On error, store error in @errp.
  */
-void bdrv_query_block_graph_info(BlockDriverState *bs,
-                                 BlockGraphInfo **p_info,
-                                 Error **errp)
+void coroutine_fn bdrv_co_query_block_graph_info(BlockDriverState *bs,
+                                                 BlockGraphInfo **p_info,
+                                                 Error **errp)
 {
     BlockGraphInfo *info;
     BlockChildInfoList **children_list_tail;
     BdrvChild *c;
     ERRP_GUARD();
 
+    assert_bdrv_graph_readable();
+
     info = g_new0(BlockGraphInfo, 1);
     bdrv_do_query_node_info(bs, qapi_BlockGraphInfo_base(info), errp);
     if (*errp) {
@@ -408,7 +410,7 @@ void bdrv_query_block_graph_info(BlockDriverState *bs,
         QAPI_LIST_APPEND(children_list_tail, c_info);
 
         c_info->name = g_strdup(c->name);
-        bdrv_query_block_graph_info(c->bs, &c_info->info, errp);
+        bdrv_co_query_block_graph_info(c->bs, &c_info->info, errp);
         if (*errp) {
             goto fail;
         }
diff --git a/include/block/qapi.h b/include/block/qapi.h
index 8663971c58..7035bcd1ae 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -25,6 +25,7 @@
 #ifndef BLOCK_QAPI_H
 #define BLOCK_QAPI_H
 
+#include "block/block-common.h"
 #include "block/graph-lock.h"
 #include "block/snapshot.h"
 #include "qapi/qapi-types-block-core.h"
@@ -41,7 +42,10 @@ void bdrv_query_image_info(BlockDriverState *bs,
                            bool flat,
                            bool skip_implicit_filters,
                            Error **errp);
-void GRAPH_RDLOCK
+void coroutine_fn GRAPH_RDLOCK
+bdrv_co_query_block_graph_info(BlockDriverState *bs, BlockGraphInfo **p_info,
+                               Error **errp);
+void co_wrapper_bdrv_rdlock
 bdrv_query_block_graph_info(BlockDriverState *bs, BlockGraphInfo **p_info,
                             Error **errp);
 
diff --git a/qemu-img.c b/qemu-img.c
index 27f48051b0..8066286f5e 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2945,9 +2945,7 @@ static BlockGraphInfoList *collect_image_info_list(bool image_opts,
          * duplicate the backing chain information that we obtain by walking
          * the chain manually here.
          */
-        bdrv_graph_rdlock_main_loop();
         bdrv_query_block_graph_info(bs, &info, &err);
-        bdrv_graph_rdunlock_main_loop();
 
         if (err) {
             error_report_err(err);
-- 
2.35.3


