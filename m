Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0707A32A2
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:43:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd30-0005BD-D4; Sat, 16 Sep 2023 17:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2x-0005A5-8w
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:47 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2s-0000Sa-06
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:47 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6bd0a0a6766so2164887a34.2
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900501; x=1695505301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwL0g4t7pLWk/ND+/4S+A46VLWCkPxcxxcvyHi0Mx8k=;
 b=ElO/TSVxTvZL684QYwJlQsvzDGYWPnnBFEkKPHa+FqccFMGW6y6/eSb2Ij4f3xLMya
 Dru1hXTasTPjxxSStJ8eF7n/QGYq7eZM4qsPJQr3hh1xHYJhB6AbPkT5navhtACB8obN
 ufcvs/joGRa6n8nclJGrqT093ILIR1HqTKl2KAS9lS8ea3Grj9HkuWY5W/A46OhsgLS3
 ONc1uGo17Ah2LntJT77xs70QXE0UyOS2m8SQ3IzFeq+qLe+om4tBKU8g5TUg+xKIhuXC
 E0mZxyUm6g1cp25LcPzeyCpDD/teifvSDj1hHflEF3au/jX9YANd9hYhhRh6LtESfPFv
 LzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900501; x=1695505301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GwL0g4t7pLWk/ND+/4S+A46VLWCkPxcxxcvyHi0Mx8k=;
 b=reoepyo+mCRufRxKvhSBhgfUY8a0oYPg/ZWRd79NqsoxjIsuQsy4/rF86MYF0GvffH
 VBdoJAP+8VJv2bozzwAX4UER1pLYgJcb9ZORyJBNGB2c8eR9V0yZSpQKqGq8r/fTcxSJ
 TGGXXzTZC7nNDn4fQN823n1xijo1eKXVKW/upLfxzaDUaGaOZ/+XmlFTHYoWTHJ+TKMH
 OKx0hGDBGjtdMpRCGibMTnm4BiZSe+EeoftfimdUkYE0NXKRZM9stTpeBDOOIfuG64RX
 q8157p8IjpBqd2g8mSfUviv8qvyl9HDoae0mtty4x8juYdLytP1npvWLoTGTbo8JT1k1
 KVNA==
X-Gm-Message-State: AOJu0YxF6SIWdljFInogOidkBIw3yAYi4on61QQRY7ZAWbIX0265zkbr
 5TjPt+XPw3bglvkP+MRJhAiwUgZz+4t0P3Z0gHI=
X-Google-Smtp-Source: AGHT+IGHBlmSWs47ILLmevgB0EfOHGWsZ/E0m050newPVh9I49bj+s08dd69Xu5pRB0bgNhku1KVCQ==
X-Received: by 2002:a05:6358:5929:b0:135:99fa:5040 with SMTP id
 g41-20020a056358592900b0013599fa5040mr5851475rwf.12.1694900500719; 
 Sat, 16 Sep 2023 14:41:40 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 15/39] tcg: Remove TCGContext.tlb_fast_offset
Date: Sat, 16 Sep 2023 14:40:59 -0700
Message-Id: <20230916214123.525796-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Now that there is no padding between CPUNegativeOffsetState
and CPUArchState, this value is constant across all targets.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h         |  1 -
 accel/tcg/translate-all.c |  2 --
 tcg/tcg.c                 | 15 +++++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

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
index 72b113ad53..c72790cdf1 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -406,7 +406,8 @@ static uintptr_t G_GNUC_UNUSED get_jmp_target_addr(TCGContext *s, int which)
 #if defined(CONFIG_SOFTMMU) && !defined(CONFIG_TCG_INTERPRETER)
 static int tlb_mask_table_ofs(TCGContext *s, int which)
 {
-    return s->tlb_fast_offset + which * sizeof(CPUTLBDescFast);
+    return (offsetof(CPUNegativeOffsetState, tlb.f[which]) -
+            sizeof(CPUNegativeOffsetState));
 }
 #endif
 
@@ -734,6 +735,13 @@ static const TCGTargetOpDef constraint_sets[] = {
 
 #include "tcg-target.c.inc"
 
+#ifndef CONFIG_TCG_INTERPRETER
+/* Validate CPUTLBDescFast placement. */
+QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
+                        sizeof(CPUNegativeOffsetState))
+                  < MIN_TLB_MASK_TABLE_OFS);
+#endif
+
 static void alloc_tcg_plugin_context(TCGContext *s)
 {
 #ifdef CONFIG_PLUGIN
@@ -1497,11 +1505,6 @@ void tcg_func_start(TCGContext *s)
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


