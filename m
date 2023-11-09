Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 654957E6B74
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:48:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Li-0003Qn-RM; Thu, 09 Nov 2023 08:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15LF-0002ee-6p; Thu, 09 Nov 2023 08:45:09 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15LD-0001Nf-BZ; Thu, 09 Nov 2023 08:45:04 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 96FF431B0D;
 Thu,  9 Nov 2023 16:43:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A6E9C344B3;
 Thu,  9 Nov 2023 16:43:04 +0300 (MSK)
Received: (nullmailer pid 1461824 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 21/55] block: Fix locking in media change monitor
 commands
Date: Thu,  9 Nov 2023 16:42:25 +0300
Message-Id: <20231109134300.1461632-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
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

blk_insert_bs() requires that the caller holds the AioContext lock for
the node to be inserted. Since commit c066e808e11, neglecting to do so
causes a crash when the child has to be moved to a different AioContext
to attach it to the BlockBackend.

This fixes qmp_blockdev_insert_anon_medium(), which is called for the
QMP commands 'blockdev-insert-medium' and 'blockdev-change-medium', to
correctly take the lock.

Cc: qemu-stable@nongnu.org
Fixes: https://issues.redhat.com/browse/RHEL-3922
Fixes: c066e808e11a5c181b625537b6c78e0de27a4801
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231013153302.39234-2-kwolf@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit fed824501501518b1ad3dc08a39f8f855508190d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/qapi-sysemu.c b/block/qapi-sysemu.c
index ef07151892..305225db32 100644
--- a/block/qapi-sysemu.c
+++ b/block/qapi-sysemu.c
@@ -232,6 +232,7 @@ static void qmp_blockdev_insert_anon_medium(BlockBackend *blk,
                                             BlockDriverState *bs, Error **errp)
 {
     Error *local_err = NULL;
+    AioContext *ctx;
     bool has_device;
     int ret;
 
@@ -253,7 +254,11 @@ static void qmp_blockdev_insert_anon_medium(BlockBackend *blk,
         return;
     }
 
+    ctx = bdrv_get_aio_context(bs);
+    aio_context_acquire(ctx);
     ret = blk_insert_bs(blk, bs, errp);
+    aio_context_release(ctx);
+
     if (ret < 0) {
         return;
     }
-- 
2.39.2


