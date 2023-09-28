Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F3C7B1E08
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:23:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwv-0003kB-TJ; Thu, 28 Sep 2023 09:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwb-0003bA-99
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwP-0008GN-8Z
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fi9I0N8egcy4maDFLCKyaxK1dBxF4FmOLc/Iqn3NDjA=;
 b=f6kHmz1O6V+pRY/+IBtJNeCcbXQj7PNcEn396WGYJF/AKdQr6k/qNlt4KvLWNK3a2txZk5
 Y8k7g5+yNMdlVP+ZRCji7OYnkgc27GmJejtZpUMLmfH3UZyB9rIi/MdbMRNR2mIX4cG99Q
 OjQZfCQnjdTZWFP0gANhKiS5oQTQ6HQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-s9n-qNcHMtiIrM4ukHd8vg-1; Thu, 28 Sep 2023 09:20:24 -0400
X-MC-Unique: s9n-qNcHMtiIrM4ukHd8vg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 624F0280A9D1;
 Thu, 28 Sep 2023 13:20:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F4E010005D4;
 Thu, 28 Sep 2023 13:20:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4CE4E21E68A0; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 44/53] migration/rdma: Convert qemu_rdma_alloc_pd_cq() to
 Error
Date: Thu, 28 Sep 2023 15:20:10 +0200
Message-ID: <20230928132019.2544702-45-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
---
 migration/rdma.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 336a960006..44d8202ad0 100644
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
 
@@ -2486,12 +2486,8 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
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
 
@@ -3477,9 +3473,9 @@ static int qemu_rdma_accept(RDMAContext *rdma)
 
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


