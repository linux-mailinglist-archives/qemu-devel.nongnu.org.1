Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA77980F484
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 18:26:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD6Va-0007ke-Nn; Tue, 12 Dec 2023 12:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rD6VW-0007ih-0b
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 12:25:22 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rD6VP-0005IS-QU
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 12:25:21 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d0b2752dc6so51779945ad.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 09:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702401911; x=1703006711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=63LZ+9XN5pZr3CYY16o4ZrfHWApFRyoEpR5td9MnyJw=;
 b=pT4gNpg91KAU7Q+Zd1gsuFKBP4S5onI0Umq53ah3EJFk9W56ewfA4cUKXCCage6D2h
 ijYxIO7+wlyvEsw0/xTfeCp1tMrGEAgCbJfTH6PlkBDRpuu2rzpTr7cFR0zoxjAx/6vG
 oNj7f1Y9Qr7uuIQvzs4ib/oxhloXUmUloLBxlS7G6f8MXK5xaPMYw+o5jYAdiY/d6Sor
 ii+MScBsFF8v/qQC9iRIGzvwkcGEI3JDKEqMzew1jLSbPgm4t7zxwlBq0wPwM1nATJ7c
 3K2gpQinenzjjYego5oWVibC7eAN/RQzKFePfuyEhqkIg95yFz4rwNKI616THtSlbQKl
 3gPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702401911; x=1703006711;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=63LZ+9XN5pZr3CYY16o4ZrfHWApFRyoEpR5td9MnyJw=;
 b=UlI3jgaEeB/evSO8r+axtyU70CDrNx1VyoWcBlxSDXbVuVMAcf0NJL2z3C9Q7PWllr
 3XWwc+FUI+ieKO2Pmhb3xOduY6M+jEXWySQr/Pxfg6Bos+Ck9lO9ayRzxNoomVN5wwyI
 pNEsnLh2N+G9ZxJxe/+WAf52NoRWInh16uCh911Vgi2qyuV+TyRZGuSdp7AyX6d/lBTe
 v3WGuvGukLTGC1257yvWRHryfoltrk4IMiv1KZzCfdBaQv8bhW9KAc6c8nxiq2eUbLRx
 /4tWoXrDAUNcqC7PaRGDevx2zYdJ8BqBI3RxOkJgh38BMuCUAl/S3zBUZfwvBSH7/Zky
 1mCA==
X-Gm-Message-State: AOJu0Yy7lDfuWnKltlQ2G2KtTlXyQO0ssxwSPCLIK8PF2VaXDhm5uODB
 oDIMsiew1AKO1W/u8QVHUza3nkmUWuaEvM+Er79q8A==
X-Google-Smtp-Source: AGHT+IGtoiyIjfCgD8iRSVR6ZTBvCrBRmShfF37kNynYJXKoSNMFqN/1OJ4fiUSvPe3oMxop69Bkag==
X-Received: by 2002:a17:903:124b:b0:1d3:2e0d:cda3 with SMTP id
 u11-20020a170903124b00b001d32e0dcda3mr2282841plh.103.1702401911579; 
 Tue, 12 Dec 2023 09:25:11 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 y16-20020a17090322d000b001d09c5424d4sm8852610plg.297.2023.12.12.09.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 09:25:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH for-8.2?] target/i386: Fix 32-bit wrapping of pc/eip
 computation
Date: Tue, 12 Dec 2023 09:25:10 -0800
Message-Id: <20231212172510.103305-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In 32-bit mode, pc = eip + cs_base is also 32-bit, and must wrap.
Failure to do so results in incorrect memory exceptions to the guest.
Before 732d548732ed, this was implicitly done via truncation to
target_ulong but only in qemu-system-i386, not qemu-system-x86_64.

To fix this, we must add conditional zero-extensions.
Since we have to test for 32 vs 64-bit anyway, note that cs_base
is always zero in 64-bit mode.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2022
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

This may be too late for 8.2; if not, then 8.2.1 and 8.1.next.
I think I have found all forms of pc <-> eip, but another set
of eyes would be appreciated.

r~

---
 target/i386/cpu.h           |  9 +++++++--
 target/i386/tcg/tcg-cpu.c   |  4 +++-
 target/i386/tcg/translate.c | 23 +++++++++++++++++------
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cd2e295bd6..ef987f344c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2324,10 +2324,15 @@ static inline int cpu_mmu_index_kernel(CPUX86State *env)
 static inline void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
-    *cs_base = env->segs[R_CS].base;
-    *pc = *cs_base + env->eip;
     *flags = env->hflags |
         (env->eflags & (IOPL_MASK | TF_MASK | RF_MASK | VM_MASK | AC_MASK));
+    if (env->hflags & HF_CS64_MASK) {
+        *cs_base = 0;
+        *pc = env->eip;
+    } else {
+        *cs_base = env->segs[R_CS].base;
+        *pc = (uint32_t)(*cs_base + env->eip);
+    }
 }
 
 void do_cpu_init(X86CPU *cpu);
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 2c6a12c835..eb05a69f79 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -66,8 +66,10 @@ static void x86_restore_state_to_opc(CPUState *cs,
 
     if (tb_cflags(tb) & CF_PCREL) {
         env->eip = (env->eip & TARGET_PAGE_MASK) | data[0];
+    } else if (tb->flags & HF_CS64_MASK) {
+        env->eip = data[0];
     } else {
-        env->eip = data[0] - tb->cs_base;
+        env->eip = (uint32_t)(data[0] - tb->cs_base);
     }
     if (cc_op != CC_OP_DYNAMIC) {
         env->cc_op = cc_op;
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 587d88692a..037bc47e7c 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -552,8 +552,10 @@ static void gen_update_eip_cur(DisasContext *s)
     assert(s->pc_save != -1);
     if (tb_cflags(s->base.tb) & CF_PCREL) {
         tcg_gen_addi_tl(cpu_eip, cpu_eip, s->base.pc_next - s->pc_save);
+    } else if (CODE64(s)) {
+        tcg_gen_movi_tl(cpu_eip, s->base.pc_next);
     } else {
-        tcg_gen_movi_tl(cpu_eip, s->base.pc_next - s->cs_base);
+        tcg_gen_movi_tl(cpu_eip, (uint32_t)(s->base.pc_next - s->cs_base));
     }
     s->pc_save = s->base.pc_next;
 }
@@ -563,8 +565,10 @@ static void gen_update_eip_next(DisasContext *s)
     assert(s->pc_save != -1);
     if (tb_cflags(s->base.tb) & CF_PCREL) {
         tcg_gen_addi_tl(cpu_eip, cpu_eip, s->pc - s->pc_save);
+    } else if (CODE64(s)) {
+        tcg_gen_movi_tl(cpu_eip, s->base.pc_next);
     } else {
-        tcg_gen_movi_tl(cpu_eip, s->pc - s->cs_base);
+        tcg_gen_movi_tl(cpu_eip, (uint32_t)(s->base.pc_next - s->cs_base));
     }
     s->pc_save = s->pc;
 }
@@ -610,8 +614,10 @@ static TCGv eip_next_tl(DisasContext *s)
         TCGv ret = tcg_temp_new();
         tcg_gen_addi_tl(ret, cpu_eip, s->pc - s->pc_save);
         return ret;
+    } else if (CODE64(s)) {
+        return tcg_constant_tl(s->pc);
     } else {
-        return tcg_constant_tl(s->pc - s->cs_base);
+        return tcg_constant_tl((uint32_t)(s->pc - s->cs_base));
     }
 }
 
@@ -622,8 +628,10 @@ static TCGv eip_cur_tl(DisasContext *s)
         TCGv ret = tcg_temp_new();
         tcg_gen_addi_tl(ret, cpu_eip, s->base.pc_next - s->pc_save);
         return ret;
+    } else if (CODE64(s)) {
+        return tcg_constant_tl(s->base.pc_next);
     } else {
-        return tcg_constant_tl(s->base.pc_next - s->cs_base);
+        return tcg_constant_tl((uint32_t)(s->base.pc_next - s->cs_base));
     }
 }
 
@@ -2837,6 +2845,10 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
         }
     }
     new_eip &= mask;
+    new_pc = new_eip + s->cs_base;
+    if (!CODE64(s)) {
+        new_pc = (uint32_t)new_pc;
+    }
 
     gen_update_cc_op(s);
     set_cc_op(s, CC_OP_DYNAMIC);
@@ -2854,8 +2866,7 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
         }
     }
 
-    if (use_goto_tb &&
-        translator_use_goto_tb(&s->base, new_eip + s->cs_base)) {
+    if (use_goto_tb && translator_use_goto_tb(&s->base, new_pc)) {
         /* jump to same page: we can use a direct jump */
         tcg_gen_goto_tb(tb_num);
         if (!(tb_cflags(s->base.tb) & CF_PCREL)) {
-- 
2.34.1


