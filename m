Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5257C726A
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:24:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySo-0003YX-Av; Thu, 12 Oct 2023 12:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySc-0003Vt-Ln
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySZ-0000aG-IT
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UAiJFoLNFET6cvrYHc1hfY+L4tEMkRssmm+pFJs3G08=;
 b=J15mYulX9ybep6lFfBjGnH5KmKi4EhsB38epEgbggMbWn33RSH/f0mTyV14IN41UV01Obu
 2SuAGf7i1GABKduaAYAIHg39ddfy6hgcg1Q+uSARt06E7wWkTNObBFyukXhz7rpzU8Pqpa
 PFTWqOvZXtPUWeZ0RByCPXwzYVUPur8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-69SGz-RVPryINwezn5sAEQ-1; Thu, 12 Oct 2023 12:22:37 -0400
X-MC-Unique: 69SGz-RVPryINwezn5sAEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 726F485A5BF;
 Thu, 12 Oct 2023 16:22:36 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D76EE2026831;
 Thu, 12 Oct 2023 16:22:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 01/26] block: rename the bdrv_co_block_status static function
Date: Thu, 12 Oct 2023 18:21:59 +0200
Message-ID: <20231012162224.240535-2-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

From: Paolo Bonzini <pbonzini@redhat.com>

bdrv_block_status exists as a wrapper for bdrv_block_status_above, but
the name of the (hypothetical) coroutine version, bdrv_co_block_status,
is squatted by a random static function.  Rename it to
bdrv_co_do_block_status.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20230904100306.156197-2-pbonzini@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/io.c b/block/io.c
index e7f9448d5a..2ff4ffda1c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2383,9 +2383,9 @@ int bdrv_flush_all(void)
  * set to the host mapping and BDS corresponding to the guest offset.
  */
 static int coroutine_fn GRAPH_RDLOCK
-bdrv_co_block_status(BlockDriverState *bs, bool want_zero,
-                     int64_t offset, int64_t bytes,
-                     int64_t *pnum, int64_t *map, BlockDriverState **file)
+bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
+                        int64_t offset, int64_t bytes,
+                        int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
     int64_t total_size;
     int64_t n; /* bytes */
@@ -2544,8 +2544,8 @@ bdrv_co_block_status(BlockDriverState *bs, bool want_zero,
 
     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
-        ret = bdrv_co_block_status(local_file, want_zero, local_map,
-                                   *pnum, pnum, &local_map, &local_file);
+        ret = bdrv_co_do_block_status(local_file, want_zero, local_map,
+                                      *pnum, pnum, &local_map, &local_file);
         goto out;
     }
 
@@ -2572,8 +2572,8 @@ bdrv_co_block_status(BlockDriverState *bs, bool want_zero,
         int64_t file_pnum;
         int ret2;
 
-        ret2 = bdrv_co_block_status(local_file, want_zero, local_map,
-                                    *pnum, &file_pnum, NULL, NULL);
+        ret2 = bdrv_co_do_block_status(local_file, want_zero, local_map,
+                                       *pnum, &file_pnum, NULL, NULL);
         if (ret2 >= 0) {
             /* Ignore errors.  This is just providing extra information, it
              * is useful but not necessary.
@@ -2640,7 +2640,8 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
         return 0;
     }
 
-    ret = bdrv_co_block_status(bs, want_zero, offset, bytes, pnum, map, file);
+    ret = bdrv_co_do_block_status(bs, want_zero, offset, bytes, pnum,
+                                  map, file);
     ++*depth;
     if (ret < 0 || *pnum == 0 || ret & BDRV_BLOCK_ALLOCATED || bs == base) {
         return ret;
@@ -2656,8 +2657,8 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     for (p = bdrv_filter_or_cow_bs(bs); include_base || p != base;
          p = bdrv_filter_or_cow_bs(p))
     {
-        ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
-                                   file);
+        ret = bdrv_co_do_block_status(p, want_zero, offset, bytes, pnum,
+                                      map, file);
         ++*depth;
         if (ret < 0) {
             return ret;
-- 
2.41.0


