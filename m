Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA597D3BDA
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:11:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxVv-0002xK-2j; Mon, 23 Oct 2023 12:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVt-0002kq-7B
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:45 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVq-0001ra-Ln
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:44 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32da7ac5c4fso2421789f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698077441; x=1698682241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSz8G6MPNajxBQHe67TPEcfd1QqFtTe7tRA8HW/GPrw=;
 b=BcYG/pAPZxwLx4GZeXNd2jFwTTm5XSBCNiOYPouoaMsHnoh10X8DlzRJj5qVmEz9zm
 afh16a1+ttj0WYifRGn/0c6ysBseNYKrEZBCL4U3Vm5AQhmRHxRvBG+lTB9HY7pKecg9
 wVJw/o7ntKsC4fJlfc08rCZmnQx8o7kDidu7IklUM+LecknR2URYVsNC3vitVE5gMA7Q
 LPBrHCT+hXKXSbRcbZJWbMbE03U26bzIptkgkCfHyRQO/TTocB3qoO4gW9g4nlWOSbAh
 GN8aWC1h84ooeG9sFk9a3Mt+r8NCWohrD1nrvU5DN828N8NkvB38vIbJcQu4otrmAPgY
 YZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698077441; x=1698682241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSz8G6MPNajxBQHe67TPEcfd1QqFtTe7tRA8HW/GPrw=;
 b=wIewh0RANcqyJIXGJu3s7S2UPAI8UbwrR3BsEPLNpQMmD6p8o+QvHO5QItqdLgScOa
 fmlxxSuuc3YWSw44BOSwVXSIpt2AJ5gX20iYP+TJs4v0T7quyoOdGPDx0McyW6hmh8ku
 rz0uAASpn6xN+9bVey9shCsEogeH+aJY99XPty2AOQ+PBD98085MEGR2Z7HHGAPt9BNP
 dfToBoJt6za/646MXhHk0juKMAe4omnm9sCLhX40T2XoJ6gIYnRfLEUBUdKwTdRHp24p
 mR/2iR12RtBBKQxWso21gCkP8p16yf3bB05bT3mAotPiICu0dnuu/JtXBfDF6k3nOfMX
 YG1A==
X-Gm-Message-State: AOJu0Yz4Mx6mczWqMjAUUs57bIznLVHKG/weGN1qnp0moq51b7/EUPIt
 RRzMxYQaDGiZ2KYsq2JFJsXIEHRfriGjXL/i+6M=
X-Google-Smtp-Source: AGHT+IGF4e510ihJiOIeOATdArOUQMXvg/x84tR/WhvrMJ+I0U3YqIbp0htFGDkt7VB6doWZ5LAaJg==
X-Received: by 2002:a5d:68c1:0:b0:32d:bf26:e7a8 with SMTP id
 p1-20020a5d68c1000000b0032dbf26e7a8mr6690479wrw.36.1698077441118; 
 Mon, 23 Oct 2023 09:10:41 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr.
 [176.170.216.159]) by smtp.gmail.com with ESMTPSA id
 dj18-20020a0560000b1200b0032d96dd703bsm8108495wrb.70.2023.10.23.09.10.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Oct 2023 09:10:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH 9/9] target/ppc: Use tcg_gen_sextract_tl
Date: Mon, 23 Oct 2023 18:09:44 +0200
Message-ID: <20231023160944.10692-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023160944.10692-1-philmd@linaro.org>
References: <20231023160944.10692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: Please double-check 32/64 & bits
---
 target/ppc/translate.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c6e1f7c2ca..1370db9bd5 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2892,13 +2892,7 @@ static void gen_slw(DisasContext *ctx)
 
     t0 = tcg_temp_new();
     /* AND rS with a mask that is 0 when rB >= 0x20 */
-#if defined(TARGET_PPC64)
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x3a);
-    tcg_gen_sari_tl(t0, t0, 0x3f);
-#else
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x1a);
-    tcg_gen_sari_tl(t0, t0, 0x1f);
-#endif
+    tcg_gen_sextract_tl(t0, cpu_gpr[rB(ctx->opcode)], 5, 1);
     tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
     t1 = tcg_temp_new();
     tcg_gen_andi_tl(t1, cpu_gpr[rB(ctx->opcode)], 0x1f);
@@ -2956,13 +2950,7 @@ static void gen_srw(DisasContext *ctx)
 
     t0 = tcg_temp_new();
     /* AND rS with a mask that is 0 when rB >= 0x20 */
-#if defined(TARGET_PPC64)
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x3a);
-    tcg_gen_sari_tl(t0, t0, 0x3f);
-#else
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x1a);
-    tcg_gen_sari_tl(t0, t0, 0x1f);
-#endif
+    tcg_gen_sextract_tl(t0, cpu_gpr[rB(ctx->opcode)], 5, 1);
     tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
     tcg_gen_ext32u_tl(t0, t0);
     t1 = tcg_temp_new();
@@ -2981,8 +2969,7 @@ static void gen_sld(DisasContext *ctx)
 
     t0 = tcg_temp_new();
     /* AND rS with a mask that is 0 when rB >= 0x40 */
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x39);
-    tcg_gen_sari_tl(t0, t0, 0x3f);
+    tcg_gen_sextract_tl(t0, cpu_gpr[rB(ctx->opcode)], 6, 1);
     tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
     t1 = tcg_temp_new();
     tcg_gen_andi_tl(t1, cpu_gpr[rB(ctx->opcode)], 0x3f);
@@ -3071,8 +3058,7 @@ static void gen_srd(DisasContext *ctx)
 
     t0 = tcg_temp_new();
     /* AND rS with a mask that is 0 when rB >= 0x40 */
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x39);
-    tcg_gen_sari_tl(t0, t0, 0x3f);
+    tcg_gen_sextract_tl(t0, cpu_gpr[rB(ctx->opcode)], 6, 1);
     tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
     t1 = tcg_temp_new();
     tcg_gen_andi_tl(t1, cpu_gpr[rB(ctx->opcode)], 0x3f);
-- 
2.41.0


