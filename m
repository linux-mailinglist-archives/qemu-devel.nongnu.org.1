Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8C278EE9D
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:27:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhgY-0004qa-7a; Thu, 31 Aug 2023 09:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qbhgO-0004cZ-5J
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qbhgJ-0007Ka-1o
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693488353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izx4/tWmYybNankH2Ws9lrXMsYKcXA5u48G6FxidvA8=;
 b=OWJETx/yUTwXJgLRvPMGbiGmvlci12OCyzgs3xBNJM2ETVWv09F0VW7KZuFTA0Vj0UpcH2
 eDJOiAvKtVHvj9oqp4yXEin/nEAvwucSDinmRN2IaeyvcZHkj2CZOK7HPT5B0mA4TnIBWG
 G4RvC+yIYd1GvHE7A6Ui9saynhybfgQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-HdqLDN7ZOBSSRUpyNiZzoA-1; Thu, 31 Aug 2023 09:25:49 -0400
X-MC-Unique: HdqLDN7ZOBSSRUpyNiZzoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94F8F280D228;
 Thu, 31 Aug 2023 13:25:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC49B63F7A;
 Thu, 31 Aug 2023 13:25:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B8D7621E692B; Thu, 31 Aug 2023 15:25:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, idryomov@gmail.com,
 pl@kamp.de, sw@weilnetz.de, sstabellini@kernel.org,
 anthony.perard@citrix.com, paul@xen.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, stefanha@redhat.com, fam@euphon.net,
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 kraxel@redhat.com, qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org
Subject: [PATCH 2/7] migration: Clean up local variable shadowing
Date: Thu, 31 Aug 2023 15:25:41 +0200
Message-ID: <20230831132546.3525721-3-armbru@redhat.com>
In-Reply-To: <20230831132546.3525721-1-armbru@redhat.com>
References: <20230831132546.3525721-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Local variables shadowing other local variables or parameters make the
code needlessly hard to understand.  Tracked down with -Wshadow=local.
Clean up: delete inner declarations when they are actually redundant,
else rename variables.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/block.c   | 4 ++--
 migration/ram.c     | 8 +++-----
 migration/rdma.c    | 8 +++++---
 migration/vmstate.c | 2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index b9580a6c7e..33b3776198 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -438,8 +438,8 @@ static int init_blk_migration(QEMUFile *f)
     /* Can only insert new BDSes now because doing so while iterating block
      * devices may end up in a deadlock (iterating the new BDSes, too). */
     for (i = 0; i < num_bs; i++) {
-        BlkMigDevState *bmds = bmds_bs[i].bmds;
-        BlockDriverState *bs = bmds_bs[i].bs;
+        bmds = bmds_bs[i].bmds;
+        bs = bmds_bs[i].bs;
 
         if (bmds) {
             ret = blk_insert_bs(bmds->blk, bs, &local_err);
diff --git a/migration/ram.c b/migration/ram.c
index 9040d66e61..0c202f8109 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3517,8 +3517,6 @@ int colo_init_ram_cache(void)
     * we use the same name 'ram_bitmap' as for migration.
     */
     if (ram_bytes_total()) {
-        RAMBlock *block;
-
         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
             unsigned long pages = block->max_length >> TARGET_PAGE_BITS;
             block->bmap = bitmap_new(pages);
@@ -3998,12 +3996,12 @@ static int ram_load_precopy(QEMUFile *f)
                         }
                     }
                     if (migrate_ignore_shared()) {
-                        hwaddr addr = qemu_get_be64(f);
+                        hwaddr addr2 = qemu_get_be64(f);
                         if (migrate_ram_is_ignored(block) &&
-                            block->mr->addr != addr) {
+                            block->mr->addr != addr2) {
                             error_report("Mismatched GPAs for block %s "
                                          "%" PRId64 "!= %" PRId64,
-                                         id, (uint64_t)addr,
+                                         id, (uint64_t)addr2,
                                          (uint64_t)block->mr->addr);
                             ret = -EINVAL;
                         }
diff --git a/migration/rdma.c b/migration/rdma.c
index b2e869aced..c6400cf641 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1902,9 +1902,11 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
      * by waiting for a READY message.
      */
     if (rdma->control_ready_expected) {
-        RDMAControlHeader resp;
-        ret = qemu_rdma_exchange_get_response(rdma,
-                                    &resp, RDMA_CONTROL_READY, RDMA_WRID_READY);
+        RDMAControlHeader resp_ignored;
+
+        ret = qemu_rdma_exchange_get_response(rdma, &resp_ignored,
+                                              RDMA_CONTROL_READY,
+                                              RDMA_WRID_READY);
         if (ret < 0) {
             return ret;
         }
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 31842c3afb..438ea77cfa 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -97,7 +97,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         return -EINVAL;
     }
     if (vmsd->pre_load) {
-        int ret = vmsd->pre_load(opaque);
+        ret = vmsd->pre_load(opaque);
         if (ret) {
             return ret;
         }
-- 
2.41.0


