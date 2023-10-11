Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F0C7C4F4A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:41:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRd-0003LQ-On; Wed, 11 Oct 2023 05:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRb-0003Jt-UO
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRa-00057b-63
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ANVX3PCrE4sisMmBLFSZg6INgNWrh4O+M3ETlU+6mA=;
 b=gmRJsRwgu73a2v3Vy/bOMxDxDDd/xZ18cMd3WUXrBgWIskTxfo/xq9KXvK9BDdVdeqjrbh
 rH9p2dPbmrUCYfkbhx1JP6zix36wOQdHyUoH0sO5hDknlCLVrIeb0RS5Ja6TyBU1LDif1I
 8I9bYVLvi7jSqVgi8S06hRimPPorsTQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-jBaLPsY3NOqKoGy8Ah7Naw-1; Wed, 11 Oct 2023 05:23:50 -0400
X-MC-Unique: jBaLPsY3NOqKoGy8Ah7Naw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E6B7887E45;
 Wed, 11 Oct 2023 09:23:50 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C4D31C060AE;
 Wed, 11 Oct 2023 09:23:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 51/65] migration/rdma: Convert qemu_rdma_alloc_pd_cq() to Error
Date: Wed, 11 Oct 2023 11:21:49 +0200
Message-ID: <20231011092203.1266-52-quintela@redhat.com>
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

Functions that use an Error **errp parameter to return errors should
not also report them to the user, because reporting is the caller's
job.  When the caller does, the error is reported twice.  When it
doesn't (because it recovered from the error), there is no error to
report, i.e. the report is bogus.

qemu_rdma_source_init() violates this principle: it calls
error_report() via qemu_rdma_alloc_pd_cq().  I elected not to
investigate how callers handle the error, i.e. precise impact is not
known.

Clean this up by converting qemu_rdma_alloc_pd_cq() to Error.

The conversion loses a piece of advice on one of two failure paths:

    Your mlock() limits may be too low. Please check $ ulimit -a # and search for 'ulimit -l' in the output

Not worth retaining.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-45-armbru@redhat.com>
---
 migration/rdma.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 41ea2edcda..ee9221d5d2 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1052,19 +1052,19 @@ err_resolve_create_id:
 /*
  * Create protection domain and completion queues
  */
-static int qemu_rdma_alloc_pd_cq(RDMAContext *rdma)
+static int qemu_rdma_alloc_pd_cq(RDMAContext *rdma, Error **errp)
 {
     /* allocate pd */
     rdma->pd = ibv_alloc_pd(rdma->verbs);
     if (!rdma->pd) {
-        error_report("failed to allocate protection domain");
+        error_setg(errp, "failed to allocate protection domain");
         return -1;
     }
 
     /* create receive completion channel */
     rdma->recv_comp_channel = ibv_create_comp_channel(rdma->verbs);
     if (!rdma->recv_comp_channel) {
-        error_report("failed to allocate receive completion channel");
+        error_setg(errp, "failed to allocate receive completion channel");
         goto err_alloc_pd_cq;
     }
 
@@ -1074,21 +1074,21 @@ static int qemu_rdma_alloc_pd_cq(RDMAContext *rdma)
     rdma->recv_cq = ibv_create_cq(rdma->verbs, (RDMA_SIGNALED_SEND_MAX * 3),
                                   NULL, rdma->recv_comp_channel, 0);
     if (!rdma->recv_cq) {
-        error_report("failed to allocate receive completion queue");
+        error_setg(errp, "failed to allocate receive completion queue");
         goto err_alloc_pd_cq;
     }
 
     /* create send completion channel */
     rdma->send_comp_channel = ibv_create_comp_channel(rdma->verbs);
     if (!rdma->send_comp_channel) {
-        error_report("failed to allocate send completion channel");
+        error_setg(errp, "failed to allocate send completion channel");
         goto err_alloc_pd_cq;
     }
 
     rdma->send_cq = ibv_create_cq(rdma->verbs, (RDMA_SIGNALED_SEND_MAX * 3),
                                   NULL, rdma->send_comp_channel, 0);
     if (!rdma->send_cq) {
-        error_report("failed to allocate send completion queue");
+        error_setg(errp, "failed to allocate send completion queue");
         goto err_alloc_pd_cq;
     }
 
@@ -2503,12 +2503,8 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
         goto err_rdma_source_init;
     }
 
-    ret = qemu_rdma_alloc_pd_cq(rdma);
+    ret = qemu_rdma_alloc_pd_cq(rdma, errp);
     if (ret < 0) {
-        error_setg(errp, "RDMA ERROR: "
-                   "rdma migration: error allocating pd and cq! Your mlock()"
-                   " limits may be too low. Please check $ ulimit -a # and "
-                   "search for 'ulimit -l' in the output");
         goto err_rdma_source_init;
     }
 
@@ -3482,9 +3478,9 @@ static int qemu_rdma_accept(RDMAContext *rdma)
 
     qemu_rdma_dump_id("dest_init", verbs);
 
-    ret = qemu_rdma_alloc_pd_cq(rdma);
+    ret = qemu_rdma_alloc_pd_cq(rdma, &err);
     if (ret < 0) {
-        error_report("rdma migration: error allocating pd and cq!");
+        error_report_err(err);
         goto err_rdma_dest_wait;
     }
 
-- 
2.41.0


