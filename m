Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD4C79F855
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:46:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcM5-0000mC-5N; Wed, 13 Sep 2023 22:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLt-0000jb-3J
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:45:09 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLd-0000iG-2t
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:45:08 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c0d5b16aacso3878965ad.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659492; x=1695264292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJqwGMxjgTHvkSu2Q4h3DPp0J6KFTcG520NltI7mhoQ=;
 b=qfBlrK+wJoK3eYnhgKxSwECDeM0WozKH6utVNV7uSw/doSn/yBgJlUcD4V2Q4SL6g9
 SAYS2tiOMzOocqsPohv5xg7JVgFkQjHodBtYHjuKcW/kqrpTxTOglYr33fz34B27zsxw
 Z3HsdPq3NRhq0Uu77CFRfHMao27toUl/4UhV61OXzEoBan/I286XyMKh5hpiYOWiacC0
 kuAlBmNFcxgmvd/8hAnmV6swatOKG4DyxAPuYVybqX5iw2ctugjKJqrGw3RjIpAXBTdz
 rb/WTXGQ5s8HNunTZk0iTNb1yFL9xHI+B3UzExuJ1KZ2lXWtS9VtQwnvY9zl8zqQDyps
 Be+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659492; x=1695264292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJqwGMxjgTHvkSu2Q4h3DPp0J6KFTcG520NltI7mhoQ=;
 b=kMi8EuX9RpAcqzjVGDeys0Ay6N+FKa7ahcJGnm6CwmCHfcDAh7lW6q/uOR48Ewvear
 rzQ968zzJjWPyV6u/TBFW5h0JMlWv8VKuJHxhRfqCNqJhPvB8jW5ORUv5VGk6uRYdUa5
 OzTziNIHqaeqP6ZvnuDaZmiNTsfL3D4z2RUy+SgTHO+h58bmBTloeKPI6Ikd+qc24/LJ
 32A5+QxhM1+FKe1cMPGunyaTfnpupTuzYB5v5BvSthc6KVazdCwWAQWsv/vAVICaWnB3
 KnX6x/RsvcebNDRqiXi67hsEyaz60L3zqz99AlUhJyfxLXEO+PI2IsowhQ0OSUeLfKm8
 FWsg==
X-Gm-Message-State: AOJu0YxzyEDZbhkhsqd9mBsdjUIFq/C1Y3PK7p9usQAfwDApjfm7BVw0
 jh6J0TMTIu13byFu2fdd7ES2srRyQYSX7dD4e1M=
X-Google-Smtp-Source: AGHT+IEpYXvsnt1qx9p5HKij8rff2QzpySfOxQj4kQNyT5Dz1MPJANnTDq686smZkFdjOtTgWi03Mw==
X-Received: by 2002:a17:903:1103:b0:1c3:f745:1cec with SMTP id
 n3-20020a170903110300b001c3f7451cecmr2279211plh.5.1694659491965; 
 Wed, 13 Sep 2023 19:44:51 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 16/24] tcg: Remove TCGContext.tlb_fast_offset
Date: Wed, 13 Sep 2023 19:44:27 -0700
Message-Id: <20230914024435.1381329-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Now that there is no padding between CPUNegativeOffsetState
and CPUArchState, this value is constant across all targets.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h         |  1 -
 accel/tcg/translate-all.c |  2 --
 tcg/tcg.c                 | 13 +++++++------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 3cdbeaf460..7743868dc9 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -489,7 +489,6 @@ struct TCGContext {
     TCGType addr_type;            /* TCG_TYPE_I32 or TCG_TYPE_I64 */
 
 #ifdef CONFIG_SOFTMMU
-    int tlb_fast_offset;
     int page_mask;
     uint8_t page_bits;
     uint8_t tlb_dyn_max_bits;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 6fac5b7e29..83e07b830f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -344,8 +344,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->page_bits = TARGET_PAGE_BITS;
     tcg_ctx->page_mask = TARGET_PAGE_MASK;
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
-    tcg_ctx->tlb_fast_offset = (int)offsetof(ArchCPU, parent_obj.neg.tlb.f)
-                             - (int)offsetof(ArchCPU, env);
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
 #ifdef TCG_GUEST_DEFAULT_MO
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 164532bafb..78070ee935 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -405,7 +405,8 @@ static uintptr_t G_GNUC_UNUSED get_jmp_target_addr(TCGContext *s, int which)
 #if defined(CONFIG_SOFTMMU) && !defined(CONFIG_TCG_INTERPRETER)
 static int tlb_mask_table_ofs(TCGContext *s, int which)
 {
-    return s->tlb_fast_offset + which * sizeof(CPUTLBDescFast);
+    return (offsetof(CPUNegativeOffsetState, tlb.f[which]) -
+            sizeof(CPUNegativeOffsetState));
 }
 #endif
 
@@ -733,6 +734,11 @@ static const TCGTargetOpDef constraint_sets[] = {
 
 #include "tcg-target.c.inc"
 
+/* Validate CPUTLBDescFast placement. */
+QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
+                        sizeof(CPUNegativeOffsetState))
+                  < MIN_TLB_MASK_TABLE_OFS);
+
 static void alloc_tcg_plugin_context(TCGContext *s)
 {
 #ifdef CONFIG_PLUGIN
@@ -1496,11 +1502,6 @@ void tcg_func_start(TCGContext *s)
     tcg_debug_assert(s->addr_type == TCG_TYPE_I32 ||
                      s->addr_type == TCG_TYPE_I64);
 
-#if defined(CONFIG_SOFTMMU) && !defined(CONFIG_TCG_INTERPRETER)
-    tcg_debug_assert(s->tlb_fast_offset < 0);
-    tcg_debug_assert(s->tlb_fast_offset >= MIN_TLB_MASK_TABLE_OFS);
-#endif
-
     tcg_debug_assert(s->insn_start_words > 0);
 }
 
-- 
2.34.1


