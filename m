Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 331B57057E3
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:48:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0el-000339-Qz; Tue, 16 May 2023 15:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cU-0000hY-0c
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:46:02 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cQ-0003qe-0L
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:46:01 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ae4f28454bso402895ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266355; x=1686858355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mg31tFrpqaSLWLouZqalEVgyQQeTv3Dfr7kkgOUM8nY=;
 b=wTW8P7YeA5Fly63x91sPNM8g0SRl/OogBYqWeajqbbLQKrZnFS/P6PojlSxQPCbO43
 za5TWZkpe7kbQpWxcVKelsrlAaG4L/ICP57wXJwlzF759uF6uPhUgbcwViOZSMNoJGpz
 itFg2CH1osDbqZO1VflKEAFvgN3F1G5Zaiuu1slV39+9+pLsz5qvVrtaFBAUswU/wD+j
 +8n6wIqfXqNu7bFJ+1t9cVi8XkFqnIZN1eQf+anZE08VEDVmYVeOxWiLbxEg5k1hHlIy
 ITpHGT07W9P2Lz0iM+tZXNaECYa0UJfDrX/bzPegd4/MuX+eNMDMdJ/5CjafOMvl9ERe
 2+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266355; x=1686858355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mg31tFrpqaSLWLouZqalEVgyQQeTv3Dfr7kkgOUM8nY=;
 b=bsLduWCmrZABSS7s0y3siFiEL91ReyzdZ1U9fUJXQg4UrJykRASXusl0qsTMCJmL6m
 NjRm1lPT20Q8uvzUj+HsrBDKl4A1DxKtv6qddwpMWjjUCV5hooV4REnv7T0ztclFsnWS
 YkcUias8pTEZMVzD9nZwylUXQ2YAvO3/mEq3snkBeFzy+WOtTmjf63Cj2q+ej12K0rMQ
 fSHsiIju/1YSI23Z7YhR/3OXXn8SNzXn5yMEMke28EwFhvE99jxYy9v6zW1kGIQX4sg7
 /yaq/O6QKzYFS7zS7MOi+vlrrWev2w8CJL9Ay2QNToxDkpraMdlR7hMk/l5zJjG6ZVbX
 Kg3w==
X-Gm-Message-State: AC+VfDxyUgCpnmFhmFpaJqx6RZiRCraULroo0rg0pjbKLW4QdzT6MLMO
 OFe7xfiXtOl//O59DAocHh+Q7QrZJCW/gnw+cVo=
X-Google-Smtp-Source: ACHHUZ67cFlkTy6a0Ugz+Ra3EVPI5ylHA34ILJ4dqnv5T+RBGVKl2g0FkIt45hd43ehaHbH2eypkYA==
X-Received: by 2002:a17:90b:4c8c:b0:252:8910:db42 with SMTP id
 my12-20020a17090b4c8c00b002528910db42mr19930992pjb.1.1684266355747; 
 Tue, 16 May 2023 12:45:55 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 79/80] tcg: Add tlb_dyn_max_bits to TCGContext
Date: Tue, 16 May 2023 12:41:44 -0700
Message-Id: <20230516194145.1749305-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Disconnect guest tlb parameters from TCG compilation.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h            | 1 +
 accel/tcg/translate-all.c    | 1 +
 tcg/aarch64/tcg-target.c.inc | 2 +-
 tcg/i386/tcg-target.c.inc    | 2 +-
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index db57c4d492..cd6327b175 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -563,6 +563,7 @@ struct TCGContext {
 #ifdef CONFIG_SOFTMMU
     int page_mask;
     uint8_t page_bits;
+    uint8_t tlb_dyn_max_bits;
 #endif
 
     TCGRegSet reserved_regs;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ca306f67da..353849ca6d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -360,6 +360,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 #ifdef CONFIG_SOFTMMU
     tcg_ctx->page_bits = TARGET_PAGE_BITS;
     tcg_ctx->page_mask = TARGET_PAGE_MASK;
+    tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
 #endif
 
  tb_overflow:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 8b7c679349..b58b39a07f 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1685,7 +1685,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     ldst->oi = oi;
     ldst->addrlo_reg = addr_reg;
 
-    mask_type = (s->page_bits + CPU_TLB_DYN_MAX_BITS > 32
+    mask_type = (s->page_bits + s->tlb_dyn_max_bits > 32
                  ? TCG_TYPE_I64 : TCG_TYPE_I32);
 
     /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {x0,x1}.  */
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index d766e8652c..51dfd18ab0 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1979,7 +1979,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         trexw = (ttype == TCG_TYPE_I32 ? 0 : P_REXW);
         if (TCG_TYPE_PTR == TCG_TYPE_I64) {
             hrexw = P_REXW;
-            if (s->page_bits + CPU_TLB_DYN_MAX_BITS > 32) {
+            if (s->page_bits + s->tlb_dyn_max_bits > 32) {
                 tlbtype = TCG_TYPE_I64;
                 tlbrexw = P_REXW;
             }
-- 
2.34.1


