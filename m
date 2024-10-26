Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C77E29B19CD
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Oct 2024 18:32:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4jhA-0007wP-D3; Sat, 26 Oct 2024 12:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1t4jgi-0007s3-3q; Sat, 26 Oct 2024 12:30:52 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be ([134.58.240.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1t4jge-0003bc-99; Sat, 26 Oct 2024 12:30:51 -0400
X-KULeuven-Envelope-From: libvirt-e6954efa@volkihar.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: D28AF106.AF92C
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be
 (icts-p-ceifnet-smtps.service.icts.svcd
 [IPv6:2a02:2c40:0:51:135:242:ac11:35])
 by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id D28AF106;
 Sat, 26 Oct 2024 18:30:37 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: 
X-CAV-Cluster: smtps
Received: from flutterbat.volkihar.be (236.58-240-81.adsl-dyn.isp.belgacom.be
 [81.240.58.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id B5DADD4F17F51; 
 Sat, 26 Oct 2024 18:30:37 +0200 (CEST)
Received: by flutterbat.volkihar.be (Postfix, from userid 1000)
 id 743004B91C6; Sat, 26 Oct 2024 18:30:37 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Subject: [PATCH v4 1/5] block: get type of block allocation in commit_run
Date: Sat, 26 Oct 2024 18:30:05 +0200
Message-ID: <20241026163010.2865002-2-libvirt-e6954efa@volkihar.be>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20241026163010.2865002-1-libvirt-e6954efa@volkihar.be>
References: <20241026163010.2865002-1-libvirt-e6954efa@volkihar.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.58.240.134;
 envelope-from=libvirt-e6954efa@volkihar.be;
 helo=icts-p-cavuit-4.kulnet.kuleuven.be
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

bdrv_co_common_block_status_above not only returns whether the block is
allocated, but also if it contains zeroes.

Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/commit.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 7c3fdcb0ca..8dee25b313 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -15,6 +15,8 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "trace.h"
+#include "block/block-common.h"
+#include "block/coroutines.h"
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
 #include "qapi/error.h"
@@ -167,9 +169,13 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
             break;
         }
         /* Copy if allocated above the base */
-        ret = blk_co_is_allocated_above(s->top, s->base_overlay, true,
-                                        offset, COMMIT_BUFFER_SIZE, &n);
-        copy = (ret > 0);
+        WITH_GRAPH_RDLOCK_GUARD() {
+            ret = bdrv_co_common_block_status_above(blk_bs(s->top),
+                s->base_overlay, true, true, offset, COMMIT_BUFFER_SIZE,
+                &n, NULL, NULL, NULL);
+        }
+
+        copy = (ret >= 0 && ret & BDRV_BLOCK_ALLOCATED);
         trace_commit_one_iteration(s, offset, n, ret);
         if (copy) {
             assert(n < SIZE_MAX);
-- 
2.44.1


