Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8859D179F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Nov 2024 19:08:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD69J-0004b2-BK; Mon, 18 Nov 2024 13:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tD697-0004YX-AU; Mon, 18 Nov 2024 13:06:45 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tD691-0008QH-Q6; Mon, 18 Nov 2024 13:06:42 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 23FAAA5480;
 Mon, 18 Nov 2024 21:06:31 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7D655173519;
 Mon, 18 Nov 2024 21:06:34 +0300 (MSK)
Received: (nullmailer pid 2302447 invoked by uid 1000);
 Mon, 18 Nov 2024 18:06:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Graf <graf@amazon.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.15 33/39] target/i386: Fix legacy page table walk
Date: Mon, 18 Nov 2024 21:06:21 +0300
Message-Id: <20241118180634.2302410-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.15-20241118210517@cover.tls.msk.ru>
References: <qemu-stable-7.2.15-20241118210517@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Alexander Graf <graf@amazon.com>

Commit b56617bbcb4 ("target/i386: Walk NPT in guest real mode") added
logic to run the page table walker even in real mode if we are in NPT
mode.  That function then determined whether real mode or paging is
active based on whether the pg_mode variable was 0.

Unfortunately pg_mode is 0 in two situations:

  1) Paging is disabled (real mode)
  2) Paging is in 2-level paging mode (32bit without PAE)

That means the walker now assumed that 2-level paging mode was real
mode, breaking NetBSD as well as Windows XP.

To fix that, this patch adds a new PG flag to pg_mode which indicates
whether paging is active at all and uses that to determine whether we
are in real mode or not.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2654
Fixes: b56617bbcb4 ("target/i386: Walk NPT in guest real mode")
Fixes: 253c0a06e03 (commit b56617bbcb4 in stable-7.2.x series)
Signed-off-by: Alexander Graf <graf@amazon.com>
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Link: https://lore.kernel.org/r/20241106154329.67218-1-graf@amazon.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 8fa11a4df344f58375eb26b3b65004345f21ef37)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 326649ca99..59c39fe527 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -336,6 +336,7 @@ typedef enum X86Seg {
 #define PG_MODE_PKE      (1 << 17)
 #define PG_MODE_PKS      (1 << 18)
 #define PG_MODE_SMEP     (1 << 19)
+#define PG_MODE_PG       (1 << 20)
 
 #define MCG_CTL_P       (1ULL<<8)   /* MCG_CAP register available */
 #define MCG_SER_P       (1ULL<<24) /* MCA recovery/new status bits */
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 539189b4d1..1fa334a743 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -30,7 +30,7 @@
 
 int get_pg_mode(CPUX86State *env)
 {
-    int pg_mode = 0;
+    int pg_mode = PG_MODE_PG;
     if (!(env->cr[0] & CR0_PG_MASK)) {
         return 0;
     }
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index a52a5b417e..9e9e02e1ad 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -296,7 +296,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /* combine pde and pte nx, user and rw protections */
         ptep &= pte ^ PG_NX_MASK;
         page_size = 4096;
-    } else if (pg_mode) {
+    } else if (pg_mode & PG_MODE_PG) {
         /*
          * Page table level 2
          */
-- 
2.39.5


