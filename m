Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B80AA09BE
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Apr 2025 13:35:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9jDs-0007AG-7U; Tue, 29 Apr 2025 07:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDh-0006vG-LJ; Tue, 29 Apr 2025 07:33:49 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDd-0008Eg-G6; Tue, 29 Apr 2025 07:33:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id BC2336139C;
 Tue, 29 Apr 2025 14:33:38 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b423::1:3a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bXTAnY0Fe0U0-et8shCl8; Tue, 29 Apr 2025 14:33:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1745926418;
 bh=5oseaxkYuuPVOra7hdGoqyPtzdfbXPYktFbnwhW/LzQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Vhfbbb94yRIIRPX+ZZx/nsvF3UXTeFPyyufiRRhkmnPWZYySwwkd0/JJsQNP2xREy
 n1jTIf/xGRBYPxpQJ6xot+gyhZ1TNlXppFvOQ0gpc1tebmOJ+nKWujq/KGk/bCFySG
 BB/BXMqKS/p+x36OJMMMifoR17dxgkKMrDKr981o=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Vincent Vanlaer <libvirt-e6954efa@volkihar.be>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 1/8] block: get type of block allocation in commit_run
Date: Tue, 29 Apr 2025 14:33:23 +0300
Message-ID: <20250429113335.423535-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429113335.423535-1-vsementsov@yandex-team.ru>
References: <20250429113335.423535-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>

bdrv_co_common_block_status_above not only returns whether the block is
allocated, but also if it contains zeroes.

Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20241026163010.2865002-2-libvirt-e6954efa@volkihar.be>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/commit.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 5df3d05346..ba0ba59316 100644
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
2.48.1


