Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 993AF7D3BD8
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:11:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxVA-0000jR-Ir; Mon, 23 Oct 2023 12:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxV7-0000eH-LS
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:09:57 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxV5-0001Mg-JV
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:09:57 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c509f2c46cso50021621fa.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698077393; x=1698682193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8a0cqsCGdNa/FVNQ7i0Dpa2jV5zig3Jd7dUxY5CgLJ0=;
 b=esmlNCo74KiK6pc0pPmajfHttryXqH8NHoYVmPkD5NzTftfPWgNqympn1XH3ZbE1/K
 rtF2pl/vWMMQhSVLeYPeBN+Fu1+Gw84onZGJ2u67XJNMuuNTiIYjT8h6QLbAunt2D6QH
 2JrIUnNv3kew29mkVkIqldQPXqRV4TiDDSKfqyYKHX7cMSk+fp8z5xQ2kkn9CCLU3CWe
 lxKo58NODfAlo8wG48GUOd9H3xEIJNBPb1wvQVU0pJwV9HYhupwgJ7ijRO7dnPsmhb/K
 zkIcUWjuTc4qNvaNyfMxiCYOyOK98wtRcAfo3tQhrtBZa4MeU+mGx0c0ozHXPh0rCJ2p
 zr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698077393; x=1698682193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8a0cqsCGdNa/FVNQ7i0Dpa2jV5zig3Jd7dUxY5CgLJ0=;
 b=EncpHdR0PKUkjRqyZNAcocWsBvKUdqQCmV0jjgzyLXokJ2saKLpduBLgJgJFAn9fbB
 VYh3QjS2kILbqA0dJeeYrk3a2XVly0SByfcIT9s03EsCMuNKS3LemjGZR96o98g262/7
 MKvodQnNJGKSB3jXzn+bBLQffel0cstbKflz73vhX9uw9s3ko/a64279ZSMCe5hGHsWt
 lnQBJ/YUw/00vw0a60ZRS5CHbYr2hNpizXtD7kFcgUrshZBsDLmUT5a1nmGh8AI3p0Jc
 4N3WTBe/4EryUXT8AZ8Qo/Ct2O/kLkpC01Ty5DS73OITLeRvQiha6OZ3rixrxw3TTEKW
 PiSQ==
X-Gm-Message-State: AOJu0Yxd2NiPnQM0lUfK792sPTrIo91jByU0KIIWiruHrC/l0mWnwooZ
 3+r3rTSBNRXBx6oUIrXQfSpGr0q89Oinu0Uy0Ss=
X-Google-Smtp-Source: AGHT+IHcHwNGuUnpw/OEvtZzgKjwiG/n4z2hbl7b93jb9wbSWatwpmVOu+9wz1podJnAbOMUxIisIA==
X-Received: by 2002:a2e:88cc:0:b0:2bf:fab9:db28 with SMTP id
 a12-20020a2e88cc000000b002bffab9db28mr6446746ljk.6.1698077393355; 
 Mon, 23 Oct 2023 09:09:53 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr.
 [176.170.216.159]) by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c35c900b0040839fcb217sm9936034wmq.8.2023.10.23.09.09.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Oct 2023 09:09:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH 1/9] target/avr: Use tcg_gen_extract_tl
Date: Mon, 23 Oct 2023 18:09:36 +0200
Message-ID: <20231023160944.10692-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023160944.10692-1-philmd@linaro.org>
References: <20231023160944.10692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/avr/translate.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index cdffa04519..52fa7cebf6 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -223,8 +223,7 @@ static void gen_add_CHf(TCGv R, TCGv Rd, TCGv Rr)
     tcg_gen_or_tl(t1, t1, t3);
 
     tcg_gen_shri_tl(cpu_Cf, t1, 7); /* Cf = t1(7) */
-    tcg_gen_shri_tl(cpu_Hf, t1, 3); /* Hf = t1(3) */
-    tcg_gen_andi_tl(cpu_Hf, cpu_Hf, 1);
+    tcg_gen_extract_tl(cpu_Hf, t1, 3, 1); /* Hf = t1(3) */
 }
 
 static void gen_add_Vf(TCGv R, TCGv Rd, TCGv Rr)
@@ -254,8 +253,7 @@ static void gen_sub_CHf(TCGv R, TCGv Rd, TCGv Rr)
     tcg_gen_or_tl(t2, t2, t3); /* t2 = ~Rd & Rr | ~Rd & R | R & Rr */
 
     tcg_gen_shri_tl(cpu_Cf, t2, 7); /* Cf = t2(7) */
-    tcg_gen_shri_tl(cpu_Hf, t2, 3); /* Hf = t2(3) */
-    tcg_gen_andi_tl(cpu_Hf, cpu_Hf, 1);
+    tcg_gen_extract_tl(cpu_Hf, t2, 3, 1); /* Hf = t2(3) */
 }
 
 static void gen_sub_Vf(TCGv R, TCGv Rd, TCGv Rr)
@@ -810,8 +808,7 @@ static bool trans_FMUL(DisasContext *ctx, arg_FMUL *a)
     /* update output registers */
     tcg_gen_shli_tl(R, R, 1);
     tcg_gen_andi_tl(R0, R, 0xff);
-    tcg_gen_shri_tl(R1, R, 8);
-    tcg_gen_andi_tl(R1, R1, 0xff);
+    tcg_gen_extract_tl(R1, R, 8, 8);
     return true;
 }
 
@@ -845,8 +842,7 @@ static bool trans_FMULS(DisasContext *ctx, arg_FMULS *a)
     /* update output registers */
     tcg_gen_shli_tl(R, R, 1);
     tcg_gen_andi_tl(R0, R, 0xff);
-    tcg_gen_shri_tl(R1, R, 8);
-    tcg_gen_andi_tl(R1, R1, 0xff);
+    tcg_gen_extract_tl(R1, R, 8, 8);
     return true;
 }
 
@@ -878,8 +874,7 @@ static bool trans_FMULSU(DisasContext *ctx, arg_FMULSU *a)
     /* update output registers */
     tcg_gen_shli_tl(R, R, 1);
     tcg_gen_andi_tl(R0, R, 0xff);
-    tcg_gen_shri_tl(R1, R, 8);
-    tcg_gen_andi_tl(R1, R1, 0xff);
+    tcg_gen_extract_tl(R1, R, 8, 8);
     return true;
 }
 
@@ -2020,8 +2015,7 @@ static bool trans_LPMX(DisasContext *ctx, arg_LPMX *a)
     tcg_gen_qemu_ld_tl(Rd, addr, MMU_CODE_IDX, MO_UB);
     tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
     tcg_gen_andi_tl(L, addr, 0xff);
-    tcg_gen_shri_tl(addr, addr, 8);
-    tcg_gen_andi_tl(H, addr, 0xff);
+    tcg_gen_extract_tl(H, addr, 8, 8);
     return true;
 }
 
-- 
2.41.0


