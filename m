Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3E47B6FCD
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:32:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjF6-0008S9-24; Tue, 03 Oct 2023 13:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEw-0008M1-TA
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:22 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEu-0007V7-JS
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:22 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-69101022969so916392b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354279; x=1696959079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2PyAcwWOrXzTpRLzRikulAFK0Th+MdnNR/ePY2JPh0=;
 b=NgtG41sgAlpcpxconLzpXFyCOX8wdhW9L17qqCE4ZfrA+xbSvOQA03mtLNgMIbfFdy
 ogUwX9CNPL8Cz/gxAuWMMD7oyscHCRniMy7ycD0XQAr2b2zPAR6XxoJs5Ozp7DGT2i5L
 SeaOZXJafMC0fftdyyKWbCVwd+tGRrnT8OtIBumEVRJtNzUaeauwvMvm68voAbXF7ECY
 5QES8T4ioaNKnc+lcvzVJsmP6dT0zxMcxNkVOSKKL2SpusEHBw4vTJjEnKneUA8eYuhu
 igq0waQhytscgACKDhGzdrjaxKtMLMq/Eutc1okRuhj4Q+JdmjCWGUAeh8mPQZTD1FW9
 qPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354279; x=1696959079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2PyAcwWOrXzTpRLzRikulAFK0Th+MdnNR/ePY2JPh0=;
 b=Zixx2u80ZoShACD4HIuywI6SepafuMdFgH6S2U0ZQQbH6zBI45GtBi5sdMTfGg2sD0
 w63QPKUv8BHwQo3GXgxcPKlNKuR1N6n0hpD2TQm5Nrc/g0/P7SKogKZvHhnNIOVIxPq3
 I0PKfResgLuS6c5Alife2UDtWpd6vRmy9HprMRI+iPbNm2IkWRx6cnSywlkkJ0k6/TDR
 vVIuq6O4YTN2KcFuFVodzyB9X/C7Qg6UZCVjzFuEJQihfLXNz8+Iyu78KETmecqdLvkh
 2NEE8wPcgX70iisJcykNlSkOVZDdOZl9PRe0++QzvG5Z1TP5OPipzw/7QY7preEb2blr
 GzMQ==
X-Gm-Message-State: AOJu0YyYCVGIYnQEmGws0L22YXE2I5cdGHIv97KThGvC77tOlR29Ndg2
 Qh0/P8Iifx9ZGdaH/AReJeWU7LynZpf79bgAazw=
X-Google-Smtp-Source: AGHT+IGGnqTmPrPGhSK9ea0FgwcMZ/yCySUdzJjkh0mNWVYw0d1D6lWInYj65B+FLYzGf+UOvUTjbQ==
X-Received: by 2002:a05:6a00:2e95:b0:68a:54e5:24e6 with SMTP id
 fd21-20020a056a002e9500b0068a54e524e6mr335164pfb.8.1696354279352; 
 Tue, 03 Oct 2023 10:31:19 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 22/47] tcg: Remove TCGContext.tlb_fast_offset
Date: Tue,  3 Oct 2023 10:30:27 -0700
Message-Id: <20231003173052.1601813-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
index ec3f93a52f..9256217b8f 100644
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


