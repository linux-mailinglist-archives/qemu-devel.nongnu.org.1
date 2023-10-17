Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E37707CBAF4
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdK1-0008NL-2A; Tue, 17 Oct 2023 02:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdJz-0008Mj-GK
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:51 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdJx-0003og-Hy
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c9d407bb15so44465185ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523168; x=1698127968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXlmVTgalHfsB9Nikgsdxk0ApYZwOaGhGlv+ImBLl8Q=;
 b=dY7SUlNPM6BAgWpJw407RKkJhTHsTB5hFkPHgi5E+7RIkQ++YJDJDnld8DDd88Xatw
 6h9QFXAFczZD8J+6Ok1HEtJnAgoIsnjrsipm5x0msAEKSJgiul/TcUDXxW/DUEbtzV/g
 IHWe6U6lLM8YXsza6k0eXPl6ffw6YBzV+ZJVLLzJ44ZhjnNM6vevaBQAZajUt6ZwHK8+
 wZ1R+ncAZTOM/hq0bIP0/vUxlULAhlqfCkU/6NZ0ZWM7lFO2G9dsGi0EA0bhf3UGA+jM
 pUzfj5xqFnyfqjRqMeyO6EQR66dNa2FC50F3YuDjo8TUPDWILp3TiZPBGRHfvi1tQltr
 /9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523168; x=1698127968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jXlmVTgalHfsB9Nikgsdxk0ApYZwOaGhGlv+ImBLl8Q=;
 b=Jjdjzn0k/qt58w8iHMBopSuCPeqUK6sobSIkMDDsCWqDxb22tdrtgqHB9SNMnFUJB5
 n1hwrYYLxybUXkfIcACMGlrlUWV+bBmRoPomwfMZl7j0iA4qCCapojV7jEvyLOaEake+
 WTiwKZHfLhnoioYa2Wq9MR/1K6DLJYuUjCjuPKoWLDtRZUPzgvjrYMSJuOjgKFMwBx6v
 tSbMny1Q7nsEuq7v6lWfThaysZ39lzy0MHiyQl1zvsCBKHt56/IM5xrOJ8ixsZPQeC8y
 SqODodI3fG/2wd/cgvESw68RoBjCT/IvICjn565FKfJNTnZ8N5lesVqT7EZ1XrjhaEar
 XdWg==
X-Gm-Message-State: AOJu0YyPat8wFb21Fb2U6RFYDv2Lyok3xCl+kt5ss/cJ72qmJQEonkn2
 y084AOrSTVtwuGC8AOU02E2dzSZd7Kdjy8VAbVY=
X-Google-Smtp-Source: AGHT+IEJU81iG6/VfcL+dLl0PFovx/rRHhL3w9ZYWdjQs9fOAnTJ3mVKpCzB6DEqf2CeVwxjCUbxCg==
X-Received: by 2002:a17:902:e742:b0:1c7:7e00:8075 with SMTP id
 p2-20020a170902e74200b001c77e008075mr1372861plf.66.1697523167511; 
 Mon, 16 Oct 2023 23:12:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 02/90] target/sparc: Implement check_align inline
Date: Mon, 16 Oct 2023 23:11:16 -0700
Message-Id: <20231017061244.681584-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Emit the exception at the end of the translation block,
so that the non-exception case can fall through.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h      |  1 -
 target/sparc/ldst_helper.c |  7 ++--
 target/sparc/translate.c   | 68 +++++++++++++++++++++++++++++++++-----
 3 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index b8f1e78c75..b116ddcb29 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -24,7 +24,6 @@ DEF_HELPER_FLAGS_2(tick_set_count, TCG_CALL_NO_RWG, void, ptr, i64)
 DEF_HELPER_FLAGS_3(tick_get_count, TCG_CALL_NO_WG, i64, env, ptr, int)
 DEF_HELPER_FLAGS_2(tick_set_limit, TCG_CALL_NO_RWG, void, ptr, i64)
 #endif
-DEF_HELPER_FLAGS_3(check_align, TCG_CALL_NO_WG, void, env, tl, i32)
 DEF_HELPER_1(debug, void, env)
 DEF_HELPER_1(save, void, env)
 DEF_HELPER_1(restore, void, env)
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 78b03308ae..246de86c98 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -360,6 +360,7 @@ static inline void do_check_asi(CPUSPARCState *env, int asi, uintptr_t ra)
 #endif /* !CONFIG_USER_ONLY */
 #endif
 
+#if defined(TARGET_SPARC64) || !defined(CONFIG_USER_ONLY)
 static void do_check_align(CPUSPARCState *env, target_ulong addr,
                            uint32_t align, uintptr_t ra)
 {
@@ -367,11 +368,7 @@ static void do_check_align(CPUSPARCState *env, target_ulong addr,
         cpu_raise_exception_ra(env, TT_UNALIGNED, ra);
     }
 }
-
-void helper_check_align(CPUSPARCState *env, target_ulong addr, uint32_t align)
-{
-    do_check_align(env, addr, align, GETPC());
-}
+#endif
 
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY) &&   \
     defined(DEBUG_MXCC)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8fabed28fd..8f6fd453e7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -68,6 +68,15 @@ static TCGv cpu_wim;
 /* Floating point registers */
 static TCGv_i64 cpu_fpr[TARGET_DPREGS];
 
+typedef struct DisasDelayException {
+    struct DisasDelayException *next;
+    TCGLabel *lab;
+    TCGv_i32 excp;
+    /* Saved state at parent insn. */
+    target_ulong pc;
+    target_ulong npc;
+} DisasDelayException;
+
 typedef struct DisasContext {
     DisasContextBase base;
     target_ulong pc;    /* current Program Counter: integer or DYNAMIC_PC */
@@ -89,6 +98,7 @@ typedef struct DisasContext {
     int fprs_dirty;
     int asi;
 #endif
+    DisasDelayException *delay_excp_list;
 } DisasContext;
 
 typedef struct {
@@ -984,9 +994,38 @@ static void gen_exception(DisasContext *dc, int which)
     dc->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_check_align(TCGv addr, int mask)
+static TCGLabel *delay_exceptionv(DisasContext *dc, TCGv_i32 excp)
 {
-    gen_helper_check_align(tcg_env, addr, tcg_constant_i32(mask));
+    DisasDelayException *e = g_new0(DisasDelayException, 1);
+
+    e->next = dc->delay_excp_list;
+    dc->delay_excp_list = e;
+
+    e->lab = gen_new_label();
+    e->excp = excp;
+    e->pc = dc->pc;
+    /* Caller must have used flush_cond before branch. */
+    assert(e->npc != JUMP_PC);
+    e->npc = dc->npc;
+
+    return e->lab;
+}
+
+static TCGLabel *delay_exception(DisasContext *dc, int excp)
+{
+    return delay_exceptionv(dc, tcg_constant_i32(excp));
+}
+
+static void gen_check_align(DisasContext *dc, TCGv addr, int mask)
+{
+    TCGv t = tcg_temp_new();
+    TCGLabel *lab;
+
+    tcg_gen_andi_tl(t, addr, mask);
+
+    flush_cond(dc);
+    lab = delay_exception(dc, TT_UNALIGNED);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t, 0, lab);
 }
 
 static void gen_mov_pc_npc(DisasContext *dc)
@@ -5019,9 +5058,9 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         tcg_gen_mov_tl(cpu_tmp0, cpu_src1);
                     }
                 }
+                gen_check_align(dc, cpu_tmp0, 3);
                 gen_helper_restore(tcg_env);
                 gen_mov_pc_npc(dc);
-                gen_check_align(cpu_tmp0, 3);
                 tcg_gen_mov_tl(cpu_npc, cpu_tmp0);
                 dc->npc = DYNAMIC_PC_LOOKUP;
                 goto jmp_insn;
@@ -5044,12 +5083,9 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                 switch (xop) {
                 case 0x38:      /* jmpl */
                     {
-                        TCGv t = gen_dest_gpr(dc, rd);
-                        tcg_gen_movi_tl(t, dc->pc);
-                        gen_store_gpr(dc, rd, t);
-
+                        gen_check_align(dc, cpu_tmp0, 3);
+                        gen_store_gpr(dc, rd, tcg_constant_tl(dc->pc));
                         gen_mov_pc_npc(dc);
-                        gen_check_align(cpu_tmp0, 3);
                         gen_address_mask(dc, cpu_tmp0);
                         tcg_gen_mov_tl(cpu_npc, cpu_tmp0);
                         dc->npc = DYNAMIC_PC_LOOKUP;
@@ -5060,8 +5096,8 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                     {
                         if (!supervisor(dc))
                             goto priv_insn;
+                        gen_check_align(dc, cpu_tmp0, 3);
                         gen_mov_pc_npc(dc);
-                        gen_check_align(cpu_tmp0, 3);
                         tcg_gen_mov_tl(cpu_npc, cpu_tmp0);
                         dc->npc = DYNAMIC_PC;
                         gen_helper_rett(tcg_env);
@@ -5643,6 +5679,7 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
+    DisasDelayException *e, *e_next;
     bool may_lookup;
 
     switch (dc->base.is_jmp) {
@@ -5704,6 +5741,19 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     default:
         g_assert_not_reached();
     }
+
+    for (e = dc->delay_excp_list; e ; e = e_next) {
+        gen_set_label(e->lab);
+
+        tcg_gen_movi_tl(cpu_pc, e->pc);
+        if (e->npc % 4 == 0) {
+            tcg_gen_movi_tl(cpu_npc, e->npc);
+        }
+        gen_helper_raise_exception(tcg_env, e->excp);
+
+        e_next = e->next;
+        g_free(e);
+    }
 }
 
 static void sparc_tr_disas_log(const DisasContextBase *dcbase,
-- 
2.34.1


