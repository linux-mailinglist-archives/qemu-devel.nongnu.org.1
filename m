Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0B77D187D
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 23:58:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtxTz-0003rO-3R; Fri, 20 Oct 2023 17:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTu-0003pO-AW; Fri, 20 Oct 2023 17:56:35 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTq-0008G5-Mz; Fri, 20 Oct 2023 17:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=iHfVvyVjq4g5YNZ0DhXc240zSGDlc6cdMexUlDF6B1U=; b=inFcDJSPdY6O
 yEuiW+4CnlCEsWiwFYN31xijQPeJ9saVyjqYdoIPW1F940fSNmRGoDBt8bb9CANQK6dh0x7N685KY
 fwc36Q5AId6jcjqiMh5irTzH9GebcUutkjNC3XhXjKm9QvPeGZQ3I/Fadf6Ik80Korslllhzte0jG
 pSDC0+iJjFx4lOQqVuqhH0hww1/N4xLoTD0F8yT1mgiUKCo61uK6aC3JE2yInANHVvKOgThCUgw2+
 P4EFoio/P5riIunsvANW3Ut8n6aTOwz59cCUqVliro28I760cQFnWKlPL6gT+7SX9zMHmwWaNJ5nX
 vVWPbQl7zcfowYpBaI1tgg==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qtxTT-00A9pF-1k;
 Fri, 20 Oct 2023 23:56:20 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH 1/7] qcow2: make function update_refcount_discard() global
Date: Sat, 21 Oct 2023 00:56:16 +0300
Message-Id: <20231020215622.789260-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We are going to need it for discarding separate subclusters.  The
function itself doesn't do anything with the refcount tables, it simply
adds a discard request to the queue, so rename it to qcow2_queue_discard().

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/qcow2-refcount.c | 8 ++++----
 block/qcow2.h          | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 0266542cee..2026f5fa21 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -754,8 +754,8 @@ void qcow2_process_discards(BlockDriverState *bs, int ret)
     }
 }
 
-static void update_refcount_discard(BlockDriverState *bs,
-                                    uint64_t offset, uint64_t length)
+void qcow2_queue_discard(BlockDriverState *bs, uint64_t offset,
+                         uint64_t length)
 {
     BDRVQcow2State *s = bs->opaque;
     Qcow2DiscardRegion *d, *p, *next;
@@ -902,7 +902,7 @@ update_refcount(BlockDriverState *bs, int64_t offset, int64_t length,
             }
 
             if (s->discard_passthrough[type]) {
-                update_refcount_discard(bs, cluster_offset, s->cluster_size);
+                qcow2_queue_discard(bs, cluster_offset, s->cluster_size);
             }
         }
     }
@@ -3619,7 +3619,7 @@ qcow2_discard_refcount_block(BlockDriverState *bs, uint64_t discard_block_offs)
         /* discard refblock from the cache if refblock is cached */
         qcow2_cache_discard(s->refcount_block_cache, refblock);
     }
-    update_refcount_discard(bs, discard_block_offs, s->cluster_size);
+    qcow2_queue_discard(bs, discard_block_offs, s->cluster_size);
 
     return 0;
 }
diff --git a/block/qcow2.h b/block/qcow2.h
index 29958c512b..75d6a1b61b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -891,6 +891,8 @@ int coroutine_fn qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *re
                                        BdrvCheckMode fix);
 
 void qcow2_process_discards(BlockDriverState *bs, int ret);
+void qcow2_queue_discard(BlockDriverState *bs, uint64_t offset,
+                         uint64_t length);
 
 int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
                                  int64_t size);
-- 
2.39.3


