Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE9F7D187C
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 23:58:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtxU1-0003sd-3K; Fri, 20 Oct 2023 17:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTu-0003pL-9Y; Fri, 20 Oct 2023 17:56:34 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTq-0008G1-PA; Fri, 20 Oct 2023 17:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=mEK1pV36MoJx+qzm6bIJ01vudQTCQDmFPR0gocEfWEI=; b=bjCGOG30fRcL
 jcRsgs+LdCPJ2Hf2WfPFw3sroGjwJykanMKSAc1/y7c/hOYELZ6Uy/OD75SgUNKfeM74NHAaMxNmS
 4IYCPq/K+r40JpZ+6JwHVXl13vEZYB7pVv7qhxCJefePEAVU7OfvYPmcFfJsBLR4hLSLJimDm2J7d
 HoNjTOGFL2lQH487iCfYliS+NOQsUtLKJYRLEiSTcWx0omf6XTO3RSwGv+QF4pw/RNCui7BPZgWpF
 2q1l5MAX8pl1dAsg6rsR2fQ5k/UtUkbhFHCVtyrh2Brx47YJPoQyaGQPViinQqueFWCT6O9jG4pRK
 lDZN0UCLDjo9d5DW29t/8w==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qtxTT-00A9pF-2S;
 Fri, 20 Oct 2023 23:56:20 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH 5/7] qcow2: zero_l2_subclusters: fall through to discard
 operation when requested
Date: Sat, 21 Oct 2023 00:56:20 +0300
Message-Id: <20231020215622.789260-6-andrey.drobyshev@virtuozzo.com>
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

When zeroizing subclusters within single cluster, detect usage of the
BDRV_REQ_MAY_UNMAP flag and fall through to the subcluster-based discard
operation, much like it's done with the cluster-based discards.  That
way subcluster-aligned operations "qemu-io -c 'write -z -u ...'" will
lead to actual unmap.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/qcow2-cluster.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index cf40f2dc12..040251f2c3 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2242,7 +2242,7 @@ zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
                     unsigned nb_subclusters, int flags)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t new_l2_bitmap;
+    uint64_t new_l2_bitmap, l2_bitmap_mask;
     int ret, sc = offset_to_sc_index(s, offset);
     SubClusterRangeInfo scri = { 0 };
 
@@ -2251,9 +2251,10 @@ zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
         goto out;
     }
 
+    l2_bitmap_mask = QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
     new_l2_bitmap = scri.l2_bitmap;
-    new_l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
-    new_l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
+    new_l2_bitmap |= QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
+    new_l2_bitmap &= ~l2_bitmap_mask;
 
     /*
      * If there're no non-zero subclusters left, we might as well zeroize
@@ -2266,6 +2267,16 @@ zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
                                 1, flags);
     }
 
+    /*
+     * If the request allows discarding subclusters and they're actually
+     * allocated, we go down the discard path since after the discard
+     * operation the subclusters are going to be read as zeroes anyway.
+     */
+    if ((flags & BDRV_REQ_MAY_UNMAP) && (scri.l2_bitmap & l2_bitmap_mask)) {
+        return discard_l2_subclusters(bs, offset, nb_subclusters,
+                                      QCOW2_DISCARD_REQUEST, false, &scri);
+    }
+
     if (new_l2_bitmap != scri.l2_bitmap) {
         set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
         qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);
-- 
2.39.3


