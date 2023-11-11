Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC45F7E8799
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 02:34:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1crP-0002HR-Ii; Fri, 10 Nov 2023 20:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crL-00027Q-DD
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:27 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1crJ-0001bl-GM
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 20:32:27 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6ce37d0f1a9so1343649a34.0
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 17:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699666344; x=1700271144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJGUiNfkARhF0DqQfpGVdM5xktg3zzPX731ojIdmei8=;
 b=Hl1ocz3ADfQLRNS8czpMGCkU6xWwlaDIMrqtH9o8vQp9IVvBB9P/Xd0fXqpAHQQTTx
 rKOlks3ttMzDNiWrTutvGv7Svev/l65hnVAA4BdPvsZ2607cwafVQYr8ZmknIstGe+pX
 5Vqn5G7WfKWLscoo5zjSnoEghHdPRR+PN3GB4bo11GGO/emv5gyUiJTf/gBGpC7uWBLT
 F9dXdzZgivQFA9228vmSBS7JIFHZARPyMHZClM38Y0deHAphIRmCqNt3W5/ru/fO5w9m
 nBNDJ6VNBjJKNkJlOX4xOO+wjzFFA4A6HqhZWmCcPvYEthBNu77O3fasuo72yetx/ikV
 0WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699666344; x=1700271144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJGUiNfkARhF0DqQfpGVdM5xktg3zzPX731ojIdmei8=;
 b=U2TeQuTNkR36xb3efxsiYEPa5A5wtTfYvvFjPnKtumZp1FvF2pA+SunGxezeaa808Y
 vCGv3H+T+ime/vHwLt2vmHfFs9GGuC8HkseGWMybJRX3RH/95sqchA8peQor3gDoF+Te
 rGiEQ0D6OOy+T74isL5rm16szPqEe/If1sj4RsDdsHYI+1vxN73jlwBIhq0999FDmmTL
 o0nevd9CzQhKOH0b8joK+VQQx50tkkLWer7FKH14cGrwRWyuvV/g+ts8AmaD/BJJj5Nk
 DiOFVnGJovz8RaVdhjKLMSVIrcy0W8OHzvDJHupKlMByIbZ4VBUKvAPRMSELsA2G+4cD
 UGFw==
X-Gm-Message-State: AOJu0YzU0yTaa/clJB8gDykXzcxuFs79uJBlqB+rHYjRH3m2+jcFEZB5
 iQituILQ1zoyrPXH2b4y6sJy0LyuskEiITgnp1s=
X-Google-Smtp-Source: AGHT+IHtst2wTIjzR9NpyHK8JStdJMTmWn7NoD52ZLB2bx3K0MzPO2M8nXZgTbaUkxdxAYpQm+1M9Q==
X-Received: by 2002:a05:6870:332a:b0:1f0:aff:333c with SMTP id
 x42-20020a056870332a00b001f00aff333cmr1221219oae.46.1699666343844; 
 Fri, 10 Nov 2023 17:32:23 -0800 (PST)
Received: from stoup.hsd1.or.comcast.net
 ([2601:1c0:5e02:2a20:a99c:45a6:14e9:ea6])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a62f20b000000b006c1221bc58bsm333502pfh.115.2023.11.10.17.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 17:32:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 08/11] target/hppa: Introduce MMU_IDX_MMU_DISABLED
Date: Fri, 10 Nov 2023 17:32:09 -0800
Message-Id: <20231111013212.229673-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111013212.229673-1-richard.henderson@linaro.org>
References: <20231111013212.229673-1-richard.henderson@linaro.org>
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

Reduce the number of direct checks against MMU_PHYS_IDX.

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


