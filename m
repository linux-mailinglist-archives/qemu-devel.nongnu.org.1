Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 837E17C4E7A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:24:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVQY-0007Hk-07; Wed, 11 Oct 2023 05:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQV-0007HK-GH
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQT-0004vO-UJ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AgPofhYt3rRsRk9IgSsmjCFWI/Wz4umAkgL+73ZjU2s=;
 b=OQjsU5tZiAdMTvMp6oheD4eNhQxWokB9saW24FkeK2FPGEEssPLaJajbCqHEaOTIRwhmY7
 ezQgVPeENOjzgfHScDDC/pYRNs5L5FCgor5UhusyfmLO/sHYTdZvR6FogjMnqvgBBJ4i06
 i0Mc+XMj7ylADMwD/JSwp1Jqo9DMwcM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-687-j1bs3fGeM9yb7iOaYXlE7g-1; Wed, 11 Oct 2023 05:22:43 -0400
X-MC-Unique: j1bs3fGeM9yb7iOaYXlE7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C7CB101AA44;
 Wed, 11 Oct 2023 09:22:43 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 812BE1C060AE;
 Wed, 11 Oct 2023 09:22:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 18/65] migration/rdma: Eliminate error_propagate()
Date: Wed, 11 Oct 2023 11:21:16 +0200
Message-ID: <20231011092203.1266-19-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

From: Markus Armbruster <armbru@redhat.com>

When all we do with an Error we receive into a local variable is
propagating to somewhere else, we can just as well receive it there
right away.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-12-armbru@redhat.com>
---
 migration/rdma.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index bc6d8248f2..c858d3fbe4 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2465,7 +2465,6 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
 static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
 {
     int ret, idx;
-    Error *local_err = NULL, **temp = &local_err;
 
     /*
      * Will be validated against destination's actual capabilities
@@ -2473,14 +2472,14 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
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
@@ -2488,13 +2487,13 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
 
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
 
@@ -2509,7 +2508,7 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
     for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
         ret = qemu_rdma_reg_control(rdma, idx);
         if (ret) {
-            ERROR(temp, "rdma migration: error registering %d control!",
+            ERROR(errp, "rdma migration: error registering %d control!",
                                                             idx);
             goto err_rdma_source_init;
         }
@@ -2518,7 +2517,6 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
     return 0;
 
 err_rdma_source_init:
-    error_propagate(errp, local_err);
     qemu_rdma_cleanup(rdma);
     return -1;
 }
@@ -4111,7 +4109,6 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
 {
     int ret;
     RDMAContext *rdma;
-    Error *local_err = NULL;
 
     trace_rdma_start_incoming_migration();
 
@@ -4121,13 +4118,12 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
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
@@ -4150,7 +4146,6 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
 cleanup_rdma:
     qemu_rdma_cleanup(rdma);
 err:
-    error_propagate(errp, local_err);
     if (rdma) {
         g_free(rdma->host);
         g_free(rdma->host_port);
-- 
2.41.0


