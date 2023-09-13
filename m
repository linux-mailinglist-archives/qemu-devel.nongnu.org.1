Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1845479E901
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:19:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPl5-0007AQ-6t; Wed, 13 Sep 2023 09:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPky-00077c-ML; Wed, 13 Sep 2023 09:18:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPkw-0002pK-06; Wed, 13 Sep 2023 09:18:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4C03B2175D;
 Wed, 13 Sep 2023 16:18:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3D39D27C80;
 Wed, 13 Sep 2023 16:18:01 +0300 (MSK)
Received: (nullmailer pid 4073274 invoked by uid 1000);
 Wed, 13 Sep 2023 13:18:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 03/66] async: avoid use-after-free on re-entrancy guard
Date: Wed, 13 Sep 2023 16:17:27 +0300
Message-Id: <20230913131757.4073200-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Alexander Bulekov <alxndr@bu.edu>

A BH callback can free the BH, causing a use-after-free in aio_bh_call.
Fix that by keeping a local copy of the re-entrancy guard pointer.

Buglink: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=58513
Fixes: 9c86c97f12 ("async: Add an optional reentrancy guard to the BH API")
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20230501141956.3444868-1-alxndr@bu.edu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 7915bd06f25e1803778081161bf6fa10c42dc7cd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/async.c b/util/async.c
index 9df7674b4e..055070ffbd 100644
--- a/util/async.c
+++ b/util/async.c
@@ -156,18 +156,20 @@ void aio_bh_call(QEMUBH *bh)
 {
     bool last_engaged_in_io = false;
 
-    if (bh->reentrancy_guard) {
-        last_engaged_in_io = bh->reentrancy_guard->engaged_in_io;
-        if (bh->reentrancy_guard->engaged_in_io) {
+    /* Make a copy of the guard-pointer as cb may free the bh */
+    MemReentrancyGuard *reentrancy_guard = bh->reentrancy_guard;
+    if (reentrancy_guard) {
+        last_engaged_in_io = reentrancy_guard->engaged_in_io;
+        if (reentrancy_guard->engaged_in_io) {
             trace_reentrant_aio(bh->ctx, bh->name);
         }
-        bh->reentrancy_guard->engaged_in_io = true;
+        reentrancy_guard->engaged_in_io = true;
     }
 
     bh->cb(bh->opaque);
 
-    if (bh->reentrancy_guard) {
-        bh->reentrancy_guard->engaged_in_io = last_engaged_in_io;
+    if (reentrancy_guard) {
+        reentrancy_guard->engaged_in_io = last_engaged_in_io;
     }
 }
 
-- 
2.39.2


