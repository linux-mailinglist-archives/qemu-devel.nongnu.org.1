Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1497D2133
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:01:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRW1-0000TX-Bz; Sun, 22 Oct 2023 02:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVu-0000Ha-OZ
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:38 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVs-0001Tu-Ih
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:38 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c5cd27b1acso18397615ad.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954435; x=1698559235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXlmVTgalHfsB9Nikgsdxk0ApYZwOaGhGlv+ImBLl8Q=;
 b=Q8YYGmT0LwUbJdwaiYbuALtdBU3Bd4yxC6BoObfFW54wa8wkwyKFq/WsucwmDq3Jjm
 2/+W5U7rJpiUyqyMolqJCMBVqe8E3O7jL3vPKLaBmmaGR8AeRdB0+/d+JIoAWFeYaqSm
 FSrkl/RQXI4q66itOPl0msa9yiB22Oug3W3s894CE3cfI20xjl2mLXmXh7zYcZylx5DE
 igKRI/gKuzAJkxvVAV/H7QjlnMGTQ7aFissYiwR33uQ9N6rtXiGPVWi58v3W3WxK0DsS
 U98DNlbk3S04D1bjV78rfQu4+KmgHpemJuU0H4vprEqZ7dQwQBRL+cfU3aJf2vVSkzq/
 nNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954435; x=1698559235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jXlmVTgalHfsB9Nikgsdxk0ApYZwOaGhGlv+ImBLl8Q=;
 b=vVUiqeLTRC2XeFo1ZggjBuuF/J5nwsSq/qFuRP0gR/xNawpX62nxA4zn0ENJOy9fza
 swvj0uTqkHj257S7dcWcG0YJHZdOsXlR/XGuJgnG86MVu+ArdZMUAAFebd6CZx7us07k
 eiGfy+S3dUokXFKtMp2qvJLuOY819EDeVtmsLVR6FcH9oVT4Mats7QpDKBBj5bAxXu08
 9LTY97gdzykmIqpA6ueHEyvwt5Pm1f5qraWs2qxpRx5e2wg5EV7+bG70KfdgOWL+Ibvs
 7BXe9oHsnKFrvUdLndct7jyxcgqzQdY/lgiDCp5akxVZ9FPfYJeoa1wtcYEBYtYh8aOe
 o27Q==
X-Gm-Message-State: AOJu0YxZDf7CZLfGbuopnFSwNTTad/qEaw5s+IeTFNN3dMtgt+hWr2Pj
 F0jGfTRSHDAvnvTLvVROxHZGkGHh3Ygz7F2vrTE=
X-Google-Smtp-Source: AGHT+IGI/CFuu5rufqlMoRONKFBvf80ViyC/EuLvkkAXrMHAwwkR/ntImw7Gg9Dynkl6S2J7sFJ+tQ==
X-Received: by 2002:a17:902:efcc:b0:1ca:3093:77b with SMTP id
 ja12-20020a170902efcc00b001ca3093077bmr5117485plb.47.1697954434944; 
 Sat, 21 Oct 2023 23:00:34 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 02/90] target/sparc: Implement check_align inline
Date: Sat, 21 Oct 2023 22:59:03 -0700
Message-Id: <20231022060031.490251-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


