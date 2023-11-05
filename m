Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B05A57E1647
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:14:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjUC-0003Rb-Hg; Sun, 05 Nov 2023 15:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjUA-0003QX-CL
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:42 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU8-0002As-Mv
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:42 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b3c2607d9bso3078771b3a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215159; x=1699819959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlzuFmbJ+lRCVWBnnRWRgKX8WhOt5plpowDBaUnKw9s=;
 b=HpMYmjXNp3q02Lc3fHCvQ2aFyHqjZ5hhg/HiNzmvHa1rCHzFaiten4BDlJpJ0FaqXJ
 ATOl+t3LTcEA1DWGve1W/3WoMh+10z85P4mOB3YYwWGTdzqBLgWm3HKWMsi/Bo1SuiZX
 NfiM+8diq9GtUNmQ3OKqT8hPo5kKqVyEGU+QrG8xNraZzaiH065x671IlUeHQFIPFn6n
 RrIA6sIhHt5+tpRQBl1JpZZQWs0SJ+nfHQjxnlJg+D/MRytip7n50azNnYRFRE2fQM5v
 tercrT86LDj0ERqGAXU/835wLFRGhOySovoRIlPlbbKILaSp6Rx1MVd7ba/au/kDCrr2
 0Qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215159; x=1699819959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlzuFmbJ+lRCVWBnnRWRgKX8WhOt5plpowDBaUnKw9s=;
 b=K6AL6qqaGtXoRntzq+wyexUs/mPamBLekUELNU2NAH2VLR5zKyM8bYEzqBAkavkNIc
 Xh6mxHr+5CJ17SbiK7pK15PruEyY4GnPMD4xmZMMMY/NBkGiub2tusRG6eI0DOktP1i2
 dfgvyfx4vvjwjK2Qahe4QQVmqkUjephoPt8Jv37O/ygPEcTSNzAV1D6yKicKamdLDbnx
 dih4fiIOlbI/1A+OiydnU4zlFMZ5FR5QT/5lqVR4swE+7avoRUsCdxWeNoEOizYQfur9
 vdYNndSVnvMx6R4HVDEPlTgmDlx1csSK8c1IVJ9eNKoJvgprQJ9R3HZOxprVvbRjr8zZ
 exNw==
X-Gm-Message-State: AOJu0YzjFg88zJ4hKyq1m9IirltQ0GmTFqvYOAuP0aNA5bahCpoPlkSI
 bAYHMvycg+scnzmQZckZe10peGNkLk9c/4z2v1M=
X-Google-Smtp-Source: AGHT+IGZngWQEO4itYmIFVmch8Ho89QeunkqMkuA2/okMhwQS2MLe4ZcH8x0+u7BRuNPiK7D1fticg==
X-Received: by 2002:a05:6a00:391a:b0:68f:f38d:f76c with SMTP id
 fh26-20020a056a00391a00b0068ff38df76cmr23607474pfb.6.1699215159238; 
 Sun, 05 Nov 2023 12:12:39 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 18/21] target/sparc: Discard cpu_cond at the end of each insn
Date: Sun,  5 Nov 2023 12:12:19 -0800
Message-Id: <20231105201222.202395-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


