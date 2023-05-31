Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C947717DA1
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:06:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4JcP-0007cJ-Qb; Wed, 31 May 2023 07:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4Jby-0007Rc-FI
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4Jbu-0001g7-In
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685530974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jw+sVL0vSNf45fXhXNhnpmyDKEDshiUy1iXF36YCo+A=;
 b=EWSPfv9Hj/Dt2N5wBrIOtvKuxVQvtTxEnIlEHf8qHCnH2/xY6lZNph7DsOTALhxqLmzqRR
 MV5Uz3VkF7RBI1ptbeA0LnK3+dJMiygjpkFkuIH/gbzC1/5Bpvl+v+zKiZAH1vm57+LOvP
 WFAA3CrWPR2tySL6WHEPssRiAdCNazY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-wchhDaqcMO6upvlbKiAuvA-1; Wed, 31 May 2023 07:02:52 -0400
X-MC-Unique: wchhDaqcMO6upvlbKiAuvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87A6E3801FFB;
 Wed, 31 May 2023 11:02:52 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A8942029F6D;
 Wed, 31 May 2023 11:02:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 09/11] blockjob: Fix AioContext locking in block_job_add_bdrv()
Date: Wed, 31 May 2023 13:02:29 +0200
Message-Id: <20230531110231.262251-10-kwolf@redhat.com>
In-Reply-To: <20230531110231.262251-1-kwolf@redhat.com>
References: <20230531110231.262251-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

bdrv_root_attach_child() requires callers to hold the AioContext lock
for child_bs. Take it in block_job_add_bdrv() before calling the
function.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockjob.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 913da3cbf7..25fe8e625d 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -230,20 +230,27 @@ int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
                        uint64_t perm, uint64_t shared_perm, Error **errp)
 {
     BdrvChild *c;
+    AioContext *ctx = bdrv_get_aio_context(bs);
     bool need_context_ops;
     GLOBAL_STATE_CODE();
 
     bdrv_ref(bs);
 
-    need_context_ops = bdrv_get_aio_context(bs) != job->job.aio_context;
+    need_context_ops = ctx != job->job.aio_context;
 
-    if (need_context_ops && job->job.aio_context != qemu_get_aio_context()) {
-        aio_context_release(job->job.aio_context);
+    if (need_context_ops) {
+        if (job->job.aio_context != qemu_get_aio_context()) {
+            aio_context_release(job->job.aio_context);
+        }
+        aio_context_acquire(ctx);
     }
     c = bdrv_root_attach_child(bs, name, &child_job, 0, perm, shared_perm, job,
                                errp);
-    if (need_context_ops && job->job.aio_context != qemu_get_aio_context()) {
-        aio_context_acquire(job->job.aio_context);
+    if (need_context_ops) {
+        aio_context_release(ctx);
+        if (job->job.aio_context != qemu_get_aio_context()) {
+            aio_context_acquire(job->job.aio_context);
+        }
     }
     if (c == NULL) {
         return -EPERM;
-- 
2.40.1


