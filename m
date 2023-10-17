Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 746C07CBB76
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdlw-0007wM-2s; Tue, 17 Oct 2023 02:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlf-0007tm-9d
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:28 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdld-0001tD-Jp
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so35034525ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524884; x=1698129684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xdO1Knle14XvqVU+j8YkOQCebKjxdVqO128wtqqFIi0=;
 b=PSMsELF62IDQ0n9O2uI9Vq+GAbTVS1fnUNEKhnahrlN9O9ec9mxq0u1jZDxaO6V1qW
 0TCCL9z6sjUip8SmltVHhcb6P+KyjvdaFFwO0hlIi1o1BUzDfsePU8ZdSGaFVyejf/L4
 RMklJSvE6VgTpZEAMmZiiD835WffigJw7KIhPSEAqrxjPld3D2nfDwiUKLqnepDhsXIv
 0jJVTaaEMkjxTpojJsSR/tHO1DmZJJv6k266SragkST1mwxPBMcCoM5tMisaGJBXqevD
 dZPRNsMELQ+gUNpoD7XQVVUoSHT02LuHVnFAyYNdfG1jeKcadaAadWVX/H+5v2U2NGxF
 NAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524884; x=1698129684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdO1Knle14XvqVU+j8YkOQCebKjxdVqO128wtqqFIi0=;
 b=pxUxXtnTU3Uf3x364AIMRhswxD+XH4g+qYN9+v203CM/2GdbnELMV4BP3XUoLCILya
 TIOe4tVzDwlZpLNMOHiUE+MgCzMbTEvt3k9v8C2yBXEXZv16B4j4IeKcPZZyqHINsuj4
 VOABF+M/3h7ED3Eq9O8e1D9BBTcbNcg0a/4nOGXkuy3RnTYMSx2hRVq4ox30r3oPcp/D
 TUagtXw8wG622dCJHamV9VgNF/gwPvOCm+7mlne2Zvs5hDioVVBsH1CDBbK8//UTnHhE
 Cp3J/ddXAKz7oa7gtaa1hWtCJkb0Er0k5I0+jLOs+PfdDsHwZO8Q4KxLR5534JmehEWZ
 lVVQ==
X-Gm-Message-State: AOJu0YyDWc7iC3mAr31LtzgReDeX0aVULmoO+Dc7cB1NOq0yfpUl9Y1q
 Gj5/uKrjMtyq5PmH4QXgMIZ1QB1zHOHpK0fNIJs=
X-Google-Smtp-Source: AGHT+IFmgKAYWOUvMG44Bya7ELZ4M75o3Xx4EakT4aH1//DKG6N2eNXKB8W0S1uErQFs3yiDI9/IsA==
X-Received: by 2002:a17:902:d091:b0:1ca:abd:1c1e with SMTP id
 v17-20020a170902d09100b001ca0abd1c1emr1263367plv.23.1697524884349; 
 Mon, 16 Oct 2023 23:41:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 18/20] target/sparc: Discard cpu_cond at the end of each insn
Date: Mon, 16 Oct 2023 23:41:07 -0700
Message-Id: <20231017064109.681935-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
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

If the insn raises no exceptions, there will be no path in which
cpu_cond is used, and so the computation may be optimized away.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index bdf1753a65..9f53e703e6 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -174,6 +174,7 @@ typedef struct DisasContext {
     target_ulong jump_pc[2];
 
     int mem_idx;
+    bool cpu_cond_live;
     bool fpu_enabled;
     bool address_mask_32bit;
 #ifndef CONFIG_USER_ONLY
@@ -850,6 +851,19 @@ static void gen_op_eval_fbo(TCGv dst, TCGv src, unsigned int fcc_offset)
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
@@ -896,6 +910,7 @@ static void save_state(DisasContext *dc)
 
 static void gen_exception(DisasContext *dc, int which)
 {
+    finishing_insn(dc);
     save_state(dc);
     gen_helper_raise_exception(tcg_env, tcg_constant_i32(which));
     dc->base.is_jmp = DISAS_NORETURN;
@@ -937,6 +952,8 @@ static void gen_check_align(DisasContext *dc, TCGv addr, int mask)
 
 static void gen_mov_pc_npc(DisasContext *dc)
 {
+    finishing_insn(dc);
+
     if (dc->npc & 3) {
         switch (dc->npc) {
         case JUMP_PC:
@@ -2247,6 +2264,8 @@ static bool advance_pc(DisasContext *dc)
 {
     TCGLabel *l1;
 
+    finishing_insn(dc);
+
     if (dc->npc & 3) {
         switch (dc->npc) {
         case DYNAMIC_PC:
@@ -2290,6 +2309,8 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
 {
     target_ulong npc = dc->npc;
 
+    finishing_insn(dc);
+
     if (cmp->cond == TCG_COND_ALWAYS) {
         if (annul) {
             dc->pc = dest;
@@ -2354,6 +2375,7 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
             } else {
                 tcg_gen_setcondi_tl(cmp->cond, cpu_cond, cmp->c1, cmp->c2);
             }
+            dc->cpu_cond_live = true;
         }
     }
     return true;
@@ -2520,6 +2542,8 @@ static bool trans_Tcc(DisasContext *dc, arg_Tcc *a)
         tcg_gen_addi_i32(trap, trap, TT_TRAP);
     }
 
+    finishing_insn(dc);
+
     /* Trap always.  */
     if (a->cond == 8) {
         save_state(dc);
@@ -3198,6 +3222,7 @@ TRANS(WRSTICK_CMPR, 64, do_wr_special, a, supervisor(dc), do_wrstick_cmpr)
 
 static void do_wrpowerdown(DisasContext *dc, TCGv src)
 {
+    finishing_insn(dc);
     save_state(dc);
     gen_helper_power_down(tcg_env);
 }
@@ -5148,6 +5173,8 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     DisasDelayException *e, *e_next;
     bool may_lookup;
 
+    finishing_insn(dc);
+
     switch (dc->base.is_jmp) {
     case DISAS_NEXT:
     case DISAS_TOO_MANY:
-- 
2.34.1


