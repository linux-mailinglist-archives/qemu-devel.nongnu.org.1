Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2A07C727B
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:26:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySy-0003he-J6; Thu, 12 Oct 2023 12:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySt-0003dH-CW
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySb-0000d7-Oj
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKYyVVUsu8/+aifIqCfOQ3V4E4NWpLflYSJdXDP15Rg=;
 b=T1g7QupHDnOEvJS+C85uwzd3TbmqcyEM8iCzWUdeBSJkzg5eRcLqdJdqXekIJOVfhWEH5x
 bD3I1N3VbniVWr4MdpouSAyR9CN3KqqJuEyDfxIQUqn0wqYlr5dvyA5KABa7WukYYoHtdV
 /r0KyxnjXmetsQn+9gis2nlDvhlAk/U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-680-SoqLmbf8PISCKHPSN7HRSg-1; Thu, 12 Oct 2023 12:22:49 -0400
X-MC-Unique: SoqLmbf8PISCKHPSN7HRSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 707F53C17098;
 Thu, 12 Oct 2023 16:22:49 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D478F20296DB;
 Thu, 12 Oct 2023 16:22:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 17/26] block: Mark bdrv_amend_options() and callers GRAPH_RDLOCK
Date: Thu, 12 Oct 2023 18:22:15 +0200
Message-ID: <20231012162224.240535-18-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This adds GRAPH_RDLOCK annotations to declare that callers of
bdrv_amend_options() need to hold a reader lock for the graph. This
removes an assume_graph_lock() call in crypto's implementation.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-14-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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
index 3ecbc375b0..585b65640f 100644
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


