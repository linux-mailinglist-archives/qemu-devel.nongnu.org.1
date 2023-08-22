Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D855783AAE
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:16:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLc7-0002Aj-L5; Tue, 22 Aug 2023 03:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLbf-0001xU-2r
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:15:18 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLbY-0002z9-Kf
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:15:13 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3198d2745feso3708511f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688507; x=1693293307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qFzQwheFK9AxDde5uR4/WWTrinK6kAcK+JYbJLTxP0=;
 b=O9nEF4u4uoo56fvng+xawxfBrUhZUIIZRcPUf1moFrXLegGrb+lDEywVYNd8PbKffL
 lR3CE3G3L52MuWomCbCdKkPj76vuA1tT8+XYv3YtVp85VXXKp6ZPCpdnXFWbeAghkAvL
 aV2rV7alU+FQNFhk0TB16v9NrnvneRgQCl93htcdCMBItDWOJqSvzZT3FQhrtOxMv/Fr
 H/RWlWPrx6S+u82h82PmqBGRYqIUA/leXdoy98YhcDfQOncDUsQYhdBKl2s6UYKGXtWA
 XEWxcTA/cLiWF5qKVp7yTp5wHMyhvAEId6JuhheIR5R2W8n5Bb3GrAXqUdTQRBD24UJO
 sDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688507; x=1693293307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qFzQwheFK9AxDde5uR4/WWTrinK6kAcK+JYbJLTxP0=;
 b=bLKPxtxJRZQ3Jh4InZSr8iMw0BUKal94WlfFF6xW4ZKziDbiD+9gTFElM/0sjYAI5I
 HGD00EYBveLrXFIYKxqigjN3wN4tl3QntEhrLPWqSr0rukW3mrh9Ul6MUhGU+Z7Klg6H
 VYZsi6niDpGtyDlfS7rup1chTUP5aRvIatC31Z1Gkj1Z/1EbmXrL71E7XuCppcR/Mp+1
 n2nptdTDT28zaAgN2l4yMHr9lm4A+5TmX4r9E/cvYAd5ssedP/pR0d1iiDN2twLIs6KG
 hl6jCFReJ9qfyKKZEU/tCSeqieDiZtPUuEQnUda7KXXRCZOisFau2FtaO2hLuGKN34A8
 oIMQ==
X-Gm-Message-State: AOJu0YzER3hPk3rs/VDbmom779sjU8A8IuuPWbXsnG3SqOVJhjk1ZyLP
 L3GOXrNiAycd3iTliLZYrVV4S/paJzkXNMxHb07TKQ==
X-Google-Smtp-Source: AGHT+IHWhHUhVishsdT8GlUQdmDT1c1tASu8ExThVlIldr66ni0mjEPryi0f9qw0pXXjD3wRX2Xu0A==
X-Received: by 2002:a5d:408b:0:b0:31a:d1c3:97ca with SMTP id
 o11-20020a5d408b000000b0031ad1c397camr6230133wrp.20.1692688506834; 
 Tue, 22 Aug 2023 00:15:06 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a056000125000b00317e6f06e22sm14942867wrx.77.2023.08.22.00.15.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:15:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RESEND v5 09/19] target/loongarch: Truncate high 32 bits of
 address in VA32 mode
Date: Tue, 22 Aug 2023 09:13:55 +0200
Message-ID: <20230822071405.35386-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071405.35386-1-philmd@linaro.org>
References: <20230822071405.35386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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


