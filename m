Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC97A7B3629
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:57:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmErN-0005sK-3E; Fri, 29 Sep 2023 10:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmErK-0005q3-Fy
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmEqw-0004jY-Hq
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695999145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZVQh/57ft7LlYLnaEUVEAO1fn7sS4z9bUu+ouJhJyU=;
 b=GsmpuVwqA7XeuURDMKjWGWT71ZrGLGodyo4czbZI4drd6a9IoJsJ9Ct1e5w35LL+Behan2
 4XS4Twv0p/vuJDpSg9VWZ5ZntXydpltgtt3NB8NZCjsTgqN9eh3Mv6iY+pF5v0iS+QKRbE
 82CIyevAkd5rBYmk+MdEWt5Z8JpWMUQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-idvFs9YDOX2K74J2V7BBFA-1; Fri, 29 Sep 2023 10:52:22 -0400
X-MC-Unique: idvFs9YDOX2K74J2V7BBFA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4210B3801EFD;
 Fri, 29 Sep 2023 14:52:22 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 076112026D17;
 Fri, 29 Sep 2023 14:52:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 13/22] block: Mark bdrv_amend_options() and callers
 GRAPH_RDLOCK
Date: Fri, 29 Sep 2023 16:51:48 +0200
Message-ID: <20230929145157.45443-14-kwolf@redhat.com>
In-Reply-To: <20230929145157.45443-1-kwolf@redhat.com>
References: <20230929145157.45443-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

This adds GRAPH_RDLOCK annotations to declare that callers of
bdrv_amend_options() need to hold a reader lock for the graph. This
removes an assume_graph_lock() call in crypto's implementation.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h |  8 ++++----
 include/block/block_int-common.h   | 10 ++++------
 block/crypto.c                     |  4 +---
 qemu-img.c                         |  7 +++++++
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index ec623ef3c9..9dc35133a8 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -160,10 +160,10 @@ void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base);
  */
 typedef void BlockDriverAmendStatusCB(BlockDriverState *bs, int64_t offset,
                                       int64_t total_work_size, void *opaque);
-int bdrv_amend_options(BlockDriverState *bs_new, QemuOpts *opts,
-                       BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
-                       bool force,
-                       Error **errp);
+int GRAPH_RDLOCK
+bdrv_amend_options(BlockDriverState *bs_new, QemuOpts *opts,
+                   BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
+                   bool force, Error **errp);
 
 /* check if a named node can be replaced when doing drive-mirror */
 BlockDriverState * GRAPH_RDLOCK
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index be80887898..c8661775f4 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -259,12 +259,10 @@ struct BlockDriver {
     int coroutine_fn GRAPH_UNLOCKED_PTR (*bdrv_co_create_opts)(
         BlockDriver *drv, const char *filename, QemuOpts *opts, Error **errp);
 
-    int (*bdrv_amend_options)(BlockDriverState *bs,
-                              QemuOpts *opts,
-                              BlockDriverAmendStatusCB *status_cb,
-                              void *cb_opaque,
-                              bool force,
-                              Error **errp);
+    int GRAPH_RDLOCK_PTR (*bdrv_amend_options)(
+        BlockDriverState *bs, QemuOpts *opts,
+        BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
+        bool force, Error **errp);
 
     int (*bdrv_make_empty)(BlockDriverState *bs);
 
diff --git a/block/crypto.c b/block/crypto.c
index c9c9a39fa3..b3f0233d53 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -828,7 +828,7 @@ block_crypto_amend_options_generic_luks(BlockDriverState *bs,
                                        errp);
 }
 
-static int
+static int GRAPH_RDLOCK
 block_crypto_amend_options_luks(BlockDriverState *bs,
                                 QemuOpts *opts,
                                 BlockDriverAmendStatusCB *status_cb,
@@ -841,8 +841,6 @@ block_crypto_amend_options_luks(BlockDriverState *bs,
     QCryptoBlockAmendOptions *amend_options = NULL;
     int ret = -EINVAL;
 
-    assume_graph_lock(); /* FIXME */
-
     assert(crypto);
     assert(crypto->block);
 
diff --git a/qemu-img.c b/qemu-img.c
index f7fa49fe65..6d8cab69a5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4129,6 +4129,8 @@ static int print_amend_option_help(const char *format)
 {
     BlockDriver *drv;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     /* Find driver and parse its options */
     drv = bdrv_find_format(format);
     if (!drv) {
@@ -4267,9 +4269,11 @@ static int img_amend(int argc, char **argv)
         goto out;
     }
 
+    bdrv_graph_rdlock_main_loop();
     if (!bs->drv->bdrv_amend_options) {
         error_report("Format driver '%s' does not support option amendment",
                      fmt);
+        bdrv_graph_rdunlock_main_loop();
         ret = -1;
         goto out;
     }
@@ -4289,6 +4293,7 @@ static int img_amend(int argc, char **argv)
                               "This option is only supported for image creation\n");
         }
 
+        bdrv_graph_rdunlock_main_loop();
         error_report_err(err);
         ret = -1;
         goto out;
@@ -4298,6 +4303,8 @@ static int img_amend(int argc, char **argv)
     qemu_progress_print(0.f, 0);
     ret = bdrv_amend_options(bs, opts, &amend_status_cb, NULL, force, &err);
     qemu_progress_print(100.f, 0);
+    bdrv_graph_rdunlock_main_loop();
+
     if (ret < 0) {
         error_report_err(err);
         goto out;
-- 
2.41.0


