Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D8B784104
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:42:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQhM-0006Qo-U9; Tue, 22 Aug 2023 08:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQhB-0006MC-7B
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:41:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQh8-0005fY-Ra
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:41:16 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe8242fc4dso43804845e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 05:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692708072; x=1693312872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+Q+413qAyohxkZfqCqkkltTwZ66XX4v/AfIWdcA3w4=;
 b=RHAt31JaX+enrxV2lGY1ElHMHQfUkmaCYzzh5D0NPoQO3WOwlVHcNJSyfwCJgMJdRE
 PRLJDtij2T3QHtANmzMg9V0JBto+2j0VV0eiggYB9uBnsvLJirOkj3JNTKO9XHqqTBBf
 XYuiH0hlG3aIOvrktg3GzU2oeySb805dxEBF9aEuVWhl354HLQT8K8+/qvFmRCobVRZ9
 zfVBJ4KP5msX5FBwxX2dvCdD8KpTdW9aCdYoxC73kf24rOcWFzibQ5MldQ7A/fhIPLue
 IVcriIEhPRxJqIiHUZlmFjPXDqNUlPtctiljgrrUFYbtoleQAZ3Tpogbb40/W+UAc/ta
 r1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692708072; x=1693312872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+Q+413qAyohxkZfqCqkkltTwZ66XX4v/AfIWdcA3w4=;
 b=Gk76pgMd5g7G1JWmL1SBDUr0hvJ9Pg3Sty8k4LRvPFwaf2GaEcwaZAiDGes01sennV
 WiRtMEGJfV5HW6qtWzWPsE2JUdUsq2/13J3gWgBhmUN+Ou4m146HrLM3VORbW2s45H7s
 o7acCaFOoqTpssVYxkEq0Mlx/wp+h1pg3lNG2CQbgTS4sulm5Z2o+D+c0bm9wBs6NEue
 wN/SrzlzvFig0JRhBd1RoR2pXOgdetKRD/4QEaRPQKqMWOb3Y8cmFlNP5LqXu5VUEKh6
 CYaljhDHxX47lNl/hSyF+QnzAbWWt/bAwsAhnKJ81zZdMOd23h6PeCfhnxxXnhYoGbEs
 TJLQ==
X-Gm-Message-State: AOJu0YwKUZKivhF1MuF+tijZuUVo/BGSeOC05WDJ8j+NMItQ29aR3EIK
 aGoFbk/QAovJf7h1HTxUBYngzmyKKFMkrsQi9+Pj+g==
X-Google-Smtp-Source: AGHT+IE0Klq3NKboZGoQKFeFB2z1o/H+PfleE968hn+XN27YrpZZkkuWgTbE9whScTIEVBgJFPh0rw==
X-Received: by 2002:a5d:4685:0:b0:317:59c8:17bc with SMTP id
 u5-20020a5d4685000000b0031759c817bcmr6009480wrq.15.1692708072120; 
 Tue, 22 Aug 2023 05:41:12 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 a14-20020adff7ce000000b0030fd03e3d25sm15856795wrq.75.2023.08.22.05.41.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 05:41:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Kurz <groug@kaod.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-arm@nongnu.org
Subject: [PATCH 03/12] target/cris: Use generic hrev32_i32() in SWAPB opcode
Date: Tue, 22 Aug 2023 14:40:33 +0200
Message-ID: <20230822124042.54739-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822124042.54739-1-philmd@linaro.org>
References: <20230822124042.54739-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/cris/translate.c         | 20 +-------------------
 target/cris/translate_v10.c.inc |  2 +-
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index 925ed2c6f6..00bbe6c645 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -381,24 +381,6 @@ static inline void t_gen_subx_carry(DisasContext *dc, TCGv d)
     }
 }
 
-/* Swap the two bytes within each half word of the s operand.
-   T0 = ((T0 << 8) & 0xff00ff00) | ((T0 >> 8) & 0x00ff00ff)  */
-static inline void t_gen_swapb(TCGv d, TCGv s)
-{
-    TCGv t, org_s;
-
-    t = tcg_temp_new();
-    org_s = tcg_temp_new();
-
-    /* d and s may refer to the same object.  */
-    tcg_gen_mov_tl(org_s, s);
-    tcg_gen_shli_tl(t, org_s, 8);
-    tcg_gen_andi_tl(d, t, 0xff00ff00);
-    tcg_gen_shri_tl(t, org_s, 8);
-    tcg_gen_andi_tl(t, t, 0x00ff00ff);
-    tcg_gen_or_tl(d, d, t);
-}
-
 /*
  * Reverse the bits within each byte.
  *
@@ -1666,7 +1648,7 @@ static int dec_swap_r(CPUCRISState *env, DisasContext *dc)
         tcg_gen_hswap_i32(t0, t0);
     }
     if (dc->op2 & 2) {
-        t_gen_swapb(t0, t0);
+        tcg_gen_hrev32_i32(t0, t0);
     }
     if (dc->op2 & 1) {
         t_gen_swapr(t0, t0);
diff --git a/target/cris/translate_v10.c.inc b/target/cris/translate_v10.c.inc
index 0ff15769ec..86cc5de8ad 100644
--- a/target/cris/translate_v10.c.inc
+++ b/target/cris/translate_v10.c.inc
@@ -508,7 +508,7 @@ static void dec10_reg_swap(DisasContext *dc)
     if (dc->dst & 4)
         tcg_gen_hswap_i32(t0, t0);
     if (dc->dst & 2)
-        t_gen_swapb(t0, t0);
+        tcg_gen_hrev32_i32(t0, t0);
     if (dc->dst & 1)
         t_gen_swapr(t0, t0);
     cris_alu(dc, CC_OP_MOVE, cpu_R[dc->src], cpu_R[dc->src], t0, 4);
-- 
2.41.0


