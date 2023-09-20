Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 778C07A8BDC
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj204-0005Pc-Ng; Wed, 20 Sep 2023 14:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qj1za-0005KI-04
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qj1zS-0002uh-5U
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695234715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cua8FyWSMnOBRwAouMn6v8fHUxBoBkJqqrwS0ytd8G4=;
 b=PxWA62MZ9xV1OLGx4BNfLEhgZ+ctC6tR8LQQgZTr6zHUqHAjNiM1MlxADPSeZoWrEqQ/Hs
 v37U5t8qjJwwwAko/5gnWsVU3wzCKxcnKmzkSB9cOK7WEQJ52hl3ndSQvZ4lqO68bL0E9s
 2wqiV/PPx0HRO/kubafIP+x4d9tzmZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-lOVAYoqTP7-l3Mnpz4ACwQ-1; Wed, 20 Sep 2023 14:31:52 -0400
X-MC-Unique: lOVAYoqTP7-l3Mnpz4ACwQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52CC285A5BA;
 Wed, 20 Sep 2023 18:31:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EB9840C2064;
 Wed, 20 Sep 2023 18:31:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3818521E6904; Wed, 20 Sep 2023 20:31:49 +0200 (CEST)
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
Subject: [PATCH v2 2/7] migration: Clean up local variable shadowing
Date: Wed, 20 Sep 2023 20:31:44 +0200
Message-ID: <20230920183149.1105333-3-armbru@redhat.com>
In-Reply-To: <20230920183149.1105333-1-armbru@redhat.com>
References: <20230920183149.1105333-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/block.c   | 4 ++--
 migration/ram.c     | 8 +++-----
 migration/rdma.c    | 8 +++++---
 migration/vmstate.c | 2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index 86c2256a2b..eb6aafeb9e 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -440,8 +440,8 @@ static int init_blk_migration(QEMUFile *f)
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
index 3915d1d7c9..c78ddfcb74 100644
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


