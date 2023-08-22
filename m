Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9555D783E86
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 13:03:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYP9b-0006Mq-DI; Tue, 22 Aug 2023 07:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYP96-0006D0-EJ
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:02:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYP8s-0003Gs-6O
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:01:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fee51329feso17747475e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 04:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692702101; x=1693306901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INGQw2gZIfMCcsQ3FRMd0eCw/OR0PNFJSBfJGOnsR8g=;
 b=jNFIBzf1c7wg+qjAxvGMDjsDm1G6q0SQSGIBC+vnsOIIITeV40Vu21S/TlouBPiMnT
 fv249pSK0msRdnsJ0zTzx+iZYAXz6HaBFTEWeidOJFE90mqBEkjJ80Z+ElQaB4+8P0IF
 kvzefs4P7cmFc3lUiNfHMg8oS5ea2kyQSVEKO4LqD6NUhyPjNJeqS1LCl/UBZSqGErwa
 gdB+o3cq4jVUHGG986E+qwy01dwuKc5igLaVhiFp3yOj/bDDyNqwTATzrrvWhLzDfxs4
 CuQ1P0If+ig1r/SqUpZc3cpmU1gL6DE9FSB4GiVPYXXoTSc9pew8uMY6OhjX5aKqkV3D
 KcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692702101; x=1693306901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=INGQw2gZIfMCcsQ3FRMd0eCw/OR0PNFJSBfJGOnsR8g=;
 b=PJDt0sddzgMDstZsGxksz+VXOGhpo6MHrDQxtmd8lDEtBT6Lo/xC3AkZ8g1ku+tuqa
 4RbXbWItW5DeCJIKRRD+0SiPeiMEw5ppQXVDhKmWTwBYuK+W+1yk9gG424dEE/fwqP7g
 JO7q8XzB6MZuS/zK0nGGoz7tB+jv0KHplDjiuKieq1DSRN5MfrZGnx9saWKOfRQw66E0
 4sfs6RSPKHXT/GDdGScAYQURxM5tnBBIkxM4iavkxC2/G/mjOhXghPHLm6/K0+XitW66
 2C7bcQFErw/RqlDFU+3saID2cfj5TCqOJgHZkLjnPuHSJQ42eNnbom+5do25xLptdEnB
 jfSg==
X-Gm-Message-State: AOJu0YwK2dX3sYxfjjLGNPQAD813ZY82XwyaeH8iSlmPk+i9N2bZCyns
 Nl6HC98PzvxzccTD6wCEUg8JuF70rbHMm+HdC7FUpg==
X-Google-Smtp-Source: AGHT+IEHaldCY8ZzfHkHp1GJoB+G6h+lzDZ33YaDrKCo8QQuqY4obv0ZBUcIQ3igW8lHJiRytNtFNQ==
X-Received: by 2002:a05:600c:1da1:b0:3fe:3389:122f with SMTP id
 p33-20020a05600c1da100b003fe3389122fmr6632341wms.1.1692702101072; 
 Tue, 22 Aug 2023 04:01:41 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a7bc3c8000000b003fd2e898aa3sm653051wmj.0.2023.08.22.04.01.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 04:01:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
Subject: [PATCH 1/6] target/arm: Use hswap_i32() in VREV/SMLAD opcodes
Date: Tue, 22 Aug 2023 13:01:24 +0200
Message-ID: <20230822110129.41022-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822110129.41022-1-philmd@linaro.org>
References: <20230822110129.41022-1-philmd@linaro.org>
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

Commit 46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}")
introduced the generic hswap_i32(). Use it instead of open-coding
it as gen_swap_half().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/translate-a32.h  | 6 ------
 target/arm/tcg/translate-neon.c | 4 ++--
 target/arm/tcg/translate.c      | 4 ++--
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/translate-a32.h b/target/arm/tcg/translate-a32.h
index 48a15379d2..0c8f408eea 100644
--- a/target/arm/tcg/translate-a32.h
+++ b/target/arm/tcg/translate-a32.h
@@ -158,10 +158,4 @@ DO_GEN_ST(32, MO_UL)
 /* Set NZCV flags from the high 4 bits of var.  */
 #define gen_set_nzcv(var) gen_set_cpsr(var, CPSR_NZCV)
 
-/* Swap low and high halfwords.  */
-static inline void gen_swap_half(TCGv_i32 dest, TCGv_i32 var)
-{
-    tcg_gen_rotri_i32(dest, var, 16);
-}
-
 #endif
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 8de4ceb203..0e59b03ff9 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -2906,7 +2906,7 @@ static bool trans_VREV64(DisasContext *s, arg_VREV64 *a)
                 tcg_gen_bswap32_i32(tmp[half], tmp[half]);
                 break;
             case 1:
-                gen_swap_half(tmp[half], tmp[half]);
+                tcg_gen_hswap_i32(tmp[half], tmp[half]);
                 break;
             case 2:
                 break;
@@ -3516,7 +3516,7 @@ static bool trans_VREV32(DisasContext *s, arg_2misc *a)
 {
     static NeonGenOneOpFn * const fn[] = {
         tcg_gen_bswap32_i32,
-        gen_swap_half,
+        tcg_gen_hswap_i32,
         NULL,
         NULL,
     };
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 1a6938d1b3..39a42611c6 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -7612,7 +7612,7 @@ static bool op_smlad(DisasContext *s, arg_rrrr *a, bool m_swap, bool sub)
     t1 = load_reg(s, a->rn);
     t2 = load_reg(s, a->rm);
     if (m_swap) {
-        gen_swap_half(t2, t2);
+        tcg_gen_hswap_i32(t2, t2);
     }
     gen_smul_dual(t1, t2);
 
@@ -7700,7 +7700,7 @@ static bool op_smlald(DisasContext *s, arg_rrrr *a, bool m_swap, bool sub)
     t1 = load_reg(s, a->rn);
     t2 = load_reg(s, a->rm);
     if (m_swap) {
-        gen_swap_half(t2, t2);
+        tcg_gen_hswap_i32(t2, t2);
     }
     gen_smul_dual(t1, t2);
 
-- 
2.41.0


