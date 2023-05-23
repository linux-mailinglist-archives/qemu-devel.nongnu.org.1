Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F2F70DA20
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:17:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P4H-00075p-Mq; Tue, 23 May 2023 06:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P3i-0006l1-NH; Tue, 23 May 2023 06:16:03 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P3f-0001rM-N0; Tue, 23 May 2023 06:16:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A1ACF7CF8;
 Tue, 23 May 2023 13:15:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EE66C7288;
 Tue, 23 May 2023 13:15:49 +0300 (MSK)
Received: (nullmailer pid 85508 invoked by uid 1000);
 Tue, 23 May 2023 10:15:48 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniil Kovalev <dkovalev@compiler-toolchain-for.me>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 42/59] linux-user: Fix mips fp64 executables loading
Date: Tue, 23 May 2023 13:15:02 +0300
Message-Id: <20230523101536.85424-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
References: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
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

From: Daniil Kovalev <dkovalev@compiler-toolchain-for.me>

If a program requires fr1, we should set the FR bit of CP0 control status
register and add F64 hardware flag. The corresponding `else if` branch
statement is copied from the linux kernel sources (see `arch_check_elf` function
in linux/arch/mips/kernel/elf.c).

Signed-off-by: Daniil Kovalev <dkovalev@compiler-toolchain-for.me>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20230404052153.16617-1-dkovalev@compiler-toolchain-for.me>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
(cherry picked from commit a0f8d2701b205d9d7986aa555e0566b13dc18fa0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index d5c1c7941d..8735e58bad 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -290,7 +290,10 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
             env->CP0_Status |= (1 << CP0St_FR);
             env->hflags |= MIPS_HFLAG_F64;
         }
-    } else  if (!prog_req.fre && !prog_req.frdefault &&
+    } else if (prog_req.fr1) {
+        env->CP0_Status |= (1 << CP0St_FR);
+        env->hflags |= MIPS_HFLAG_F64;
+    } else if (!prog_req.fre && !prog_req.frdefault &&
           !prog_req.fr1 && !prog_req.single && !prog_req.soft) {
         fprintf(stderr, "qemu: Can't find a matching FPU mode\n");
         exit(1);
-- 
2.39.2


