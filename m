Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F00783E8C
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 13:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYP9j-0006SW-3g; Tue, 22 Aug 2023 07:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYP9I-0006ID-Fu
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:02:13 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYP9F-0003Kf-0Y
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:02:12 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fee87dd251so25426715e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 04:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692702108; x=1693306908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iElFObsC3ifF74P0i52/vlr1BqZqHUcD9/Vx9wOeGDY=;
 b=w5VOsL8HA902IBDleuj4nPXjr8wGO+zzCVi5et9JLr2e2P+DvkB7cT5JnSY4paZa23
 lHVbn5nsDd3W/OeHcXBbV3zcIFMGqF4HjEgIWdrUT0fTFMrd9u8y8trNKDts4XChSXPZ
 15fa6oGy0I6qFx6BwbtHW1PKyZJrLS3yvLUObrqt4IiGjIPIg5sNnQ5jnWug/+XOOvCp
 ltPf8jAfWkrwsHYTCEY51Wl72hAM2Wl+CXMpf6FvpMdx3BX9JtvX2PLlte1fY664eD5q
 Mhs3y/71+HX7vrAurDpEgfG4Ns6Cfq5iLo2vGs7QSGVfD5YBsXV7Hj5moQasl9JqvA0T
 FIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692702108; x=1693306908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iElFObsC3ifF74P0i52/vlr1BqZqHUcD9/Vx9wOeGDY=;
 b=KHbcefltPhF+m5y5zjiKYWeo3WK3GFTSQu5lG7a3jQ3mvD6jxfXIEBAOXSe/driyu2
 ZWEOwaw+k7UVh3Pda2G7FFIwWYSIh7seShE1klRMLRfncsPxycCyNMLOrCxCytNCzJVs
 ae9hFp0ofGiraytk4gJ2Hf5xT4Q21hT2M0WttrWdithV5LZhpPjgFITLwBxqr++iRGI+
 7lgmcUOEOQkOaBVOrorEqfAAeahx0sFYqHh0rshEZQ+WOyjBkDssRVMfu856bsjjK2Ut
 va6EvMyKtBKMiKpVqEPqXtoY36JvBVNVYExwFg0zd2W+9TYhdpJ5y4RCaKUibTKAqUkv
 S23g==
X-Gm-Message-State: AOJu0YwXnXmpn9zIDAJPQFlAIWLvBS26GYYoQcEoAIKNQV1Ag9r9DmpW
 D+IrB0RNrcgF80SKpVfWYn4MnRHubjtwhpASDZyzCw==
X-Google-Smtp-Source: AGHT+IHP/k93I6MkIH2Jgd3n20k2cCMifEpaa5arEeVvhP6Q4QYzF1IoG9bAH1NE5JuYiKmGJBbgiw==
X-Received: by 2002:adf:f44e:0:b0:31a:ea7d:49d9 with SMTP id
 f14-20020adff44e000000b0031aea7d49d9mr7728917wrp.53.1692702108101; 
 Tue, 22 Aug 2023 04:01:48 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a5d594a000000b003140f47224csm15488415wri.15.2023.08.22.04.01.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 04:01:47 -0700 (PDT)
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
Subject: [PATCH 2/6] target/cris: Use hswap_i32() in SWAPW opcode
Date: Tue, 22 Aug 2023 13:01:25 +0200
Message-ID: <20230822110129.41022-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822110129.41022-1-philmd@linaro.org>
References: <20230822110129.41022-1-philmd@linaro.org>
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
it as t_gen_swapw().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/cris/translate.c         | 14 +-------------
 target/cris/translate_v10.c.inc |  2 +-
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index 42103b5558..925ed2c6f6 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -399,18 +399,6 @@ static inline void t_gen_swapb(TCGv d, TCGv s)
     tcg_gen_or_tl(d, d, t);
 }
 
-/* Swap the halfwords of the s operand.  */
-static inline void t_gen_swapw(TCGv d, TCGv s)
-{
-    TCGv t;
-    /* d and s refer the same object.  */
-    t = tcg_temp_new();
-    tcg_gen_mov_tl(t, s);
-    tcg_gen_shli_tl(d, t, 16);
-    tcg_gen_shri_tl(t, t, 16);
-    tcg_gen_or_tl(d, d, t);
-}
-
 /*
  * Reverse the bits within each byte.
  *
@@ -1675,7 +1663,7 @@ static int dec_swap_r(CPUCRISState *env, DisasContext *dc)
         tcg_gen_not_tl(t0, t0);
     }
     if (dc->op2 & 4) {
-        t_gen_swapw(t0, t0);
+        tcg_gen_hswap_i32(t0, t0);
     }
     if (dc->op2 & 2) {
         t_gen_swapb(t0, t0);
diff --git a/target/cris/translate_v10.c.inc b/target/cris/translate_v10.c.inc
index b7b0517982..0ff15769ec 100644
--- a/target/cris/translate_v10.c.inc
+++ b/target/cris/translate_v10.c.inc
@@ -506,7 +506,7 @@ static void dec10_reg_swap(DisasContext *dc)
     if (dc->dst & 8)
         tcg_gen_not_tl(t0, t0);
     if (dc->dst & 4)
-        t_gen_swapw(t0, t0);
+        tcg_gen_hswap_i32(t0, t0);
     if (dc->dst & 2)
         t_gen_swapb(t0, t0);
     if (dc->dst & 1)
-- 
2.41.0


