Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A0E8B5731
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Apr 2024 13:54:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1PYc-0008HJ-1s; Mon, 29 Apr 2024 07:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1PYX-0008EI-Kh; Mon, 29 Apr 2024 07:52:25 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1PYQ-0001ny-At; Mon, 29 Apr 2024 07:52:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id E2F8A60B5D;
 Mon, 29 Apr 2024 14:52:12 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0qOEuD11MuQ0-AeJvAd0z; Mon, 29 Apr 2024 14:52:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714391532;
 bh=I1mOWou9kbYL8/uNkdlX0JTVSXvIsMtggeYmfxIr4Kk=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qplkCrgBfLpyVoGi9yhMEqMSIrfitGrvGOD6s10m+OkB9KnkYN8JsZ2BCRkoIEqFh
 3HcrxNIJJwsbPMTB704i0gQO/eSAwZhbgZQUFmUnI228xjh/kQD/gDMhc7q+tmsplH
 OKoDJDDvTQk8Kdae+zvzoHuvtlSOC+lo6/ARZiSU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Fiona Ebner <f.ebner@proxmox.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PULL 2/6] block/copy-before-write: fix permission
Date: Mon, 29 Apr 2024 14:51:53 +0300
Message-Id: <20240429115157.2260885-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429115157.2260885-1-vsementsov@yandex-team.ru>
References: <20240429115157.2260885-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

In case when source node does not have any parents, the condition still
works as required: backup job do create the parent by

  block_job_create -> block_job_add_bdrv -> bdrv_root_attach_child

Still, in this case checking @perm variable doesn't work, as backup job
creates the root blk with empty permissions (as it rely on CBW filter
to require correct permissions and don't want to create extra
conflicts).

So, we should not check @perm.

The hack may be dropped entirely when transactional insertion of
filter (when we don't try to recalculate permissions in intermediate
state, when filter does conflict with original parent of the source
node) merged (old big series
"[PATCH v5 00/45] Transactional block-graph modifying API"[1] and it's
current in-flight part is "[PATCH v8 0/7] blockdev-replace"[2])

[1] https://patchew.org/QEMU/20220330212902.590099-1-vsementsov@openvz.org/
[2] https://patchew.org/QEMU/20231017184444.932733-1-vsementsov@yandex-team.ru/

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240313152822.626493-2-vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/copy-before-write.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 8aba27a71d..3e3af30c08 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -364,9 +364,13 @@ cbw_child_perm(BlockDriverState *bs, BdrvChild *c, BdrvChildRole role,
                            perm, shared, nperm, nshared);
 
         if (!QLIST_EMPTY(&bs->parents)) {
-            if (perm & BLK_PERM_WRITE) {
-                *nperm = *nperm | BLK_PERM_CONSISTENT_READ;
-            }
+            /*
+             * Note, that source child may be shared with backup job. Backup job
+             * does create own blk parent on copy-before-write node, so this
+             * works even if source node does not have any parents before backup
+             * start
+             */
+            *nperm = *nperm | BLK_PERM_CONSISTENT_READ;
             *nshared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
         }
     }
-- 
2.34.1


