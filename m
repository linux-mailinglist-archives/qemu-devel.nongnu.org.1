Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6237169B7
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:35:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42IF-0008CZ-BR; Tue, 30 May 2023 12:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42Hd-0006sa-1u
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42Ha-0008Ro-Rw
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wWZBE4LInGOpo4wFASMu39cjfstx1Z2V5hY1HfMK5JU=;
 b=ffWpktXjd3t9RA6sJOovQOcaupzEKYnVDYGawVE/wQXNBuKPPEyemKW3ckn+mm/pjGZRfN
 7UdC93ckP+lOT+3pTm8KhZ6Srslt4Z9uH5xhdX+/RIsCJ61QEBhV/+9TpejZUetbdoF+96
 19EaHe/L1SmKiM5T/cb4w1333hHaGTA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-CiYiDmpSNQSZi-dSsAUoDg-1; Tue, 30 May 2023 12:33:12 -0400
X-MC-Unique: CiYiDmpSNQSZi-dSsAUoDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF2FC28EC101;
 Tue, 30 May 2023 16:33:11 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13B8DC154D2;
 Tue, 30 May 2023 16:33:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 26/32] block/export: don't require AioContext lock around
 blk_exp_ref/unref()
Date: Tue, 30 May 2023 18:32:33 +0200
Message-Id: <20230530163239.576632-27-kwolf@redhat.com>
In-Reply-To: <20230530163239.576632-1-kwolf@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The FUSE export calls blk_exp_ref/unref() without the AioContext lock.
Instead of fixing the FUSE export, adjust blk_exp_ref/unref() so they
work without the AioContext lock. This way it's less error-prone.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230516190238.8401-15-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/export.h   |  2 ++
 block/export/export.c    | 13 ++++++-------
 block/export/vduse-blk.c |  4 ----
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/block/export.h b/include/block/export.h
index 7feb02e10d..f2fe0f8078 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -57,6 +57,8 @@ struct BlockExport {
      * Reference count for this block export. This includes strong references
      * both from the owner (qemu-nbd or the monitor) and clients connected to
      * the export.
+     *
+     * Use atomics to access this field.
      */
     int refcount;
 
diff --git a/block/export/export.c b/block/export/export.c
index a5c8f42f53..10316b43c5 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -204,11 +204,10 @@ fail:
     return NULL;
 }
 
-/* Callers must hold exp->ctx lock */
 void blk_exp_ref(BlockExport *exp)
 {
-    assert(exp->refcount > 0);
-    exp->refcount++;
+    assert(qatomic_read(&exp->refcount) > 0);
+    qatomic_inc(&exp->refcount);
 }
 
 /* Runs in the main thread */
@@ -231,11 +230,10 @@ static void blk_exp_delete_bh(void *opaque)
     aio_context_release(aio_context);
 }
 
-/* Callers must hold exp->ctx lock */
 void blk_exp_unref(BlockExport *exp)
 {
-    assert(exp->refcount > 0);
-    if (--exp->refcount == 0) {
+    assert(qatomic_read(&exp->refcount) > 0);
+    if (qatomic_fetch_dec(&exp->refcount) == 1) {
         /* Touch the block_exports list only in the main thread */
         aio_bh_schedule_oneshot(qemu_get_aio_context(), blk_exp_delete_bh,
                                 exp);
@@ -343,7 +341,8 @@ void qmp_block_export_del(const char *id,
     if (!has_mode) {
         mode = BLOCK_EXPORT_REMOVE_MODE_SAFE;
     }
-    if (mode == BLOCK_EXPORT_REMOVE_MODE_SAFE && exp->refcount > 1) {
+    if (mode == BLOCK_EXPORT_REMOVE_MODE_SAFE &&
+        qatomic_read(&exp->refcount) > 1) {
         error_setg(errp, "export '%s' still in use", exp->id);
         error_append_hint(errp, "Use mode='hard' to force client "
                           "disconnect\n");
diff --git a/block/export/vduse-blk.c b/block/export/vduse-blk.c
index a25556fe04..e0455551f9 100644
--- a/block/export/vduse-blk.c
+++ b/block/export/vduse-blk.c
@@ -44,9 +44,7 @@ static void vduse_blk_inflight_inc(VduseBlkExport *vblk_exp)
 {
     if (qatomic_fetch_inc(&vblk_exp->inflight) == 0) {
         /* Prevent export from being deleted */
-        aio_context_acquire(vblk_exp->export.ctx);
         blk_exp_ref(&vblk_exp->export);
-        aio_context_release(vblk_exp->export.ctx);
     }
 }
 
@@ -57,9 +55,7 @@ static void vduse_blk_inflight_dec(VduseBlkExport *vblk_exp)
         aio_wait_kick();
 
         /* Now the export can be deleted */
-        aio_context_acquire(vblk_exp->export.ctx);
         blk_exp_unref(&vblk_exp->export);
-        aio_context_release(vblk_exp->export.ctx);
     }
 }
 
-- 
2.40.1


