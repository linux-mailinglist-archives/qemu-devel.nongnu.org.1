Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C08ECBED84E
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Oct 2025 21:08:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vACH7-0006SV-VX; Sat, 18 Oct 2025 15:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vACGz-0006Q1-83; Sat, 18 Oct 2025 15:07:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vACGv-00010Z-D6; Sat, 18 Oct 2025 15:07:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D040715F79D;
 Sat, 18 Oct 2025 22:06:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 958B12F0606;
 Sat, 18 Oct 2025 22:07:02 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, YiFei Zhu <zhuyifei@google.com>,
 unvariant.winter@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.2 16/23] i386/tcg/smm_helper: Properly apply DR values
 on SMM entry / exit
Date: Sat, 18 Oct 2025 22:06:51 +0300
Message-ID: <20251018190702.1178893-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.2-20251018220623@cover.tls.msk.ru>
References: <qemu-stable-10.1.2-20251018220623@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: YiFei Zhu <zhuyifei@google.com>

do_smm_enter and helper_rsm sets the env->dr, but does not sync the
values with cpu_x86_update_dr7. A malicious kernel may control the
instruction pointer in SMM by setting a breakpoint on the SMI
entry point, and after do_smm_enter cpu->breakpoints contains the
stale breakpoint; and because IDT is not reloaded upon SMI entry,
the debug exception handler controlled by the malicious kernel
is invoked.

Fixes: 01df040b5247 ("x86: Debug register emulation (Jan Kiszka)")
Reported-by: unvariant.winter@gmail.com
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Link: https://lore.kernel.org/r/2bacb9b24e9d337dbe48791aa25d349eb9c52c3a.1758794468.git.zhuyifei@google.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit cdba90ac1b0ac789b10c0b5f6ef7e9558237ec66)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/system/smm_helper.c b/target/i386/tcg/system/smm_helper.c
index 251eb7856c..fb028a8272 100644
--- a/target/i386/tcg/system/smm_helper.c
+++ b/target/i386/tcg/system/smm_helper.c
@@ -168,7 +168,7 @@ void do_smm_enter(X86CPU *cpu)
                        env->cr[0] & ~(CR0_PE_MASK | CR0_EM_MASK | CR0_TS_MASK |
                                       CR0_PG_MASK));
     cpu_x86_update_cr4(env, 0);
-    env->dr[7] = 0x00000400;
+    helper_set_dr(env, 7, 0x00000400);
 
     cpu_x86_load_seg_cache(env, R_CS, (env->smbase >> 4) & 0xffff, env->smbase,
                            0xffffffff,
@@ -233,8 +233,8 @@ void helper_rsm(CPUX86State *env)
     env->eip = x86_ldq_phys(cs, sm_state + 0x7f78);
     cpu_load_eflags(env, x86_ldl_phys(cs, sm_state + 0x7f70),
                     ~(CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C | DF_MASK));
-    env->dr[6] = x86_ldl_phys(cs, sm_state + 0x7f68);
-    env->dr[7] = x86_ldl_phys(cs, sm_state + 0x7f60);
+    helper_set_dr(env, 6, x86_ldl_phys(cs, sm_state + 0x7f68));
+    helper_set_dr(env, 7, x86_ldl_phys(cs, sm_state + 0x7f60));
 
     cpu_x86_update_cr4(env, x86_ldl_phys(cs, sm_state + 0x7f48));
     cpu_x86_update_cr3(env, x86_ldq_phys(cs, sm_state + 0x7f50));
@@ -268,8 +268,8 @@ void helper_rsm(CPUX86State *env)
     env->regs[R_EDX] = x86_ldl_phys(cs, sm_state + 0x7fd8);
     env->regs[R_ECX] = x86_ldl_phys(cs, sm_state + 0x7fd4);
     env->regs[R_EAX] = x86_ldl_phys(cs, sm_state + 0x7fd0);
-    env->dr[6] = x86_ldl_phys(cs, sm_state + 0x7fcc);
-    env->dr[7] = x86_ldl_phys(cs, sm_state + 0x7fc8);
+    helper_set_dr(env, 6, x86_ldl_phys(cs, sm_state + 0x7fcc));
+    helper_set_dr(env, 7, x86_ldl_phys(cs, sm_state + 0x7fc8));
 
     env->tr.selector = x86_ldl_phys(cs, sm_state + 0x7fc4) & 0xffff;
     env->tr.base = x86_ldl_phys(cs, sm_state + 0x7f64);
-- 
2.47.3


