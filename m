Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 244D5797E20
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 23:54:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeMwR-0004xC-VP; Thu, 07 Sep 2023 17:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qeMwQ-0004wm-IE; Thu, 07 Sep 2023 17:53:34 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qeMwN-0004Dk-SL; Thu, 07 Sep 2023 17:53:34 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qeMtB-00EbSj-35;
 Thu, 07 Sep 2023 23:53:25 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Nir Soffer <nirsof@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Subject: [PATCH 1/1] block: improve alignment detection and fix 271 test
Date: Thu,  7 Sep 2023 23:53:26 +0200
Message-Id: <20230907215326.367847-1-den@openvz.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, HEXHASH_WORD=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Unfortunately 271 IO test is broken if started in non-cached mode.

Commits
    commit a6b257a08e3d72219f03e461a52152672fec0612
    Author: Nir Soffer <nirsof@gmail.com>
    Date:   Tue Aug 13 21:21:03 2019 +0300
    file-posix: Handle undetectable alignment
and
    commit 9c60a5d1978e6dcf85c0e01b50e6f7f54ca09104
    Author: Kevin Wolf <kwolf@redhat.com>
    Date:   Thu Jul 16 16:26:00 2020 +0200
    block: Require aligned image size to avoid assertion failure
have interesting side effect if used togather.

If the image size is not multiple of 4k and that image falls under
original constraints of Nil's patch, the image can not be opened
due to the check in the bdrv_check_perm().

The patch tries to satisfy the requirements of bdrv_check_perm()
inside raw_probe_alignment(). This is at my opinion better that just
disallowing to run that test in non-cached mode. The operation is legal
by itself.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Nir Soffer <nirsof@gmail.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Alberto Garcia <berto@igalia.com>
---
 block/file-posix.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index b16e9c21a1..988cfdc76c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -447,8 +447,21 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
         for (i = 0; i < ARRAY_SIZE(alignments); i++) {
             align = alignments[i];
             if (raw_is_io_aligned(fd, buf, align)) {
-                /* Fallback to safe value. */
-                bs->bl.request_alignment = (align != 1) ? align : max_align;
+                if (align != 1) {
+                    bs->bl.request_alignment = align;
+                    break;
+                }
+                /*
+                 * Fallback to safe value. max_align is perfect, but the size of the device must be multiple of
+                 * the virtual length of the device. In the other case we will get a error in
+                 * bdrv_node_refresh_perm().
+                 */
+                for (align = max_align; align > 1; align /= 2) {
+                    if ((bs->total_sectors * BDRV_SECTOR_SIZE) % align == 0) {
+                        break;
+                    }
+                }
+                bs->bl.request_alignment = align;
                 break;
             }
         }
-- 
2.34.1


