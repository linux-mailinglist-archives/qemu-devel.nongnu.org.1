Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2EB830A77
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:09:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ8SW-0006Zr-IC; Wed, 17 Jan 2024 11:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rQ8SM-0006Tl-MD; Wed, 17 Jan 2024 11:07:58 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rQ8SI-0000GO-Q6; Wed, 17 Jan 2024 11:07:57 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:62a3:0:640:1524:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id A738D6229D;
 Wed, 17 Jan 2024 19:07:48 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b43a::1:2b])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id c7sSt20Ih8c0-0CvkHDft; Wed, 17 Jan 2024 19:07:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1705507667;
 bh=L5q+CYOmRfNevs8m8vD/BAKMWEc8QPFpWMwHiaSeWUk=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=QJKirFm5C4DEzxwOqnuk/X+04OlbNBfz+3Z0Z45/4f8j3ReV0XsQGqPc3yb50uGfD
 P2Zr4gdmlhWFG68McCxbA8FcJSRnKYXvxyAB0yqkqPzo1lPcQo7cJcuMSoAmFIJMtH
 HPfe3EouITuYf4zr5+L5366DtBcgpTrupQo5mIrE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 f.ebner@proxmox.com
Subject: [PATCH v2 1/4] block/copy-before-write: fix permission
Date: Wed, 17 Jan 2024 19:07:34 +0300
Message-Id: <20240117160737.1057513-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117160737.1057513-1-vsementsov@yandex-team.ru>
References: <20240117160737.1057513-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 block/copy-before-write.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 0842a1a6df..3919d495d7 100644
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


