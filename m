Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EE07A4B39
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:48:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSS-00033z-2x; Mon, 18 Sep 2023 10:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSH-0002w0-QZ
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002aL-IV
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLAXsPvTYg40VSa2kAHh0ona3CBYtNksrIdR7NytkLg=;
 b=dnVxLb/EnDZnVWo1r9kzEN2erI4InTOu3ovt2kC5d77I6g9UBJAXwa4nv0ihPEf4Q014di
 rDBBpVqgThirlnx0TsQj6bYe0VBdvjW63uVZLrsAAD1+C1ZdOCybCAho9dnOdw0y5/uQ9U
 9aOswVaJrTMpf2vF2nq3ek87dgSXPjM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-m_5eTfx5OzixZC0nlBFZ3w-1; Mon, 18 Sep 2023 10:42:09 -0400
X-MC-Unique: m_5eTfx5OzixZC0nlBFZ3w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C42129AA2C8
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A45D20268D0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0627421E6911; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 10/52] migration/rdma: Eliminate error_propagate()
Date: Mon, 18 Sep 2023 16:41:24 +0200
Message-ID: <20230918144206.560120-11-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

When all we do with an Error we receive into a local variable is
propagating to somewhere else, we can just as well receive it there
right away.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 2b40bbcbb0..960fff5860 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2445,7 +2445,6 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
 static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
 {
     int ret, idx;
-    Error *local_err = NULL, **temp = &local_err;
 
     /*
      * Will be validated against destination's actual capabilities
@@ -2453,14 +2452,14 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
      */
     rdma->pin_all = pin_all;
 
-    ret = qemu_rdma_resolve_host(rdma, temp);
+    ret = qemu_rdma_resolve_host(rdma, errp);
     if (ret) {
         goto err_rdma_source_init;
     }
 
     ret = qemu_rdma_alloc_pd_cq(rdma);
     if (ret) {
-        ERROR(temp, "rdma migration: error allocating pd and cq! Your mlock()"
+        ERROR(errp, "rdma migration: error allocating pd and cq! Your mlock()"
                     " limits may be too low. Please check $ ulimit -a # and "
                     "search for 'ulimit -l' in the output");
         goto err_rdma_source_init;
@@ -2468,13 +2467,13 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
 
     ret = qemu_rdma_alloc_qp(rdma);
     if (ret) {
-        ERROR(temp, "rdma migration: error allocating qp!");
+        ERROR(errp, "rdma migration: error allocating qp!");
         goto err_rdma_source_init;
     }
 
     ret = qemu_rdma_init_ram_blocks(rdma);
     if (ret) {
-        ERROR(temp, "rdma migration: error initializing ram blocks!");
+        ERROR(errp, "rdma migration: error initializing ram blocks!");
         goto err_rdma_source_init;
     }
 
@@ -2489,7 +2488,7 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
     for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
         ret = qemu_rdma_reg_control(rdma, idx);
         if (ret) {
-            ERROR(temp, "rdma migration: error registering %d control!",
+            ERROR(errp, "rdma migration: error registering %d control!",
                                                             idx);
             goto err_rdma_source_init;
         }
@@ -2498,7 +2497,6 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
     return 0;
 
 err_rdma_source_init:
-    error_propagate(errp, local_err);
     qemu_rdma_cleanup(rdma);
     return -1;
 }
@@ -4103,7 +4101,6 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
 {
     int ret;
     RDMAContext *rdma;
-    Error *local_err = NULL;
 
     trace_rdma_start_incoming_migration();
 
@@ -4113,13 +4110,12 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
         return;
     }
 
-    rdma = qemu_rdma_data_init(host_port, &local_err);
+    rdma = qemu_rdma_data_init(host_port, errp);
     if (rdma == NULL) {
         goto err;
     }
 
-    ret = qemu_rdma_dest_init(rdma, &local_err);
-
+    ret = qemu_rdma_dest_init(rdma, errp);
     if (ret) {
         goto err;
     }
@@ -4142,7 +4138,6 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
 cleanup_rdma:
     qemu_rdma_cleanup(rdma);
 err:
-    error_propagate(errp, local_err);
     if (rdma) {
         g_free(rdma->host);
         g_free(rdma->host_port);
-- 
2.41.0


