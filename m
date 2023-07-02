Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B59C744F96
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 20:07:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qG1SE-0000gG-S1; Sun, 02 Jul 2023 14:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qG1Rd-0000ak-Nq; Sun, 02 Jul 2023 14:05:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qG1RZ-0005FA-MM; Sun, 02 Jul 2023 14:05:08 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E76FD10DED;
 Sun,  2 Jul 2023 21:04:53 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2FB2E11201;
 Sun,  2 Jul 2023 21:04:52 +0300 (MSK)
Received: (nullmailer pid 2122363 invoked by uid 1000);
 Sun, 02 Jul 2023 18:04:51 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 58/65] icount: don't adjust virtual time backwards
 after warp
Date: Sun,  2 Jul 2023 21:04:31 +0300
Message-Id: <20230702180439.2122316-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230702210422@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230702210422@cover.tls.msk.ru>
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

From: Nicholas Piggin <npiggin@gmail.com>

The icount-based QEMU_CLOCK_VIRTUAL runs ahead of the RT clock at times.
When warping, it is possible it is still ahead at the end of the warp,
which causes icount adaptive mode to adjust it backward. This can result
in the machine observing time going backwards.

Prevent this by clamping adaptive adjustment to 0 at minimum.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20230627061406.241847-1-npiggin@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 67f85346ca9305d9fb3254ceff735ceaadeb0911)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/softmmu/icount.c b/softmmu/icount.c
index 4504433e16..a5cef9c60a 100644
--- a/softmmu/icount.c
+++ b/softmmu/icount.c
@@ -259,11 +259,16 @@ static void icount_warp_rt(void)
         warp_delta = clock - timers_state.vm_clock_warp_start;
         if (icount_enabled() == 2) {
             /*
-             * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too
-             * far ahead of real time.
+             * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too far
+             * ahead of real time (it might already be ahead so careful not
+             * to go backwards).
              */
             int64_t cur_icount = icount_get_locked();
             int64_t delta = clock - cur_icount;
+
+            if (delta < 0) {
+                delta = 0;
+            }
             warp_delta = MIN(warp_delta, delta);
         }
         qatomic_set_i64(&timers_state.qemu_icount_bias,
-- 
2.39.2


