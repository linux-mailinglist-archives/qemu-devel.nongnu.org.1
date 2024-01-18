Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC0283135F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:54:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNE3-0000L3-VA; Thu, 18 Jan 2024 02:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNE1-0000KX-SF; Thu, 18 Jan 2024 02:54:09 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNDz-0007JE-VP; Thu, 18 Jan 2024 02:54:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D25A74502B;
 Thu, 18 Jan 2024 10:54:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0A85F66194;
 Thu, 18 Jan 2024 10:54:05 +0300 (MSK)
Received: (nullmailer pid 2381631 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 01/38] block: Fix crash when loading snapshot on
 inactive node
Date: Thu, 18 Jan 2024 10:52:28 +0300
Message-Id: <20240118075404.2381519-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Kevin Wolf <kwolf@redhat.com>

bdrv_is_read_only() only checks if the node is configured to be
read-only eventually, but even if it returns false, writing to the node
may not be permitted at the moment (because it's inactive).

bdrv_is_writable() checks that the node can be written to right now, and
this is what the snapshot operations really need.

Change bdrv_can_snapshot() to use bdrv_is_writable() to fix crashes like
the following:

$ ./qemu-system-x86_64 -hda /tmp/test.qcow2 -loadvm foo -incoming defer
qemu-system-x86_64: ../block/io.c:1990: int bdrv_co_write_req_prepare(BdrvChild *, int64_t, int64_t, BdrvTrackedRequest *, int): Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.

The resulting error message after this patch isn't perfect yet, but at
least it doesn't crash any more:

$ ./qemu-system-x86_64 -hda /tmp/test.qcow2 -loadvm foo -incoming defer
qemu-system-x86_64: Device 'ide0-hd0' is writable but does not support snapshots

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231201142520.32255-2-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit d3007d348adaaf04ee8b099a475282034a662414)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/snapshot.c b/block/snapshot.c
index ec8cf4810b..c4d40e80dd 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -196,8 +196,10 @@ bdrv_snapshot_fallback(BlockDriverState *bs)
 int bdrv_can_snapshot(BlockDriverState *bs)
 {
     BlockDriver *drv = bs->drv;
+
     GLOBAL_STATE_CODE();
-    if (!drv || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs)) {
+
+    if (!drv || !bdrv_is_inserted(bs) || !bdrv_is_writable(bs)) {
         return 0;
     }
 
-- 
2.39.2


