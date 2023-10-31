Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 995337DD685
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:05:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtya-0004Q0-MY; Tue, 31 Oct 2023 15:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtyA-0004Ck-BI
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxm-00068u-Bo
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpinoL1G2q5CE1NDLmmev9agQismCJOSxfaHubnK3hY=;
 b=Hua0SdeO1GEYjZtsaNURUCdT1ejaQ+7MkR1N/n1f9jEaE6H01dVPgsr6D4Un9Y9UpABswQ
 rc3UCMwlX49bpJPj2HxSaQCnlVSHDUtf1Xba8cUpihdbUtK2WHNUAz7t9UPhOebUpb4Te1
 gZyY4r9FvMze5R/S9hWdcxkV2DrqBZA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-B09XwH2WNIKdNmSelFPqRQ-1; Tue, 31 Oct 2023 14:59:29 -0400
X-MC-Unique: B09XwH2WNIKdNmSelFPqRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9872A185A78F;
 Tue, 31 Oct 2023 18:59:29 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0882B25C0;
 Tue, 31 Oct 2023 18:59:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 11/27] blockjob: drop AioContext lock before calling
 bdrv_graph_wrlock()
Date: Tue, 31 Oct 2023 19:59:02 +0100
Message-ID: <20231031185918.346940-12-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

Same rationale as in 31b2ddfea3 ("graph-lock: Unlock the AioContext
while polling"). Otherwise, a deadlock can happen.

The alternative would be to pass a BlockDriverState along to
bdrv_graph_wrlock(), but there is no BlockDriverState readily
available and it's also better conceptually, because the lock is held
for the job.

The function is always called with the job's AioContext lock held, via
one of the .abort, .clean, .free or .prepare job driver functions.
Thus, it's safe to drop it.

While mirror_exit_common() does hold a second AioContext lock while
calling block_job_remove_all_bdrv(), that is for the main thread's
AioContext and does not need to be dropped (bdrv_graph_wrlock(bs) also
skips dropping the lock if bdrv_get_aio_context(bs) ==
qemu_get_aio_context()).

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20231019131936.414246-2-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockjob.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/blockjob.c b/blockjob.c
index 807f992b59..953dc1b6dc 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -198,7 +198,9 @@ void block_job_remove_all_bdrv(BlockJob *job)
      * one to make sure that such a concurrent access does not attempt
      * to process an already freed BdrvChild.
      */
+    aio_context_release(job->job.aio_context);
     bdrv_graph_wrlock(NULL);
+    aio_context_acquire(job->job.aio_context);
     while (job->nodes) {
         GSList *l = job->nodes;
         BdrvChild *c = l->data;
-- 
2.41.0


