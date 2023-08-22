Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7900784141
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:54:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQtF-0002aM-W9; Tue, 22 Aug 2023 08:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQtE-0002Zb-0k
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:53:44 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQtA-0001x7-AA
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:53:43 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb72b9so42477025e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692708818; x=1693313618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Icl2oC8GOqjO24t8EWhlRVld/KcOgjsSN5YvmxZ62js=;
 b=Gp9lX3VDoXX35GM5xyhu2PCd9ow6FOVUajl8oZz8OU/Dsya/BMC4kUvSTeAE/VS5II
 ftoxjDg2l5GvP0Va7K9DJefDdfD3F0TVxt+BN9Jx+qf4lUi0KrZQIzognPu81wg9docv
 uBwmQb2BWFweD+vKAWBxftuv1CJaWRE/cMxeb/Xk2r7els4pEa+xOdcifHReIgDqQEhk
 rrvx89ojQyr0UxWmm5XSUQIIZLPI0huQMYJw6AREQDC6oF0U6jn3MnK2pH4myMbn2RFm
 /IkqfVm3etK8Y/p2xgBsGU7jKJGbditWvzQvjWlALqayN+dooyUGYG7dEOVdsSztUPr7
 KKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692708818; x=1693313618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Icl2oC8GOqjO24t8EWhlRVld/KcOgjsSN5YvmxZ62js=;
 b=Ls0H7yfY89vdlhxvgy4VPgKShPBZLqRMXRyoK76JCdEvxV4+RrRiAyLhEY7jW2KbQA
 EA+SUXeDqbLBfQX2OsxKlVKvR3o1QhEjG9EPAeeTX5xIPWc5VpNYs2XhtoVfNTkZR8lc
 d9ZwG2etOHVywfhE/WZKOFE8GXEMkOAyrl3Op+m7t7aF+JoHBBO8kC0Kp+77hrx1IU68
 PIujTGHQS6vf2aIVOV0vnEoXhi7sPKvDTV6qzEX5mPtWlKzSQY1H8GMjqXd4aJTOC5Ux
 u/hBmDn2Lx/pIuexrU0GLfH+PCNu61IcS/2Uq1suA4tqo4jew2hBYTm23fj0cagm2jxp
 oeAQ==
X-Gm-Message-State: AOJu0Ywr1jPcTUYZ6V3UtFGKSMcoLds0kFqQNEMzCaOtKGYoH2D/y3sg
 OkLhQl/nyknyn/iypIzb4a18iuzPc+D/FAyeReluzA==
X-Google-Smtp-Source: AGHT+IHMgfE0n2urYLnUimVNWMqkaX00MrFEQ134k9fygJTYqc1XZLhuqu365hkvclXIcsIUddnWIg==
X-Received: by 2002:a05:600c:20a:b0:3fe:603e:7fd2 with SMTP id
 10-20020a05600c020a00b003fe603e7fd2mr7165320wmi.0.1692708818329; 
 Tue, 22 Aug 2023 05:53:38 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a05600c2a5400b003fef60005b5sm3426261wme.9.2023.08.22.05.53.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 05:53:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Kurz <groug@kaod.org>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/12] target/ppc: Use generic hrev64_i64() in BRH / BSWAP16x8
 opcodes
Date: Tue, 22 Aug 2023 14:53:31 +0200
Message-ID: <20230822125332.55086-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822124042.54739-1-philmd@linaro.org>
References: <20230822124042.54739-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
 target/ppc/translate.c              | 10 +---------
 target/ppc/translate/vsx-impl.c.inc | 19 ++-----------------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 74796ec7ba..91a9ec2d1c 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6435,15 +6435,7 @@ static void gen_brw(DisasContext *ctx)
 /* brh */
 static void gen_brh(DisasContext *ctx)
 {
-    TCGv_i64 mask = tcg_constant_i64(0x00ff00ff00ff00ffull);
-    TCGv_i64 t1 = tcg_temp_new_i64();
-    TCGv_i64 t2 = tcg_temp_new_i64();
-
-    tcg_gen_shri_i64(t1, cpu_gpr[rS(ctx->opcode)], 8);
-    tcg_gen_and_i64(t2, t1, mask);
-    tcg_gen_and_i64(t1, cpu_gpr[rS(ctx->opcode)], mask);
-    tcg_gen_shli_i64(t1, t1, 8);
-    tcg_gen_or_i64(cpu_gpr[rA(ctx->opcode)], t1, t2);
+    tcg_gen_hrev64_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
 }
 #endif
 
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 0f5b0056f1..639ab7f1bc 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -154,23 +154,8 @@ static void gen_lxvdsx(DisasContext *ctx)
 static void gen_bswap16x8(TCGv_i64 outh, TCGv_i64 outl,
                           TCGv_i64 inh, TCGv_i64 inl)
 {
-    TCGv_i64 mask = tcg_constant_i64(0x00FF00FF00FF00FF);
-    TCGv_i64 t0 = tcg_temp_new_i64();
-    TCGv_i64 t1 = tcg_temp_new_i64();
-
-    /* outh = ((inh & mask) << 8) | ((inh >> 8) & mask) */
-    tcg_gen_and_i64(t0, inh, mask);
-    tcg_gen_shli_i64(t0, t0, 8);
-    tcg_gen_shri_i64(t1, inh, 8);
-    tcg_gen_and_i64(t1, t1, mask);
-    tcg_gen_or_i64(outh, t0, t1);
-
-    /* outl = ((inl & mask) << 8) | ((inl >> 8) & mask) */
-    tcg_gen_and_i64(t0, inl, mask);
-    tcg_gen_shli_i64(t0, t0, 8);
-    tcg_gen_shri_i64(t1, inl, 8);
-    tcg_gen_and_i64(t1, t1, mask);
-    tcg_gen_or_i64(outl, t0, t1);
+    tcg_gen_hrev64_i64(outh, inh);
+    tcg_gen_hrev64_i64(outl, inl);
 }
 
 static void gen_bswap32x4(TCGv_i64 outh, TCGv_i64 outl,
-- 
2.41.0


