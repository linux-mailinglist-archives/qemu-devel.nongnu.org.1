Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 604F9783A76
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:11:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLXM-0002F6-Jh; Tue, 22 Aug 2023 03:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLXK-0002El-VV
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:10:46 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLXI-0002KG-JO
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:10:46 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31781e15a0cso3748876f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688242; x=1693293042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0lC9gMe2kWPLwbVJidGFgIBdYr23SH/S3e9rEjZW5mo=;
 b=p+kn9GafdB0xXa1Dw7rRxlicImYgfLyC3uKKpmu0F1cJ2kKYn7xgNXWUGF6dPyk75W
 rSsjW18lVP/L8haPnegDJofBjPrcKmxXUEiuaJdOrEn5dAH8QD8rJaDN1zNA1UTCK5ZX
 BNFZeL9hmQVCHHbdatxROkv+pWN50ZlgwZxjG2j2A6DBYG/MQ15aTwvRkrUpT30uCgcp
 hCIdeTkzxtfl92cR/2Y4nBDlKXZthmOVEvNUxk2zuiCti7S7ObKKw2+SFLCp0jmC5Eaw
 TT/w2BD0UwA/SBOuB1lteDpVBmv/b3b1KzGzJbB0QBPvts8n5y+fWNI/K/owbcIhYBUL
 RfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688242; x=1693293042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0lC9gMe2kWPLwbVJidGFgIBdYr23SH/S3e9rEjZW5mo=;
 b=abuFSbi2x2vSlqKsn24wKV0eMQPzMfCbYq5BcPVUh2rPfAo0dGd0Shnws9jdO6rawK
 A15yiEQlSgh8rkGhQd9bH3M4BxnjmYl/1z+eVUgag3hZTn+tXQVJ8hbozB4YuIRf0JB5
 Fsz2FoN31YhqPthf4jAq3E/Rn/QZmf8YeO/WGWUobVRuOAKC4udBEWrIjYmFT3u7dMnf
 aTIfTYwaLk7klvEPIsV1GzO6b5HbPqNqiH6vjCJkmNE71RwyFJpBP5tHFcK7qqoFEKDA
 /Xf4PUDhMPPEIs0K8vZ9u+Q6awPcz0xN2eY9Hr4rFMLRKjhGIpc8N5htFP7wnHW+ZfTo
 trIg==
X-Gm-Message-State: AOJu0YzqVq3+TxQzeEeYhCj/s/jBY+Bgi+DzRLPc+Se2tcH1TkeUMggp
 6oTXaaABAtcD1XODBEkwWbJq7DbPJWh400G4CELi7w==
X-Google-Smtp-Source: AGHT+IHHMDXewg4fM/JMkjIbB4W3IJ/zoSi43ESrLlRDFRuUT7U6qwCz1Pm4sBDy1Kwo0yrNtO89OA==
X-Received: by 2002:a5d:4403:0:b0:317:4ef8:1659 with SMTP id
 z3-20020a5d4403000000b003174ef81659mr5926769wrq.28.1692688242746; 
 Tue, 22 Aug 2023 00:10:42 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 v1-20020a5d6101000000b0031c612146f1sm1305025wrt.100.2023.08.22.00.10.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:10:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 04/19] target/loongarch: Add LA64 & VA32 to DisasContext
Date: Tue, 22 Aug 2023 09:09:57 +0200
Message-ID: <20230822071013.34884-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071013.34884-1-philmd@linaro.org>
References: <20230822071013.34884-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Jiajie Chen <c@jia.je>

Add LA64 and VA32(32-bit Virtual Address) to DisasContext to allow the
translator to reject doubleword instructions in LA32 mode for example.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20230822032724.1353391-5-gaosong@loongson.cn>
---
 target/loongarch/cpu.h       | 13 +++++++++++++
 target/loongarch/translate.h |  2 ++
 target/loongarch/translate.c |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index b8af491041..72109095e4 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -432,6 +432,17 @@ static inline bool is_la64(CPULoongArchState *env)
     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
 }
 
+static inline bool is_va32(CPULoongArchState *env)
+{
+    /* VA32 if !LA64 or VA32L[1-3] */
+    bool va32 = !is_la64(env);
+    uint64_t plv = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
+    if (plv >= 1 && (FIELD_EX64(env->CSR_MISC, CSR_MISC, VA32) & (1 << plv))) {
+        va32 = true;
+    }
+    return va32;
+}
+
 /*
  * LoongArch CPUs hardware flags.
  */
@@ -439,6 +450,7 @@ static inline bool is_la64(CPULoongArchState *env)
 #define HW_FLAGS_CRMD_PG    R_CSR_CRMD_PG_MASK   /* 0x10 */
 #define HW_FLAGS_EUEN_FPE   0x04
 #define HW_FLAGS_EUEN_SXE   0x08
+#define HW_FLAGS_VA32       0x20
 
 static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
@@ -448,6 +460,7 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
     *flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
     *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
     *flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
+    *flags |= is_va32(env) * HW_FLAGS_VA32;
 }
 
 void loongarch_cpu_list(void);
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 7f60090580..b6fa5df82d 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -33,6 +33,8 @@ typedef struct DisasContext {
     uint16_t plv;
     int vl;   /* Vector length */
     TCGv zero;
+    bool la64; /* LoongArch64 mode */
+    bool va32; /* 32-bit virtual address */
 } DisasContext;
 
 void generate_exception(DisasContext *ctx, int excp);
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 3146a2d4ac..ac847745df 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -119,6 +119,9 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
         ctx->vl = LSX_LEN;
     }
 
+    ctx->la64 = is_la64(env);
+    ctx->va32 = (ctx->base.tb->flags & HW_FLAGS_VA32) != 0;
+
     ctx->zero = tcg_constant_tl(0);
 }
 
-- 
2.41.0


