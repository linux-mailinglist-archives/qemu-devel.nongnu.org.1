Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B972C7C4F1A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:35:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVR3-0007TT-Gs; Wed, 11 Oct 2023 05:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQr-0007KH-6X
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQp-0004yl-Ad
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QExctMMTUQml/pyQHoo0nhTEs83xMLNoCP7Yfh0PzvA=;
 b=Ee8meC9N1rQ4F2I9EhiNPMPuRewb1N1E8Spkn8Lpz7SKaja65WVXODYF+BTyvk0DViU0XJ
 gnk8gH/l1cxuBvaeke/ODWwhSr5dAX89M5DASDGFhQfqaJmmJpRvbYUf+k49h9vp3/3rhi
 li7SylWtIAL409SOCJEOHjzE19x5cho=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-0ocD7TdgNXSyQliPS_pXjw-1; Wed, 11 Oct 2023 05:22:53 -0400
X-MC-Unique: 0ocD7TdgNXSyQliPS_pXjw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B58D811E91;
 Wed, 11 Oct 2023 09:22:53 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C5BB1C060AE;
 Wed, 11 Oct 2023 09:22:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 23/65] migration/rdma: Fix or document problematic uses of errno
Date: Wed, 11 Oct 2023 11:21:21 +0200
Message-ID: <20231011092203.1266-24-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

We use errno after calling Libibverbs functions that are not
documented to set errno (manual page does not mention errno), or where
the documentation is unclear ("returns [...] the value of errno on
failure").  While this could be read as "sets errno and returns it",
a glance at the source code[*] kills that hope:

    static inline int ibv_post_send(struct ibv_qp *qp, struct ibv_send_wr *wr,
                                    struct ibv_send_wr **bad_wr)
    {
            return qp->context->ops.post_send(qp, wr, bad_wr);
    }

The callback can be

    static int mana_post_send(struct ibv_qp *ibqp, struct ibv_send_wr *wr,
                              struct ibv_send_wr **bad)
    {
            /* This version of driver supports RAW QP only.
             * Posting WR is done directly in the application.
             */
            return EOPNOTSUPP;
    }

Neither of them touches errno.

One of these errno uses is easy to fix, so do that now.  Several more
will go away later in the series; add temporary FIXME commments.
Three will remain; add TODO comments.  TODO, not FIXME, because the
bug might be in Libibverbs documentation.

[*] https://github.com/linux-rdma/rdma-core.git
    commit 55fa316b4b18f258d8ac1ceb4aa5a7a35b094dcf

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-17-armbru@redhat.com>
---
 migration/rdma.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index dffca30382..35b0129ae6 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -853,6 +853,12 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
 
         for (x = 0; x < num_devices; x++) {
             verbs = ibv_open_device(dev_list[x]);
+            /*
+             * ibv_open_device() is not documented to set errno.  If
+             * it does, it's somebody else's doc bug.  If it doesn't,
+             * the use of errno below is wrong.
+             * TODO Find out whether ibv_open_device() sets errno.
+             */
             if (!verbs) {
                 if (errno == EPERM) {
                     continue;
@@ -1162,11 +1168,7 @@ static void qemu_rdma_advise_prefetch_mr(struct ibv_pd *pd, uint64_t addr,
     ret = ibv_advise_mr(pd, advice,
                         IBV_ADVISE_MR_FLAG_FLUSH, &sg_list, 1);
     /* ignore the error */
-    if (ret) {
-        trace_qemu_rdma_advise_mr(name, len, addr, strerror(errno));
-    } else {
-        trace_qemu_rdma_advise_mr(name, len, addr, "successed");
-    }
+    trace_qemu_rdma_advise_mr(name, len, addr, strerror(ret));
 #endif
 }
 
@@ -1183,7 +1185,12 @@ static int qemu_rdma_reg_whole_ram_blocks(RDMAContext *rdma)
                     local->block[i].local_host_addr,
                     local->block[i].length, access
                     );
-
+        /*
+         * ibv_reg_mr() is not documented to set errno.  If it does,
+         * it's somebody else's doc bug.  If it doesn't, the use of
+         * errno below is wrong.
+         * TODO Find out whether ibv_reg_mr() sets errno.
+         */
         if (!local->block[i].mr &&
             errno == ENOTSUP && rdma_support_odp(rdma->verbs)) {
                 access |= IBV_ACCESS_ON_DEMAND;
@@ -1291,6 +1298,12 @@ static int qemu_rdma_register_and_get_keys(RDMAContext *rdma,
         trace_qemu_rdma_register_and_get_keys(len, chunk_start);
 
         block->pmr[chunk] = ibv_reg_mr(rdma->pd, chunk_start, len, access);
+        /*
+         * ibv_reg_mr() is not documented to set errno.  If it does,
+         * it's somebody else's doc bug.  If it doesn't, the use of
+         * errno below is wrong.
+         * TODO Find out whether ibv_reg_mr() sets errno.
+         */
         if (!block->pmr[chunk] &&
             errno == ENOTSUP && rdma_support_odp(rdma->verbs)) {
             access |= IBV_ACCESS_ON_DEMAND;
@@ -1408,6 +1421,11 @@ static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
         block->remote_keys[chunk] = 0;
 
         if (ret != 0) {
+            /*
+             * FIXME perror() is problematic, bcause ibv_dereg_mr() is
+             * not documented to set errno.  Will go away later in
+             * this series.
+             */
             perror("unregistration chunk failed");
             return -ret;
         }
@@ -1658,6 +1676,11 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma,
 
         ret = ibv_get_cq_event(ch, &cq, &cq_ctx);
         if (ret) {
+            /*
+             * FIXME perror() is problematic, because ibv_reg_mr() is
+             * not documented to set errno.  Will go away later in
+             * this series.
+             */
             perror("ibv_get_cq_event");
             goto err_block_for_wrid;
         }
@@ -2210,6 +2233,11 @@ retry:
         goto retry;
 
     } else if (ret > 0) {
+        /*
+         * FIXME perror() is problematic, because whether
+         * ibv_post_send() sets errno is unclear.  Will go away later
+         * in this series.
+         */
         perror("rdma migration: post rdma write failed");
         return -ret;
     }
@@ -2579,6 +2607,11 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
         ret = rdma_get_cm_event(rdma->channel, &cm_event);
     }
     if (ret) {
+        /*
+         * FIXME perror() is wrong, because
+         * qemu_get_cm_event_timeout() can fail without setting errno.
+         * Will go away later in this series.
+         */
         perror("rdma_get_cm_event after rdma_connect");
         ERROR(errp, "connecting to destination!");
         goto err_rdma_source_connect;
-- 
2.41.0


