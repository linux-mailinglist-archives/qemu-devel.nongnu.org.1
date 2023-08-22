Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E610C783A83
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:11:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLY5-0003uC-H2; Tue, 22 Aug 2023 03:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLXt-0003LX-K5
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:11:27 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLXo-0002Qt-Ia
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:11:18 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe8242fc4dso41086205e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688274; x=1693293074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qFzQwheFK9AxDde5uR4/WWTrinK6kAcK+JYbJLTxP0=;
 b=PacZu67Nrm8q5JgiHQhA2mZ2Jbz2tdxzEeHbDXStFgxAoln6IqZHA3rDAvmFlG+fAb
 k2v8AIASlKiD/Da7V1ncbAl+VCWvfPcL+xkvIeJl83WzqY4m9rfgROVq23VWBqtsKJwE
 KRTiHXf39Kf+YKcBkaQknTjBlZQnw27+XJoYdfArlvFB7O4qXzndamDJX5vaqSBOrSRJ
 jG+ceW57SH/McuEzARsl2Jl7HtTuHeNEk91SVgXSZmZl8wcqZ65v+L6LB65o3qJrmnCU
 vEpOlxBEzWIz8VVV0AMQwsHRvP5nPzKQShAyHtoFO65maXJ1ED6VGiNKWUSnUo6Ah+4Q
 3EJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688274; x=1693293074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qFzQwheFK9AxDde5uR4/WWTrinK6kAcK+JYbJLTxP0=;
 b=ND9Q5PsA+TaqjNfCDsNu/V4kyOcomRquyykgp400vnctQ75QKVtBLKFoazPJUkB/Rx
 x1vichmxVeqMPwDbxcs762mp2/OKIt16gf02PdGAc/09hUsQrtR+Q9jElJ3ti3DunVox
 AFICZRIe9OtFtwc3gyFHEiVqEq0KyFSWy8cObVC23OhyeoCsJ4QUjp8Lo2pLMWoi5YtH
 S3bX+1D+65bbsCqsrWlmATTy8vu2yj2v2uytlqcqgsCV+w5Mm9j/474bjvXAjoOfpnC1
 UP3JZNdm7OZzCa9WkpFr2MP5tQFKJBjzNcdMOv8XASnoqybqaCqhNMp06X9ikkUaJ2P4
 GONQ==
X-Gm-Message-State: AOJu0YxJqFZjkM/kpw9ADlxH0Lsw20EFnGIXWn/QGLjJyF3zw+hQl3PT
 oNqLC+iz+UV75fl9f6PGD9ZbQURLC2opu+BahlplxA==
X-Google-Smtp-Source: AGHT+IGXpLGwFDtEmfMl7gPOgd6xoXAIPrrwcy4UNK/yLRnDh0AEqhbR4252YOFVU+anj0FQn2UV1w==
X-Received: by 2002:a1c:4b0e:0:b0:3fe:c7fe:206c with SMTP id
 y14-20020a1c4b0e000000b003fec7fe206cmr6556451wma.23.1692688274783; 
 Tue, 22 Aug 2023 00:11:14 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 e1-20020adfe7c1000000b0031b2c01f342sm8993223wrn.87.2023.08.22.00.11.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:11:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 09/19] target/loongarch: Truncate high 32 bits of address
 in VA32 mode
Date: Tue, 22 Aug 2023 09:10:02 +0200
Message-ID: <20230822071013.34884-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071013.34884-1-philmd@linaro.org>
References: <20230822071013.34884-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

When running in VA32 mode(!LA64 or VA32L[1-3] matching PLV), virtual
address is truncated to 32 bits before address mapping.

Signed-off-by: Jiajie Chen <c@jia.je>
Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230822032724.1353391-6-gaosong@loongson.cn>
---
 target/loongarch/cpu.h       |  6 +++++-
 target/loongarch/translate.c | 16 +++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index e1562695e8..25a0ef7e41 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -445,7 +445,11 @@ static inline bool is_va32(CPULoongArchState *env)
 
 static inline void set_pc(CPULoongArchState *env, uint64_t value)
 {
-    env->pc = value;
+    if (is_va32(env)) {
+        env->pc = (uint32_t)value;
+    } else {
+        env->pc = value;
+    }
 }
 
 /*
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 8b26555a27..9a23ec786d 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -86,6 +86,10 @@ void generate_exception(DisasContext *ctx, int excp)
 
 static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
 {
+    if (ctx->va32) {
+        dest = (uint32_t) dest;
+    }
+
     if (translator_use_goto_tb(&ctx->base, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_tl(cpu_pc, dest);
@@ -212,11 +216,17 @@ static TCGv make_address_x(DisasContext *ctx, TCGv base, TCGv addend)
 {
     TCGv temp = NULL;
 
-    if (addend) {
+    if (addend || ctx->va32) {
         temp = tcg_temp_new();
+    }
+    if (addend) {
         tcg_gen_add_tl(temp, base, addend);
         base = temp;
     }
+    if (ctx->va32) {
+        tcg_gen_ext32u_tl(temp, base);
+        base = temp;
+    }
     return base;
 }
 
@@ -262,6 +272,10 @@ static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     }
 
     ctx->base.pc_next += 4;
+
+    if (ctx->va32) {
+        ctx->base.pc_next = (uint32_t)ctx->base.pc_next;
+    }
 }
 
 static void loongarch_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
-- 
2.41.0


