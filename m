Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D117E6B7C
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:49:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Ke-0000C4-8O; Thu, 09 Nov 2023 08:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Ka-0008RH-VG; Thu, 09 Nov 2023 08:44:25 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15KY-0001Bq-Nl; Thu, 09 Nov 2023 08:44:24 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F091E31B04;
 Thu,  9 Nov 2023 16:43:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 05A39344AB;
 Thu,  9 Nov 2023 16:43:04 +0300 (MSK)
Received: (nullmailer pid 1461800 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mikulas Patocka <mpatocka@redhat.com>,
 Yoshinori Sato <ysato@users.sourcefoege.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 13/55] linux-user/sh4: Fix crashes on signal delivery
Date: Thu,  9 Nov 2023 16:42:17 +0300
Message-Id: <20231109134300.1461632-13-mjt@tls.msk.ru>
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

From: Mikulas Patocka <mpatocka@redhat.com>

sh4 uses gUSA (general UserSpace Atomicity) to provide atomicity on CPUs
that don't have atomic instructions. A gUSA region that adds 1 to an
atomic variable stored in @R2 looks like this:

  4004b6:       03 c7           mova    4004c4 <gusa+0x10>,r0
  4004b8:       f3 61           mov     r15,r1
  4004ba:       09 00           nop
  4004bc:       fa ef           mov     #-6,r15
  4004be:       22 63           mov.l   @r2,r3
  4004c0:       01 73           add     #1,r3
  4004c2:       32 22           mov.l   r3,@r2
  4004c4:       13 6f           mov     r1,r15

R0 contains a pointer to the end of the gUSA region
R1 contains the saved stack pointer
R15 contains negative length of the gUSA region

When this region is interrupted by a signal, the kernel detects if
R15 >= -128U. If yes, the kernel rolls back PC to the beginning of the
region and restores SP by copying R1 to R15.

The problem happens if we are interrupted by a signal at address 4004c4.
R15 still holds the value -6, but the atomic value was already written by
an instruction at address 4004c2. In this situation we can't undo the
gUSA. The function unwind_gusa does nothing, the signal handler attempts
to push a signal frame to the address -6 and crashes.

This patch fixes it, so that if we are interrupted at the last instruction
in a gUSA region, we copy R1 to R15 to restore the correct stack pointer
and avoid crashing.

There's another bug: if we are interrupted in a delay slot, we save the
address of the instruction in the delay slot. We must save the address of
the previous instruction.

Cc: qemu-stable@nongnu.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Yoshinori Sato <ysato@users.sourcefoege.jp>
Message-Id: <b16389f7-6c62-70b7-59b3-87533c0bcc@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 3b894b699c9a9c064466e128c18be80a3f2113bc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index c4ba962708..c16c2c2d57 100644
--- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -104,6 +104,14 @@ static void unwind_gusa(CPUSH4State *regs)
 
         /* Reset the SP to the saved version in R1.  */
         regs->gregs[15] = regs->gregs[1];
+    } else if (regs->gregs[15] >= -128u && regs->pc == regs->gregs[0]) {
+        /* If we are on the last instruction of a gUSA region, we must reset
+           the SP, otherwise we would be pushing the signal context to
+           invalid memory.  */
+        regs->gregs[15] = regs->gregs[1];
+    } else if (regs->flags & TB_FLAG_DELAY_SLOT) {
+        /* If we are in a delay slot, push the previous instruction.  */
+        regs->pc -= 2;
     }
 }
 
-- 
2.39.2


