Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD117E6B97
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:52:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Lp-0004gK-OU; Thu, 09 Nov 2023 08:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Ld-0003kx-3s; Thu, 09 Nov 2023 08:45:30 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15La-0001ZL-Ny; Thu, 09 Nov 2023 08:45:28 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E517231B0F;
 Thu,  9 Nov 2023 16:43:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id F064C344B5;
 Thu,  9 Nov 2023 16:43:04 +0300 (MSK)
Received: (nullmailer pid 1461830 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 23/55] qemu-img: rebase: stop when reaching EOF of old
 backing file
Date: Thu,  9 Nov 2023 16:42:27 +0300
Message-Id: <20231109134300.1461632-23-mjt@tls.msk.ru>
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

In case when we're rebasing within one backing chain, and when target image
is larger than old backing file, bdrv_is_allocated_above() ends up setting
*pnum = 0.  As a result, target offset isn't getting incremented, and we
get stuck in an infinite for loop.  Let's detect this case and proceed
further down the loop body, as the offsets beyond the old backing size need
to be explicitly zeroed.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20230919165804.439110-2-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 8b097fd6b06ec295faefd4f30f96f8709abc9605)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qemu-img.c b/qemu-img.c
index 27f48051b0..78433f3746 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3801,6 +3801,8 @@ static int img_rebase(int argc, char **argv)
             }
 
             if (prefix_chain_bs) {
+                uint64_t bytes = n;
+
                 /*
                  * If cluster wasn't changed since prefix_chain, we don't need
                  * to take action
@@ -3813,9 +3815,18 @@ static int img_rebase(int argc, char **argv)
                                  strerror(-ret));
                     goto out;
                 }
-                if (!ret) {
+                if (!ret && n) {
                     continue;
                 }
+                if (!n) {
+                    /*
+                     * If we've reached EOF of the old backing, it means that
+                     * offsets beyond the old backing size were read as zeroes.
+                     * Now we will need to explicitly zero the cluster in
+                     * order to preserve that state after the rebase.
+                     */
+                    n = bytes;
+                }
             }
 
             /*
-- 
2.39.2


