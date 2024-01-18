Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC3383139A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:59:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNHG-0002DY-Hd; Thu, 18 Jan 2024 02:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNGz-0001t7-1Y; Thu, 18 Jan 2024 02:57:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNGx-00082w-Ch; Thu, 18 Jan 2024 02:57:12 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 456754504F;
 Thu, 18 Jan 2024 10:54:37 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 70298661B7;
 Thu, 18 Jan 2024 10:54:07 +0300 (MSK)
Received: (nullmailer pid 2381738 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 36/38] target/hppa: Fix IOR and ISR on unaligned access
 trap
Date: Thu, 18 Jan 2024 10:53:03 +0300
Message-Id: <20240118075404.2381519-36-mjt@tls.msk.ru>
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

From: Helge Deller <deller@gmx.de>

Put correct values (depending on CPU arch) into IOR and ISR on fault.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 910ada0225d17530188aa45afcb9412c17267f46)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 04de1689d7..fda32d7f59 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -110,11 +110,7 @@ void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     CPUHPPAState *env = &cpu->env;
 
     cs->exception_index = EXCP_UNALIGN;
-    if (env->psw & PSW_Q) {
-        /* ??? Needs tweaking for hppa64.  */
-        env->cr[CR_IOR] = addr;
-        env->cr[CR_ISR] = addr >> 32;
-    }
+    hppa_set_ior_and_isr(env, addr, MMU_IDX_MMU_DISABLED(mmu_idx));
 
     cpu_loop_exit_restore(cs, retaddr);
 }
-- 
2.39.2


