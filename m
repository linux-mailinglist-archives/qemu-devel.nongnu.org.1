Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE647B1E42
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:26:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwx-0003n5-1X; Thu, 28 Sep 2023 09:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwW-0003Vw-0y
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwN-0008Ef-Jt
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BU0uqGbP8qq4nNLIZgnbAmU0nErX6Kb3gxdo8hQggZ8=;
 b=PJ8yC15SotzTn80zoNi+LKjQUBijp0S29AgtJ8boeWUGyDtPgPKy69DwfaZ+EKAR002Pmd
 ALoI78VM5xIw6bkFBA3+QFdkdXl1TdqCLKMa2KVHqcHfrHqRhcgWlFeRSDvHt8hHaIksUz
 1+vdSDvTdaL0caq2oOzkhU0p5FpYY/o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-YQtk4SzeML6LczlCsMGKvg-1; Thu, 28 Sep 2023 09:20:23 -0400
X-MC-Unique: YQtk4SzeML6LczlCsMGKvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32961381459B;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8D27167F8;
 Thu, 28 Sep 2023 13:20:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EF71921E691B; Thu, 28 Sep 2023 15:20:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 16/53] migration/rdma: Fix or document problematic uses of
 errno
Date: Thu, 28 Sep 2023 15:19:42 +0200
Message-ID: <20230928132019.2544702-17-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 migration/rdma.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 28097ce604..bba8c99fa9 100644
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
@@ -2199,6 +2222,11 @@ retry:
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
@@ -2559,6 +2587,11 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
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


