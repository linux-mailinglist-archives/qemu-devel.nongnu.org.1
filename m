Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9FE7CA4D3
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:09:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKWb-0002cH-8d; Mon, 16 Oct 2023 06:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKWS-0002Os-Uf
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKWR-0007dG-5A
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697450906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LGzZnFSMqWKxGcuhRASuKFzl/RSCBXuu+XMNIzZxRUI=;
 b=K+6P6/r1L5hZd3a6J1fnakD1hkNsKKnbuMp5es9XKYaxQfkA/n7yGyRy1FhhWL7k5DTFMW
 MdaVMHnxvFrBXQeYbOmMvuTAUR0eXz6aPruihJyA0Oxmm/Jg/mr1pK4hSlzpkNp21OAjuT
 JwHQ7dx632yzLjwS/DY+o83c4jnlwzg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-UyIIBMmNO6a4kxig_aw4Eg-1; Mon, 16 Oct 2023 06:08:23 -0400
X-MC-Unique: UyIIBMmNO6a4kxig_aw4Eg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C87F929ABA35;
 Mon, 16 Oct 2023 10:08:22 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B358906CF;
 Mon, 16 Oct 2023 10:08:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 24/38] migration/rdma: Use i as for index instead of idx
Date: Mon, 16 Oct 2023 12:06:52 +0200
Message-ID: <20231016100706.2551-25-quintela@redhat.com>
In-Reply-To: <20231016100706.2551-1-quintela@redhat.com>
References: <20231016100706.2551-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

Once there, all the uses are local to the for, so declare the variable
inside the for statement.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231011203527.9061-12-quintela@redhat.com>
---
 migration/rdma.c | 49 ++++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index e973579a52..5f6a771e8e 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2354,7 +2354,6 @@ static int qemu_rdma_write(RDMAContext *rdma,
 static void qemu_rdma_cleanup(RDMAContext *rdma)
 {
     Error *err = NULL;
-    int idx;
 
     if (rdma->cm_id && rdma->connected) {
         if ((rdma->errored ||
@@ -2381,12 +2380,12 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
     g_free(rdma->dest_blocks);
     rdma->dest_blocks = NULL;
 
-    for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
-        if (rdma->wr_data[idx].control_mr) {
+    for (int i = 0; i < RDMA_WRID_MAX; i++) {
+        if (rdma->wr_data[i].control_mr) {
             rdma->total_registrations--;
-            ibv_dereg_mr(rdma->wr_data[idx].control_mr);
+            ibv_dereg_mr(rdma->wr_data[i].control_mr);
         }
-        rdma->wr_data[idx].control_mr = NULL;
+        rdma->wr_data[i].control_mr = NULL;
     }
 
     if (rdma->local_ram_blocks.block) {
@@ -2452,7 +2451,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
 
 static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
 {
-    int ret, idx;
+    int ret;
 
     /*
      * Will be validated against destination's actual capabilities
@@ -2480,18 +2479,17 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
 
     /* Build the hash that maps from offset to RAMBlock */
     rdma->blockmap = g_hash_table_new(g_direct_hash, g_direct_equal);
-    for (idx = 0; idx < rdma->local_ram_blocks.nb_blocks; idx++) {
+    for (int i = 0; i < rdma->local_ram_blocks.nb_blocks; i++) {
         g_hash_table_insert(rdma->blockmap,
-                (void *)(uintptr_t)rdma->local_ram_blocks.block[idx].offset,
-                &rdma->local_ram_blocks.block[idx]);
+                (void *)(uintptr_t)rdma->local_ram_blocks.block[i].offset,
+                &rdma->local_ram_blocks.block[i]);
     }
 
-    for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
-        ret = qemu_rdma_reg_control(rdma, idx);
+    for (int i = 0; i < RDMA_WRID_MAX; i++) {
+        ret = qemu_rdma_reg_control(rdma, i);
         if (ret < 0) {
-            error_setg(errp,
-                       "RDMA ERROR: rdma migration: error registering %d control!",
-                       idx);
+            error_setg(errp, "RDMA ERROR: rdma migration: error "
+                       "registering %d control!", i);
             goto err_rdma_source_init;
         }
     }
@@ -2625,16 +2623,16 @@ err_rdma_source_connect:
 static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 {
     Error *err = NULL;
-    int ret, idx;
+    int ret;
     struct rdma_cm_id *listen_id;
     char ip[40] = "unknown";
     struct rdma_addrinfo *res, *e;
     char port_str[16];
     int reuse = 1;
 
-    for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
-        rdma->wr_data[idx].control_len = 0;
-        rdma->wr_data[idx].control_curr = NULL;
+    for (int i = 0; i < RDMA_WRID_MAX; i++) {
+        rdma->wr_data[i].control_len = 0;
+        rdma->wr_data[i].control_curr = NULL;
     }
 
     if (!rdma->host || !rdma->host[0]) {
@@ -2723,11 +2721,9 @@ err_dest_init_create_listen_id:
 static void qemu_rdma_return_path_dest_init(RDMAContext *rdma_return_path,
                                             RDMAContext *rdma)
 {
-    int idx;
-
-    for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
-        rdma_return_path->wr_data[idx].control_len = 0;
-        rdma_return_path->wr_data[idx].control_curr = NULL;
+    for (int i = 0; i < RDMA_WRID_MAX; i++) {
+        rdma_return_path->wr_data[i].control_len = 0;
+        rdma_return_path->wr_data[i].control_curr = NULL;
     }
 
     /*the CM channel and CM id is shared*/
@@ -3376,7 +3372,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     struct rdma_cm_event *cm_event;
     struct ibv_context *verbs;
     int ret;
-    int idx;
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
     if (ret < 0) {
@@ -3462,10 +3457,10 @@ static int qemu_rdma_accept(RDMAContext *rdma)
 
     qemu_rdma_init_ram_blocks(rdma);
 
-    for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
-        ret = qemu_rdma_reg_control(rdma, idx);
+    for (int i = 0; i < RDMA_WRID_MAX; i++) {
+        ret = qemu_rdma_reg_control(rdma, i);
         if (ret < 0) {
-            error_report("rdma: error registering %d control", idx);
+            error_report("rdma: error registering %d control", i);
             goto err_rdma_dest_wait;
         }
     }
-- 
2.41.0


