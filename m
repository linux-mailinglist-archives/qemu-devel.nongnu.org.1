Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9D27EA1DF
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:33:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2anx-0001Ti-Gj; Mon, 13 Nov 2023 12:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anr-0001T1-N6
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:51 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2ank-0000vN-VO
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:50 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc29f39e7aso28418605ad.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699896764; x=1700501564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjPsuk23KkrkM5/YBDeM53YiJeXm+wBzAfk3xkmGY20=;
 b=efixGbnXfcFOTZkT9HqbnifvZfiC9GHjJfyBcGf99sQpqjzdZblRsPTwbaTcoKEoJC
 HpqCHPVuCKLTFhLpMxad1mmdfzzrLsw7rtST3+0suFB4cVJ3ZlJOlXtBx1cW3kEcfhRL
 99sV9Dz36ox/ApPewo/4RZhzP2PfW8KGLIV24TpSFwz8ODk03djFXPLV9XEZa74BtNju
 fYlBdR/VnxwZ/CZVmjkNOfNpcBN/W3/Ji1erbZEbC1tKZIBe+WfA98KCbZNTueAjbSn8
 iSQWgCmxM4u3FT2fVu90gMs0PY86hDsJdW0YnehfEZeuimT31W3Ln/LZU8b3/Ku9Qw6E
 uKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699896764; x=1700501564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjPsuk23KkrkM5/YBDeM53YiJeXm+wBzAfk3xkmGY20=;
 b=TGLqJu4l8MVTVYviGZDBGN1hBsBGkQdddiR43DFxylP6qsrtX+92xyjqElLSDVjD5v
 H9oHANNlVTUDT5l+JgoyH0HRnO3raMV42lOv8j+3v+nlYTqSTcQzx67V3LBhQTXWg0qm
 oKzIVCDdDTjKugSMnkNaefOmmEyOvujG9VAArn6PBaylss/6aHWT9/1TNy0+lHV2w/GM
 tCHxZoN0kSB2A9int4M1GU4AByh7SqfTnZHm8teBMXx3C8JXrc7o4FwpjwXkzYaF4rq4
 c2pnIIBMzE345Jmpf895rxtfK25UFa44CSwQEdXSOEPgnTdt4FIrCDXntlOEUtCOJuSG
 wGEw==
X-Gm-Message-State: AOJu0Yyb2Kw0yLFwKiHXZtD2NIMd9OAeeqLXIC65LHgKtEkPptIvPRRi
 rxQ9Ym5hQjRz+Wt0dNe8JtLMO5Sl3P3zw6EAFBo=
X-Google-Smtp-Source: AGHT+IFOgOHYcjAUMrdQRC2pXwiyW850z84GbGfXO2aT6eH1zVNCBLGGoxJTClUE3KobjS8FrNxVkw==
X-Received: by 2002:a17:902:fe82:b0:1cc:50f6:7fcc with SMTP id
 x2-20020a170902fe8200b001cc50f67fccmr210965plm.55.1699896763655; 
 Mon, 13 Nov 2023 09:32:43 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c731b62403sm4271910pld.218.2023.11.13.09.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:32:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/12] target/hppa: Introduce MMU_IDX_MMU_DISABLED
Date: Mon, 13 Nov 2023 09:32:31 -0800
Message-Id: <20231113173237.48233-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113173237.48233-1-richard.henderson@linaro.org>
References: <20231113173237.48233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reduce the number of direct checks against MMU_PHYS_IDX.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  1 +
 target/hppa/mem_helper.c |  4 ++--
 target/hppa/translate.c  | 20 +++++++++++---------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index cecec59700..6c0f104661 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -41,6 +41,7 @@
 #define MMU_USER_P_IDX    14
 #define MMU_PHYS_IDX      15
 
+#define MMU_IDX_MMU_DISABLED(MIDX)  ((MIDX) == MMU_PHYS_IDX)
 #define MMU_IDX_TO_PRIV(MIDX)       (((MIDX) - MMU_KERNEL_IDX) / 2)
 #define MMU_IDX_TO_P(MIDX)          (((MIDX) - MMU_KERNEL_IDX) & 1)
 #define PRIV_P_TO_MMU_IDX(PRIV, P)  ((PRIV) * 2 + !!(P) + MMU_KERNEL_IDX)
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index a13f200359..af8e86699d 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -367,8 +367,8 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
         trace_hppa_tlb_fill_excp(env, addr, size, type, mmu_idx);
 
         /* Failure.  Raise the indicated exception.  */
-        raise_exception_with_ior(env, excp, retaddr,
-                                 addr, mmu_idx == MMU_PHYS_IDX);
+        raise_exception_with_ior(env, excp, retaddr, addr,
+                                 MMU_IDX_MMU_DISABLED(mmu_idx));
     }
 
     trace_hppa_tlb_fill_success(env, addr & TARGET_PAGE_MASK,
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index bb1b65fef0..727dd8a829 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -69,9 +69,11 @@ typedef struct DisasContext {
 } DisasContext;
 
 #ifdef CONFIG_USER_ONLY
-#define UNALIGN(C)  (C)->unalign
+#define UNALIGN(C)       (C)->unalign
+#define MMU_DISABLED(C)  false
 #else
-#define UNALIGN(C)  MO_ALIGN
+#define UNALIGN(C)       MO_ALIGN
+#define MMU_DISABLED(C)  MMU_IDX_MMU_DISABLED((C)->mmu_idx)
 #endif
 
 /* Note that ssm/rsm instructions number PSW_W and PSW_E differently.  */
@@ -1375,7 +1377,7 @@ static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
-             ctx->mmu_idx == MMU_PHYS_IDX);
+             MMU_DISABLED(ctx));
     tcg_gen_qemu_ld_i32(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
     if (modify) {
         save_gpr(ctx, rb, ofs);
@@ -1393,7 +1395,7 @@ static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
-             ctx->mmu_idx == MMU_PHYS_IDX);
+             MMU_DISABLED(ctx));
     tcg_gen_qemu_ld_i64(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
     if (modify) {
         save_gpr(ctx, rb, ofs);
@@ -1411,7 +1413,7 @@ static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
-             ctx->mmu_idx == MMU_PHYS_IDX);
+             MMU_DISABLED(ctx));
     tcg_gen_qemu_st_i32(src, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
     if (modify) {
         save_gpr(ctx, rb, ofs);
@@ -1429,7 +1431,7 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
-             ctx->mmu_idx == MMU_PHYS_IDX);
+             MMU_DISABLED(ctx));
     tcg_gen_qemu_st_i64(src, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
     if (modify) {
         save_gpr(ctx, rb, ofs);
@@ -3078,7 +3080,7 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
     }
 
     form_gva(ctx, &addr, &ofs, a->b, a->x, a->scale ? a->size : 0,
-             a->disp, a->sp, a->m, ctx->mmu_idx == MMU_PHYS_IDX);
+             a->disp, a->sp, a->m, MMU_DISABLED(ctx));
 
     /*
      * For hppa1.1, LDCW is undefined unless aligned mod 16.
@@ -3108,7 +3110,7 @@ static bool trans_stby(DisasContext *ctx, arg_stby *a)
     nullify_over(ctx);
 
     form_gva(ctx, &addr, &ofs, a->b, 0, 0, a->disp, a->sp, a->m,
-             ctx->mmu_idx == MMU_PHYS_IDX);
+             MMU_DISABLED(ctx));
     val = load_gpr(ctx, a->r);
     if (a->a) {
         if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
@@ -3142,7 +3144,7 @@ static bool trans_stdby(DisasContext *ctx, arg_stby *a)
     nullify_over(ctx);
 
     form_gva(ctx, &addr, &ofs, a->b, 0, 0, a->disp, a->sp, a->m,
-             ctx->mmu_idx == MMU_PHYS_IDX);
+             MMU_DISABLED(ctx));
     val = load_gpr(ctx, a->r);
     if (a->a) {
         if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
-- 
2.34.1


