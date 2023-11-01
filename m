Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A97DDBD2
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:14:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2aE-0005zG-Kz; Wed, 01 Nov 2023 00:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a7-0005xj-QK
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:52 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a6-0007a3-6x
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:51 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6cd09f51fe0so3681307a34.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811909; x=1699416709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2X7Ucp2Y9mIkZhRq4HmkfCIbzcycIOamUSvNy3V5fio=;
 b=UQ6TUsDaTXzzBFwGa5SiY+5ipxOYRvDXTSHRZmbPhGQq1kMrRuS2aZ1WE5xmSFFI6b
 TzF+Q/FYDxlFtogtaNxcG0p8saBtsANVN+rzrpm3N91azfYobxocjxWe6A54/fADuN5R
 d60wlwXv8+lZgJlgF5mG52AL6mm4HoWvwlsXm0hvF2iyIZqa+rjH0Lzhzi9HG8frX4G9
 qTY/pAElTOUV7p5DWPVJY47GHvOjDXlfp484bw9Ca1Kwk0Tbya2mWbXYlMQyuErFZUvp
 fpC4Ht4JqKlyuNtoMvlgdmofy9PO4kl1niSHprvx/EKIWA/ladzcaJrV38jA2X7sS58I
 pGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811909; x=1699416709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2X7Ucp2Y9mIkZhRq4HmkfCIbzcycIOamUSvNy3V5fio=;
 b=EHQkvYovDCnJNDIJxTPEaZcTdedbPALn/ti+rgSAanN8DBUuU/9b0+2CZnrf1lNk6J
 Zv/tNjqxYdnyRdp520lWoXF1HupPJjSMUxKFySpAN4jkyzdm4g+JuUZxwS4RtQQA71lE
 mVzId/MnXHxueec0wh4Hdo059lRuHN6PpOpGezScfpUPHOQ+CDrClOHmqbtukMa0s0Uy
 CTLUn42hUGdhzjmzrdpyGDyDkb9ACgicT7yS0UOOqFndkmSPkoQOga0YJ0jMMkuQiQNp
 jP2mFEP+v+ASkHnZJ/NLJzlfjQPzhTxxIdxyeWT9qesZoyNgSjoOpv7AY1/VcgdtWk4N
 SzRg==
X-Gm-Message-State: AOJu0Yw1dfUnSJfV4jZFcOlA4mOZ6S0evMM0ocRw9Fkrat2witMDCOhZ
 C3CeYJC9u6odbjQABE+IFasC1KCYOiFmk1rGbIc=
X-Google-Smtp-Source: AGHT+IGNaEzVbazOJ4FT9ReA78s529Oy/AnckknJbOxpDGt7LJZDAAY11n34+uxFkCsdXX2KAvUCRA==
X-Received: by 2002:a05:6830:2642:b0:6ce:40f1:e9f0 with SMTP id
 f2-20020a056830264200b006ce40f1e9f0mr20119314otu.11.1698811909117; 
 Tue, 31 Oct 2023 21:11:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 18/21] target/sparc: Discard cpu_cond at the end of each
 insn
Date: Tue, 31 Oct 2023 21:11:29 -0700
Message-Id: <20231101041132.174501-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

If the insn raises no exceptions, there will be no path in which
cpu_cond is used, and so the computation may be optimized away.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5c9a3d45fa..3564c6032e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -171,6 +171,7 @@ typedef struct DisasContext {
     target_ulong jump_pc[2];
 
     int mem_idx;
+    bool cpu_cond_live;
     bool fpu_enabled;
     bool address_mask_32bit;
 #ifndef CONFIG_USER_ONLY
@@ -912,6 +913,19 @@ static void gen_op_eval_fbo(TCGv dst, TCGv src, unsigned int fcc_offset)
     tcg_gen_xori_tl(dst, dst, 0x1);
 }
 
+static void finishing_insn(DisasContext *dc)
+{
+    /*
+     * From here, there is no future path through an unwinding exception.
+     * If the current insn cannot raise an exception, the computation of
+     * cpu_cond may be able to be elided.
+     */
+    if (dc->cpu_cond_live) {
+        tcg_gen_discard_tl(cpu_cond);
+        dc->cpu_cond_live = false;
+    }
+}
+
 static void gen_generic_branch(DisasContext *dc)
 {
     TCGv npc0 = tcg_constant_tl(dc->jump_pc[0]);
@@ -958,6 +972,7 @@ static void save_state(DisasContext *dc)
 
 static void gen_exception(DisasContext *dc, int which)
 {
+    finishing_insn(dc);
     save_state(dc);
     gen_helper_raise_exception(tcg_env, tcg_constant_i32(which));
     dc->base.is_jmp = DISAS_NORETURN;
@@ -999,6 +1014,8 @@ static void gen_check_align(DisasContext *dc, TCGv addr, int mask)
 
 static void gen_mov_pc_npc(DisasContext *dc)
 {
+    finishing_insn(dc);
+
     if (dc->npc & 3) {
         switch (dc->npc) {
         case JUMP_PC:
@@ -2339,6 +2356,8 @@ static bool advance_pc(DisasContext *dc)
 {
     TCGLabel *l1;
 
+    finishing_insn(dc);
+
     if (dc->npc & 3) {
         switch (dc->npc) {
         case DYNAMIC_PC:
@@ -2383,6 +2402,8 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
     target_ulong dest = address_mask_i(dc, dc->pc + disp * 4);
     target_ulong npc;
 
+    finishing_insn(dc);
+
     if (cmp->cond == TCG_COND_ALWAYS) {
         if (annul) {
             dc->pc = dest;
@@ -2449,6 +2470,7 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
             } else {
                 tcg_gen_setcondi_tl(cmp->cond, cpu_cond, cmp->c1, cmp->c2);
             }
+            dc->cpu_cond_live = true;
         }
     }
     return true;
@@ -2585,6 +2607,8 @@ static bool do_tcc(DisasContext *dc, int cond, int cc,
         tcg_gen_addi_i32(trap, trap, TT_TRAP);
     }
 
+    finishing_insn(dc);
+
     /* Trap always.  */
     if (cond == 8) {
         save_state(dc);
@@ -3201,6 +3225,7 @@ TRANS(WRSTICK_CMPR, 64, do_wr_special, a, supervisor(dc), do_wrstick_cmpr)
 
 static void do_wrpowerdown(DisasContext *dc, TCGv src)
 {
+    finishing_insn(dc);
     save_state(dc);
     gen_helper_power_down(tcg_env);
 }
@@ -5080,6 +5105,8 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     DisasDelayException *e, *e_next;
     bool may_lookup;
 
+    finishing_insn(dc);
+
     switch (dc->base.is_jmp) {
     case DISAS_NEXT:
     case DISAS_TOO_MANY:
-- 
2.34.1


